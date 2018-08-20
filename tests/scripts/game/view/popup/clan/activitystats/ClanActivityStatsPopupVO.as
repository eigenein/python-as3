package game.view.popup.clan.activitystats
{
   import game.model.user.clan.ClanMemberValueObject;
   
   public class ClanActivityStatsPopupVO
   {
       
      
      public var isPlayer:Boolean;
      
      public var isDungeon:Boolean;
      
      private var _id:String;
      
      public var member:ClanMemberValueObject;
      
      public var activity:Array;
      
      public var likeFlags:Array;
      
      public function ClanActivityStatsPopupVO(param1:Object, param2:Array)
      {
         var _loc3_:int = 0;
         super();
         _id = param1.id;
         activity = param2;
         activity.reverse();
         likeFlags = [];
         _loc3_ = 0;
         while(_loc3_ < 8)
         {
            likeFlags[_loc3_] = false;
            _loc3_++;
         }
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get nickname() : String
      {
         return !!member?member.nickname:"";
      }
      
      public function get value_total() : int
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = activity.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _loc1_ + activity[_loc3_];
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function value_byDay(param1:int) : int
      {
         return activity[param1];
      }
   }
}
