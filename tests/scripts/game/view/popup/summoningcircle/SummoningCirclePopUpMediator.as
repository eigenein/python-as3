package game.view.popup.summoningcircle
{
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.IntPropertyWriteable;
   import game.command.intern.OpenTitanPopupCommand;
   import game.command.rpc.titan.CommandTitanUseSummoningCircle;
   import game.command.timer.GameTimer;
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.data.storage.clan.ClanSummoningCircleDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.titan.TitanDescription;
   import game.mediator.gui.component.RewardValueObjectList;
   import game.mediator.gui.popup.GamePopupManager;
   import game.mediator.gui.popup.HeroRewardPopupHandler;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.inventory.InventoryItemCountProxy;
   import game.stat.Stash;
   import game.util.TimeFormatter;
   import game.view.gui.tutorial.Tutorial;
   import game.view.popup.PopupBase;
   import game.view.popup.summoningcircle.reward.SummoningCircleRewardPopupMediator;
   import idv.cjcat.signals.Signal;
   
   public class SummoningCirclePopUpMediator extends PopupMediator
   {
      
      public static var current:SummoningCirclePopUpMediator;
       
      
      private var _circle:ClanSummoningCircleDescription;
      
      private var summonKeyCoinCounter:InventoryItemCountProxy;
      
      private var _dungeonActivityPoints:IntPropertyWriteable;
      
      private var _timeLeft:String;
      
      private var _signal_resetTimeUpdate:Signal;
      
      public var signal_summonKeyCoinUpdate:Signal;
      
      public var signal_starmoneySpent:Signal;
      
      public function SummoningCirclePopUpMediator(param1:Player)
      {
         _dungeonActivityPoints = new IntPropertyWriteable();
         _signal_resetTimeUpdate = new Signal();
         signal_summonKeyCoinUpdate = new Signal();
         signal_starmoneySpent = new Signal();
         super(param1);
         _circle = DataStorage.clanSummoningCircle.defaultCircle;
         summonKeyCoinCounter = param1.inventory.getItemCounterProxy(DataStorage.coin.getByIdent("summon_key"),false);
         summonKeyCoinCounter.signal_update.add(handler_summonKeyCoinUpdate);
         param1.titanSummoningCircle.signal_starmoneySpent.add(handler_summoningCircleStarmoneySpent);
         if(param1 && param1.clan.clan)
         {
            _dungeonActivityPoints.value = param1.clan.clan.dungeonActivityPoints.value;
         }
         handler_timer();
         GameTimer.instance.oneSecTimer.add(handler_timer);
         current = this;
      }
      
      override protected function dispose() : void
      {
         player.titanSummoningCircle.signal_starmoneySpent.remove(handler_summoningCircleStarmoneySpent);
         super.dispose();
         summonKeyCoinCounter.signal_update.remove(handler_summonKeyCoinUpdate);
         GameTimer.instance.oneSecTimer.remove(handler_timer);
         if(current == this)
         {
            current = null;
         }
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
      
      public function get x10Avaliable() : Boolean
      {
         return player.titanSummoningCircle.starmoneySpent >= DataStorage.rule.summoningCircleRule.packX10UnlockStarmoney;
      }
      
      public function get packValueX1() : uint
      {
         return 1;
      }
      
      public function get packValueX10() : uint
      {
         return 10;
      }
      
      public function get packAmount() : uint
      {
         return 5;
      }
      
      public function get packX10Amount() : uint
      {
         return packAmount * packValueX10;
      }
      
      public function get titanSimpleList() : Vector.<TitanDescription>
      {
         var _loc1_:Vector.<TitanDescription> = DataStorage.titan.getList();
         _loc1_ = _loc1_.filter(titanSimpleFilter);
         _loc1_.sort(TitanDescription.sort_fireWaterEarth);
         return _loc1_;
      }
      
      public function get titanUltraList() : Vector.<TitanDescription>
      {
         var _loc1_:Vector.<TitanDescription> = DataStorage.titan.getList();
         _loc1_ = _loc1_.filter(titanUltraFilter);
         _loc1_.sort(TitanDescription.sort_fireWaterEarth);
         return _loc1_;
      }
      
      public function get dungeonActivityPoints() : IntProperty
      {
         return _dungeonActivityPoints;
      }
      
      public function get timeLeft() : String
      {
         return _timeLeft;
      }
      
      public function get dungeonActivityForNextKey() : int
      {
         return DataStorage.clanDungeonActivityReward.getPointsForNextKey(dungeonActivityPoints.value);
      }
      
      public function get dungeonRewardForNextKey() : InventoryItem
      {
         return DataStorage.clanDungeonActivityReward.getNextRewardItem(dungeonActivityPoints.value);
      }
      
      public function get openFreeCost() : InventoryItem
      {
         return new InventoryItem(cost_single.outputDisplayFirst.item,openFreeMultiplier * cost_single.outputDisplayFirst.amount);
      }
      
      public function get openPaidCost() : InventoryItem
      {
         return cost_pack.outputDisplayFirst;
      }
      
      public function get openCostX10() : InventoryItem
      {
         return cost_pack_x10.outputDisplayFirst;
      }
      
      public function get openFreeMultiplier() : int
      {
         var _loc3_:int = GameModel.instance.player.inventory.getItemCount(DataStorage.coin.getByIdent("summon_key"));
         if(!DataStorage.rule.summoningCircleMultiplierRule.useMultiplierInTutorial && Tutorial.inputIsBlocked)
         {
            return 1;
         }
         if(player.titans.getAmount() < DataStorage.rule.summoningCircleMultiplierRule.minTitanAmountToMultiply)
         {
            return 1;
         }
         var _loc2_:int = DataStorage.rule.summoningCircleMultiplierRule.multiplierMax;
         var _loc1_:int = DataStorage.rule.summoningCircleMultiplierRule.multiplierStep;
         if(_loc3_ >= _loc2_ * cost_single.outputDisplayFirst.amount)
         {
            return _loc2_;
         }
         if(_loc3_ >= _loc1_ * cost_single.outputDisplayFirst.amount)
         {
            return Math.floor(_loc3_ / (_loc1_ * cost_single.outputDisplayFirst.amount)) * _loc1_;
         }
         return 1;
      }
      
      public function get signal_resetTimeUpdate() : Signal
      {
         return _signal_resetTimeUpdate;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new SummoningCirclePopUp(this);
         return _popup;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney(true);
         _loc1_.requre_coin(DataStorage.coin.getByIdent("summon_key"));
         return _loc1_;
      }
      
      public function action_summon(param1:Boolean, param2:uint) : void
      {
         var _loc3_:CommandTitanUseSummoningCircle = GameModel.instance.actionManager.titan.titanUseSummonCircle(param1,param2);
         _loc3_.signal_complete.add(onSummonComplete);
         HeroRewardPopupHandler.instance.hold();
      }
      
      public function action_navigate_dungeon() : void
      {
         GamePopupManager.closeAll();
         Game.instance.navigator.navigateToMechanic(MechanicStorage.CLAN_DUNGEON,_popup.stashParams);
      }
      
      public function action_updateClanActivity() : void
      {
         if(player && player.clan.clan)
         {
            player.clan.clan.activityUpdateManager.requestUpdate();
         }
      }
      
      public function action_showTitanInfo(param1:TitanDescription) : void
      {
         var _loc2_:OpenTitanPopupCommand = new OpenTitanPopupCommand(player,param1,Stash.click("summoning_circle",_popup.stashParams));
         _loc2_.execute();
      }
      
      private function titanSimpleFilter(param1:TitanDescription, param2:int, param3:Vector.<TitanDescription>) : Boolean
      {
         return !titanUltraFilter(param1,param2,param3);
      }
      
      private function titanUltraFilter(param1:TitanDescription, param2:int, param3:Vector.<TitanDescription>) : Boolean
      {
         if(param1.details.type == "ultra")
         {
            return true;
         }
         return false;
      }
      
      private function onSummonComplete(param1:CommandTitanUseSummoningCircle) : void
      {
         var _loc2_:RewardValueObjectList = new RewardValueObjectList(param1.rewardList);
         dungeonActivityPoints.value = param1.dungeonActivity;
         var _loc3_:SummoningCircleRewardPopupMediator = new SummoningCircleRewardPopupMediator(GameModel.instance.player,_loc2_,param1.paid,param1.amount);
         _loc3_.signal_reSummon.add(handler_circleReSummon);
         _loc3_.open(_popup.stashParams);
      }
      
      private function handler_circleReSummon(param1:Boolean, param2:uint) : void
      {
         action_summon(param1,param2);
      }
      
      private function handler_timer() : void
      {
         if(player.clan.clan)
         {
            _timeLeft = TimeFormatter.toMS2(player.clan.clan.resetTime - GameTimer.instance.currentServerTime);
            _signal_resetTimeUpdate.dispatch();
         }
      }
      
      private function handler_summonKeyCoinUpdate(param1:InventoryItemCountProxy) : void
      {
         signal_summonKeyCoinUpdate.dispatch();
      }
      
      private function handler_summoningCircleStarmoneySpent() : void
      {
         signal_starmoneySpent.dispatch();
      }
   }
}
