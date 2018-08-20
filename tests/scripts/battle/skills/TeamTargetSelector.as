package battle.skills
{
   import battle.Hero;
   import battle.Team;
   import battle.data.HeroState;
   import battle.objects.BattleBody;
   import battle.utils.Version;
   import flash.Boot;
   
   public class TeamTargetSelector
   {
       
      
      public var team:Team;
      
      public var heroes:Vector.<Hero>;
      
      public var count:int;
      
      public function TeamTargetSelector(param1:Team = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         team = param1;
         heroes = param1.heroes;
      }
      
      public function withEffect(param1:SkillCast, param2:String) : Boolean
      {
         var _loc5_:int = 0;
         var _loc6_:* = null as Hero;
         var _loc7_:int = 0;
         if(team == null || int(heroes.length) == 0)
         {
            return false;
         }
         param1.targets = new Vector.<Hero>();
         param1.targetsCount = 0;
         param1.index = -1;
         var _loc3_:int = 0;
         var _loc4_:int = heroes.length;
         while(_loc3_ < _loc4_)
         {
            _loc3_++;
            _loc5_ = _loc3_;
            _loc6_ = heroes[_loc5_];
            if(!heroIsNotAvailable(_loc6_,param1.hero))
            {
               if(_loc6_.getEffect(param2) != null)
               {
                  _loc7_ = param1.targetsCount;
                  param1.targetsCount = param1.targetsCount + 1;
                  param1.targets[_loc7_] = heroes[_loc5_];
               }
            }
         }
         return param1.targetsCount != 0;
      }
      
      public function random(param1:SkillCast) : void
      {
         var _loc5_:int = 0;
         var _loc6_:* = null as Hero;
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = heroes.length;
         while(_loc3_ < _loc4_)
         {
            _loc3_++;
            _loc5_ = _loc3_;
            _loc6_ = heroes[_loc5_];
            if(!heroIsNotAvailable(_loc6_,param1.hero))
            {
               _loc2_++;
            }
         }
         param1.targetsCount = 0;
         if(_loc2_ == 0)
         {
            return;
         }
         _loc3_ = heroes[0].engine.randomSource(1,_loc2_);
         _loc4_ = 0;
         _loc5_ = heroes.length;
         while(_loc4_ < _loc5_)
         {
            _loc4_++;
            _loc7_ = _loc4_;
            _loc6_ = heroes[_loc7_];
            if(!heroIsNotAvailable(_loc6_,param1.hero))
            {
               _loc3_--;
               if(_loc3_ == 0)
               {
                  param1.select(_loc6_);
                  break;
               }
            }
         }
      }
      
      public function nearest(param1:SkillCast, param2:Number) : void
      {
         var _loc7_:int = 0;
         var _loc8_:* = null as Hero;
         var _loc9_:int = 0;
         var _loc3_:int = 16777215;
         var _loc4_:Hero = null;
         var _loc5_:int = 0;
         var _loc6_:int = heroes.length;
         while(_loc5_ < _loc6_)
         {
            _loc5_++;
            _loc7_ = _loc5_;
            _loc8_ = heroes[_loc7_];
            if(!heroIsNotAvailable(_loc8_,param1.hero))
            {
               _loc9_ = Number((param2 - _loc8_.body.x) * (param2 - _loc8_.body.x) + 0.5);
               if(_loc9_ < _loc3_)
               {
                  _loc3_ = _loc9_;
                  _loc4_ = _loc8_;
               }
            }
         }
         if(_loc4_ != null)
         {
            param1.select(_loc4_);
         }
      }
      
      public function minHp(param1:SkillCast, param2:int = 1) : void
      {
         var _loc7_:int = 0;
         var _loc8_:* = null as Hero;
         var _loc9_:* = 0;
         var _loc3_:Vector.<Hero> = param1.targets;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = heroes.length;
         while(_loc5_ < _loc6_)
         {
            _loc5_++;
            _loc7_ = _loc5_;
            _loc8_ = heroes[_loc7_];
            if(!heroIsNotAvailable(_loc8_,param1.hero))
            {
               if(_loc4_ < param2)
               {
                  _loc4_++;
               }
               else if(_loc8_.state.hp >= _loc3_[_loc4_ - 1].state.hp)
               {
                  continue;
               }
               _loc9_ = _loc4_ - 1;
               while(true)
               {
                  _loc9_--;
                  if(!(_loc9_ > 0 && _loc8_.state.hp < _loc3_[_loc9_].state.hp))
                  {
                     break;
                  }
                  _loc3_[_loc9_ + 1] = _loc3_[_loc9_];
               }
               _loc3_[_loc9_ + 1] = _loc8_;
            }
         }
         if(Version.current >= 126)
         {
            param1.index = -1;
         }
         param1.targets = _loc3_;
         param1.targetsCount = _loc4_;
      }
      
      public function maxHp(param1:SkillCast, param2:int = 1) : void
      {
         var _loc7_:int = 0;
         var _loc8_:* = null as Hero;
         var _loc9_:* = 0;
         var _loc3_:Vector.<Hero> = param1.targets;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = heroes.length;
         while(_loc5_ < _loc6_)
         {
            _loc5_++;
            _loc7_ = _loc5_;
            _loc8_ = heroes[_loc7_];
            if(!heroIsNotAvailable(_loc8_,param1.hero))
            {
               if(_loc4_ < param2)
               {
                  _loc4_++;
               }
               else if(_loc8_.state.hp <= _loc3_[_loc4_ - 1].state.hp)
               {
                  continue;
               }
               _loc9_ = _loc4_ - 1;
               while(true)
               {
                  _loc9_--;
                  if(!(_loc9_ > 0 && _loc8_.state.hp > _loc3_[_loc9_].state.hp))
                  {
                     break;
                  }
                  _loc3_[_loc9_ + 1] = _loc3_[_loc9_];
               }
               _loc3_[_loc9_ + 1] = _loc8_;
            }
         }
         if(Version.current >= 126)
         {
            param1.index = -1;
         }
         param1.targets = _loc3_;
         param1.targetsCount = _loc4_;
      }
      
      public function inTouchWithFront(param1:SkillCast, param2:Hero, param3:Number, param4:Number = 0) : void
      {
         var _loc5_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:* = null as Hero;
         var _loc10_:Number = NaN;
         var _loc11_:int = 0;
         param1.targetsCount = 0;
         param1.index = -1;
         if(int(param2.getCurrentDirection()) < 0)
         {
            _loc5_ = param4;
            param4 = param2.body.x - param3;
            param3 = param2.body.x - _loc5_;
         }
         else
         {
            param4 = param4 + param2.body.x;
            param3 = param3 + param2.body.x;
         }
         var _loc6_:int = 0;
         var _loc7_:int = heroes.length;
         while(_loc6_ < _loc7_)
         {
            _loc6_++;
            _loc8_ = _loc6_;
            _loc9_ = heroes[_loc8_];
            if(!heroIsNotAvailable(_loc9_,param1.hero))
            {
               _loc5_ = _loc9_.body.x;
               _loc10_ = _loc9_.body.size;
               if(Number(_loc5_ + _loc10_) >= param4 && _loc5_ - _loc10_ <= param3)
               {
                  _loc11_ = param1.targetsCount;
                  param1.targetsCount = param1.targetsCount + 1;
                  param1.targets[_loc11_] = _loc9_;
               }
            }
         }
         Context.scene.area(param4 - param2.body.size,Number(param3 + param2.body.size),param1);
      }
      
      public function inTouchWithArea(param1:SkillCast, param2:Number, param3:Number) : Boolean
      {
         var _loc6_:int = 0;
         var _loc7_:* = null as Hero;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:int = 0;
         if(team == null || int(heroes.length) == 0)
         {
            return false;
         }
         param1.targets = new Vector.<Hero>();
         param1.targetsCount = 0;
         param1.index = -1;
         var _loc4_:int = 0;
         var _loc5_:int = heroes.length;
         while(_loc4_ < _loc5_)
         {
            _loc4_++;
            _loc6_ = _loc4_;
            _loc7_ = heroes[_loc6_];
            if(!heroIsNotAvailable(_loc7_,param1.hero))
            {
               _loc8_ = _loc7_.body.x;
               _loc9_ = _loc7_.body.size;
               if((_loc8_ - param2) * (_loc8_ - param2) <= (param3 + _loc9_) * (param3 + _loc9_))
               {
                  _loc10_ = param1.targetsCount;
                  param1.targetsCount = param1.targetsCount + 1;
                  param1.targets[_loc10_] = heroes[_loc6_];
               }
            }
         }
         Context.scene.area(param2 - param3 - param1.hero.body.size,Number(Number(param2 + param3) + param1.hero.body.size),param1);
         return param1.targetsCount != 0;
      }
      
      public function inFrontMelee(param1:SkillCast, param2:Hero, param3:Number, param4:Number = 0) : void
      {
         var _loc6_:Number = NaN;
         var _loc9_:int = 0;
         var _loc10_:* = null as Hero;
         var _loc11_:Number = NaN;
         var _loc12_:int = 0;
         var _loc5_:Number = param1.engine.config.heroSize;
         param1.targetsCount = 0;
         param1.index = -1;
         if(int(param2.getCurrentDirection()) < 0)
         {
            _loc6_ = param4;
            param4 = param2.body.x - param3 + _loc5_;
            param3 = param2.body.x - _loc6_ - _loc5_;
         }
         else
         {
            param4 = param4 + (Number(param2.body.x + _loc5_));
            param3 = param3 + (param2.body.x - _loc5_);
         }
         var _loc7_:int = 0;
         var _loc8_:int = heroes.length;
         while(_loc7_ < _loc8_)
         {
            _loc7_++;
            _loc9_ = _loc7_;
            _loc10_ = heroes[_loc9_];
            if(!heroIsNotAvailable(_loc10_,param1.hero))
            {
               _loc6_ = _loc10_.body.x;
               _loc11_ = _loc10_.body.size;
               if(Number(_loc6_ + _loc11_) > param4 && _loc6_ - _loc11_ < param3)
               {
                  _loc12_ = param1.targetsCount;
                  param1.targetsCount = param1.targetsCount + 1;
                  param1.targets[_loc12_] = _loc10_;
               }
            }
         }
         Context.scene.area(param4 - param2.body.size,Number(param3 + param2.body.size),param1);
      }
      
      public function inFront(param1:SkillCast, param2:Hero, param3:Number, param4:Number = 0) : void
      {
         var _loc6_:Number = NaN;
         var _loc9_:int = 0;
         var _loc10_:* = null as Hero;
         var _loc11_:int = 0;
         param1.targetsCount = 0;
         param1.index = -1;
         var _loc5_:Number = param2.body.x;
         if(int(param2.getCurrentDirection()) < 0)
         {
            _loc6_ = param4;
            param4 = _loc5_ - param3;
            param3 = _loc5_ - _loc6_;
         }
         else
         {
            param4 = param4 + _loc5_;
            param3 = param3 + _loc5_;
         }
         var _loc7_:int = 0;
         var _loc8_:int = heroes.length;
         while(_loc7_ < _loc8_)
         {
            _loc7_++;
            _loc9_ = _loc7_;
            _loc10_ = heroes[_loc9_];
            if(!heroIsNotAvailable(_loc10_,param1.hero))
            {
               _loc5_ = _loc10_.body.x;
               if(param4 < _loc5_ && _loc5_ < param3)
               {
                  _loc11_ = param1.targetsCount;
                  param1.targetsCount = param1.targetsCount + 1;
                  param1.targets[_loc11_] = _loc10_;
               }
            }
         }
         Context.scene.area(param4,param3,param1);
      }
      
      public function inDirection(param1:SkillCast, param2:Number, param3:int, param4:int = 1, param5:Hero = undefined) : void
      {
         var _loc10_:int = 0;
         var _loc11_:* = null as Hero;
         var _loc12_:int = 0;
         var _loc6_:* = 1000000 * param4;
         var _loc7_:Hero = null;
         var _loc8_:int = 0;
         var _loc9_:int = heroes.length;
         while(_loc8_ < _loc9_)
         {
            _loc8_++;
            _loc10_ = _loc8_;
            _loc11_ = heroes[_loc10_];
            if(!(heroIsNotAvailable(_loc11_,param1.hero) || _loc11_ == param5))
            {
               _loc12_ = (_loc11_.body.x - param2) * param3;
               if(_loc12_ * param4 < _loc6_ * param4 && _loc12_ > 0)
               {
                  _loc6_ = int(_loc12_);
                  _loc7_ = _loc11_;
               }
            }
         }
         if(Version.current >= 129)
         {
            param1.select(_loc7_);
         }
         else if(_loc7_ != null)
         {
            param1.select(_loc7_);
         }
      }
      
      public function inAreaAround(param1:SkillCast, param2:BattleBody, param3:Number) : Boolean
      {
         var _loc7_:int = 0;
         var _loc8_:* = null as Hero;
         var _loc9_:Number = NaN;
         var _loc10_:int = 0;
         if(param2 == null || team == null || int(heroes.length) == 0)
         {
            return false;
         }
         param1.targets = new Vector.<Hero>();
         var _loc4_:Number = param2.body.x;
         param1.targetsCount = 0;
         var _loc5_:int = 0;
         var _loc6_:int = heroes.length;
         while(_loc5_ < _loc6_)
         {
            _loc5_++;
            _loc7_ = _loc5_;
            _loc8_ = heroes[_loc7_];
            if(!(heroIsNotAvailable(_loc8_,param1.hero) || _loc8_ == param2))
            {
               _loc9_ = _loc8_.body.x;
               if((_loc9_ - _loc4_) * (_loc9_ - _loc4_) <= param3 * param3)
               {
                  _loc10_ = param1.targetsCount;
                  param1.targetsCount = param1.targetsCount + 1;
                  param1.targets[_loc10_] = _loc8_;
               }
            }
         }
         Context.scene.area(_loc4_ - param3,Number(_loc4_ + param3),param1);
         return param1.targetsCount != 0;
      }
      
      public function inArea(param1:SkillCast, param2:Number, param3:Number, param4:Hero = undefined) : Boolean
      {
         var _loc7_:int = 0;
         var _loc8_:* = null as Hero;
         var _loc9_:Number = NaN;
         var _loc10_:int = 0;
         if(team == null || int(heroes.length) == 0)
         {
            return false;
         }
         param1.targets = new Vector.<Hero>();
         param1.targetsCount = 0;
         param1.index = -1;
         var _loc5_:int = 0;
         var _loc6_:int = heroes.length;
         while(_loc5_ < _loc6_)
         {
            _loc5_++;
            _loc7_ = _loc5_;
            _loc8_ = heroes[_loc7_];
            if(!(heroIsNotAvailable(_loc8_,param1.hero) || _loc8_ == param4))
            {
               _loc9_ = _loc8_.body.x;
               if((_loc9_ - param2) * (_loc9_ - param2) <= param3 * param3)
               {
                  _loc10_ = param1.targetsCount;
                  param1.targetsCount = param1.targetsCount + 1;
                  param1.targets[_loc10_] = heroes[_loc7_];
               }
            }
         }
         Context.scene.area(param2 - param3,Number(param2 + param3),param1);
         return param1.targetsCount != 0;
      }
      
      public function heroIsNotAvailable(param1:Hero, param2:Hero) : Boolean
      {
         if(Version.current > 118)
         {
            return !(param1 != param2 && (param1.state == null || param1.state.isDead == false) && param1.canBeTargeted.enabled && (param2 == null || param2.targetSelector.canTarget(param1,param2)));
         }
         return !(param1 != param2 && (param1.state == null || param1.state.isDead == false) && param1.canBeTargeted.enabled);
      }
      
      public function getNearestToPositionAbstract(param1:Number) : Hero
      {
         var _loc6_:int = 0;
         var _loc7_:* = null as Hero;
         var _loc8_:int = 0;
         var _loc2_:int = 16777215;
         var _loc3_:Hero = null;
         var _loc4_:int = 0;
         var _loc5_:int = heroes.length;
         while(_loc4_ < _loc5_)
         {
            _loc4_++;
            _loc6_ = _loc4_;
            _loc7_ = heroes[_loc6_];
            if(!(!(_loc7_.state == null || _loc7_.state.isDead == false) && _loc7_.canBeTargeted.enabled))
            {
               _loc8_ = Number((param1 - _loc7_.body.x) * (param1 - _loc7_.body.x) + 0.5);
               if(_loc8_ < _loc2_)
               {
                  _loc2_ = _loc8_;
                  _loc3_ = _loc7_;
               }
            }
         }
         return _loc3_;
      }
      
      public function getNearestToPosition(param1:Number, param2:Hero) : Hero
      {
         var _loc7_:int = 0;
         var _loc8_:* = null as Hero;
         var _loc9_:int = 0;
         var _loc3_:* = 100000000000;
         var _loc4_:Hero = null;
         var _loc5_:int = 0;
         var _loc6_:int = heroes.length;
         while(_loc5_ < _loc6_)
         {
            _loc5_++;
            _loc7_ = _loc5_;
            _loc8_ = heroes[_loc7_];
            if(!heroIsNotAvailable(_loc8_,param2))
            {
               _loc9_ = Number((param1 - _loc8_.body.x) * (param1 - _loc8_.body.x) + 0.5);
               if(_loc9_ < _loc3_)
               {
                  _loc3_ = Number(_loc9_);
                  _loc4_ = _loc8_;
               }
            }
         }
         return _loc4_;
      }
      
      public function getNearest(param1:Hero) : Hero
      {
         var _loc7_:int = 0;
         var _loc8_:* = null as Hero;
         var _loc9_:int = 0;
         var _loc2_:int = 16777215;
         var _loc3_:Number = param1.body.x;
         var _loc4_:Hero = null;
         var _loc5_:int = 0;
         var _loc6_:int = heroes.length;
         while(_loc5_ < _loc6_)
         {
            _loc5_++;
            _loc7_ = _loc5_;
            _loc8_ = heroes[_loc7_];
            if(!heroIsNotAvailable(_loc8_,param1))
            {
               _loc9_ = Number((_loc3_ - _loc8_.body.x) * (_loc3_ - _loc8_.body.x) + 0.5);
               if(_loc9_ < _loc2_)
               {
                  _loc2_ = _loc9_;
                  _loc4_ = _loc8_;
               }
            }
         }
         return _loc4_;
      }
      
      public function getHeroes() : Vector.<Hero>
      {
         if(team == null)
         {
            null;
         }
         return team.heroes;
      }
      
      public function getCenter() : Number
      {
         var _loc5_:int = 0;
         var _loc6_:* = null as Hero;
         var _loc1_:int = 0;
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         var _loc4_:int = heroes.length;
         while(_loc3_ < _loc4_)
         {
            _loc3_++;
            _loc5_ = _loc3_;
            _loc6_ = heroes[_loc5_];
            if(!_loc6_.get_isDead())
            {
               _loc1_++;
               _loc2_ = Number(_loc2_ + _loc6_.body.x);
            }
         }
         if(_loc1_ == 0)
         {
            return 100;
         }
         return _loc2_ / _loc1_;
      }
      
      public function getAnyNearestToPosition(param1:Number, param2:Hero) : Hero
      {
         var _loc7_:int = 0;
         var _loc8_:* = null as Hero;
         var _loc9_:int = 0;
         var _loc3_:* = 100000000000;
         var _loc4_:Hero = null;
         var _loc5_:int = 0;
         var _loc6_:int = heroes.length;
         while(_loc5_ < _loc6_)
         {
            _loc5_++;
            _loc7_ = _loc5_;
            _loc8_ = heroes[_loc7_];
            if(!(_loc8_ != param2 && (_loc8_.state == null || _loc8_.state.isDead == false) && param2.targetSelector.canTarget(_loc8_,param2)))
            {
               _loc9_ = Number((param1 - _loc8_.body.x) * (param1 - _loc8_.body.x) + 0.5);
               if(_loc9_ < _loc3_)
               {
                  _loc3_ = Number(_loc9_);
                  _loc4_ = _loc8_;
               }
            }
         }
         return _loc4_;
      }
      
      public function furthestSome(param1:SkillCast, param2:Hero, param3:int) : void
      {
         var _loc10_:int = 0;
         var _loc11_:* = null as Hero;
         var _loc12_:int = 0;
         var _loc13_:* = 0;
         var _loc4_:Number = param2.body.x;
         var _loc5_:Vector.<Hero> = param1.targets;
         var _loc6_:int = 0;
         var _loc7_:int = param2.getCurrentDirection();
         var _loc8_:int = 0;
         var _loc9_:int = heroes.length;
         while(_loc8_ < _loc9_)
         {
            _loc8_++;
            _loc10_ = _loc8_;
            _loc11_ = heroes[_loc10_];
            if(Version.current < 119)
            {
               if(!(_loc11_ == param1.hero || _loc11_.get_isAvailable()))
               {
                  continue;
               }
            }
            else if(heroIsNotAvailable(_loc11_,param1.hero))
            {
               continue;
            }
            _loc12_ = (_loc11_.body.x - _loc4_) * _loc7_;
            if(_loc6_ < param3)
            {
               _loc6_++;
            }
            else if(_loc12_ <= int((_loc5_[_loc6_ - 1].body.x - _loc4_) * _loc7_))
            {
               continue;
            }
            _loc13_ = _loc6_ - 1;
            while(true)
            {
               _loc13_--;
               if(!(_loc13_ > 0 && _loc12_ > int((_loc5_[_loc13_].body.x - _loc4_) * _loc7_)))
               {
                  break;
               }
               _loc5_[_loc13_ + 1] = _loc5_[_loc13_];
            }
            _loc5_[_loc13_ + 1] = _loc11_;
         }
         param1.targets = _loc5_;
         param1.targetsCount = _loc6_;
      }
      
      public function furthestInFront(param1:SkillCast, param2:Hero) : void
      {
         var _loc9_:int = 0;
         var _loc10_:* = null as Hero;
         var _loc11_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Hero = null;
         var _loc5_:Number = param2.body.x;
         var _loc6_:int = param2.getCurrentDirection();
         var _loc7_:int = 0;
         var _loc8_:int = heroes.length;
         while(_loc7_ < _loc8_)
         {
            _loc7_++;
            _loc9_ = _loc7_;
            _loc10_ = heroes[_loc9_];
            if(!heroIsNotAvailable(_loc10_,param1.hero))
            {
               _loc11_ = (_loc10_.body.x - _loc5_) * _loc6_;
               if(_loc11_ > _loc3_)
               {
                  _loc3_ = _loc11_;
                  _loc4_ = _loc10_;
               }
            }
         }
         if(_loc4_ != null)
         {
            param1.select(_loc4_);
         }
      }
      
      public function furthest(param1:SkillCast, param2:Number) : void
      {
         var _loc7_:int = 0;
         var _loc8_:* = null as Hero;
         var _loc9_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Hero = null;
         var _loc5_:int = 0;
         var _loc6_:int = heroes.length;
         while(_loc5_ < _loc6_)
         {
            _loc5_++;
            _loc7_ = _loc5_;
            _loc8_ = heroes[_loc7_];
            if(!heroIsNotAvailable(_loc8_,param1.hero))
            {
               _loc9_ = Number((param2 - _loc8_.body.x) * (param2 - _loc8_.body.x) + 0.5);
               if(_loc9_ > _loc3_)
               {
                  _loc3_ = _loc9_;
                  _loc4_ = _loc8_;
               }
            }
         }
         if(_loc4_ != null)
         {
            param1.select(_loc4_);
         }
      }
      
      public function fit(param1:SkillCast, param2:Function, param3:int) : void
      {
         var _loc8_:int = 0;
         var _loc9_:* = null as Hero;
         var _loc10_:* = 0;
         var _loc4_:Vector.<Hero> = param1.targets;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = heroes.length;
         while(_loc6_ < _loc7_)
         {
            _loc6_++;
            _loc8_ = _loc6_;
            _loc9_ = heroes[_loc8_];
            if(!heroIsNotAvailable(_loc9_,param1.hero))
            {
               if(_loc5_ < param3)
               {
                  _loc5_++;
               }
               else if(!param2(_loc9_,_loc4_[_loc5_ - 1]))
               {
                  continue;
               }
               _loc10_ = _loc5_ - 1;
               while(true)
               {
                  _loc10_--;
                  if(!(_loc10_ > 0 && param2(_loc9_,_loc4_[_loc10_])))
                  {
                     break;
                  }
                  _loc4_[_loc10_ + 1] = _loc4_[_loc10_];
               }
               _loc4_[_loc10_ + 1] = _loc9_;
            }
         }
         param1.index = -1;
         param1.targets = _loc4_;
         param1.targetsCount = _loc5_;
      }
      
      public function all(param1:SkillCast) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(team == null)
         {
            return;
         }
         param1.targets = new Vector.<Hero>();
         param1.targetsCount = 0;
         param1.index = -1;
         var _loc2_:int = 0;
         var _loc3_:int = heroes.length;
         while(_loc2_ < _loc3_)
         {
            _loc2_++;
            _loc4_ = _loc2_;
            if(heroes[_loc4_] != param1.hero)
            {
               _loc5_ = param1.targetsCount;
               param1.targetsCount = param1.targetsCount + 1;
               param1.targets[_loc5_] = heroes[_loc4_];
            }
         }
      }
   }
}
