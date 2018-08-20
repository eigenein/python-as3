package game.view.hero
{
   import flash.geom.Point;
   
   public class DungeonHeroTerrainHeight implements IHeroTerrain
   {
       
      
      public const mapPoints:Vector.<Point> = new Vector.<Point>();
      
      public function DungeonHeroTerrainHeight()
      {
         super();
      }
      
      public function getHeight(param1:Number, param2:Number) : Number
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc6_:int = mapPoints.length;
         if(_loc6_ == 0)
         {
            return 0;
         }
         if(param1 <= mapPoints[0].x)
         {
            return mapPoints[0].y;
         }
         if(param1 >= mapPoints[_loc6_ - 1].x)
         {
            return mapPoints[_loc6_ - 1].y;
         }
         _loc5_ = 1;
         while(_loc5_ < _loc6_)
         {
            _loc4_ = mapPoints[_loc5_];
            if(param1 < _loc4_.x)
            {
               _loc3_ = mapPoints[_loc5_ - 1];
               return _loc3_.y + (param1 - _loc3_.x) * (_loc4_.y - _loc3_.y) / (_loc4_.x - _loc3_.x);
            }
            if(param1 == _loc4_.x)
            {
               return _loc4_.y;
            }
            _loc5_++;
         }
         return 0;
      }
   }
}
