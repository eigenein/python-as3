package game.model.user.clan
{
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.clan.ClanRole;
   
   public class ClanRoleNames
   {
       
      
      private var _owner:String;
      
      private var _officer:String;
      
      private var _member:String;
      
      private var _warlord:String;
      
      public function ClanRoleNames(param1:* = null)
      {
         super();
         if(param1)
         {
            update(param1);
         }
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
      
      public function update(param1:Object) : void
      {
         _owner = param1.owner;
         _officer = param1.officer;
         _member = param1.member;
         _warlord = param1.warlord;
      }
      
      public function getRoleString(param1:ClanRole) : String
      {
         var _loc2_:* = param1.code;
         if(255 !== _loc2_)
         {
            if(3 !== _loc2_)
            {
               if(2 !== _loc2_)
               {
                  if(4 === _loc2_)
                  {
                     if(_warlord)
                     {
                        return _warlord;
                     }
                  }
               }
               else if(_member)
               {
                  return _member;
               }
            }
            else if(_officer)
            {
               return _officer;
            }
         }
         else if(_owner)
         {
            return _owner;
         }
         return param1.roleName;
      }
      
      public function get displayedTitle_warlord() : String
      {
         return getRoleString(DataStorage.clanRole.getByCode(4));
      }
      
      public function get displayedTitle_leader() : String
      {
         return getRoleString(DataStorage.clanRole.getByCode(255));
      }
      
      public function get displayedTitle_officer() : String
      {
         return getRoleString(DataStorage.clanRole.getByCode(3));
      }
      
      public function get displayedTitle_member() : String
      {
         return getRoleString(DataStorage.clanRole.getByCode(2));
      }
   }
}
