package game.mediator.gui.popup
{
   import battle.BattleStats;
   import feathers.core.PopUpManager;
   import game.data.reward.RewardData;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.skin.SkinDescription;
   import game.data.storage.titan.TitanDescription;
   import game.mediator.gui.popup.hero.skin.SkinLevelUpPopUp;
   import game.mediator.gui.popup.hero.skin.SkinLevelUpPopUpMediator;
   import game.mediator.gui.popup.titan.upgrade.TitanStarUpPopup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.hero.PlayerTitanEntry;
   import game.model.user.inventory.InventoryCollection;
   import game.model.user.inventory.InventoryFragmentItem;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.hero.upgrade.HeroColorUpPopup;
   import game.view.popup.hero.upgrade.HeroStarUpPopup;
   import game.view.popup.reward.RewardHeroPopup;
   import game.view.popup.reward.RewardTitanPopup;
   
   public class HeroRewardPopupHandler
   {
      
      private static var _instance:HeroRewardPopupHandler;
       
      
      private var player:Player;
      
      private var _hold:Boolean;
      
      private var _queue:Vector.<RewardHeroPopup>;
      
      private var _queueTitan:Vector.<RewardTitanPopup>;
      
      private var _queueSkin:Vector.<SkinLevelUpPopUp>;
      
      private var _latestHero:HeroDescription;
      
      private var _latestTitan:TitanDescription;
      
      private var _skinFragmentsInventory:InventoryCollection;
      
      private var _history:Vector.<int>;
      
      public function HeroRewardPopupHandler(param1:Player)
      {
         _queue = new Vector.<RewardHeroPopup>();
         _queueTitan = new Vector.<RewardTitanPopup>();
         _queueSkin = new Vector.<SkinLevelUpPopUp>();
         super();
         this.player = param1;
         _history = new Vector.<int>();
         _skinFragmentsInventory = param1.inventory.getFragmentCollection().getCollectionByType(InventoryItemType.SKIN);
         param1.heroes.signal_newHeroObtained.add(handler_newHero);
         param1.heroes.signal_heroEvolveStar.add(handler_heroEvolveStar);
         param1.heroes.signal_heroPromoteColor.add(handler_heroPromoteColor);
         param1.heroes.signal_heroUpgradeSkin.add(handler_heroUpgrageSkin);
         param1.signal_takeReward.add(handler_shardedHeroOrTitanReward);
         param1.titans.signal_titanEvolveStar.add(handler_titanEvolveStar);
         param1.titans.signal_newTitanObtained.add(handler_newTitan);
         _skinFragmentsInventory.updateSignal.add(handler_skinFragmentAdd);
         _skinFragmentsInventory.updateCountSignal.add(handler_skinFragmentAdd);
         _instance = this;
      }
      
      public static function get instance() : HeroRewardPopupHandler
      {
         return _instance;
      }
      
      private function handler_shardedHeroOrTitanReward(param1:RewardData) : void
      {
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:* = null;
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc7_:* = null;
         if(param1.heroCards && param1.heroCards.length)
         {
            _loc2_ = param1.heroCards.length;
            _loc6_ = 0;
            while(_loc6_ < _loc2_)
            {
               _loc8_ = param1.heroCards[_loc6_];
               _loc5_ = _loc8_.item as HeroDescription;
               _loc4_ = new RewardHeroPopup(_loc5_,_loc8_.amount);
               queuePopup(_loc4_);
               _loc6_++;
            }
         }
         if(param1.titanCards && param1.titanCards.length)
         {
            _loc2_ = param1.titanCards.length;
            _loc6_ = 0;
            while(_loc6_ < _loc2_)
            {
               _loc8_ = param1.titanCards[_loc6_];
               _loc3_ = _loc8_.item as TitanDescription;
               _loc7_ = new RewardTitanPopup(_loc3_,_loc8_.amount);
               queueTitanPopup(_loc7_);
               _loc6_++;
            }
         }
      }
      
      public function get history() : Vector.<int>
      {
         return _history;
      }
      
      public function hold() : void
      {
         _hold = true;
      }
      
      public function release() : void
      {
         _hold = false;
         shiftQueue();
         shiftQueueSkin();
         shiftQueueTitan();
      }
      
      public function addListenerTakeReward() : void
      {
         player.signal_takeReward.add(handler_shardedHeroOrTitanReward);
      }
      
      public function removeListenerTakeReward() : void
      {
         player.signal_takeReward.remove(handler_shardedHeroOrTitanReward);
      }
      
      private function queuePopup(param1:RewardHeroPopup) : void
      {
         if(!param1.shards)
         {
            _latestHero = param1.heroDesc;
            addToHistory(param1.heroDesc.id);
         }
         _queue.push(param1);
         if(!_hold)
         {
            shiftQueue();
         }
      }
      
      private function queueTitanPopup(param1:RewardTitanPopup) : void
      {
         if(!param1.shards)
         {
            _latestTitan = param1.titanDesc;
            addToHistory(param1.titanDesc.id);
         }
         _queueTitan.push(param1);
         if(!_hold)
         {
            shiftQueueTitan();
         }
      }
      
      private function queueSkinPopup(param1:SkinLevelUpPopUp) : void
      {
         _queueSkin.push(param1);
         if(!_hold)
         {
            shiftQueueSkin();
         }
      }
      
      private function addToHistory(param1:uint) : void
      {
         if(_history.indexOf(param1) == -1)
         {
            _history.push(param1);
         }
      }
      
      private function shiftQueue() : void
      {
         var _loc1_:* = null;
         if(_queue.length)
         {
            _loc1_ = _queue.shift();
            PopUpManager.addPopUp(_loc1_);
         }
         else if(_latestHero)
         {
            if(_latestHero)
            {
               PopupList.instance.dialog_hero(_latestHero);
            }
            _latestHero = null;
         }
      }
      
      private function shiftQueueTitan() : void
      {
         var _loc1_:* = null;
         if(_queueTitan.length)
         {
            _loc1_ = _queueTitan.shift();
            PopUpManager.addPopUp(_loc1_);
         }
         else if(_latestTitan)
         {
            if(_latestTitan)
            {
               PopupList.instance.dialog_titan(_latestTitan);
            }
            _latestTitan = null;
         }
      }
      
      private function shiftQueueSkin() : void
      {
         var _loc1_:* = null;
         if(_queueSkin.length)
         {
            _loc1_ = _queueSkin.shift();
            PopUpManager.addPopUp(_loc1_);
         }
      }
      
      private function handler_newHeroSharded() : void
      {
      }
      
      private function handler_newHero(param1:PlayerHeroEntry) : void
      {
         var _loc4_:HeroDescription = param1.hero;
         var _loc2_:RewardData = new RewardData();
         _loc2_.addHero(_loc4_);
         var _loc3_:RewardHeroPopup = new RewardHeroPopup(_loc4_,0);
         queuePopup(_loc3_);
      }
      
      private function handler_newTitan(param1:PlayerTitanEntry) : void
      {
         var _loc4_:TitanDescription = param1.titan;
         var _loc2_:RewardData = new RewardData();
         _loc2_.addTitan(_loc4_);
         var _loc3_:RewardTitanPopup = new RewardTitanPopup(_loc4_,0);
         queueTitanPopup(_loc3_);
      }
      
      private function handler_heroPromoteColor(param1:PlayerHeroEntry, param2:int) : void
      {
         var _loc3_:HeroColorUpPopup = new HeroColorUpPopup(param1,param2);
         PopUpManager.addPopUp(_loc3_);
      }
      
      private function handler_heroUpgrageSkin(param1:PlayerHeroEntry, param2:SkinDescription, param3:Boolean) : void
      {
         var _loc5_:* = null;
         var _loc4_:* = null;
         if(!param2.isDefault && !param3)
         {
            _loc5_ = player.heroes.getById(param2.heroId);
            if(_loc5_ && _loc5_.skinData.getSkinLevelByID(param2.id) == 1)
            {
               _loc4_ = new SkinLevelUpPopUpMediator(GameModel.instance.player,param2.id);
               queueSkinPopup(_loc4_.createPopup() as SkinLevelUpPopUp);
            }
         }
      }
      
      private function handler_skinFragmentAdd(param1:InventoryItem) : void
      {
         var _loc2_:SkinLevelUpPopUpMediator = new SkinLevelUpPopUpMediator(GameModel.instance.player,param1.item.id);
         queueSkinPopup(_loc2_.createPopup() as SkinLevelUpPopUp);
      }
      
      private function handler_heroEvolveStar(param1:PlayerHeroEntry, param2:BattleStats, param3:int) : void
      {
         var _loc4_:HeroStarUpPopup = new HeroStarUpPopup(param1,param2,param3);
         PopUpManager.addPopUp(_loc4_);
      }
      
      private function handler_titanEvolveStar(param1:PlayerTitanEntry, param2:BattleStats, param3:int) : void
      {
         var _loc4_:TitanStarUpPopup = new TitanStarUpPopup(param1,param2,param3);
         PopUpManager.addPopUp(_loc4_);
      }
   }
}
