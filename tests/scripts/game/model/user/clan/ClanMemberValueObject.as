package game.model.user.clan
{
   import engine.context.GameContext;
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.clan.ClanRole;
   import game.model.user.UserInfo;
   import idv.cjcat.signals.Signal;
   
   public class ClanMemberValueObject extends UserInfo
   {
       
      
      private var _signal_updateRole:Signal;
      
      private var _signal_updateStat:Signal;
      
      private var _activitySum:int;
      
      private var _todayActivity:int;
      
      private var _dungeonActivitySum:int;
      
      private var _todayDungeonActivity:int;
      
      private var _raidSum:int;
      
      private var _wasChampion:Boolean;
      
      private var _clanRoleDesc:ClanRole;
      
      private var _showProfile:Boolean;
      
      public function ClanMemberValueObject(param1:ClanBasicInfoValueObject, param2:Object)
      {
         _signal_updateRole = new Signal(ClanMemberValueObject);
         _signal_updateStat = new Signal(ClanMemberValueObject);
         super();
         _clanInfo = param1;
         _clanRoleDesc = DataStorage.clanRole.getByCode(param2.clanRole);
         _id = param2.id;
         _showProfile = param2.showProfile && GameContext.instance.platformFacade.canNavigateToSocialProfile;
         _wasChampion = param2.wasChampion;
         parse(param2);
      }
      
      public function get signal_updateRole() : Signal
      {
         return _signal_updateRole;
      }
      
      public function get signal_updateStat() : Signal
      {
         return _signal_updateStat;
      }
      
      public function get activitySum() : int
      {
         return _activitySum;
      }
      
      public function get todayActivity() : int
      {
         return _todayActivity;
      }
      
      public function get dungeonActivitySum() : int
      {
         return _dungeonActivitySum;
      }
      
      public function get todayDungeonActivity() : int
      {
         return _todayDungeonActivity;
      }
      
      public function get raidSum() : int
      {
         return _raidSum;
      }
      
      public function get wasChampion() : Boolean
      {
         return _wasChampion;
      }
      
      public function get clanRoleDesc() : ClanRole
      {
         return _clanRoleDesc;
      }
      
      public function get showProfile() : Boolean
      {
         return _showProfile;
      }
      
      public function get clanRoleString() : String
      {
         if(_clanInfo is ClanBasicInfoValueObject)
         {
            return (_clanInfo as ClanBasicInfoValueObject).roleNames.getRoleString(_clanRoleDesc);
         }
         return _clanRoleDesc.roleName;
      }
      
      function internal_setRole(param1:int) : void
      {
         _clanRole = param1;
         _clanRoleDesc = DataStorage.clanRole.getByCode(param1);
         _signal_updateRole.dispatch(this);
      }
      
      function internal_addRawStat(param1:Object) : void
      {
         _activitySum = param1.activitySum;
         _todayActivity = param1.todayActivity;
         _dungeonActivitySum = param1.dungeonActivitySum;
         _todayDungeonActivity = param1.todayDungeonActivity;
         _raidSum = param1.raidSum;
         _wasChampion = param1.wasChampion;
         _signal_updateStat.dispatch(this);
      }
      
      function internal_setActivity(param1:int, param2:int) : void
      {
         _activitySum = param1;
         _todayActivity = param2;
         _signal_updateStat.dispatch(this);
      }
      
      function internal_setDungeonActivity(param1:int, param2:int) : void
      {
         _dungeonActivitySum = param1;
         _todayDungeonActivity = param2;
         _signal_updateStat.dispatch(this);
      }
   }
}
