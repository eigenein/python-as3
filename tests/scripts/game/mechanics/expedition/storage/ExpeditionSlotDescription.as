package game.mechanics.expedition.storage
{
   public class ExpeditionSlotDescription
   {
      
      public static const TYPE_NORMAL:String = "normal";
      
      public static const TYPE_PREMIUM:String = "premium";
       
      
      private var _id:int;
      
      private var _unlockTeamLevel:int = 0;
      
      private var _unlockVipLevel:int = 0;
      
      private var _unlockSubscription:Boolean = false;
      
      private var _isPremium:Boolean;
      
      public function ExpeditionSlotDescription(param1:Object)
      {
         super();
         _id = param1.id;
         _isPremium = param1.type == "premium";
         var _loc2_:Object = param1.unlockRequirement;
         if(_loc2_.teamLevel)
         {
            _unlockTeamLevel = _loc2_.teamLevel;
         }
         if(_loc2_.subscription)
         {
            _unlockSubscription = _loc2_.subscription;
         }
         if(_loc2_.vipLevel)
         {
            _unlockVipLevel = _loc2_.vipLevel;
         }
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get isPremium() : Boolean
      {
         return _isPremium;
      }
      
      public function get unlockRequirementTeamLevel() : Boolean
      {
         return _unlockTeamLevel > 0;
      }
      
      public function get unlockTeamLevel() : int
      {
         return _unlockTeamLevel;
      }
      
      public function get unlockRequirementVipLevel() : Boolean
      {
         return _unlockVipLevel > 0;
      }
      
      public function get unlockVipLevel() : int
      {
         return _unlockVipLevel;
      }
      
      public function get unlockRequirementSubscription() : Boolean
      {
         return _unlockSubscription;
      }
   }
}
