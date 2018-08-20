package game.model.user.quest
{
   public class PlayerDayTimeQuestValueObject extends PlayerQuestValueObject
   {
       
      
      public function PlayerDayTimeQuestValueObject(param1:PlayerDayTimeQuestEntry, param2:Boolean)
      {
         super(param1,param2);
      }
      
      override public function get sortValue() : int
      {
         var _loc1_:int = (entry as PlayerDayTimeQuestEntry).sortValue;
         if(canFarm)
         {
            _loc1_ = _loc1_ + 30000;
         }
         if(hasNavigator)
         {
            _loc1_ = _loc1_ + 1000;
         }
         return _loc1_;
      }
   }
}
