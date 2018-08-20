package game.view.popup.clan
{
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import game.command.rpc.clan.CommandClanUpdateRoleNames;
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.clan.ClanPopupMediatorBase;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.clan.ClanRoleNames;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.PopupBase;
   
   public class ClanEditRolesPopupMediator extends ClanPopupMediatorBase
   {
       
      
      private var _owner:String = "";
      
      private var _officer:String = "";
      
      private var _member:String = "";
      
      private var _warlord:String = "";
      
      private var _regexp:RegExp;
      
      private var clanRoleNames:ClanRoleNames;
      
      private const _rolesWasChanged:BooleanPropertyWriteable = new BooleanPropertyWriteable(false);
      
      private const _roleIsUpdating:BooleanPropertyWriteable = new BooleanPropertyWriteable(false);
      
      public const rolesWasChanged:BooleanProperty = _rolesWasChanged;
      
      public const rolesIsUpdating:BooleanProperty = _roleIsUpdating;
      
      public const defaultOwner:String = DataStorage.clanRole.getByCode(255).roleName;
      
      public const defaultOfficer:String = DataStorage.clanRole.getByCode(3).roleName;
      
      public const defaultMember:String = DataStorage.clanRole.getByCode(2).roleName;
      
      public const defaultWarlord:String = DataStorage.clanRole.getByCode(4).roleName;
      
      public function ClanEditRolesPopupMediator(param1:Player)
      {
         super(param1);
         clanRoleNames = param1.clan.clan.roleNames;
         var _loc2_:String = DataStorage.rule.nicknameUpdate.regexp;
         var _loc3_:String = _loc2_.slice(1,_loc2_.lastIndexOf("/"));
         var _loc4_:String = _loc2_.slice(_loc2_.lastIndexOf("/") + 1);
         _regexp = new RegExp(_loc3_,_loc4_);
      }
      
      public function get changeRolesCost() : InventoryItem
      {
         var _loc1_:Vector.<InventoryItem> = DataStorage.rule.clanRule.changeRoleNamesCost.outputDisplay;
         if(_loc1_ && _loc1_.length > 0)
         {
            return _loc1_[0];
         }
         return new InventoryItem(DataStorage.pseudo.STARMONEY,100);
      }
      
      public function get owner() : String
      {
         return _owner;
      }
      
      public function get officer() : String
      {
         return _officer;
      }
      
      public function get member() : String
      {
         return _member;
      }
      
      public function get warlord() : String
      {
         return _warlord;
      }
      
      public function get currentOwner() : String
      {
         return clanRoleNames.owner;
      }
      
      public function get currentOfficer() : String
      {
         return clanRoleNames.officer;
      }
      
      public function get currentMember() : String
      {
         return clanRoleNames.member;
      }
      
      public function get currentWarlord() : String
      {
         return clanRoleNames.warlord;
      }
      
      public function get maxChars() : int
      {
         return DataStorage.rule.clanRule.maxTitleLength;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ClanEditRolesPopup(this);
         return _popup;
      }
      
      public function action_updateRoleNames() : void
      {
         var _loc1_:CommandClanUpdateRoleNames = GameModel.instance.actionManager.clan.clanUpdateRoleNames(_owner,_officer,_member,_warlord);
         _loc1_.onClientExecute(handler_updateRoleNames);
         _roleIsUpdating.value = true;
         _rolesWasChanged.value = true;
      }
      
      public function updateRoles(param1:String, param2:String, param3:String, param4:String) : void
      {
         _owner = param1;
         _officer = param2;
         _member = param3;
         _warlord = param4;
         var _loc5_:Boolean = param1 == currentOwner && param2 == currentOfficer && param3 == currentMember && param4 == currentWarlord;
         _rolesWasChanged.value = !_loc5_;
      }
      
      public function verifyRoleName(param1:String) : String
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:* = null;
         while(param1.indexOf(" ") == 0)
         {
            param1 = param1.slice(1);
         }
         if(param1.length > DataStorage.rule.clanRule.maxTitleLength)
         {
            param1 = param1.slice(0,DataStorage.rule.clanRule.maxTitleLength);
         }
         _loc4_ = param1.length;
         while(_loc4_ >= 0)
         {
            _loc3_ = param1.charAt(_loc4_).toLowerCase();
            _loc2_ = _loc3_.match(_regexp);
            if(_loc2_ && _loc2_.length > 0)
            {
               param1 = param1.slice(0,_loc4_) + param1.slice(_loc4_ + 1);
            }
            _loc4_--;
         }
         return param1;
      }
      
      private function handler_updateRoleNames(param1:CommandClanUpdateRoleNames) : void
      {
         _rolesWasChanged.value = false;
         _roleIsUpdating.value = false;
      }
   }
}
