package game.battle.controller.position
{
   import battle.BattleEngine;
   import battle.data.ProjectileParam;
   import battle.objects.ProjectileEntity;
   import battle.proxy.ViewPosition;
   import flash.geom.Matrix;
   import game.battle.controller.BattleMediatorObjects;
   import game.battle.controller.entities.BattleHero;
   
   public class BattleStraightProjectilePosition extends ViewPosition
   {
      
      public static const Z_OFFSET:Number = 10;
       
      
      public var angle:Number;
      
      protected var objects:BattleMediatorObjects;
      
      protected var projectile:ProjectileEntity;
      
      protected var projectileSpawnHeight:Number = -70;
      
      protected var xOffset:Number = 0;
      
      protected var yOffset:Number = 0;
      
      public function BattleStraightProjectilePosition(param1:BattleMediatorObjects)
      {
         super();
         this.objects = param1;
      }
      
      public function advanceTime(param1:Number) : void
      {
         x = projectile.getVisualPosition() + xOffset;
      }
      
      public function init(param1:ProjectileEntity) : void
      {
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc2_:Number = NaN;
         var _loc4_:Number = NaN;
         this.projectile = param1;
         var _loc6_:BattleHero = objects.entities.getHero(param1.skillCast.hero);
         if(_loc6_)
         {
            x = param1.position;
            y = _loc6_.view.position.y;
            z = _loc6_.view.position.z + 10;
            _loc5_ = param1.skillCast.skill.projectile;
            if(_loc5_)
            {
               y = y + _loc5_.y * BattleEngine.ASSET_SCALE * _loc6_.hero.desc.scale;
            }
            _loc3_ = _loc6_.view.currentWeaponTransform;
            if(_loc3_)
            {
               _loc2_ = _loc5_.x * BattleEngine.ASSET_SCALE * _loc6_.hero.desc.scale - _loc3_.tx;
               _loc4_ = _loc5_.y * BattleEngine.ASSET_SCALE * _loc6_.hero.desc.scale - _loc3_.ty;
               xOffset = _loc2_ * _loc3_.a + _loc4_ * _loc3_.c - _loc2_;
               yOffset = _loc2_ * _loc3_.b + _loc4_ * _loc3_.d - _loc4_;
            }
            x = x + xOffset;
            y = y + yOffset;
         }
         else
         {
            x = param1.position;
            y = 0;
            z = 0;
         }
         angle = param1.body.vx > 0?0:3.14159265358979;
      }
      
      public function dropTarget() : void
      {
      }
   }
}
