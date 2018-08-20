package game.assets.battle
{
   import battle.data.BattleData;
   import battle.data.BattleHeroDescription;
   import battle.data.BattleTeamDescription;
   import engine.core.assets.AssetProvider;
   import engine.core.assets.FileDependentAsset;
   import game.assets.storage.AssetStorage;
   import vm.InterpreterCore;
   
   public class BattleCodeAsset extends FileDependentAsset
   {
       
      
      public var battleData:BattleData;
      
      public var interpreter:InterpreterCore;
      
      protected var _completed:Boolean;
      
      public function BattleCodeAsset(param1:BattleData)
      {
         super();
         this.battleData = param1;
         interpreter = AssetStorage.battle.interpreter.interp;
      }
      
      override public function get completed() : Boolean
      {
         return _completed;
      }
      
      override public function prepare(param1:AssetProvider) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      override public function complete() : void
      {
         battleData.attackers.initialize(AssetStorage.battle.skillFactory);
         battleData.defenders.initialize(AssetStorage.battle.skillFactory);
         _completed = true;
      }
      
      protected function requestHero(param1:Array, param2:BattleHeroDescription, param3:int) : void
      {
      }
      
      protected function get basicAssets() : Array
      {
         var _loc1_:Array = AssetStorage.battle.allCodeAssets();
         return _loc1_;
      }
   }
}
