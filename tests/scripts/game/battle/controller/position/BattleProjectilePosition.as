package game.battle.controller.position
{
   import battle.Hero;
   import battle.objects.ProjectileEntity;
   import flash.geom.Point;
   import game.battle.controller.BattleMediatorObjects;
   import game.battle.controller.entities.BattleHero;
   
   public class BattleProjectilePosition extends BattleStraightProjectilePosition
   {
       
      
      private var initialX:Number;
      
      private var initialY:Number;
      
      private var initialZ:Number;
      
      private var angleTangence:Number = NaN;
      
      private var zTangence:Number = NaN;
      
      public function BattleProjectilePosition(param1:BattleMediatorObjects)
      {
         super(param1);
      }
      
      override public function advanceTime(param1:Number) : void
      {
         if(angleTangence != angleTangence)
         {
            findTarget();
            if(angleTangence != angleTangence)
            {
               return;
            }
         }
         x = projectile.getVisualPosition();
         y = (x - initialX) * angleTangence + initialY;
         z = (z - initialZ) * zTangence + initialZ;
      }
      
      override public function init(param1:ProjectileEntity) : void
      {
         super.init(param1);
         initialX = x;
         initialY = y;
         initialZ = z;
      }
      
      public function findTarget() : void
      {
         var _loc3_:* = null;
         var _loc1_:Hero = projectile.getCurrentTarget() as Hero;
         if(_loc1_)
         {
            _loc3_ = objects.entities.getHero(_loc1_);
         }
         if(!_loc3_)
         {
            angleTangence = 0;
            zTangence = 0;
            return;
         }
         var _loc2_:Point = _loc3_.view.anchors.chest;
         angleTangence = (_loc2_.y - y) / (_loc2_.x - x);
         zTangence = (_loc3_.view.position.z + 10 - z) / (_loc2_.x - x);
         angle = Math.atan2(_loc2_.y - y,_loc2_.x - x);
      }
      
      override public function dropTarget() : void
      {
         angleTangence = NaN;
         initialX = x;
         initialY = y;
         initialZ = z;
      }
   }
}
