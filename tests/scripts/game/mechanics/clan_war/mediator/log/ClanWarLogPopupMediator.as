package game.mechanics.clan_war.mediator.log
{
   import feathers.data.ListCollection;
   import game.mechanics.clan_war.mediator.ActiveClanWarMembersPopupMediator;
   import game.mechanics.clan_war.model.command.CommandClanWarGetAvailableHistory;
   import game.mechanics.clan_war.model.command.CommandClanWarGetDayHistory;
   import game.mechanics.clan_war.popup.log.ClanWarLogPopup;
   import game.mechanics.clan_war.popup.log.ClanWarLogSeasonEntry;
   import game.mediator.gui.popup.clan.ClanPopupMediatorBase;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   
   public class ClanWarLogPopupMediator extends ClanPopupMediatorBase
   {
       
      
      private var _logs:Vector.<ClanWarLogValueObject>;
      
      public const logs:ListCollection = new ListCollection();
      
      public function ClanWarLogPopupMediator(param1:Player, param2:Vector.<ClanWarLogEntry>, param3:ClanWarLogSeasonEntry)
      {
         _logs = new Vector.<ClanWarLogValueObject>();
         super(param1);
         parseLogs(param2,param3);
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ClanWarLogPopup(this);
         return new ClanWarLogPopup(this);
      }
      
      public function action_select(param1:ClanWarLogItem) : void
      {
         var _loc2_:CommandClanWarGetDayHistory = GameModel.instance.actionManager.clanWar.clanWarGetDayHistory(param1.dayVo,param1.attacker,param1.defender);
         _loc2_.onClientExecute(handler_commandGetDayHistory);
      }
      
      public function action_openMemberList_attacker(param1:ClanWarLogItem) : void
      {
         var _loc2_:* = false;
         var _loc3_:* = null;
         if(param1.isCurrent)
         {
            _loc2_ = player.clan.clanWarData.currentWar.participant_us == param1.attacker;
            _loc3_ = new ActiveClanWarMembersPopupMediator(GameModel.instance.player,_loc2_);
            _loc3_.open(Stash.click("members_our",_popup.stashParams));
         }
      }
      
      public function action_openMemberList_defender(param1:ClanWarLogItem) : void
      {
         var _loc2_:* = false;
         var _loc3_:* = null;
         if(param1.isCurrent)
         {
            _loc2_ = player.clan.clanWarData.currentWar.participant_us == param1.attacker;
            _loc3_ = new ActiveClanWarMembersPopupMediator(GameModel.instance.player,!_loc2_);
            _loc3_.open(Stash.click("members_our",_popup.stashParams));
         }
      }
      
      protected function requestLogs() : void
      {
         var _loc1_:CommandClanWarGetAvailableHistory = GameModel.instance.actionManager.clanWar.clanWarGetAvailableHistory();
         _loc1_.onClientExecute(handler_commandClanWarGetAvailableHistory);
      }
      
      protected function parseLogs(param1:Vector.<ClanWarLogEntry>, param2:ClanWarLogSeasonEntry) : void
      {
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc8_:* = null;
         var _loc4_:* = null;
         _logs.length = 0;
         var _loc7_:int = param1.length;
         if(_loc7_ == 0)
         {
            logs.data = _logs;
            return;
         }
         var _loc5_:String = null;
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc3_ = param1[_loc6_];
            _loc8_ = new ClanWarLogItem(player,_loc3_);
            if(_loc8_.isDecider)
            {
               _loc4_ = new ClanWarLogSeasonEndData(param2,true,_loc3_.isUpward);
               _logs.push(createLogFooter(param1,_loc8_,_loc6_,_loc4_));
               _loc5_ = null;
            }
            else if(_loc3_.day.season != _loc5_)
            {
               if(_loc5_)
               {
                  _loc4_ = new ClanWarLogSeasonEndData(param2,false,_loc3_.isUpward);
                  _logs.push(createLogFooter(param1,_loc8_,_loc6_,_loc4_));
               }
               _loc5_ = _loc3_.day.season;
               _logs.push(createLogHeader(param1,_loc8_,_loc6_));
            }
            _logs.push(createLogContent(param1,_loc8_,1));
            _loc6_++;
         }
         logs.data = _logs;
      }
      
      private function createLogHeader(param1:Vector.<ClanWarLogEntry>, param2:ClanWarLogItem, param3:int) : ClanWarLogValueObject
      {
         return new ClanWarLogValueObject(this,param2,0);
      }
      
      private function createLogFooter(param1:Vector.<ClanWarLogEntry>, param2:ClanWarLogItem, param3:int, param4:ClanWarLogSeasonEndData) : ClanWarLogValueObject
      {
         return new ClanWarLogValueObject(this,param2,2,param4);
      }
      
      private function createLogContent(param1:Vector.<ClanWarLogEntry>, param2:ClanWarLogItem, param3:int) : ClanWarLogValueObject
      {
         return new ClanWarLogValueObject(this,param2,1);
      }
      
      private function handler_commandClanWarGetAvailableHistory(param1:CommandClanWarGetAvailableHistory) : void
      {
         var _loc2_:Vector.<ClanWarLogEntry> = param1.logs;
         parseLogs(param1.logs,param1.lastSeasonResult);
      }
      
      private function handler_commandGetDayHistory(param1:CommandClanWarGetDayHistory) : void
      {
         var _loc2_:ClanWarLogBattlePopupMediator = new ClanWarLogBattlePopupMediator(player,param1.log);
         _loc2_.open(Stash.click("dayLog",_popup.stashParams));
      }
   }
}
