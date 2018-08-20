package game.mechanics.clan_war.mediator
{
   import feathers.core.PopUpManager;
   import game.mechanics.clan_war.model.ClanWarParticipantValueObject;
   import game.mechanics.clan_war.model.ClanWarSlotValueObject;
   import game.mechanics.clan_war.model.command.CommandClanWarEndBattle;
   import game.mechanics.clan_war.popup.victory.ClanWarBattleVictoryPopup;
   import game.mechanics.dungeon.model.command.CommandDungeonEndBattle;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.arena.BattleResultValueObject;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.model.user.Player;
   import game.model.user.UserInfo;
   import game.view.popup.PopupBase;
   import game.view.popup.statistics.BattleStatisticsPopup;
   import idv.cjcat.signals.Signal;
   import starling.events.Event;
   
   public class ClanWarBattleVictoryPopupMediator extends PopupMediator
   {
       
      
      private var result:BattleResultValueObject;
      
      private var cmd:CommandClanWarEndBattle;
      
      private var _hpPercentState:Vector.<Number>;
      
      private var _participant_us:ClanWarParticipantValueObject;
      
      private var _participant_them:ClanWarParticipantValueObject;
      
      private var _team_me:Vector.<UnitEntryValueObject>;
      
      private var _team_them:Vector.<UnitEntryValueObject>;
      
      private var _user_me:UserInfo;
      
      private var _user_them:UserInfo;
      
      private var _buildingId:int;
      
      private var _buildingName:String;
      
      private var _signal_complete:Signal;
      
      public const signal_closed:Signal = new Signal();
      
      public function ClanWarBattleVictoryPopupMediator(param1:Player, param2:ClanWarSlotValueObject, param3:CommandClanWarEndBattle)
      {
         _signal_complete = new Signal(CommandDungeonEndBattle);
         super(param1);
         this.cmd = param3;
         this.result = param3.battleResultValueObject;
         _participant_us = param1.clan.clanWarData.currentWar.participant_us;
         _participant_them = param1.clan.clanWarData.currentWar.participant_them;
         _user_me = param1.getUserInfo();
         _user_them = param2.defender.user;
         _team_me = result.result.attackers;
         _team_them = result.result.defenders;
         _buildingName = param2.fortificationDesc.name;
         _hpPercentState = param2.defender.hpPercentState;
      }
      
      public function get hpPercentState() : Vector.<Number>
      {
         return _hpPercentState;
      }
      
      public function get victory() : Boolean
      {
         return cmd.victory;
      }
      
      public function get participant_us() : ClanWarParticipantValueObject
      {
         return _participant_us;
      }
      
      public function get participant_them() : ClanWarParticipantValueObject
      {
         return _participant_them;
      }
      
      public function get team_me() : Vector.<UnitEntryValueObject>
      {
         return _team_me;
      }
      
      public function get team_them() : Vector.<UnitEntryValueObject>
      {
         return _team_them;
      }
      
      public function get user_me() : UserInfo
      {
         return _user_me;
      }
      
      public function get user_them() : UserInfo
      {
         return _user_them;
      }
      
      public function get points_base() : int
      {
         return cmd.slotVictoryPoints;
      }
      
      public function get points_building() : int
      {
         return cmd.fortificationVictoryPoints;
      }
      
      public function get buildingId() : int
      {
         return _buildingId;
      }
      
      public function get buildingName() : String
      {
         return _buildingName;
      }
      
      public function get signal_complete() : Signal
      {
         return _signal_complete;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ClanWarBattleVictoryPopup(this);
         return _popup;
      }
      
      public function action_showStats() : void
      {
         var _loc1_:BattleStatisticsPopup = new BattleStatisticsPopup(result.attackerTeamStats,result.defenderTeamStats);
         _loc1_.addEventListener("removed",handler_statisticsPopupRemoved);
         PopUpManager.addPopUp(_loc1_);
         Game.instance.screen.hideNotDisposedBattle();
      }
      
      override public function close() : void
      {
         super.close();
         signal_closed.dispatch();
      }
      
      private function handler_statisticsPopupRemoved(param1:Event) : void
      {
         Game.instance.screen.showNotDisposedBattle();
      }
   }
}
