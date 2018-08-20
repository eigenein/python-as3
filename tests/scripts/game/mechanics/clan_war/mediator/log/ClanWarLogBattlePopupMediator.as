package game.mechanics.clan_war.mediator.log
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.VectorUtil;
   import engine.core.utils.property.ObjectProperty;
   import engine.core.utils.property.ObjectPropertyWriteable;
   import feathers.core.PopUpManager;
   import feathers.data.ListCollection;
   import game.battle.controller.instant.ArenaInstantReplay;
   import game.battle.controller.thread.BattleThread;
   import game.battle.controller.thread.ClanWarHeroBattleThread;
   import game.battle.controller.thread.ClanWarTitanBattleThread;
   import game.command.rpc.arena.ArenaBattleResultValueObject;
   import game.data.storage.DataStorage;
   import game.mechanics.clan_war.mediator.ActiveClanWarMembersPopupMediator;
   import game.mechanics.clan_war.model.ClanWarParticipantValueObject;
   import game.mechanics.clan_war.popup.log.ClanWarLogBattlePopup;
   import game.mechanics.clan_war.storage.ClanWarSlotDescription;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.arena.ArenaLogEntryVOProxy;
   import game.mediator.gui.popup.chat.sendreplay.SendReplayPopUpMediator;
   import game.mediator.gui.popup.clan.ClanPopupMediatorBase;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.UserInfo;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.arena.log.ArenaLogEntryPopup;
   import game.view.popup.statistics.BattleStatisticsPopup;
   
   public class ClanWarLogBattlePopupMediator extends ClanPopupMediatorBase
   {
      
      public static const TAB_ATTACK:int = 0;
      
      public static const TAB_DEFENCE:int = 1;
       
      
      private var warLog:ClanWarLogWarEntry;
      
      private var attackData:Vector.<ClanWarLogBattleValueObjectBase>;
      
      private var defenceData:Vector.<ClanWarLogBattleValueObjectBase>;
      
      private var _selectedTabIndex:int;
      
      private var _attacker:ObjectPropertyWriteable;
      
      private var _defender:ObjectPropertyWriteable;
      
      public const dataProvider:ListCollection = new ListCollection();
      
      public const tabsNames:Vector.<String> = new Vector.<String>();
      
      public function ClanWarLogBattlePopupMediator(param1:Player, param2:ClanWarLogWarEntry)
      {
         var _loc4_:int = 0;
         _attacker = new ObjectPropertyWriteable(ClanWarParticipantValueObject,null);
         _defender = new ObjectPropertyWriteable(ClanWarParticipantValueObject,null);
         super(param1);
         this.warLog = param2;
         var _loc3_:int = 2;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            tabsNames.push(Translate.translate("UI_CLAN_WAR_LOG_DAY_TAB_" + _loc4_));
            _loc4_++;
         }
         action_selectTab(0);
      }
      
      public function get selectedTabIndex() : int
      {
         return _selectedTabIndex;
      }
      
      public function get attacker() : ObjectProperty
      {
         return _attacker;
      }
      
      public function get defender() : ObjectProperty
      {
         return _defender;
      }
      
      public function get isCurrentWar() : Boolean
      {
         return player.clan.clanWarData.currentWar && player.clan.clanWarData.currentWar.day.isEqual(warLog.day);
      }
      
      public function get warDateString() : String
      {
         return warLog.day.date;
      }
      
      public function action_selectTab(param1:int) : void
      {
         if(param1 == 0)
         {
            §§push(dataProvider);
            if(attackData)
            {
               §§push(attackData);
            }
            else
            {
               attackData = createData(warLog.attack);
               §§push(createData(warLog.attack));
            }
            §§pop().data = §§pop();
            _attacker.value = warLog.attacker;
            _defender.value = warLog.defender;
         }
         else if(param1 == 1)
         {
            §§push(dataProvider);
            if(defenceData)
            {
               §§push(defenceData);
            }
            else
            {
               defenceData = createData(warLog.defence);
               §§push(createData(warLog.defence));
            }
            §§pop().data = §§pop();
            _attacker.value = warLog.defender;
            _defender.value = warLog.attacker;
         }
         _selectedTabIndex = param1;
      }
      
      public function action_chat(param1:ClanWarLogBattleValueObject) : void
      {
         var _loc4_:* = null;
         var _loc3_:UserInfo = param1.attacker.user;
         var _loc6_:UserInfo = param1.defender.user;
         var _loc2_:String = !!_loc3_?_loc3_.nickname:"?";
         var _loc5_:String = !!_loc6_?_loc6_.nickname:"?";
         _loc4_ = Translate.translateArgs("UI_CLAN_WAR_SEND_REPLAY_TEXT",_loc2_,_loc5_);
         new SendReplayPopUpMediator(player,param1.rawReplay.id,_loc4_,2).open(Stash.click("arena_log_send_replay",_popup.stashParams));
      }
      
      public function action_info(param1:ClanWarLogBattleValueObject) : void
      {
         var _loc2_:ArenaInstantReplay = new ArenaInstantReplay(param1.rawReplay,param1);
         if(param1.isHeroBattle)
         {
            _loc2_.config = DataStorage.battleConfig.clanPvp;
         }
         else
         {
            _loc2_.config = DataStorage.battleConfig.titanClanPvp;
         }
         _loc2_.signal_invalidReplay.add(handler_invalidReplay);
         _loc2_.signal_hasInstantReplayResult.add(handler_hasInstantReplayResult);
         _loc2_.start();
      }
      
      public function action_replay(param1:ClanWarLogBattleValueObject) : void
      {
         var _loc2_:* = null;
         var _loc3_:Object = param1.rawReplay;
         if(_loc3_)
         {
            if(param1.isHeroBattle)
            {
               _loc2_ = new ClanWarHeroBattleThread(_loc3_,param1.attacker.user,param1.defender.user);
            }
            else
            {
               _loc2_ = new ClanWarTitanBattleThread(_loc3_,param1.attacker.user,param1.defender.user);
            }
            _loc2_.onComplete.addOnce(handler_battleEnded);
            _loc2_.run();
         }
      }
      
      public function action_openMemberList_attacker() : void
      {
         var _loc1_:* = false;
         var _loc2_:* = null;
         if(isCurrentWar)
         {
            _loc1_ = player.clan.clanWarData.currentWar.participant_us == _attacker.value;
            _loc2_ = new ActiveClanWarMembersPopupMediator(GameModel.instance.player,_loc1_);
            _loc2_.open(Stash.click("members_our",_popup.stashParams));
         }
      }
      
      public function action_openMemberList_defender() : void
      {
         var _loc1_:* = false;
         var _loc2_:* = null;
         if(isCurrentWar)
         {
            _loc1_ = player.clan.clanWarData.currentWar.participant_us == _attacker.value;
            _loc2_ = new ActiveClanWarMembersPopupMediator(GameModel.instance.player,!_loc1_);
            _loc2_.open(Stash.click("members_our",_popup.stashParams));
         }
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ClanWarLogBattlePopup(this);
         return new ClanWarLogBattlePopup(this);
      }
      
      protected function createData(param1:Vector.<ClanWarLogBattleEntry>) : Vector.<ClanWarLogBattleValueObjectBase>
      {
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc8_:* = null;
         var _loc2_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:* = null;
         var _loc5_:Vector.<ClanWarLogBattleValueObjectBase> = new Vector.<ClanWarLogBattleValueObjectBase>();
         var _loc9_:int = param1.length;
         _loc6_ = 0;
         while(_loc6_ < _loc9_)
         {
            _loc4_ = param1[_loc6_];
            _loc8_ = DataStorage.clanWar.getSlotById(_loc4_.slotId);
            if(_loc4_.wasEmpty)
            {
               _loc2_ = 1;
               _loc7_ = _loc6_ + 1;
               while(_loc7_ < _loc9_)
               {
                  _loc3_ = DataStorage.clanWar.getSlotById(param1[_loc7_].slotId);
                  if(param1[_loc7_].wasEmpty && _loc3_.fortificationDesc == _loc8_.fortificationDesc)
                  {
                     _loc2_++;
                     VectorUtil.removeAt(param1,_loc7_);
                     _loc9_--;
                     _loc7_--;
                  }
                  _loc7_++;
               }
               _loc5_.push(new ClanWarLogBattleFreeValueObject(this,_loc4_,_loc2_));
            }
            else
            {
               _loc5_.push(new ClanWarLogBattleValueObject(this,_loc4_));
            }
            if(_loc4_.fortificationPoints > 0)
            {
               _loc5_.push(new ClanWarLogBattleCaptureValueObject(this,_loc4_));
            }
            _loc6_++;
         }
         return _loc5_;
      }
      
      protected function handler_battleEnded(param1:BattleThread) : void
      {
         Game.instance.screen.hideBattle();
      }
      
      private function handler_hasInstantReplayResult(param1:ArenaInstantReplay) : void
      {
         var _loc2_:ArenaBattleResultValueObject = new ArenaBattleResultValueObject();
         _loc2_.result = param1.result;
         PopUpManager.addPopUp(new BattleStatisticsPopup(_loc2_.attackerTeamStats,_loc2_.defenderTeamStats));
      }
      
      private function handler_invalidReplay(param1:ArenaInstantReplay) : void
      {
         var _loc2_:ArenaLogEntryVOProxy = param1.data as ArenaLogEntryVOProxy;
         if(_loc2_)
         {
            PopUpManager.addPopUp(new ArenaLogEntryPopup(_loc2_));
         }
         if(param1.incorrectVersionHigh)
         {
            PopupList.instance.message(Translate.translate("UI_ARENA_INCORRECT_VERSION_HIGH"));
         }
         else if(!param1.incorrectVersionLow)
         {
         }
      }
   }
}
