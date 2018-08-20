package game.mechanics.clan_war.mediator
{
   import game.mechanics.clan_war.model.ClanWarParticipantValueObject;
   import game.mechanics.clan_war.model.ClanWarSlotValueObject;
   import game.mechanics.clan_war.popup.war.ClanWarScreen;
   import game.mechanics.clan_war.storage.ClanWarFortificationDescription;
   import game.mediator.gui.popup.clan.ClanPopupMediatorBase;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   
   public class ClanWarScreenMediator extends ClanPopupMediatorBase
   {
       
      
      private var _participant_us:ClanWarParticipantValueObject;
      
      private var _participant_them:ClanWarParticipantValueObject;
      
      public function ClanWarScreenMediator(param1:Player)
      {
         super(param1);
         _participant_us = param1.clan.clanWarData.currentWar.participant_us;
         _participant_them = param1.clan.clanWarData.currentWar.participant_them;
      }
      
      public function get participant_us() : ClanWarParticipantValueObject
      {
         return _participant_us;
      }
      
      public function get participant_them() : ClanWarParticipantValueObject
      {
         return _participant_them;
      }
      
      public function action_openMemberList_our() : void
      {
         var _loc1_:ActiveClanWarMembersPopupMediator = new ActiveClanWarMembersPopupMediator(GameModel.instance.player,true);
         _loc1_.open(Stash.click("members_our",_popup.stashParams));
      }
      
      public function action_openMemberList_enemy() : void
      {
         var _loc1_:ActiveClanWarMembersPopupMediator = new ActiveClanWarMembersPopupMediator(GameModel.instance.player,false);
         _loc1_.open(Stash.click("members_their",_popup.stashParams));
      }
      
      public function action_selectEnemyBuilding(param1:ClanWarFortificationDescription) : void
      {
         var _loc2_:Vector.<ClanWarSlotValueObject> = player.clan.clanWarData.currentWar.getEnemySlotsByFortification(param1);
         var _loc3_:ClanWarAttackPopupMediator = new ClanWarAttackPopupMediator(player,param1,_loc2_);
         _loc3_.open(Stash.click("attack",_popup.stashParams));
      }
      
      public function action_selectMyBuilding(param1:ClanWarFortificationDescription) : void
      {
         var _loc2_:Vector.<ClanWarSlotValueObject> = player.clan.clanWarData.currentWar.getOurSlotsByFortification(param1);
         var _loc3_:ClanWarDefensePopupMediator = new ClanWarDefensePopupMediator(player,param1,_loc2_);
         _loc3_.open(Stash.click("view_defense",_popup.stashParams));
      }
      
      public function getOurSlots(param1:ClanWarFortificationDescription) : Vector.<ClanWarSlotValueObject>
      {
         return player.clan.clanWarData.currentWar.getOurSlotsByFortification(param1);
      }
      
      public function getEnemySlots(param1:ClanWarFortificationDescription) : Vector.<ClanWarSlotValueObject>
      {
         return player.clan.clanWarData.currentWar.getEnemySlotsByFortification(param1);
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ClanWarScreen(this);
         return _popup;
      }
   }
}
