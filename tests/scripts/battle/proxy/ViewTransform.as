package battle.proxy
{
   import flash.Boot;
   import flash.geom.Matrix;
   
   public class ViewTransform extends Matrix
   {
       
      
      public var tz:Number;
      
      public function ViewTransform()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super();
         tz = 0;
      }
      
      public function setRotationAngle(param1:Number) : void
      {
         var _loc2_:Number = Math.cos(param1);
         var _loc3_:Number = Math.sin(param1);
         a = _loc2_;
         b = _loc3_;
         c = -_loc3_;
         d = _loc2_;
      }
      
      public function rayTo(param1:Number, param2:Number, param3:Number = 1, param4:Number = 1) : void
      {
         var _loc5_:Number = Math.sqrt(Number((param1 - tx) * (param1 - tx) + (param2 - ty) * (param2 - ty)));
         var _loc6_:Number = (param1 - tx) / _loc5_;
         var _loc7_:Number = (param2 - ty) / _loc5_;
         a = _loc6_ * _loc5_ / param3;
         b = _loc7_ * _loc5_ / param3;
         c = -_loc7_ * param4;
         d = _loc6_ * param4;
      }
      
      public function invalid() : Boolean
      {
         if(tx != tx || ty != ty || a != a || b != b || c != c || d != d || tz != tz)
         {
            return true;
         }
         return false;
      }
      
      public function getRotation() : Number
      {
         return Number(Math.atan2(b,a));
      }
      
      public function directTo(param1:Number, param2:Number, param3:Number = 1) : void
      {
         var _loc4_:Number = Math.sqrt(Number((param1 - tx) * (param1 - tx) + (param2 - ty) * (param2 - ty)));
         if(_loc4_ > 0)
         {
            a = (param1 - tx) / _loc4_;
            b = (param2 - ty) / _loc4_;
            c = (ty - param2) / _loc4_ * param3;
            d = (param1 - tx) / _loc4_ * param3;
         }
      }
      
      public function directByVector(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = Math.sqrt(Number(param1 * param1 + param2 * param2));
         if(_loc3_ > 0)
         {
            a = param1 / _loc3_;
            b = param2 / _loc3_;
            c = -param2 / _loc3_;
            d = param1 / _loc3_;
         }
      }
      
      public function cloneViewTransform() : ViewTransform
      {
         var _loc1_:ViewTransform = new ViewTransform();
         _loc1_.a = a;
         _loc1_.b = b;
         _loc1_.c = c;
         _loc1_.d = d;
         _loc1_.tx = tx;
         _loc1_.ty = ty;
         _loc1_.tz = tz;
         return _loc1_;
      }
   }
}
