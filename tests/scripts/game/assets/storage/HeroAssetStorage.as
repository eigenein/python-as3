package game.assets.storage
{
   import engine.context.GameContext;
   import engine.core.assets.RequestableAsset;
   import flash.utils.Dictionary;
   import game.assets.HeroRsxAsset;
   import game.assets.HeroRsxAssetDisposable;
   import game.data.storage.DataStorage;
   import game.data.storage.skin.SkinDescription;
   import starling.textures.TextureMemoryManager;
   
   public class HeroAssetStorage extends AssetTypeStorage
   {
       
      
      private const heroesByString:Dictionary = new Dictionary();
      
      private const map:HeroesByScaleAndAsset = new HeroesByScaleAndAsset();
      
      public function HeroAssetStorage(param1:* = null)
      {
         super(param1);
         TextureMemoryManager.signal_memoryAlarm.add(handler_textureMemoryAlarm);
      }
      
      public function clear() : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = dict;
         for each(var _loc1_ in dict)
         {
            _loc2_ = _loc1_ as HeroRsxAsset;
            if(_loc2_.completed)
            {
               _loc2_.dispose();
            }
         }
         map.disposeUnused();
      }
      
      public function getById(param1:int) : HeroRsxAsset
      {
         var _loc2_:String = DataStorage.hero.getUnitById(param1).asset;
         if(dict[_loc2_] == null && GameContext.instance.consoleEnabled)
         {
            throw "No asset for unit asset ident " + _loc2_;
         }
         return dict[_loc2_] as HeroRsxAsset;
      }
      
      public function getClipProvider(param1:int, param2:int = 0, param3:Number = 1) : HeroRsxAssetDisposable
      {
         var _loc4_:HeroRsxAsset = getByHeroAndSkin(param1,param2);
         return map.getAsset(param1,_loc4_,param3);
      }
      
      public function getByString(param1:String) : HeroRsxAsset
      {
         return heroesByString[param1];
      }
      
      override protected function createEntry(param1:String, param2:*) : RequestableAsset
      {
         var _loc4_:HeroRsxAsset = new HeroRsxAsset(param2);
         dict[param1] = _loc4_;
         var _loc3_:String = param2.asset;
         heroesByString[_loc3_] = _loc4_;
         return _loc4_;
      }
      
      private function handler_textureMemoryAlarm() : void
      {
         map.disposeUnused();
      }
      
      protected function getByHeroAndSkin(param1:int, param2:int) : HeroRsxAsset
      {
         var _loc3_:* = null;
         if(param2 != 0)
         {
            _loc3_ = DataStorage.skin.getSkinById(param2);
            if(!_loc3_.isDefault)
            {
               return getByString(_loc3_.asset);
            }
            return getById(_loc3_.heroId);
         }
         return getById(param1);
      }
   }
}
