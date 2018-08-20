package game.mechanics.boss.mediator
{
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.ObjectProperty;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.resource.CoinDescription;
   import game.mechanics.boss.model.BossPossibleRewardValueObject;
   import game.mechanics.boss.model.CommandBossOpenChest;
   import game.mechanics.boss.model.PlayerBossEntry;
   import game.mechanics.boss.popup.BossChestPopup;
   import game.mechanics.boss.storage.BossChestDescription;
   import game.mechanics.boss.storage.BossTypeDescription;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.PopupBase;
   import idv.cjcat.signals.Signal;
   
   public class BossChestPopupMediator extends PopupMediator
   {
       
      
      private var _bossType:BossTypeDescription;
      
      private var boss:PlayerBossEntry;
      
      private var showRewardPopupTimeout:int = -1;
      
      public function BossChestPopupMediator(param1:Player, param2:PlayerBossEntry)
      {
         super(param1);
         this._bossType = param2.type;
         this.boss = param2;
         param2.signal_chestOpened.add(handler_chestOpened);
      }
      
      override protected function dispose() : void
      {
         boss.signal_chestOpened.remove(handler_chestOpened);
         super.dispose();
      }
      
      public function get chestCost() : ObjectProperty
      {
         return boss.chestCost;
      }
      
      public function get chestId() : IntProperty
      {
         return boss.chestId;
      }
      
      public function get chestRepeatFromId() : int
      {
         return DataStorage.rule.bossRule.chestRepeatFromId;
      }
      
      public function get signal_chestOpened() : Signal
      {
         return boss.signal_chestOpened;
      }
      
      public function get possibleReward() : ObjectProperty
      {
         return boss.possibleReward;
      }
      
      public function get obtainedRewards() : Vector.<RewardData>
      {
         return boss.obtainedRewards.concat();
      }
      
      public function get chestPackAmount() : int
      {
         return DataStorage.rule.bossRule.chestPackAmount;
      }
      
      public function get chestPackCost() : CostData
      {
         return DataStorage.rule.bossRule.chestPackCost;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney();
         var _loc2_:CoinDescription = DataStorage.coin.getByIdent("boss");
         _loc1_.requre_coin(_loc2_).animateChanges = true;
         _loc1_.requre_coin(DataStorage.coin.getByIdent("skin_coin_int")).animateChanges = true;
         _loc1_.requre_coin(DataStorage.coin.getByIdent("skin_coin_str")).animateChanges = true;
         _loc1_.requre_coin(DataStorage.coin.getByIdent("skin_coin_agi")).animateChanges = true;
         return _loc1_;
      }
      
      public function get chestNum() : int
      {
         return boss.chestsOpenedCount.value + 1;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new BossChestPopup(this);
         return new BossChestPopup(this);
      }
      
      override public function close() : void
      {
         if(showRewardPopupTimeout != -1)
         {
            clearTimeout(showRewardPopupTimeout);
         }
         super.close();
      }
      
      public function action_hero() : void
      {
         var _loc1_:HeroDescription = (boss.possibleReward.value as BossPossibleRewardValueObject).heroDescription as HeroDescription;
         if(_loc1_ == null)
         {
            return;
         }
         if(player.heroes.getById(_loc1_.id))
         {
            PopupList.instance.dialog_hero(_loc1_);
         }
         else
         {
            PopupList.instance.popup_item_info(_loc1_);
         }
      }
      
      public function action_open(param1:int = 1) : void
      {
         boss.openChest(param1);
      }
      
      public function getNextChestValueObject(param1:int) : BossChestPopupValueObject
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc7_:int = boss.chestsOpenedCount.value;
         var _loc6_:int = _loc7_ + param1;
         if(_loc6_ < 1)
         {
            return null;
         }
         var _loc8_:BossChestDescription = DataStorage.boss.getChestByNum(_loc6_);
         var _loc5_:Boolean = _loc8_.cost.isEmpty && _loc8_.definedReward;
         var _loc4_:* = _loc6_ <= _loc7_;
         if(_loc4_)
         {
            _loc2_ = boss.getChestReward(_loc6_);
            if(!_loc2_)
            {
               return null;
            }
         }
         else
         {
            _loc2_ = _loc8_.getRewardBySlot(0,boss.type);
         }
         if(_loc2_)
         {
            _loc3_ = _loc2_.outputDisplay[0];
         }
         return new BossChestPopupValueObject(_loc6_,_loc5_,_loc4_,_loc3_);
      }
      
      private function handler_chestOpened(param1:CommandBossOpenChest) : void
      {
         cmd = param1;
         if(cmd.rewardList.length > 1)
         {
            showRewardPopupTimeout = setTimeout(function():void
            {
               new BossChestPackRewardPopupMediator(player,cmd.rewardList).open(_popup.stashParams);
               close();
            },2200);
         }
      }
   }
}
