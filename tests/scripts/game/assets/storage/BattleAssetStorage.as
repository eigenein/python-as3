package game.assets.storage
{
   import battle.BattleConfig;
   import battle.BattleEngine;
   import battle.skills.Effect;
   import com.progrestar.common.Logger;
   import engine.context.GameContext;
   import engine.core.assets.AssetProgressProvider;
   import engine.core.assets.RequestableAsset;
   import engine.core.assets.file.SwfFile;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import game.assets.battle.EncodedCodeAsset;
   import game.mediator.gui.popup.battle.BattlePreloaderPopupMediator;
   import haxe.io.Bytes;
   import vm.Interpreter;
   
   public class BattleAssetStorage
   {
      
      public static var USE_INTERPRETER:Boolean = true;
      
      private static const EMPTY_ARRAY:Array = [];
      
      private static const interpreterDefines:Array = ["flash","client","log","collectStatistics"];
      
      public static const SKILL_CODE_ASSET:String = "skills.sc";
      
      public static const BATTLECORE_SWF:String = "battlecore.swf";
      
      public static const COMMON_ARTIFACT_TITAN_ASSET:String = "common_artifact_titan.rsx";
      
      public static const COMMON_ARTIFACT_TITAN_FIRE_ASSET:String = "common_artifact_titan_fire.rsx";
      
      public static const COMMON_ARTIFACT_TITAN_WATER_ASSET:String = "common_artifact_titan_water.rsx";
      
      public static const COMMON_ARTIFACT_TITAN_EARTH_ASSET:String = "common_artifact_titan_earth.rsx";
       
      
      public const interpreter:Interpreter = new Interpreter();
      
      private var codeSwf:SwfFile;
      
      private var code:Dictionary;
      
      private var _config:BattleConfig;
      
      private var heroes:Dictionary;
      
      private var effects:Dictionary;
      
      public function BattleAssetStorage()
      {
         super();
         code = new Dictionary();
         heroes = new Dictionary();
         effects = new Dictionary();
         var _loc1_:* = _trace;
         BattleEngine.trace = _loc1_;
         Interpreter.trace = _loc1_;
         _loc1_ = trace;
         BattleEngine.trace = _loc1_;
         Interpreter.trace = _loc1_;
         _loc1_ = log;
         BattleEngine.log = _loc1_;
         Interpreter.log = _loc1_;
      }
      
      public function getEncodedScriptByIdent(param1:String) : EncodedCodeAsset
      {
         if(code[param1])
         {
            return code[param1];
         }
         var _loc2_:* = new EncodedCodeAsset(param1);
         code[param1] = _loc2_;
         return _loc2_;
      }
      
      public function clearLoadedCode() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = code;
         for each(var _loc1_ in code)
         {
            _loc1_.codeBytes = null;
         }
      }
      
      public function loadEncodedCode(param1:ByteArray) : void
      {
         interpreter.runCompressedBytes(Bytes.ofData(param1));
      }
      
      public function skillFactory(param1:String) : *
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(USE_INTERPRETER)
         {
            _loc2_ = interpreter.interp.resolveClass("code." + param1);
            if(_loc2_ != null)
            {
               return interpreter.createInstance("code." + param1,EMPTY_ARRAY);
            }
            throw "Undefined effect " + param1;
         }
         _loc3_ = codeSwf.applicationDomain.getDefinition("code::" + param1) as Class;
         return new _loc3_();
      }
      
      public function effectFactory(param1:Effect) : void
      {
         var _loc2_:* = null;
         var _loc4_:uint = param1.ident.indexOf("(");
         var _loc3_:String = param1.ident;
         _loc3_ = param1.ident.charAt(0).toUpperCase() + _loc3_.slice(1,_loc4_);
         param1.ident = _loc3_;
         if(USE_INTERPRETER)
         {
            param1.execution = interpreter.createInstance("code.Effect" + _loc3_,[param1]);
         }
         else
         {
            _loc2_ = codeSwf.applicationDomain.getDefinition("code::Effect" + _loc3_) as Class;
            param1.execution = new _loc2_(param1);
         }
      }
      
      public function allCodeAssets() : Array
      {
         if(USE_INTERPRETER || codeSwf)
         {
            return [getEncodedScriptByIdent("skills.sc")];
         }
         codeSwf = GameContext.instance.assetIndex.getAssetFile("battlecore.swf") as SwfFile;
         codeSwf.doNotCheckFileSizeAnyMore();
         return [getEncodedScriptByIdent("skills.sc"),codeSwf];
      }
      
      public function requestAllCode() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = allCodeAssets();
         for each(var _loc1_ in allCodeAssets())
         {
            AssetStorage.instance.globalLoader.requestAsset(_loc1_);
         }
      }
      
      public function requestAssetWithPreloader(param1:RequestableAsset, param2:Function) : void
      {
         var _loc3_:* = null;
         AssetStorage.instance.globalLoader.requestAssetWithCallback(param1,param2);
         var _loc4_:AssetProgressProvider = AssetStorage.instance.globalLoader.getAssetProgress(param1);
         if(!_loc4_.completed)
         {
            _loc3_ = new BattlePreloaderPopupMediator(_loc4_);
            _loc3_.open();
         }
      }
      
      private function log(param1:String, param2:*) : void
      {
         Logger.getLogger("battle::" + param1).debug(param2);
      }
      
      private function _trace(param1:*) : void
      {
      }
      
      public function getBattleEngine() : BattleEngine
      {
         return new BattleEngine();
      }
   }
}
