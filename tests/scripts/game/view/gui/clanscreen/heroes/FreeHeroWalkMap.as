package game.view.gui.clanscreen.heroes
{
   import flash.geom.Point;
   
   public class FreeHeroWalkMap
   {
       
      
      public const obstacles:Vector.<Circle> = new Vector.<Circle>();
      
      public const boundaries:Vector.<Circle> = new Vector.<Circle>();
      
      public function FreeHeroWalkMap()
      {
         super();
      }
      
      public function getRandomPosition(param1:Number) : Point
      {
         var _loc4_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc2_:Point = new Point();
         var _loc7_:* = 0;
         var _loc5_:Circle = null;
         var _loc11_:int = 0;
         var _loc10_:* = boundaries;
         for each(_loc5_ in boundaries)
         {
            _loc7_ = Number(_loc7_ + _loc5_.r * _loc5_.r * 3.14159265358979);
         }
         var _loc6_:Number = Math.random() * _loc7_;
         var _loc13_:int = 0;
         var _loc12_:* = boundaries;
         for each(_loc5_ in boundaries)
         {
            _loc7_ = Number(_loc7_ + _loc5_.r * _loc5_.r * 3.14159265358979);
            if(_loc6_ >= _loc7_)
            {
               continue;
            }
            break;
         }
         var _loc8_:Boolean = true;
         while(_loc8_)
         {
            _loc4_ = Math.random() * (_loc5_.r - param1);
            _loc3_ = Math.random() * 3.14159265358979 * 2;
            _loc2_.x = _loc5_.x + Math.cos(_loc3_) * _loc4_;
            _loc2_.y = _loc5_.y + Math.sin(_loc3_) * _loc4_;
            _loc8_ = false;
            var _loc15_:int = 0;
            var _loc14_:* = obstacles;
            for each(var _loc9_ in obstacles)
            {
               if((_loc2_.x - _loc9_.x) * (_loc2_.x - _loc9_.x) + (_loc2_.y - _loc9_.y) * (_loc2_.y - _loc9_.y) < (_loc9_.r + param1) * (_loc9_.r + param1))
               {
                  _loc8_ = true;
                  break;
               }
            }
         }
         return _loc2_;
      }
   }
}
