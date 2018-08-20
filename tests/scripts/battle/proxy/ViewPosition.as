package battle.proxy
{
   import flash.Boot;
   import flash.geom.Point;
   
   public class ViewPosition extends Point
   {
       
      
      public var z:Number;
      
      public function ViewPosition(param1:Number = 0, param2:Number = 0, param3:Number = 0)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1,param2);
         z = param3;
      }
      
      public function interpolateTo(param1:ViewPosition, param2:Number) : void
      {
         x = Number(x * (1 - param2) + param1.x * param2);
         y = Number(y * (1 - param2) + param1.y * param2);
         z = Number(z * (1 - param2) + param1.z * param2);
      }
      
      public function interpolate(param1:ViewPosition, param2:ViewPosition, param3:Number) : void
      {
         x = Number(param1.x * (1 - param3) + param2.x * param3);
         y = Number(param1.y * (1 - param3) + param2.y * param3);
         z = Number(param1.z * (1 - param3) + param2.z * param3);
      }
      
      public function flatDistanceTo(param1:ViewPosition) : Number
      {
         return Number(Math.sqrt(Number((param1.x - x) * (param1.x - x) + (param1.y - y) * (param1.y - y))));
      }
      
      public function clonePosition() : ViewPosition
      {
         return new ViewPosition(x,y,z);
      }
   }
}
