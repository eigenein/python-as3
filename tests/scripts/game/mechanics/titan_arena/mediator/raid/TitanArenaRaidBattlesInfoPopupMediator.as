package game.mechanics.titan_arena.mediator.raid
{
   import com.progrestar.common.lang.Translate;
   import feathers.core.PopUpManager;
   import game.battle.controller.instant.ArenaInstantReplay;
   import game.battle.controller.thread.BattleThread;
   import game.battle.controller.thread.TitanArenaBattleThread;
   import game.command.rpc.arena.ArenaBattleResultValueObject;
   import game.data.storage.DataStorage;
   import game.mechanics.titan_arena.mediator.TitanArenaRoundResultValueObject;
   import game.mechanics.titan_arena.model.PlayerTitanArenaEnemy;
   import game.mechanics.titan_arena.model.TitanArenaRaidBattleItem;
   import game.mechanics.titan_arena.popup.raid.TitanArenaRaidBattlesInfoPopup;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.chat.sendreplay.SendReplayPopUpMediator;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.model.user.Player;
   import game.model.user.UserInfo;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.statistics.BattleStatisticsPopup;
   
   public class TitanArenaRaidBattlesInfoPopupMediator extends PopupMediator
   {
       
      
      private var item:TitanArenaRaidBattleItem;
      
      private var _hpPercentState:Vector.<Number>;
      
      public function TitanArenaRaidBattlesInfoPopupMediator(param1:Player, param2:TitanArenaRaidBattleItem)
      {
         super(param1);
         this.item = param2;
      }
      
      public function get enemy() : PlayerTitanArenaEnemy
      {
         return item.enemy;
      }
      
      public function get playerUserInfo() : UserInfo
      {
         return player.getUserInfo();
      }
      
      public function get attackersTeam() : Vector.<UnitEntryValueObject>
      {
         return player.titanArenaData.defenders;
      }
      
      public function get defendersTeam() : Vector.<UnitEntryValueObject>
      {
         return player.titanArenaData.defenders;
      }
      
      public function get resultAttack() : TitanArenaRoundResultValueObject
      {
         return item.resultAttack;
      }
      
      public function get resultDefence() : TitanArenaRoundResultValueObject
      {
         return item.resultDefence;
      }
      
      public function get pointsAttack() : String
      {
         return item.enemy.points_attack + "/" + item.enemy.points_attackMax;
      }
      
      public function get pointsDefence() : String
      {
         return item.enemy.points_defense + "/" + item.enemy.points_defenseMax;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TitanArenaRaidBattlesInfoPopup(this);
         return _popup;
      }
      
      public function attackReplay() : void
      {
         replay(playerUserInfo,enemy,item.rawAttackBattle);
      }
      
      public function attackInfo() : void
      {
         info(playerUserInfo,enemy,item.rawAttackBattle);
      }
      
      public function attackShare() : void
      {
         share(playerUserInfo,enemy,item.rawAttackBattle.id);
      }
      
      public function defenceReplay() : void
      {
         replay(enemy,playerUserInfo,item.rawDefenceBattle);
      }
      
      public function defenceInfo() : void
      {
         info(enemy,playerUserInfo,item.rawDefenceBattle);
      }
      
      public function defenceShare() : void
      {
         share(enemy,playerUserInfo,item.rawDefenceBattle.id);
      }
      
      protected function info(param1:UserInfo, param2:UserInfo, param3:Object) : void
      {
         var _loc4_:ArenaInstantReplay = new ArenaInstantReplay(param3,null);
         _loc4_.config = DataStorage.battleConfig.titanClanPvp;
         _loc4_.signal_invalidReplay.add(handler_invalidReplay);
         _loc4_.signal_hasInstantReplayResult.add(handler_hasInstantReplayResult);
         _loc4_.start();
      }
      
      private function handler_hasInstantReplayResult(param1:ArenaInstantReplay) : void
      {
         var _loc2_:ArenaBattleResultValueObject = new ArenaBattleResultValueObject();
         _loc2_.result = param1.result;
         PopUpManager.addPopUp(new BattleStatisticsPopup(_loc2_.attackerTeamStats,_loc2_.defenderTeamStats));
      }
      
      private function handler_invalidReplay(param1:ArenaInstantReplay) : void
      {
         if(param1.incorrectVersionHigh)
         {
            PopupList.instance.message(Translate.translate("UI_ARENA_INCORRECT_VERSION_HIGH"));
         }
         else if(param1.incorrectVersionLow)
         {
            PopupList.instance.message(Translate.translate("UI_TOWER_VALIDATION_ERROR"));
         }
         else
         {
            PopupList.instance.message(Translate.translate("UI_TOWER_VALIDATION_ERROR"));
         }
      }
      
      protected function replay(param1:UserInfo, param2:UserInfo, param3:Object) : void
      {
         var _loc4_:* = null;
         if(param3)
         {
            _loc4_ = new TitanArenaBattleThread(param3,param1,param2);
            _loc4_.onComplete.addOnce(handler_battleEnded);
            _loc4_.run();
         }
      }
      
      protected function handler_battleEnded(param1:BattleThread) : void
      {
         Game.instance.screen.hideBattle();
      }
      
      protected function share(param1:UserInfo, param2:UserInfo, param3:String) : void
      {
         var _loc4_:String = !!param1?param1.nickname:"?";
         var _loc5_:String = !!param2?param2.nickname:"?";
         var _loc6_:String = Translate.translateArgs("UI_CLAN_WAR_SEND_REPLAY_TEXT",_loc4_,_loc5_);
         new SendReplayPopUpMediator(player,param3,_loc6_,2).open(Stash.click("titan_arena_send_replay",_popup.stashParams));
      }
   }
}
