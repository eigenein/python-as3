package game.model.user.clan
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import game.command.realtime.SocketClientEvent;
   import game.command.rpc.clan.CommandClanCreate;
   import game.command.rpc.clan.CommandClanGetInfo;
   import game.command.rpc.clan.CommandClanJoin;
   import game.data.storage.DataStorage;
   import game.data.storage.refillable.RefillableDescription;
   import game.mechanics.clan_war.model.PlayerClanWarData;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.clan.ClanRole;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.refillable.PlayerRefillableEntry;
   import idv.cjcat.signals.Signal;
   
   public class PlayerClanData
   {
       
      
      private var player:Player;
      
      private var _playerRole:ClanRole;
      
      private var _clan:ClanPrivateInfoValueObject;
      
      private var _signal_clanUpdate:Signal;
      
      private var _signal_roleUpdate:Signal;
      
      private var _clanWarData:PlayerClanWarData;
      
      private var _property_redMark_clanGiftCount:BooleanPropertyWriteable;
      
      public function PlayerClanData(param1:Player)
      {
         _signal_clanUpdate = new Signal();
         _signal_roleUpdate = new Signal();
         _property_redMark_clanGiftCount = new BooleanPropertyWriteable();
         super();
         this.player = param1;
         _clanWarData = new PlayerClanWarData(param1);
      }
      
      public function get playerRole() : ClanRole
      {
         return _playerRole;
      }
      
      public function get clan() : ClanPrivateInfoValueObject
      {
         return _clan;
      }
      
      public function get signal_clanUpdate() : Signal
      {
         return _signal_clanUpdate;
      }
      
      public function get signal_roleUpdate() : Signal
      {
         return _signal_roleUpdate;
      }
      
      public function get clanWarData() : PlayerClanWarData
      {
         return _clanWarData;
      }
      
      public function get property_redMark_clanGiftCount() : BooleanProperty
      {
         return _property_redMark_clanGiftCount;
      }
      
      public function init(param1:Object, param2:Object, param3:Object, param4:Object) : void
      {
         if(param1)
         {
            _clan = new ClanPrivateInfoValueObject(param1,player);
            _clan.property_giftsCount.signal_update.add(handler_clanGiftCountUpdate);
            setPlayerRole(DataStorage.clanRole.getByCode(param2.clanRole));
         }
         GameModel.instance.actionManager.messageClient.subscribe("clanDismissMember",handler_push_dismissMember);
         GameModel.instance.actionManager.messageClient.subscribe("clanInfoUpdated",handler_push_infoUpdated);
         GameModel.instance.actionManager.messageClient.subscribe("clanLevelUp",handler_push_levelUp);
         GameModel.instance.actionManager.messageClient.subscribe("clanNewMember",handler_push_newMember);
         GameModel.instance.actionManager.messageClient.subscribe("clanRoleChanged",handler_push_roleChanged);
         GameModel.instance.actionManager.messageClient.subscribe("clanActivityReward",handler_push_activityReward);
         GameModel.instance.actionManager.messageClient.subscribe("clanWarFillFortification",handler_message_clanWarFillFortification);
         GameModel.instance.actionManager.messageClient.subscribe("clanWarSetDefenceTeam",handler_message_setDefenseTeam);
         GameModel.instance.actionManager.messageClient.subscribe("clanWarAttack",handler_message_clanWarAttack);
         GameModel.instance.actionManager.messageClient.subscribe("clanWarEndBattle",handler_message_clanWarEndBattle);
         GameModel.instance.actionManager.messageClient.subscribe("clanWarFarmEmpty",handler_message_clanWarFarmEmpty);
         GameModel.instance.actionManager.messageClient.subscribe("clanWarChampion",handler_message_clanWarChampion);
         updateRedMark_clanGiftCount();
         _clanWarData.init(param3,param4);
      }
      
      public function action_leave() : void
      {
         setPlayerRole(null);
         _clan = null;
         var _loc2_:RefillableDescription = DataStorage.refillable.getByIdent("clanReenter_cooldown");
         var _loc1_:PlayerRefillableEntry = player.refillable.getById(_loc2_.id);
         player.refillable.empty(_loc1_);
         _signal_clanUpdate.dispatch();
      }
      
      public function action_disband() : void
      {
         action_leave();
      }
      
      public function action_dismissMember(param1:String) : void
      {
      }
      
      public function action_create(param1:CommandClanCreate) : void
      {
         _clan = new ClanPrivateInfoValueObject(param1.result.body,player);
         setPlayerRole(DataStorage.clanRole.getByCode(255));
         _signal_clanUpdate.dispatch();
      }
      
      public function action_join(param1:CommandClanJoin) : void
      {
         _clan = new ClanPrivateInfoValueObject(param1.result.body,player);
         setPlayerRole(DataStorage.clanRole.getByCode(2));
         _signal_clanUpdate.dispatch();
      }
      
      public function action_updateServerData() : void
      {
         var _loc1_:CommandClanGetInfo = GameModel.instance.actionManager.clan.clanGetInfo();
         _loc1_.onClientExecute(handler_clanInfoUpdate);
      }
      
      private function updateRedMark_clanGiftCount() : void
      {
         _property_redMark_clanGiftCount.value = clan != null && clan.property_giftsCount.value > 0 && playerRole.permission_disband;
      }
      
      private function setPlayerRole(param1:ClanRole) : void
      {
         _playerRole = param1;
         clanWarData.action_handleRoleUpdate(_playerRole);
      }
      
      private function handler_push_dismissMember(param1:SocketClientEvent) : void
      {
         var _loc3_:String = param1.data.body.userId;
         var _loc2_:String = param1.data.body.byUserId;
         if(_loc3_ == player.id)
         {
            if(_loc3_ != _loc2_)
            {
               action_leave();
               PopupList.instance.message(Translate.translateArgs("UI_CLAN_KICKED_TITLE",Translate.genderTriggerString(GameModel.instance.player.male)));
            }
         }
         else if(_clan)
         {
            clan.internal_removeMember(_loc3_);
            clan.internal_updateTodayActivityOnMemberDismiss(param1.data.body.activityPoints);
            clan.internal_updateTodayDungeonActivityOnMemberDismiss(param1.data.body.dungeonPoints);
         }
      }
      
      private function handler_push_roleChanged(param1:SocketClientEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ClanMemberValueObject = clan.getMemberById(param1.data.body.userId);
         if(_loc3_)
         {
            _loc2_ = param1.data.body.newRole;
            _loc3_.internal_setRole(_loc2_);
            if(_loc3_.id == player.id)
            {
               setPlayerRole(DataStorage.clanRole.getByCode(_loc2_));
               _signal_roleUpdate.dispatch();
            }
         }
      }
      
      private function handler_push_activityReward(param1:SocketClientEvent) : void
      {
         if(_clan)
         {
            _clan.internal_handleActivityRewardMessage(param1.data.body);
         }
      }
      
      private function handler_push_infoUpdated(param1:SocketClientEvent) : void
      {
         if(_clan)
         {
            _clan.internal_handleInfoUpdate(param1.data.body);
         }
      }
      
      private function handler_push_levelUp(param1:SocketClientEvent) : void
      {
      }
      
      private function handler_push_newMember(param1:SocketClientEvent) : void
      {
         var _loc2_:* = null;
         if(param1 && param1.data && param1.data.body && param1.data.body.user && clan)
         {
            param1.data.body.user.wasChampion = Boolean(param1.data.body.wasChampion);
            _loc2_ = new ClanMemberValueObject(clan,param1.data.body.user);
            clan.internal_addMember(_loc2_);
         }
      }
      
      private function handler_clanInfoUpdate(param1:CommandClanGetInfo) : void
      {
         if(clan)
         {
            clan.internal_updateServerInfo(param1.result.body);
         }
      }
      
      private function handler_message_clanWarFillFortification(param1:SocketClientEvent) : void
      {
         if(clanWarData)
         {
            clanWarData.handler_message_clanWarFillFortification(param1);
         }
      }
      
      private function handler_message_setDefenseTeam(param1:SocketClientEvent) : void
      {
         if(clanWarData)
         {
            clanWarData.handler_message_setDefenseTeam(param1);
         }
      }
      
      private function handler_message_clanWarEndBattle(param1:SocketClientEvent) : void
      {
         if(clanWarData)
         {
            clanWarData.handler_message_clanWarEndBattle(param1);
         }
      }
      
      private function handler_message_clanWarAttack(param1:SocketClientEvent) : void
      {
         if(clanWarData)
         {
            clanWarData.handler_message_clanWarAttack(param1);
         }
      }
      
      private function handler_message_clanWarFarmEmpty(param1:SocketClientEvent) : void
      {
         if(clanWarData)
         {
            clanWarData.handler_message_clanWarFarmEmpty(param1);
         }
      }
      
      private function handler_message_clanWarChampion(param1:SocketClientEvent) : void
      {
         if(clanWarData)
         {
            clanWarData.handler_message_clanWarChampion(param1);
         }
      }
      
      private function handler_clanGiftCountUpdate(param1:int) : void
      {
         updateRedMark_clanGiftCount();
      }
   }
}
