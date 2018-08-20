package game.model.user.clan
{
   import game.model.user.ClanUserInfoValueObject;
   
   public class ClanBasicInfoValueObject extends ClanUserInfoValueObject
   {
       
      
      protected var data:Object;
      
      protected var _topActivity:int;
      
      protected var _description:String;
      
      protected var _country:int;
      
      protected var _disbanding:Boolean;
      
      protected var _membersCount:int;
      
      protected var _minLevel:int;
      
      protected var _ownerId:int;
      
      protected var _frameId:int;
      
      protected var _members:Vector.<ClanMemberValueObject>;
      
      protected var _roleNames:ClanRoleNames;
      
      public function ClanBasicInfoValueObject(param1:Object)
      {
         super();
         this.data = param1;
         setup(param1);
         _members = new Vector.<ClanMemberValueObject>();
         _description = param1.description;
         _country = param1.country;
         _disbanding = param1.disbanding;
         _ownerId = param1.ownerId;
         _frameId = param1.frameId;
         _topActivity = param1.topActivity;
         _minLevel = param1.minLevel;
         _membersCount = param1.membersCount;
         _roleNames = new ClanRoleNames(param1.roleNames);
      }
      
      public function get topActivity() : int
      {
         return _topActivity;
      }
      
      public function get description() : String
      {
         return _description;
      }
      
      public function get country() : int
      {
         return _country;
      }
      
      public function get disbanding() : Boolean
      {
         return _disbanding;
      }
      
      public function get membersCount() : int
      {
         return _membersCount;
      }
      
      public function get minLevel() : int
      {
         return _minLevel;
      }
      
      public function get ownerId() : int
      {
         return _ownerId;
      }
      
      public function get frameId() : int
      {
         return _frameId;
      }
      
      public function get members() : Vector.<ClanMemberValueObject>
      {
         return _members;
      }
      
      public function get roleNames() : ClanRoleNames
      {
         return _roleNames;
      }
      
      public function getMemberById(param1:String) : ClanMemberValueObject
      {
         var _loc3_:int = 0;
         var _loc2_:int = _members.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_members[_loc3_].id == param1)
            {
               return _members[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      public function parseMembers(param1:Object) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc2_ in param1)
         {
            _loc3_ = new ClanMemberValueObject(this,_loc2_);
            _members.push(_loc3_);
         }
      }
      
      protected function parseMemberStat(param1:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc2_:Array = param1.membersStat;
         if(_loc2_)
         {
            _loc3_ = _loc2_.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc6_ = _loc2_[_loc4_];
               if(_loc6_)
               {
                  _loc5_ = getMemberById(_loc6_.userId);
                  if(_loc5_)
                  {
                     _loc5_.internal_addRawStat(_loc6_);
                  }
               }
               _loc4_++;
            }
         }
      }
   }
}
