package game.battle.view.hero
{
   import battle.proxy.HeroViewAnchors;
   import flash.geom.Matrix;
   import game.battle.controller.position.HeroViewPositionValue;
   
   public class GameHeroViewAnchors extends HeroViewAnchors
   {
      
      private static const matrix:Matrix = new Matrix();
       
      
      public function GameHeroViewAnchors()
      {
         super();
      }
      
      public function update(param1:HeroView) : void
      {
         var _loc2_:HeroViewPositionValue = param1.position;
         var _loc4_:Matrix = param1.transform.containerTransform;
         var _loc6_:* = _loc2_.x;
         ground.x = _loc6_;
         chest.x = _loc6_;
         _loc6_ = _loc2_.z;
         ground.z = _loc6_;
         chest.z = _loc6_;
         ground.y = _loc2_.y;
         var _loc3_:Number = 70 * _loc2_.scale;
         _loc3_ = _loc3_ * 0.5 + 0.5 * param1.initialBounds.height * 0.5;
         chest.y = _loc2_.y + _loc4_.ty - _loc4_.d * _loc3_;
         scale = param1.transform.scale;
         var _loc5_:Matrix = param1.getMarkerPosition("MARKER_BASE",true);
         if(_loc5_)
         {
            marker.x = _loc5_.tx;
            marker.y = _loc5_.ty;
         }
         marker.z = _loc2_.z;
      }
   }
}
