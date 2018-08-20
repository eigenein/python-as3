package battle.skills
{
   import battle.Hero;
   import battle.HeroStats;
   import battle.Team;
   import battle.utils.Version;
   import flash.Boot;
   
   public class TeamAllyTargetSelector extends TeamTargetSelector
   {
       
      
      public function TeamAllyTargetSelector(param1:Team = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1);
      }
      
      public function minRelativeHpExcludes(param1:SkillCast, param2:Hero) : void
      {
         var _loc7_:int = 0;
         var _loc8_:* = null as Hero;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc3_:* = 10000;
         var _loc4_:Hero = null;
         var _loc5_:int = 0;
         var _loc6_:int = heroes.length;
         while(_loc5_ < _loc6_)
         {
            _loc5_++;
            _loc7_ = _loc5_;
            _loc8_ = heroes[_loc7_];
            if(!(heroIsNotAvailable(_loc8_,param1.hero) || _loc8_ == param2))
            {
               if(Version.current >= 135)
               {
                  if(_loc4_ == null)
                  {
                     _loc4_ = _loc8_;
                  }
                  else
                  {
                     _loc9_ = _loc8_.state.hp / 1 * (_loc4_.updatedStats().hp / 1);
                     _loc10_ = _loc4_.state.hp / 1 * (_loc8_.updatedStats().hp / 1);
                     if(_loc9_ < _loc10_ || _loc9_ == _loc10_ && _loc8_.desc.battleOrder < _loc4_.desc.battleOrder)
                     {
                        _loc4_ = _loc8_;
                     }
                  }
               }
               else
               {
                  _loc9_ = _loc8_.getRelativeHealth();
                  if(_loc9_ < _loc3_)
                  {
                     _loc3_ = Number(_loc9_);
                     _loc4_ = _loc8_;
                  }
               }
            }
         }
         if(_loc4_ == null)
         {
            param1.targetsCount = 0;
         }
         else
         {
            param1.select(_loc4_);
         }
      }
      
      public function minHpRelative(param1:SkillCast, param2:int = 1) : void
      {
         var _loc7_:int = 0;
         var _loc8_:* = null as Hero;
         var _loc9_:Number = NaN;
         var _loc10_:* = 0;
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
               _loc9_ = _loc8_.getRelativeHealth();
               if(_loc4_ < param2)
               {
                  _loc4_++;
               }
               else if(_loc9_ >= Number(_loc3_[_loc4_ - 1].getRelativeHealth()))
               {
                  continue;
               }
               _loc10_ = _loc4_ - 1;
               while(true)
               {
                  _loc10_--;
                  if(!(_loc10_ > 0 && _loc9_ < Number(_loc3_[_loc10_].getRelativeHealth())))
                  {
                     break;
                  }
                  _loc3_[_loc10_ + 1] = _loc3_[_loc10_];
               }
               _loc3_[_loc10_ + 1] = _loc8_;
            }
         }
         param1.index = -1;
         param1.targets = _loc3_;
         param1.targetsCount = _loc4_;
      }
      
      public function minHpExcludes(param1:SkillCast, param2:Hero) : void
      {
         var _loc7_:int = 0;
         var _loc8_:* = null as Hero;
         var _loc3_:int = 1000000;
         var _loc4_:Hero = null;
         var _loc5_:int = 0;
         var _loc6_:int = heroes.length;
         while(_loc5_ < _loc6_)
         {
            _loc5_++;
            _loc7_ = _loc5_;
            _loc8_ = heroes[_loc7_];
            if(!(heroIsNotAvailable(_loc8_,param1.hero) || _loc8_ == param2))
            {
               if(_loc8_.state.hp < _loc3_)
               {
                  _loc3_ = _loc8_.state.hp;
                  _loc4_ = _loc8_;
               }
            }
         }
         if(_loc4_ == null)
         {
            param1.targetsCount = 0;
         }
         else
         {
            param1.select(_loc4_);
         }
      }
      
      override public function minHp(param1:SkillCast, param2:int = 1) : void
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
         param1.targets = _loc3_;
         param1.targetsCount = _loc4_;
      }
      
      override public function heroIsNotAvailable(param1:Hero, param2:Hero) : Boolean
      {
         return !(!param1.state.isDead && param1.canBeTargetedByAliases.enabled);
      }
      
      override public function getNearestToPosition(param1:Number, param2:Hero) : Hero
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
            if(!heroIsNotAvailable(_loc8_,param2))
            {
               _loc9_ = Number((param1 - _loc8_.body.x) * (param1 - _loc8_.body.x) + 0.5);
               if(_loc9_ < _loc3_)
               {
                  _loc3_ = _loc9_;
                  _loc4_ = _loc8_;
               }
            }
         }
         return _loc4_;
      }
      
      override public function furthestInFront(param1:SkillCast, param2:Hero) : void
      {
         var _loc10_:int = 0;
         var _loc11_:* = null as Hero;
         var _loc12_:Number = NaN;
         var _loc13_:int = 0;
         var _loc3_:Number = param2.body.x;
         var _loc4_:* = -1.0e100;
         var _loc5_:* = 1.0e100;
         if(int(param2.getCurrentDirection()) > 0)
         {
            _loc4_ = Number(_loc3_);
         }
         else
         {
            _loc5_ = Number(_loc3_);
         }
         var _loc6_:Hero = null;
         var _loc7_:* = 0;
         var _loc8_:int = 0;
         var _loc9_:int = heroes.length;
         while(_loc8_ < _loc9_)
         {
            _loc8_++;
            _loc10_ = _loc8_;
            _loc11_ = heroes[_loc10_];
            if(!heroIsNotAvailable(_loc11_,param1.hero))
            {
               _loc12_ = _loc11_.body.x;
               if(_loc4_ <= _loc12_ && _loc12_ <= _loc5_)
               {
                  _loc13_ = Number((_loc3_ - _loc12_) * (_loc3_ - _loc12_) + 0.5);
                  if(_loc13_ > _loc7_)
                  {
                     _loc7_ = Number(_loc13_);
                     _loc6_ = heroes[_loc10_];
                  }
               }
            }
         }
         if(_loc6_ != null)
         {
            param1.select(_loc6_);
         }
         else
         {
            param1.select(param2);
         }
      }
      
      override public function fit(param1:SkillCast, param2:Function, param3:int) : void
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
            if(!(heroIsNotAvailable(_loc9_,param1.hero) || _loc9_ == param1.hero))
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
      
      override public function all(param1:SkillCast) : void
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
            _loc5_ = param1.targetsCount;
            param1.targetsCount = param1.targetsCount + 1;
            param1.targets[_loc5_] = heroes[_loc4_];
         }
      }
   }
}
