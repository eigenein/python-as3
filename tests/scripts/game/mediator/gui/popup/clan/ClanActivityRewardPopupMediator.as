package game.mediator.gui.popup.clan
{
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.IntProperty;
   import game.command.timer.GameTimer;
   import game.data.storage.DataStorage;
   import game.data.storage.clan.ClanActivityRewardDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.mediator.gui.popup.clan.activitystats.ClanActivityStatsPopupMediator;
   import game.mediator.gui.popup.hero.HeroRuneListPopupMediator;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.stat.Stash;
   import game.util.TimeFormatter;
   import game.view.popup.PopupBase;
   import game.view.popup.clan.ClanActivityRewardPopup;
   import idv.cjcat.signals.Signal;
   
   public class ClanActivityRewardPopupMediator extends ClanPopupMediatorBase
   {
      
      public static const QUEST_FOR_ACTIVITY_ID:int = 10005;
       
      
      private var _property_giftsRedMark:BooleanProperty;
      
      private var _pointsCost:InventoryItem;
      
      private var _paidPoints:int;
      
      private var _name:Type;
      
      private var _paidPointsPurchased:Boolean;
      
      private var _rewardList:Vector.<ClanActivityRewardDescription>;
      
      private var _signal_paidPointsUpdate:Signal;
      
      private var _signal_updatePoints:Signal;
      
      private var _signal_resetTimeUpdate:Signal;
      
      private var _timeLeft:String;
      
      public function ClanActivityRewardPopupMediator(param1:Player)
      {
         _signal_paidPointsUpdate = new Signal();
         _signal_updatePoints = new Signal();
         _signal_resetTimeUpdate = new Signal();
         super(param1);
         _pointsCost = DataStorage.rule.clanRule.paidActivityPoints_cost.outputDisplay[0];
         _paidPoints = DataStorage.rule.clanRule.paidActivityPoints_amount;
         _rewardList = DataStorage.clanActivityReward.getList();
         _paidPointsPurchased = false;
         handler_timer();
         GameTimer.instance.oneSecTimer.add(handler_timer);
         _property_giftsRedMark = param1.clan.property_redMark_clanGiftCount;
      }
      
      override protected function dispose() : void
      {
         super.dispose();
         GameTimer.instance.oneSecTimer.remove(handler_timer);
      }
      
      public function get property_giftsRedMark() : BooleanProperty
      {
         return _property_giftsRedMark;
      }
      
      public function get hasClan() : Boolean
      {
         return player.clan.clan;
      }
      
      public function get guildPoints() : IntProperty
      {
         return player.clan.clan.activityPoints;
      }
      
      public function get personalPoints() : IntProperty
      {
         return player.clan.clan.stat.todayActivity;
      }
      
      public function get pointsCost() : InventoryItem
      {
         return _pointsCost;
      }
      
      public function get paidPoints() : int
      {
         return _paidPoints;
      }
      
      public function get pointsPerQuest() : int
      {
         return DataStorage.rule.clanRule.activityForRuneUpgrade;
      }
      
      public function get activityForRuneAvailable() : BooleanProperty
      {
         return player.clan.clan.stat.activityForRuneAvailable;
      }
      
      public function get name() : Type
      {
         return _name;
      }
      
      public function get paidPointsPurchased() : Boolean
      {
         return _paidPointsPurchased;
      }
      
      public function get rewardList() : Vector.<ClanActivityRewardDescription>
      {
         return _rewardList;
      }
      
      public function get signal_paidPointsUpdate() : Signal
      {
         return _signal_paidPointsUpdate;
      }
      
      public function get signal_updatePoints() : Signal
      {
         return _signal_updatePoints;
      }
      
      public function get signal_resetTimeUpdate() : Signal
      {
         return _signal_resetTimeUpdate;
      }
      
      public function get timeLeft() : String
      {
         return _timeLeft;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ClanActivityRewardPopup(this);
         return _popup;
      }
      
      public function action_gifts() : void
      {
         var _loc1_:ClanActivityStatsPopupMediator = new ClanActivityStatsPopupMediator(player);
         _loc1_.open(Stash.click("gifts",_popup.stashParams));
      }
      
      public function action_itemExchange() : void
      {
         var _loc1_:ClanItemForActivityPopupMediator = new ClanItemForActivityPopupMediator(player);
         _loc1_.open();
      }
      
      public function action_forge() : void
      {
         var _loc1_:HeroRuneListPopupMediator = new HeroRuneListPopupMediator(player);
         _loc1_.open(Stash.click("clan_forge",_popup.stashParams));
      }
      
      public function action_campaign() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.MISSION,Stash.click("clan_activity_to_campaign",_popup.stashParams));
      }
      
      public function action_purchasePoints() : void
      {
         _paidPointsPurchased = true;
         _signal_paidPointsUpdate.dispatch();
         _signal_updatePoints.dispatch();
      }
      
      public function action_addedToStage() : void
      {
         if(player.clan.clan)
         {
            player.clan.clan.activityUpdateManager.requestUpdate();
         }
      }
      
      private function handler_timer() : void
      {
         if(player.clan.clan)
         {
            _timeLeft = TimeFormatter.toMS2(player.clan.clan.resetTime - GameTimer.instance.currentServerTime);
            _signal_resetTimeUpdate.dispatch();
         }
      }
   }
}
