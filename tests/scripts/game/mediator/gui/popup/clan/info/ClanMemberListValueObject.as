package game.mediator.gui.popup.clan.info
{
   import game.model.user.UserInfo;
   import game.model.user.clan.ClanMemberValueObject;
   import idv.cjcat.signals.Signal;
   
   public class ClanMemberListValueObject
   {
       
      
      protected var member:ClanMemberValueObject;
      
      private var _showSumActivity:Boolean;
      
      public const signal_updateRole:Signal = new Signal(ClanMemberListValueObject);
      
      public const signal_updatePoints:Signal = new Signal(ClanMemberListValueObject);
      
      public function ClanMemberListValueObject(param1:ClanMemberValueObject)
      {
         super();
         this.member = param1;
         param1.signal_updateRole.add(handler_updateRole);
         param1.signal_updateStat.add(handler_updateStat);
      }
      
      public static function sort_byActivity(param1:ClanMemberListValueObject, param2:ClanMemberListValueObject) : int
      {
         return param2.member.activitySum - param1.member.activitySum;
      }
      
      public static function sort_byTodayActivity(param1:ClanMemberListValueObject, param2:ClanMemberListValueObject) : int
      {
         var _loc3_:int = param2.member.todayActivity - param1.member.todayActivity;
         if(_loc3_ != 0)
         {
            return _loc3_;
         }
         return param2.member.activitySum - param1.member.activitySum;
      }
      
      public static function sort_byDungeonActivity(param1:ClanMemberListValueObject, param2:ClanMemberListValueObject) : int
      {
         return param2.member.dungeonActivitySum - param1.member.dungeonActivitySum;
      }
      
      public static function sort_byTodayDungeonActivity(param1:ClanMemberListValueObject, param2:ClanMemberListValueObject) : int
      {
         var _loc3_:int = param2.member.todayDungeonActivity - param1.member.todayDungeonActivity;
         if(_loc3_ != 0)
         {
            return _loc3_;
         }
         return param2.member.dungeonActivitySum - param1.member.dungeonActivitySum;
      }
      
      public function dispose() : void
      {
         member.signal_updateStat.remove(handler_updateStat);
         member.signal_updateRole.remove(handler_updateRole);
         member = null;
      }
      
      public function get userInfo() : UserInfo
      {
         return member;
      }
      
      public function get id() : String
      {
         return member.id;
      }
      
      public function get nickname() : String
      {
         return member.nickname;
      }
      
      public function get level() : int
      {
         return member.level;
      }
      
      public function get role() : int
      {
         return member.clanRole;
      }
      
      public function get roleString() : String
      {
         return member.clanRoleString;
      }
      
      public function get defaultRoleString() : String
      {
         return member.clanRoleDesc.roleName;
      }
      
      public function get canEdit() : Boolean
      {
         return false;
      }
      
      public function get canDismiss() : Boolean
      {
         return false;
      }
      
      public function get showProfile() : Boolean
      {
         return member.showProfile;
      }
      
      public function get activityPoints() : int
      {
         if(_showSumActivity)
         {
            return member.activitySum;
         }
         return member.todayActivity;
      }
      
      public function get dungeonActivityPoints() : int
      {
         if(_showSumActivity)
         {
            return member.dungeonActivitySum;
         }
         return member.todayDungeonActivity;
      }
      
      public function toggleActivityToShow(param1:Boolean) : void
      {
         _showSumActivity = param1;
      }
      
      private function handler_updateRole(param1:ClanMemberValueObject) : void
      {
         signal_updateRole.dispatch(this);
      }
      
      private function handler_updateStat(param1:ClanMemberValueObject) : void
      {
         signal_updatePoints.dispatch(this);
      }
   }
}
