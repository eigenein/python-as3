package game.mediator.gui.popup.clan
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.PopupList;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.UserInfo;
   import game.view.popup.PopupBase;
   import game.view.popup.PromptPopup;
   import game.view.popup.clan.role.ClanEditRolePopup;
   
   public class ClanEditRolePopupMediator extends ClanPopupMediatorBase
   {
       
      
      private var member:ClanMemberListPrivateValueObject;
      
      private var _data:Vector.<ClanEditRolePopupValueObject>;
      
      private var _roles:Vector.<ClanRole>;
      
      private var _rank1:ClanRole;
      
      private var _rank2:ClanRole;
      
      private var _rank3:ClanRole;
      
      public function ClanEditRolePopupMediator(param1:Player, param2:ClanMemberListPrivateValueObject)
      {
         var _loc6_:int = 0;
         var _loc4_:* = undefined;
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         super(param1);
         this.member = param2;
         _data = new Vector.<ClanEditRolePopupValueObject>();
         _roles = new Vector.<ClanRole>();
         _roles.push(DataStorage.clanRole.getByCode(255));
         _roles.push(DataStorage.clanRole.getByCode(4));
         _roles.push(DataStorage.clanRole.getByCode(3));
         _roles.push(DataStorage.clanRole.getByCode(2));
         var _loc7_:Vector.<String> = new <String>["permission_dismiss_member","permission_edit_admin_rank","permission_edit_champion_status","permission_edit_banner","permission_edit_settings"];
         var _loc3_:int = _loc7_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            if(_rank1 && _rank2 && !_rank3 && roles[_loc6_].code != param2.role)
            {
               _rank3 = roles[_loc6_];
            }
            if(_rank1 && !_rank2 && roles[_loc6_].code != param2.role)
            {
               _rank2 = roles[_loc6_];
            }
            if(!_rank1 && roles[_loc6_].code != param2.role)
            {
               _rank1 = roles[_loc6_];
            }
            _loc4_ = new Vector.<Boolean>();
            _loc8_ = roles.length;
            _loc5_ = 0;
            while(_loc5_ < _loc8_)
            {
               _loc4_.push(roles[_loc5_][_loc7_[_loc6_]]);
               _loc5_++;
            }
            _data.push(new ClanEditRolePopupValueObject(Translate.translate("LIB_CLAN_" + _loc7_[_loc6_].toUpperCase()),_loc4_));
            _loc6_++;
         }
      }
      
      public function get nickname() : String
      {
         return member.nickname;
      }
      
      public function get currentRole() : String
      {
         return member.defaultRoleString;
      }
      
      public function get data() : Vector.<ClanEditRolePopupValueObject>
      {
         return _data;
      }
      
      public function get userInfo() : UserInfo
      {
         return member.userInfo;
      }
      
      public function get roles() : Vector.<ClanRole>
      {
         return _roles;
      }
      
      public function get rank1() : ClanRole
      {
         return _rank1;
      }
      
      public function get rank2() : ClanRole
      {
         return _rank2;
      }
      
      public function get rank3() : ClanRole
      {
         return _rank3;
      }
      
      public function action_rankOne() : void
      {
         changeRank(_rank1);
      }
      
      public function action_rankTwo() : void
      {
         changeRank(_rank2);
      }
      
      public function action_rankThree() : void
      {
         changeRank(_rank3);
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ClanEditRolePopup(this);
         return _popup;
      }
      
      private function changeRank(param1:ClanRole) : void
      {
         var _loc2_:* = null;
         if(param1.permission_edit_admin_rank)
         {
            _loc2_ = PopupList.instance.prompt(Translate.translateArgs("UI_POPUP_CLAN_CHANGE_LEADER_MSG",member.nickname),Translate.translate("UI_POPUP_CLAN_CHANGE_LEADER_TITLE"),Translate.translate("UI_COMMON_YES"),Translate.translate("UI_COMMON_NO"));
            _loc2_.data = param1;
            _loc2_.signal_confirm.addOnce(handler_memberChangeRoleConfirmed);
         }
         else
         {
            GameModel.instance.actionManager.clan.clanChangeRole(member.id,param1);
            close();
         }
      }
      
      private function handler_memberChangeRoleConfirmed(param1:PromptPopup) : void
      {
         GameModel.instance.actionManager.clan.clanChangeRole(member.id,param1.data as ClanRole);
         close();
      }
   }
}
