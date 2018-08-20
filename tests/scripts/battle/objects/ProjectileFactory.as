package battle.objects
{
   import battle.Hero;
   import battle.Team;
   import battle.data.BattleSkillDescription;
   import battle.logic.ImpactRange;
   import battle.logic.MovingBody;
   import battle.proxy.idents.EffectAnimationIdent;
   import battle.proxy.idents.ProjectileMovementIdent;
   import battle.skills.Context;
   import battle.skills.HeroCollection;
   import battle.skills.SkillCast;
   import battle.skills.TeamTargetAreaSelector;
   import battle.utils.Version;
   
   public class ProjectileFactory
   {
      
      public static var DEFAULT_DISPOSE_RANGE:Number = 1300;
      
      public static var instance:ProjectileFactory = new ProjectileFactory();
       
      
      public var targetTeam:Team;
      
      public var targetBothTeams:Boolean;
      
      public var speed:Number;
      
      public var spawnOffset:Number;
      
      public var skillCast:SkillCast;
      
      public var prioritizedTarget:Hero;
      
      public var position:Number;
      
      public var fxTransform:ProjectileMovementIdent;
      
      public var fxSkill:BattleSkillDescription;
      
      public var fxIdent:EffectAnimationIdent;
      
      public var disposeRange:Number;
      
      public var direction:int;
      
      public function ProjectileFactory()
      {
      }
      
      public function straight(param1:Function) : ProjectileEntity
      {
         if(fxTransform == null)
         {
            fxTransform = ProjectileMovementIdent.NO_ROTATION;
         }
         prioritizedTarget = null;
         return create(param1);
      }
      
      public function singleTarget(param1:Hero, param2:Function) : ProjectileEntity
      {
         if(fxTransform == null)
         {
            fxTransform = ProjectileMovementIdent.DEFAULT;
         }
         prioritizedTarget = param1;
         return create(param2);
      }
      
      public function disposeProjectile(param1:ProjectileEntity) : void
      {
         param1.dispose();
      }
      
      public function create(param1:Function) : ProjectileEntity
      {
         var _loc3_:* = null as ProjectileEntity;
         var _loc4_:* = null as ProjectileEntityCoupled;
         var _loc5_:* = null as ImpactRange;
         var _loc6_:* = null as TeamTargetAreaSelector;
         var _loc7_:Number = NaN;
         var _loc8_:* = null as HeroCollection;
         var _loc9_:* = null as Hero;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:Number = NaN;
         var _loc13_:* = null as TeamTargetAreaSelector;
         var _loc2_:MovingBody = new MovingBody(1);
         _loc2_.x = Number(position + spawnOffset * direction);
         if(prioritizedTarget == null)
         {
            _loc2_.vx = speed * direction;
         }
         else if(prioritizedTarget.body.x > _loc2_.x)
         {
            _loc2_.vx = speed;
         }
         else
         {
            _loc2_.vx = -speed;
         }
         if(prioritizedTarget == null)
         {
            _loc3_ = new ProjectileEntity(skillCast,targetTeam,_loc2_);
            _loc5_ = new ImpactRange(skillCast.engine.timeline,_loc2_,0);
            targetTeam.addRange(_loc5_);
            _loc3_.range = _loc5_;
            if(targetBothTeams)
            {
               targetTeam.enemyTeam.addRange(_loc3_.range);
            }
         }
         else
         {
            _loc4_ = new ProjectileEntityCoupled(skillCast,targetTeam,_loc2_);
            _loc3_ = _loc4_;
            _loc5_ = new ImpactRange(skillCast.engine.timeline,_loc2_,0);
            _loc5_.addObject(prioritizedTarget.body);
            _loc3_.range = _loc5_;
            if(Version.current < 142)
            {
               if(targetBothTeams)
               {
                  targetTeam.enemyTeam.addRange(_loc3_.range);
               }
            }
         }
         if(spawnOffset > 0)
         {
            if(Version.current >= 142)
            {
               _loc6_ = targetTeam.targetAreaSelector;
            }
            else
            {
               _loc6_ = skillCast.hero.get_enemyTeam().targetAreaSelector;
            }
            _loc7_ = Math.abs(Number(Number(Number(spawnOffset + skillCast.engine.config.heroSize) + _loc2_.size) + 1.0e-7)) * 0.5;
            _loc6_.inArea(skillCast,Number(skillCast.hero.body.x + _loc7_ * direction),_loc7_,skillCast.hero);
            if(skillCast.targetsCount > 0)
            {
               _loc8_ = skillCast.getHeroList(true);
               while(_loc8_.index < _loc8_.length && (_loc8_.filterAvailableOnly || _loc8_.heroes[_loc8_.index].get_isAvailable()))
               {
                  _loc11_ = _loc8_.index;
                  _loc8_.index = _loc8_.index + 1;
                  _loc10_ = _loc11_;
                  _loc9_ = _loc8_.heroes[_loc10_];
                  if(!(prioritizedTarget != null && prioritizedTarget != _loc9_))
                  {
                     skillCast.select(_loc9_);
                     if(fxSkill != null)
                     {
                        Context.scene.addProjectileHitFx(_loc3_,skillCast.target,fxSkill);
                     }
                     param1(skillCast,_loc3_);
                     if(!_loc3_.disposed)
                     {
                        continue;
                     }
                     break;
                  }
               }
            }
            if(!_loc3_.disposed && targetBothTeams)
            {
               _loc12_ = Math.abs(Number(Number(Number(spawnOffset + skillCast.engine.config.heroSize) + _loc2_.size) + 1.0e-7)) * 0.5;
               if(Version.current >= 142)
               {
                  _loc13_ = targetTeam.enemyTeam.targetAreaSelector;
               }
               else
               {
                  _loc13_ = skillCast.hero.get_enemyTeam().enemyTeam.targetAreaSelector;
               }
               _loc13_.inArea(skillCast,Number(skillCast.hero.body.x + _loc12_ * direction),_loc12_,skillCast.hero);
               if(skillCast.targetsCount > 0)
               {
                  _loc8_ = skillCast.getHeroList(true);
                  while(_loc8_.index < _loc8_.length && (_loc8_.filterAvailableOnly || _loc8_.heroes[_loc8_.index].get_isAvailable()))
                  {
                     _loc11_ = _loc8_.index;
                     _loc8_.index = _loc8_.index + 1;
                     _loc10_ = _loc11_;
                     _loc9_ = _loc8_.heroes[_loc10_];
                     if(!(prioritizedTarget != null && prioritizedTarget != _loc9_))
                     {
                        skillCast.select(_loc9_);
                        if(fxSkill != null)
                        {
                           Context.scene.addProjectileHitFx(_loc3_,skillCast.target,fxSkill);
                        }
                        param1(skillCast,_loc3_);
                        if(!_loc3_.disposed)
                        {
                           continue;
                        }
                        break;
                     }
                  }
               }
            }
         }
         if(!_loc3_.disposed)
         {
            _loc3_.range.onOccupied.add(_loc3_.onHitListener);
            _loc3_.setHeroCollisionHandler(param1);
            skillCast.createdObjectsCount = skillCast.createdObjectsCount + 1;
            skillCast.engine.movement.add(_loc2_);
            _loc3_.add(disposeProjectile,Number(_loc3_.timeline.time + disposeRange / speed));
            if(prioritizedTarget != null)
            {
               _loc4_.couple(prioritizedTarget,targetBothTeams);
            }
            if(fxSkill != null)
            {
               Context.scene.addProjectile(_loc3_,fxSkill,fxTransform,fxIdent);
            }
         }
         return _loc3_;
      }
      
      public function closest(param1:Function) : ProjectileEntity
      {
         if(fxTransform == null)
         {
            fxTransform = ProjectileMovementIdent.DEFAULT;
         }
         prioritizedTarget = null;
         var _loc3_:Hero = skillCast.hero;
         var _loc2_:Hero = _loc3_.skills.enemyTeam.targetSelector.getNearest(_loc3_);
         if(_loc2_ != skillCast.enemyTeam.getNearestToPositionAbstract(skillCast.hero.body.x))
         {
            prioritizedTarget = _loc2_;
         }
         return create(param1);
      }
   }
}
