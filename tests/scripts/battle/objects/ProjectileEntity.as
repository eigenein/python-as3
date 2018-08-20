package battle.objects
{
   import battle.BattleEngine;
   import battle.BattleLog;
   import battle.Hero;
   import battle.Team;
   import battle.logic.ImpactRange;
   import battle.logic.MovingBody;
   import battle.proxy.IProjectileProxy;
   import battle.proxy.empty.EmptyProjectileProxy;
   import battle.skills.SkillCast;
   import battle.utils.Version;
   import flash.Boot;
   
   public class ProjectileEntity extends BattleBody
   {
       
      
      public var viewProxy:IProjectileProxy;
      
      public var targetTeam:Team;
      
      public var skillCast:SkillCast;
      
      public var range:ImpactRange;
      
      public var heroCollisionHandler:Function;
      
      public var accuracy:int;
      
      public function ProjectileEntity(param1:SkillCast = undefined, param2:Team = undefined, param3:MovingBody = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         viewProxy = EmptyProjectileProxy.instance;
         accuracy = 0;
         targetTeam = param2;
         skillCast = param1;
         super(param1.engine,param3);
      }
      
      override public function toString() : String
      {
         if(body != null)
         {
            return "`" + (body.vx > 0?"+pj":"-pj") + int(body.x) + "`";
         }
         return "`nobody`";
      }
      
      public function setHeroCollisionHandler(param1:Function) : void
      {
         if(heroCollisionHandler != null)
         {
            throw "heroCollisionHandler already set";
         }
         heroCollisionHandler = param1;
      }
      
      public function selectTargetAndDispose() : Boolean
      {
         var _loc2_:* = null as Hero;
         var _loc1_:Hero = engine.objects.heroesByBody[range.occupator];
         if(_loc1_ == null)
         {
            return false;
         }
         _loc2_ = _loc1_;
         skillCast.target = _loc2_;
         skillCast.targets[0] = _loc2_;
         skillCast.targetsCount = 1;
         dispose();
         return true;
      }
      
      public function selectTarget() : Boolean
      {
         var _loc2_:* = null as Hero;
         var _loc1_:Hero = engine.objects.heroesByBody[range.occupator];
         if(_loc1_ == null)
         {
            return false;
         }
         _loc2_ = _loc1_;
         skillCast.targets[0] = _loc2_;
         skillCast.target = _loc2_;
         skillCast.targetsCount = 1;
         return true;
      }
      
      public function resetTargets() : void
      {
         targetTeam.removeRange(range);
         targetTeam.addRange(range);
      }
      
      public function onHitListener() : void
      {
         var _loc1_:* = null as MovingBody;
         var _loc2_:* = null as Hero;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:* = null as MovingBody;
         var _loc8_:Number = NaN;
         if(heroCollisionHandler == null)
         {
            add(initiationDefferedHitListener,timeline.time);
         }
         else
         {
            _loc1_ = range.occupator;
            _loc2_ = engine.objects.heroesByBody[_loc1_];
            if(_loc2_ != null)
            {
               skillCast.select(_loc2_);
               heroCollisionHandler(skillCast,this);
               viewProxy.projectileHit();
            }
            if(!disposed)
            {
               range.removeObject(_loc1_);
            }
            _loc3_ = true;
            while(Version.current > 104 && !disposed && _loc3_)
            {
               _loc3_ = false;
               _loc4_ = 0;
               _loc5_ = range.objects.length;
               while(_loc4_ < _loc5_)
               {
                  _loc4_++;
                  _loc6_ = _loc4_;
                  _loc7_ = range.objects[_loc6_];
                  _loc8_ = _loc7_.x - _loc1_.x;
                  if(_loc8_ * _loc8_ < 1.0e-14)
                  {
                     _loc2_ = engine.objects.heroesByBody[_loc7_];
                     if(_loc2_ != null)
                     {
                        skillCast.select(_loc2_);
                        heroCollisionHandler(skillCast,this);
                        viewProxy.projectileHit();
                     }
                     if(!disposed)
                     {
                        range.removeObject(_loc7_);
                     }
                     _loc3_ = true;
                     break;
                  }
               }
            }
         }
      }
      
      public function initiationDefferedHitListener(param1:ProjectileEntity) : void
      {
         var _loc2_:* = null as MovingBody;
         var _loc3_:* = null as Hero;
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = null as MovingBody;
         var _loc9_:Number = NaN;
         if(heroCollisionHandler != null)
         {
            _loc2_ = range.occupator;
            _loc3_ = engine.objects.heroesByBody[_loc2_];
            if(_loc3_ != null)
            {
               skillCast.select(_loc3_);
               heroCollisionHandler(skillCast,this);
               viewProxy.projectileHit();
            }
            if(!disposed)
            {
               range.removeObject(_loc2_);
            }
            _loc4_ = true;
            while(Version.current > 104 && !disposed && _loc4_)
            {
               _loc4_ = false;
               _loc5_ = 0;
               _loc6_ = range.objects.length;
               while(_loc5_ < _loc6_)
               {
                  _loc5_++;
                  _loc7_ = _loc5_;
                  _loc8_ = range.objects[_loc7_];
                  _loc9_ = _loc8_.x - _loc2_.x;
                  if(_loc9_ * _loc9_ < 1.0e-14)
                  {
                     _loc3_ = engine.objects.heroesByBody[_loc8_];
                     if(_loc3_ != null)
                     {
                        skillCast.select(_loc3_);
                        heroCollisionHandler(skillCast,this);
                        viewProxy.projectileHit();
                     }
                     if(!disposed)
                     {
                        range.removeObject(_loc8_);
                     }
                     _loc4_ = true;
                     break;
                  }
               }
            }
         }
      }
      
      public function hitBody(param1:MovingBody) : void
      {
         var _loc2_:Hero = engine.objects.heroesByBody[param1];
         if(_loc2_ != null)
         {
            skillCast.select(_loc2_);
            heroCollisionHandler(skillCast,this);
            viewProxy.projectileHit();
         }
         if(!disposed)
         {
            range.removeObject(param1);
         }
      }
      
      override public function get_isAvailable() : Boolean
      {
         return true;
      }
      
      override public function getVisualPosition() : Number
      {
         var _loc1_:* = null as MovingBody;
         if(engine != null)
         {
            _loc1_ = body;
            return Number(_loc1_.x + _loc1_.vx * (engine.displayTimeline.time - engine.movement.oldTime));
         }
         return body.x;
      }
      
      public function getCurrentTargetTime() : Number
      {
         return Number(range.getNextTime());
      }
      
      public function getCurrentTarget() : Hero
      {
         return engine.objects.heroesByBody[range.occupator];
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            if(BattleLog.doLog)
            {
               BattleLog.m.logString("this projectile was already disposed");
            }
            return;
         }
         super.dispose();
         skillCast.createdObjectsCount = skillCast.createdObjectsCount - 1;
         onRemove.fire();
         range.dispose();
         range.onOccupied.removeAll();
      }
      
      public function dispatchCollision() : void
      {
         var _loc2_:* = null as Hero;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:* = null as MovingBody;
         var _loc8_:Number = NaN;
         var _loc1_:MovingBody = range.occupator;
         _loc2_ = engine.objects.heroesByBody[_loc1_];
         if(_loc2_ != null)
         {
            skillCast.select(_loc2_);
            heroCollisionHandler(skillCast,this);
            viewProxy.projectileHit();
         }
         if(!disposed)
         {
            range.removeObject(_loc1_);
         }
         var _loc3_:Boolean = true;
         while(Version.current > 104 && !disposed && _loc3_)
         {
            _loc3_ = false;
            _loc4_ = 0;
            _loc5_ = range.objects.length;
            while(_loc4_ < _loc5_)
            {
               _loc4_++;
               _loc6_ = _loc4_;
               _loc7_ = range.objects[_loc6_];
               _loc8_ = _loc7_.x - _loc1_.x;
               if(_loc8_ * _loc8_ < 1.0e-14)
               {
                  _loc2_ = engine.objects.heroesByBody[_loc7_];
                  if(_loc2_ != null)
                  {
                     skillCast.select(_loc2_);
                     heroCollisionHandler(skillCast,this);
                     viewProxy.projectileHit();
                  }
                  if(!disposed)
                  {
                     range.removeObject(_loc7_);
                  }
                  _loc3_ = true;
                  break;
               }
            }
         }
      }
   }
}
