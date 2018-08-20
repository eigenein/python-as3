package game.mechanics.boss.mediator
{
   import com.progrestar.framework.ares.core.Clip;
   import engine.core.assets.AssetProgressProvider;
   import engine.core.clipgui.GuiClipFactory;
   import engine.core.utils.property.ObjectProperty;
   import engine.core.utils.property.ObjectPropertyWriteable;
   import game.assets.HeroRsxAsset;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.RsxGameAsset;
   import game.data.cost.CostData;
   import game.mechanics.boss.model.PlayerBossEntry;
   import game.mechanics.boss.popup.BossMapClip;
   import game.mechanics.boss.storage.BossLevelDescription;
   
   public class BossMapProgressMediator
   {
       
      
      private var currentBoss:PlayerBossEntry;
      
      private const _mapClip:ObjectPropertyWriteable = new ObjectPropertyWriteable(BossMapClip);
      
      private var mapClips:Vector.<BossMapClip>;
      
      private var entriesInStages:Vector.<int>;
      
      private var _mapStageEntryOffset:int = 0;
      
      private var assetLoaded:Boolean = false;
      
      private var _mapAsset:String;
      
      private var _heroAssetId:int;
      
      private var _heroAsset:HeroRsxAsset;
      
      private const _assetProgress:ObjectPropertyWriteable = new ObjectPropertyWriteable(AssetProgressProvider);
      
      public function BossMapProgressMediator()
      {
         mapClips = new Vector.<BossMapClip>();
         entriesInStages = new Vector.<int>();
         super();
      }
      
      public function dispose() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function get mapClip() : ObjectProperty
      {
         return _mapClip;
      }
      
      public function get assetProgress() : ObjectProperty
      {
         return _assetProgress;
      }
      
      public function setup(param1:PlayerBossEntry) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         currentBoss = param1;
         var _loc2_:int = param1.type.heroId;
         if(_heroAssetId != param1.type.heroId)
         {
            _heroAssetId = param1.type.heroId;
            AssetStorage.instance.globalLoader.requestAssetWithCallback(AssetStorage.hero.getById(_heroAssetId) as HeroRsxAsset,handler_heroAssetLoaded);
         }
         if(_mapAsset != param1.type.mapAsset)
         {
            _mapAsset = param1.type.mapAsset;
            assetLoaded = false;
            _loc4_ = AssetStorage.rsx.getByName(_mapAsset);
            AssetStorage.instance.globalLoader.requestAssetWithCallback(_loc4_,handler_assetLoaded);
            _loc3_ = AssetStorage.instance.globalLoader.getAssetProgress(_loc4_);
            if(!_loc3_.completed)
            {
               _assetProgress.value = _loc3_;
            }
         }
         else
         {
            updateState();
         }
      }
      
      protected function updateState() : void
      {
         var _loc5_:int = 0;
         var _loc4_:Boolean = false;
         var _loc3_:BossMapClip = mapClips[0];
         _mapClip.value = _loc3_;
         _loc5_ = 0;
         while(_loc5_ < _loc3_.entries.length)
         {
            _loc3_.entries[_loc5_].clear();
            _loc5_++;
         }
         var _loc1_:uint = currentBoss.level != null?currentBoss.level.bossLevel:0;
         if(currentBoss.level != null)
         {
            _loc3_.entries[0].setHeroAsset(_heroAsset);
            _loc3_.entries[0].setBossUI(currentBoss.level.level,currentBoss.mayRaid.value,(currentBoss.chestCost.value as CostData).isEmpty,false,true,false,_loc1_ == 0);
         }
         var _loc6_:BossLevelDescription = currentBoss.type.getLevelByBossLevel(_loc1_ + 1);
         if(_loc6_)
         {
            _loc4_ = currentBoss.level == null || !currentBoss.mayRaid.value && !(currentBoss.chestCost.value as CostData).isEmpty;
            _loc3_.entries[1].setHeroAsset(_heroAsset);
            _loc3_.entries[1].setBossUI(_loc6_.level,false,false,_loc4_,false,true,_loc1_ == 0);
         }
         var _loc2_:BossLevelDescription = currentBoss.type.getLevelByBossLevel(_loc1_ + 2);
         if(_loc2_)
         {
            _loc3_.entries[2].setBossUI(_loc2_.level,false,false,false,false,false,false);
         }
      }
      
      private function handler_heroAssetLoaded(param1:HeroRsxAsset) : void
      {
         _heroAsset = param1;
      }
      
      private function handler_assetLoaded(param1:RsxGameAsset) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
   }
}
