package game.view.popup.summoningcircle.reward
{
   import game.command.rpc.stash.StashEventParams;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.clan.ClanSummoningCircleDescription;
   import game.data.storage.resource.CoinDescription;
   import game.data.storage.resource.PseudoResourceDescription;
   import game.data.storage.titan.TitanDescription;
   import game.mediator.gui.component.RewardValueObjectList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryFragmentItem;
   import game.model.user.inventory.InventoryItem;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import idv.cjcat.signals.Signal;
   
   public class SummoningCircleRewardPopupMediator extends PopupMediator
   {
       
      
      private var _circle:ClanSummoningCircleDescription;
      
      private var _reward:RewardValueObjectList;
      
      private var _paid:Boolean;
      
      private var _amount:uint;
      
      private var _signal_reSummon:Signal;
      
      public function SummoningCircleRewardPopupMediator(param1:Player, param2:RewardValueObjectList, param3:Boolean, param4:uint)
      {
         _signal_reSummon = new Signal(Boolean,int);
         super(param1);
         _reward = param2;
         _paid = param3;
         _amount = param4;
         _circle = DataStorage.clanSummoningCircle.defaultCircle;
      }
      
      public function get cost_single() : CostData
      {
         return _circle.getCostSingle(player);
      }
      
      public function get cost_pack() : CostData
      {
         return _circle.getCostPack(player);
      }
      
      public function get cost_pack_x10() : CostData
      {
         return _circle.getCostPackX10(player);
      }
      
      public function get openFreeCost() : InventoryItem
      {
         return new InventoryItem(cost_single.outputDisplayFirst.item,amount * cost_single.outputDisplayFirst.amount);
      }
      
      public function get openPaidCost() : InventoryItem
      {
         return cost_pack.outputDisplayFirst;
      }
      
      public function get openPaidX10Cost() : InventoryItem
      {
         return cost_pack_x10.outputDisplayFirst;
      }
      
      public function get reward() : RewardValueObjectList
      {
         return _reward;
      }
      
      public function get rewardList() : Vector.<InventoryItem>
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:Vector.<InventoryItem> = new Vector.<InventoryItem>();
         _loc2_ = 0;
         while(_loc2_ < _reward.rewardList.length)
         {
            if(_reward.rewardList[_loc2_].item is TitanDescription || _reward.rewardList[_loc2_].item is CoinDescription)
            {
               _loc1_.push(_reward.rewardList[_loc2_]);
            }
            _loc2_++;
         }
         if(_reward.hasTitans)
         {
            _loc3_ = 0;
            while(_loc3_ < _reward.rewardTitans.length)
            {
               _loc1_.push(new InventoryItem(_reward.rewardTitans[_loc3_].desc));
               _loc3_++;
            }
         }
         return _loc1_;
      }
      
      public function get mergedRewardsList() : Vector.<InventoryItem>
      {
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc7_:RewardData = new RewardData();
         var _loc5_:Vector.<InventoryItem> = rewardList;
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc7_.addItem(rewardList[_loc6_]);
            _loc6_++;
         }
         var _loc1_:Vector.<InventoryItem> = _loc7_.outputDisplay;
         _loc1_.sort(sortMergedRewardsListByAmount);
         var _loc8_:uint = 10;
         if(_loc1_.length > 0 && _loc1_.length < _loc8_)
         {
            while(_loc1_.length < _loc8_)
            {
               _loc2_ = _loc1_.shift();
               _loc4_ = new InventoryFragmentItem(_loc2_.item,Math.floor(_loc2_.amount / 2));
               _loc3_ = new InventoryFragmentItem(_loc2_.item,_loc2_.amount - _loc4_.amount);
               _loc1_.push(_loc4_);
               _loc1_.push(_loc3_);
            }
         }
         return _loc1_;
      }
      
      public function get bonusReward() : InventoryItem
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < reward.rewardList.length)
         {
            if(reward.rewardList[_loc1_].item is PseudoResourceDescription)
            {
               return reward.rewardList[_loc1_];
            }
            _loc1_++;
         }
         return null;
      }
      
      public function get paid() : Boolean
      {
         return _paid;
      }
      
      public function get amount() : uint
      {
         return _amount;
      }
      
      public function get signal_reSummon() : Signal
      {
         return _signal_reSummon;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney(true);
         _loc1_.requre_coin(DataStorage.coin.getByIdent("summon_key"));
         return _loc1_;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new SummoningCircleRewardPopup(this);
         return _popup;
      }
      
      public function action_reSummon() : void
      {
         var _loc1_:StashEventParams = Stash.click("get_more",_popup.stashParams);
         close();
         _signal_reSummon.dispatch(paid,amount);
      }
      
      public function action_showExtendedRewardsPopup() : void
      {
         new SummoningCircleRewardExtendedPopupMediator(player,rewardList).open(Stash.click("btn_more",_popup.stashParams));
      }
      
      private function sortMergedRewardsListByAmount(param1:InventoryItem, param2:InventoryItem) : int
      {
         return param2.amount - param1.amount;
      }
   }
}
