package game.mechanics.boss.popup.dropparticle
{
   import flash.geom.Point;
   
   public class PointPool
   {
       
      
      private var _pool:Vector.<Point>;
      
      public function PointPool()
      {
         _pool = new Vector.<Point>();
         super();
      }
      
      public function point(param1:Number = 0, param2:Number = 0) : Point
      {
         var _loc3_:* = null;
         if(_pool.length > 0)
         {
            _loc3_ = _pool.pop();
            _loc3_.x = param1;
            _loc3_.y = param2;
            return _loc3_;
         }
         return new Point(param1,param2);
      }
      
      public function pool(param1:Point) : void
      {
         _pool.push(param1);
      }
   }
}
