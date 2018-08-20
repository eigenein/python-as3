package game.battle.view.hero
{
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.ClipAsset;
   import com.progrestar.framework.ares.starling.ClipAssetDataProvider;
   import com.progrestar.framework.ares.starling.ClipSkin;
   import game.battle.view.EffectGraphicsProvider;
   
   public class HeroClipAssetDataProvider
   {
       
      
      private var isMirrored:Boolean;
      
      private var clipAsset:ClipAssetDataProvider;
      
      private var _prefix:String;
      
      private var _defaultScale:Number;
      
      private var _tryAlterDefenderLook:Boolean;
      
      public function HeroClipAssetDataProvider(param1:ClipAssetDataProvider, param2:Boolean, param3:String, param4:Number, param5:Boolean = false)
      {
         super();
         this.isMirrored = param2;
         this.clipAsset = param1;
         this._prefix = param3;
         this._defaultScale = param4;
         this._tryAlterDefenderLook = param5;
      }
      
      public function dropUsage() : void
      {
      }
      
      public function get name() : String
      {
         return clipAsset.name;
      }
      
      public function get prefix() : String
      {
         return _prefix;
      }
      
      public function get defaultScale() : Number
      {
         return _defaultScale;
      }
      
      public function get soundAsset() : ClipAsset
      {
         return clipAsset.data;
      }
      
      public function get mirrored() : Boolean
      {
         return isMirrored;
      }
      
      public function get frameProvider() : ClipAssetDataProvider
      {
         return clipAsset;
      }
      
      public function get tryAlterDefenderLook() : Boolean
      {
         return _tryAlterDefenderLook;
      }
      
      public function getClipByName(param1:String) : Clip
      {
         var _loc2_:* = null;
         if(_prefix == null)
         {
            return clipAsset.getClipByName(param1);
         }
         _loc2_ = clipAsset.getClipByName(_prefix + param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         return clipAsset.getClipByName(param1);
      }
      
      public function getEffectProvider(param1:String) : EffectGraphicsProvider
      {
         return new EffectGraphicsProvider(this,param1);
      }
      
      public function createSkin(param1:Clip) : ClipSkin
      {
         var _loc2_:ClipSkin = new ClipSkin(param1,frameProvider);
         if(_tryAlterDefenderLook)
         {
            _loc2_.applySkinPart("marker_skin_defender",getClipByName("skin_defender"));
         }
         return _loc2_;
      }
   }
}
