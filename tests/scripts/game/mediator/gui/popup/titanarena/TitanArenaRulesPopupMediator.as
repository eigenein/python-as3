package game.mediator.gui.popup.titanarena
{
   import game.data.storage.DataStorage;
   import game.data.storage.titanarenaleague.TitanArenaReward;
   import game.data.storage.titanarenaleague.TitanArenaTournamentReward;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   import game.view.popup.titanarena.TitanArenaRulesPopup;
   
   public class TitanArenaRulesPopupMediator extends PopupMediator
   {
      
      public static const TAB_CUPS:String = "TAB_CUPS";
      
      public static const TAB_POINTS:String = "TAB_POINTS";
      
      public static const TAB_RULES:String = "TAB_RULES";
       
      
      private var _tabs:Vector.<String>;
      
      public var selectedTab:String;
      
      public function TitanArenaRulesPopupMediator(param1:Player, param2:String = "TAB_RULES")
      {
         super(param1);
         _tabs = new Vector.<String>();
         _tabs.push("TAB_RULES");
         _tabs.push("TAB_CUPS");
         _tabs.push("TAB_POINTS");
         this.selectedTab = param2;
      }
      
      public function get tournamentRaidIsStageBased() : Boolean
      {
         return player.titanArenaData.maxTier > 6;
      }
      
      public function get victoryRewardList() : Vector.<TitanArenaReward>
      {
         return DataStorage.titanArena.getVictoryRewardList();
      }
      
      public function get dailyRewardList() : Vector.<TitanArenaReward>
      {
         return DataStorage.titanArena.getDailyRewardList();
      }
      
      public function get tabs() : Vector.<String>
      {
         return _tabs;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TitanArenaRulesPopup(this);
         return new TitanArenaRulesPopup(this);
      }
      
      public function getTournamentRewardListByCupId(param1:uint) : Vector.<TitanArenaTournamentReward>
      {
         return DataStorage.titanArena.getTournamentRewardListByCupId(param1);
      }
   }
}
