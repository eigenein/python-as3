package battle.logic
{
   import battle.Team;
   import battle.timeline.Timeline;
   import battle.utils.Version;
   
   public class RangeFactory
   {
       
      
      public function RangeFactory()
      {
      }
      
      public static function normalRange(param1:Timeline, param2:MovingBody, param3:Number) : PrimeRange
      {
         return new PrimeRange(param1,param2,param3);
      }
      
      public static function teamProjectileRange(param1:Timeline, param2:Team, param3:MovingBody, param4:Number) : ImpactRange
      {
         var _loc5_:ImpactRange = new ImpactRange(param1,param3,param4);
         param2.addRange(_loc5_);
         return _loc5_;
      }
      
      public static function teamRange(param1:Timeline, param2:Team, param3:MovingBody, param4:Number) : PrimeRange
      {
         var _loc5_:PrimeRange = new PrimeRange(param1,param3,param4);
         if(Version.current < 119)
         {
            param2.addRange(_loc5_);
         }
         return _loc5_;
      }
      
      public static function singleObjectRange(param1:Timeline, param2:MovingBody, param3:MovingBody, param4:Number) : ImpactRange
      {
         var _loc5_:ImpactRange = new ImpactRange(param1,param3,param4);
         _loc5_.addObject(param2);
         return _loc5_;
      }
   }
}
