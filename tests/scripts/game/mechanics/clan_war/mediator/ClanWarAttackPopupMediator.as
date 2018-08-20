package game.mechanics.clan_war.mediator
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.IntPropertyWriteable;
   import feathers.data.ListCollection;
   import game.battle.controller.thread.BattleThread;
   import game.battle.controller.thread.ClanWarHeroBattleThread;
   import game.battle.controller.thread.ClanWarTitanBattleThread;
   import game.data.storage.mechanic.MechanicStorage;
   import game.mechanics.clan_war.model.ClanWarSlotValueObject;
   import game.mechanics.clan_war.model.command.CommandClanWarAttack;
   import game.mechanics.clan_war.model.command.CommandClanWarEndBattle;
   import game.mechanics.clan_war.popup.war.attack.ClanWarAttackPopup;
   import game.mechanics.clan_war.popup.war.attack.ClanWarAttackTeamGatherPopupMediator;
   import game.mechanics.clan_war.storage.ClanWarFortificationDescription;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.clan.ClanPopupMediatorBase;
   import game.mediator.gui.popup.mission.MissionDefeatPopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.screen.BattleScreen;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.PopupBase;
   
   public class ClanWarAttackPopupMediator extends ClanPopupMediatorBase
   {
       
      
      private var buildingDesc:ClanWarFortificationDescription;
      
      private var _tries_personal:IntProperty;
      
      private var _tries_clan:IntProperty;
      
      private var _points_sum:IntPropertyWriteable;
      
      private var _defenderListData:ListCollection;
      
      private var _text_desc:String;
      
      private var attackedSlot:ClanWarSlotValueObject;
      
      private var teamGatherPopup:ClanWarAttackTeamGatherPopupMediator;
      
      public function ClanWarAttackPopupMediator(param1:Player, param2:ClanWarFortificationDescription, param3:Vector.<ClanWarSlotValueObject>)
      {
         _points_sum = new IntPropertyWriteable();
         super(param1);
         this.buildingDesc = param2;
         _defenderListData = new ListCollection();
         var _loc6_:int = 0;
         var _loc5_:* = param3;
         for each(var _loc4_ in param3)
         {
            defenderListData.addItem(_loc4_);
         }
         _tries_personal = param1.clan.clanWarData.currentWar.myTries;
         _tries_clan = param1.clan.clanWarData.currentWar.ourClanTries.displayValue_triesLeft;
         param1.clan.clanWarData.currentWar.property_points.onValue(handler_updatePoints);
      }
      
      override protected function dispose() : void
      {
         player.clan.clanWarData.currentWar.property_points.unsubscribe(handler_updatePoints);
         super.dispose();
      }
      
      public function get isTierLocked() : Boolean
      {
         return !player.clan.clanWarData.currentWar.getIsTierAvailable(buildingDesc.tier);
      }
      
      public function get showClanTries() : Boolean
      {
         return player.clan.clanWarData.currentWar.showClanTries;
      }
      
      public function get tierLockedMessage() : String
      {
         if(buildingDesc.tier == 2)
         {
            return Translate.translate("UI_POPUP_BUILDING_SELECTED_ATTACK_TIER_2_LOCK_MSG");
         }
         return Translate.translate("UI_POPUP_BUILDING_SELECTED_ATTACK_TIER_3_LOCK_MSG");
      }
      
      public function get tries_personal() : IntProperty
      {
         return _tries_personal;
      }
      
      public function get tries_clan() : IntProperty
      {
         return _tries_clan;
      }
      
      public function get points_sum() : IntProperty
      {
         return _points_sum;
      }
      
      public function get defenderListData() : ListCollection
      {
         return _defenderListData;
      }
      
      public function get text_desc() : String
      {
         return Translate.translateArgs("UI_POPUP_BUILDING_SELECTED_TF_DESC",victoryPoints);
      }
      
      public function get text_header() : String
      {
         return Translate.translateArgs("UI_POPUP_BUILDING_SELECTED_ATTACK_TF_HEADER",buildingDesc.name);
      }
      
      public function get victoryPointsTooltip() : String
      {
         return Translate.translateArgs("UI_POPUP_BUILDING_SELECTED_TF_DESC",victoryPoints);
      }
      
      public function get victoryPoints() : int
      {
         return buildingDesc.pointReward * player.clan.clanWarData.currentWar.pointMultiplier;
      }
      
      public function action_select(param1:ClanWarSlotValueObject) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:* = null;
         if(param1.team)
         {
            _loc4_ = player.clan.clanWarData.currentWar.myTries.value;
            _loc3_ = player.clan.clanWarData.currentWar.clanTries.value;
            if(_loc4_ > 0 && _loc3_ > 0)
            {
               _loc2_ = new ClanWarAttackTeamGatherPopupMediator(player,param1);
               _loc2_.signal_teamGatherComplete.addOnce(handler_atackTeamGatheringComplete);
               _loc2_.open();
            }
            else
            {
               if(_loc3_ == 0)
               {
                  PopupList.instance.message(Translate.translate("UI_CLAN_WAR_ATTACK_BLOCK_TF_TRIES_CLAN_NOT_ENOUGH"));
               }
               if(_loc4_ == 0)
               {
                  PopupList.instance.message(Translate.translate("UI_CLAN_WAR_ATTACK_BLOCK_TF_TRIES_PERSONAL_NOT_ENOUGH"));
               }
            }
         }
         else
         {
            action_claimFreeSlots();
            close();
         }
      }
      
      public function action_claimFreeSlots() : void
      {
         player.clan.clanWarData.action_takeEmptySlots();
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ClanWarAttackPopup(this);
         return _popup;
      }
      
      private function handler_atackTeamGatheringComplete(param1:ClanWarAttackTeamGatherPopupMediator) : void
      {
         var _loc2_:* = null;
         this.attackedSlot = param1.slot;
         this.teamGatherPopup = param1;
         if(player.clan.clanWarData.currentWar)
         {
            _loc2_ = player.clan.clanWarData.currentWar.action_attack(param1.slot,param1.descriptionList);
            _loc2_.onClientExecute(startBattle);
         }
      }
      
      private function startBattle(param1:CommandClanWarAttack) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = undefined;
         var _loc4_:* = null;
         if(param1.startBattleError)
         {
            _loc2_ = param1.startBattleError.toUpperCase();
            PopupList.instance.message(Translate.translate("UI_CLAN_WAR_ATTACK_ERROR_" + _loc2_));
         }
         else
         {
            _loc3_ = param1.battle;
            player.clan.clanWarData.currentWar.currentBattle.startCurrentBattle(param1.slot,param1.endTime);
            if(_loc3_)
            {
               if(teamGatherPopup.slot.isHeroSlot)
               {
                  _loc4_ = new ClanWarHeroBattleThread(_loc3_,player.getUserInfo(),param1.slot.defender.user);
               }
               else
               {
                  _loc4_ = new ClanWarTitanBattleThread(_loc3_,player.getUserInfo(),param1.slot.defender.user);
               }
               _loc4_.onComplete.addOnce(handler_battleComplete);
               _loc4_.run();
               teamGatherPopup.close();
               teamGatherPopup = null;
            }
         }
      }
      
      private function handler_battleComplete(param1:ClanWarHeroBattleThread) : void
      {
         var _loc2_:CommandClanWarEndBattle = GameModel.instance.actionManager.clanWar.clanWarEndBattle(param1.battleResult,param1.completedWithRetreat);
         _loc2_.onClientExecute(handler_battleEndCommandExecuted);
      }
      
      private function handler_battleEndCommandExecuted(param1:CommandClanWarEndBattle) : void
      {
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(player.clan.clanWarData.currentWar)
         {
            player.clan.clanWarData.currentWar.action_endBattle(attackedSlot,param1);
         }
         if(!param1.success)
         {
            Game.instance.screen.hideBattle();
            return;
         }
         var _loc4_:Boolean = true;
         if(_loc4_)
         {
            _loc6_ = new ClanWarBattleVictoryPopupMediator(player,attackedSlot,param1);
            _loc5_ = Game.instance.screen.getBattleScreen();
            if(_loc5_ && _loc5_.scene && !param1.completedWithRetreat)
            {
               _loc2_ = _loc6_.createPopup() as ClipBasedPopup;
               _loc5_.gui.lockAndHideControlls();
               _loc5_.gui.addBattlePopup(_loc2_);
               _loc5_.scene.setBlur();
               _loc6_.signal_closed.add(handler_victoryPopupClosed);
            }
            else
            {
               Game.instance.screen.hideBattle();
               _loc6_.open();
            }
         }
         else
         {
            Game.instance.screen.hideBattle();
            _loc3_ = new MissionDefeatPopupMediator(GameModel.instance.player,param1.battleResultValueObject,MechanicStorage.CLAN_DUNGEON);
            _loc3_.open();
         }
      }
      
      protected function handler_victoryPopupClosed() : void
      {
         Game.instance.screen.hideBattle();
      }
      
      private function handler_updatePoints(param1:int) : void
      {
         var _loc5_:int = 0;
         if(player.clan.clanWarData.currentWar == null)
         {
            return;
         }
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Vector.<ClanWarSlotValueObject> = player.clan.clanWarData.currentWar.getEnemySlotsByFortification(buildingDesc);
         var _loc3_:int = _loc2_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            if(_loc2_[_loc5_].slotState == ClanWarSlotState.DEFEATED)
            {
               _loc4_++;
            }
            _loc6_ = _loc6_ + _loc2_[_loc5_].pointsFarmed;
            _loc5_++;
         }
         if(_loc4_ == _loc3_)
         {
            _loc6_ = _loc6_ + buildingDesc.pointReward * player.clan.clanWarData.currentWar.pointMultiplier;
         }
         _points_sum.value = _loc6_;
      }
   }
}
