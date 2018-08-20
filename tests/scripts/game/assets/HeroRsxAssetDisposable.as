package game.assets
{
   import avmplus.getQualifiedClassName;
   import com.progrestar.framework.ares.starling.ClipAssetDataProvider;
   import engine.core.assets.AssetProvider;
   import engine.core.assets.RequestableAsset;
   import game.battle.view.hero.HeroClipAssetDataProvider;
   
   public class HeroRsxAssetDisposable implements RequestableAsset, IHeroAsset
   {
       
      
      private var _usages:int = 0;
      
      private var _unitId:int;
      
      private var _completed:Boolean = false;
      
      private var rsxAsset:HeroRsxAsset;
      
      private var samplingScale:Number;
      
      private var clipAssetDataProvider:ClipAssetDataProvider;
      
      public function HeroRsxAssetDisposable(param1:int, param2:HeroRsxAsset, param3:Number)
      {
         super();
         this._unitId = param1;
         this.rsxAsset = param2;
         this.samplingScale = param3;
      }
      
      public function dispose() : void
      {
         if(clipAssetDataProvider != null)
         {
            clipAssetDataProvider.dispose();
            clipAssetDataProvider = null;
         }
         _completed = false;
      }
      
      public function get unitId() : int
      {
         return _unitId;
      }
      
      public function get usages() : int
      {
         return _usages;
      }
      
      public function addUsage() : void
      {
         _usages = Number(_usages) + 1;
      }
      
      public function dropUsage(param1:Boolean = false) : void
      {
         _usages = Number(_usages) - 1;
         if(_usages < 0)
         {
            trace(getQualifiedClassName(this),"asset disposed not once",!!rsxAsset?rsxAsset.ident:null);
         }
         if(param1 && _usages <= 0)
         {
            dispose();
         }
      }
      
      public function prepare(param1:AssetProvider) : void
      {
         param1.request(this,rsxAsset);
      }
      
      public function get completed() : Boolean
      {
         return _completed;
      }
      
      public function complete() : void
      {
         _completed = true;
      }
      
      public function getHeroData(param1:Number = 1, param2:String = null, param3:Boolean = false) : HeroClipAssetDataProvider
      {
         if(rsxAsset == null)
         {
            return null;
         }
         if(clipAssetDataProvider == null)
         {
            clipAssetDataProvider = new ClipAssetDataProvider(rsxAsset.data,samplingScale);
         }
         return new HeroClipAssetDataProvider(clipAssetDataProvider,rsxAsset.mirrored,param2,param1,param3);
      }
   }
}
