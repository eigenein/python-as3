package battle.data
{
   import flash.Boot;
   
   public class ProjectileParam extends BattleSkillParam
   {
       
      
      public var y:Number;
      
      public var x:Number;
      
      public var speed:Number;
      
      public function ProjectileParam(param1:* = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         if(param1.x || param1.x == 0)
         {
            x = param1.x;
         }
         else
         {
            x = 0;
         }
         if(param1.y || param1.y == 0)
         {
            y = param1.y;
         }
         else
         {
            y = 0;
         }
         if(param1.speed || param1.speed == 0)
         {
            speed = param1.speed;
         }
         else
         {
            speed = 0;
         }
      }
      
      public function toString() : String
      {
         return JSON.stringify(toJSON(null));
      }
      
      public function toJSON(param1:*) : *
      {
         var _loc2_:* = {};
         _loc2_.x = x;
         _loc2_.y = y;
         _loc2_.speed = speed;
         return _loc2_;
      }
   }
}
