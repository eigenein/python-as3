package battle.skills
{
   import battle.BattleLog;
   import battle.Hero;
   import battle.Team;
   import battle.data.HeroState;
   import battle.logic.MovingBody;
   import battle.logic.PrimeRange;
   import flash.Boot;
   
   public class TargetSelectResolver
   {
       
      
      public var targetTeam:Team;
      
      public var self:Hero;
      
      public var ranges:Vector.<PrimeRange>;
      
      public var hasExplicitTargetsAvailable:Boolean;
      
      public var explicitTargets:Vector.<Hero>;
      
      public var currentTeamExplicitTargets:Vector.<Hero>;
      
      public var active:Vector.<MovingBody>;
      
      public function TargetSelectResolver(param1:Hero = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         active = new Vector.<MovingBody>();
         ranges = new Vector.<PrimeRange>();
         currentTeamExplicitTargets = new Vector.<Hero>();
         explicitTargets = new Vector.<Hero>();
         self = param1;
      }
      
      public function setTargetTeamSilently(param1:Team) : void
      {
         if(targetTeam != null)
         {
            targetTeam.removeTargetSelector(this);
         }
         targetTeam = param1;
         targetTeam.addTargetSelector(this);
      }
      
      public function setTargetTeam(param1:Team) : void
      {
         var _loc6_:int = 0;
         var _loc7_:* = null as Hero;
         var _loc8_:* = false;
         if(targetTeam != null)
         {
            targetTeam.removeTargetSelector(this);
         }
         targetTeam = param1;
         targetTeam.addTargetSelector(this);
         hasExplicitTargetsAvailable = false;
         currentTeamExplicitTargets.length = 0;
         var _loc2_:Vector.<MovingBody> = new Vector.<MovingBody>();
         var _loc3_:Vector.<MovingBody> = new Vector.<MovingBody>();
         var _loc4_:int = 0;
         var _loc5_:int = param1.heroes.length;
         while(_loc4_ < _loc5_)
         {
            _loc4_++;
            _loc6_ = _loc4_;
            _loc7_ = param1.heroes[_loc6_];
            _loc8_ = int(explicitTargets.indexOf(_loc7_)) != -1;
            if(_loc8_)
            {
               currentTeamExplicitTargets.push(_loc7_);
            }
            if(!(_loc7_ == self || _loc7_.state != null && _loc7_.state.isDead == true || !_loc7_.canBeTargeted.enabled))
            {
               if(_loc8_)
               {
                  hasExplicitTargetsAvailable = true;
                  _loc3_.push(_loc7_.body);
               }
               _loc2_.push(_loc7_.body);
            }
         }
         if(hasExplicitTargetsAvailable)
         {
            resetActive(_loc3_);
         }
         else
         {
            resetActive(_loc2_);
         }
      }
      
      public function setActive(param1:MovingBody) : void
      {
         var _loc5_:* = null as PrimeRange;
         var _loc6_:* = null as Vector.<MovingBody>;
         var _loc2_:Vector.<MovingBody> = new Vector.<MovingBody>();
         _loc2_.push(param1);
         var _loc3_:Vector.<PrimeRange> = ranges;
         var _loc4_:int = _loc3_.length;
         while(true)
         {
            _loc4_--;
            if(_loc4_ <= 0)
            {
               break;
            }
            _loc5_ = _loc3_[_loc4_];
            _loc6_ = _loc2_.concat();
            _loc5_.setTargets(_loc6_);
         }
         active = _loc2_;
         self.adjustToTarget();
      }
      
      public function resetActive(param1:Vector.<MovingBody>) : void
      {
         var _loc4_:* = null as PrimeRange;
         var _loc5_:* = null as Vector.<MovingBody>;
         var _loc2_:Vector.<PrimeRange> = ranges;
         var _loc3_:int = _loc2_.length;
         while(true)
         {
            _loc3_--;
            if(_loc3_ <= 0)
            {
               break;
            }
            _loc4_ = _loc2_[_loc3_];
            _loc5_ = param1.concat();
            _loc4_.setTargets(_loc5_);
         }
         active = param1;
         self.adjustToTarget();
      }
      
      public function removeActive(param1:MovingBody) : void
      {
         var _loc2_:* = null as String;
         var _loc5_:* = null as PrimeRange;
         if(int(active.indexOf(param1)) == -1)
         {
            _loc2_ = "inconsistent remove " + Std.string(Context.engine.objects.heroesByBody[param1]) + " in " + Std.string(self) + " from " + Std.string(Context.engine.objects.bodiesToHeroes(active));
            if(BattleLog.doLog)
            {
               BattleLog.m.logString(_loc2_);
            }
            return;
         }
         var _loc3_:Vector.<PrimeRange> = ranges;
         var _loc4_:int = _loc3_.length;
         while(true)
         {
            _loc4_--;
            if(_loc4_ <= 0)
            {
               break;
            }
            _loc5_ = _loc3_[_loc4_];
            _loc5_.removeObject(param1);
         }
         var _loc6_:Vector.<MovingBody> = active;
         _loc4_ = _loc6_.length;
         var _loc7_:int = _loc4_;
         while(true)
         {
            _loc4_--;
            if(_loc4_ > 0)
            {
               if(_loc6_[_loc4_] == param1)
               {
                  while(true)
                  {
                     _loc4_++;
                     if(_loc4_ >= _loc7_)
                     {
                        break;
                     }
                     _loc6_[_loc4_ - 1] = _loc6_[_loc4_];
                  }
                  _loc6_.length = _loc7_ - 1;
                  break;
               }
               continue;
            }
            break;
         }
         self.adjustToTarget();
      }
      
      public function prioritizeTarget(param1:Hero, param2:Hero) : void
      {
         if(explicitTargets == null)
         {
            explicitTargets = new Vector.<Hero>();
         }
         var _loc3_:* = int(explicitTargets.indexOf(param1)) != -1;
         explicitTargets.push(param1);
         if(int(targetTeam.heroes.indexOf(param1)) == -1)
         {
            return;
         }
         currentTeamExplicitTargets.push(param1);
         if(!_loc3_)
         {
            if(param1 == param2 || param1.state != null && param1.state.isDead == true || !param1.canBeTargeted.enabled)
            {
               return;
            }
            if(hasExplicitTargetsAvailable)
            {
               addActive(param1.body);
            }
            else
            {
               setActive(param1.body);
               hasExplicitTargetsAvailable = true;
            }
         }
      }
      
      public function heroIsNotAvailable(param1:Hero) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = null as Hero;
         var _loc7_:* = null as Vector.<MovingBody>;
         if(param1 == self)
         {
            return;
         }
         var _loc2_:Boolean = currentTeamExplicitTargets != null && int(currentTeamExplicitTargets.length) > 0 && int(currentTeamExplicitTargets.indexOf(param1)) != -1;
         if(_loc2_)
         {
            hasExplicitTargetsAvailable = false;
            _loc3_ = 0;
            _loc4_ = currentTeamExplicitTargets.length;
            while(_loc3_ < _loc4_)
            {
               _loc3_++;
               _loc5_ = _loc3_;
               _loc6_ = currentTeamExplicitTargets[_loc5_];
               if(!(_loc6_ == self || _loc6_.state != null && _loc6_.state.isDead == true || !_loc6_.canBeTargeted.enabled))
               {
                  hasExplicitTargetsAvailable = true;
                  break;
               }
            }
            if(hasExplicitTargetsAvailable)
            {
               removeActive(param1.body);
            }
            else
            {
               _loc7_ = new Vector.<MovingBody>();
               _loc3_ = 0;
               _loc4_ = targetTeam.heroes.length;
               while(_loc3_ < _loc4_)
               {
                  _loc3_++;
                  _loc5_ = _loc3_;
                  _loc6_ = targetTeam.heroes[_loc5_];
                  if(!(_loc6_ == self || _loc6_.state != null && _loc6_.state.isDead == true || !_loc6_.canBeTargeted.enabled))
                  {
                     _loc7_.push(_loc6_.body);
                  }
               }
               resetActive(_loc7_);
            }
         }
         else if(!hasExplicitTargetsAvailable)
         {
            removeActive(param1.body);
         }
      }
      
      public function heroIsAvailable(param1:Hero) : void
      {
         if(param1 == self)
         {
            return;
         }
         var _loc2_:Boolean = currentTeamExplicitTargets != null && int(currentTeamExplicitTargets.length) > 0 && int(currentTeamExplicitTargets.indexOf(param1)) != -1;
         if(_loc2_ == hasExplicitTargetsAvailable)
         {
            addActive(param1.body);
         }
         else if(!!_loc2_ && !hasExplicitTargetsAvailable)
         {
            hasExplicitTargetsAvailable = true;
            setActive(param1.body);
         }
      }
      
      public function deprioritizeTarget(param1:Hero, param2:Hero) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = null as Hero;
         var _loc9_:* = null as Vector.<MovingBody>;
         var _loc3_:Vector.<Hero> = explicitTargets;
         _loc4_ = _loc3_.length;
         _loc5_ = _loc4_;
         while(true)
         {
            _loc4_--;
            if(_loc4_ > 0)
            {
               if(_loc3_[_loc4_] == param1)
               {
                  while(true)
                  {
                     _loc4_++;
                     if(_loc4_ >= _loc5_)
                     {
                        break;
                     }
                     _loc3_[_loc4_ - 1] = _loc3_[_loc4_];
                  }
                  _loc3_.length = _loc5_ - 1;
                  break;
               }
               continue;
            }
            break;
         }
         if(int(targetTeam.heroes.indexOf(param1)) == -1)
         {
            return;
         }
         _loc3_ = currentTeamExplicitTargets;
         _loc4_ = _loc3_.length;
         _loc5_ = _loc4_;
         while(true)
         {
            _loc4_--;
            if(_loc4_ > 0)
            {
               if(_loc3_[_loc4_] == param1)
               {
                  while(true)
                  {
                     _loc4_++;
                     if(_loc4_ >= _loc5_)
                     {
                        break;
                     }
                     _loc3_[_loc4_ - 1] = _loc3_[_loc4_];
                  }
                  _loc3_.length = _loc5_ - 1;
                  break;
               }
               continue;
            }
            break;
         }
         if(param1 == param2 || param1.state != null && param1.state.isDead == true || !param1.canBeTargeted.enabled)
         {
            return;
         }
         var _loc6_:* = int(explicitTargets.indexOf(param1)) != -1;
         if(!_loc6_)
         {
            if(hasExplicitTargetsAvailable)
            {
               hasExplicitTargetsAvailable = false;
               _loc4_ = 0;
               _loc5_ = currentTeamExplicitTargets.length;
               while(_loc4_ < _loc5_)
               {
                  _loc4_++;
                  _loc7_ = _loc4_;
                  _loc8_ = currentTeamExplicitTargets[_loc7_];
                  if(!(_loc8_ == param2 || _loc8_.state != null && _loc8_.state.isDead == true || !_loc8_.canBeTargeted.enabled))
                  {
                     hasExplicitTargetsAvailable = true;
                     break;
                  }
               }
               if(hasExplicitTargetsAvailable)
               {
                  removeActive(param1.body);
               }
               else
               {
                  _loc9_ = new Vector.<MovingBody>();
                  _loc4_ = 0;
                  _loc5_ = targetTeam.heroes.length;
                  while(_loc4_ < _loc5_)
                  {
                     _loc4_++;
                     _loc7_ = _loc4_;
                     _loc8_ = targetTeam.heroes[_loc7_];
                     if(!(_loc8_ == param2 || _loc8_.state != null && _loc8_.state.isDead == true || !_loc8_.canBeTargeted.enabled))
                     {
                        _loc9_.push(_loc8_.body);
                     }
                  }
                  resetActive(_loc9_);
               }
            }
         }
      }
      
      public function checkRanges() : void
      {
         var _loc3_:* = null as PrimeRange;
         var _loc1_:Vector.<PrimeRange> = ranges;
         var _loc2_:int = _loc1_.length;
         while(true)
         {
            _loc2_--;
            if(_loc2_ <= 0)
            {
               break;
            }
            _loc3_ = _loc1_[_loc2_];
            _loc3_.checkObjectsForDuplicates();
         }
      }
      
      public function canTarget(param1:Hero, param2:Hero) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:* = null as Hero;
         if(param1 == param2 || param1.state != null && param1.state.isDead == true || !param1.canBeTargeted.enabled)
         {
            return false;
         }
         if(explicitTargets != null && int(explicitTargets.length) > 0)
         {
            if(int(explicitTargets.indexOf(param1)) != -1)
            {
               return true;
            }
            _loc3_ = false;
            _loc4_ = 0;
            _loc5_ = currentTeamExplicitTargets.length;
            while(_loc4_ < _loc5_)
            {
               _loc4_++;
               _loc6_ = _loc4_;
               _loc7_ = currentTeamExplicitTargets[_loc6_];
               if(!(_loc7_ == param2 || _loc7_.state != null && _loc7_.state.isDead == true || !_loc7_.canBeTargeted.enabled))
               {
                  _loc3_ = true;
               }
            }
            if(_loc3_)
            {
               return false;
            }
            return true;
         }
         return true;
      }
      
      public function addRange(param1:PrimeRange) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = null as Hero;
         ranges.push(param1);
         if(hasExplicitTargetsAvailable)
         {
            _loc2_ = 0;
            _loc3_ = currentTeamExplicitTargets.length;
            while(_loc2_ < _loc3_)
            {
               _loc2_++;
               _loc4_ = _loc2_;
               _loc5_ = currentTeamExplicitTargets[_loc4_];
               if(!(_loc5_ == self || _loc5_.state != null && _loc5_.state.isDead == true || !_loc5_.canBeTargeted.enabled))
               {
                  param1.addObject(_loc5_.body);
               }
            }
         }
         else if(targetTeam != null)
         {
            _loc2_ = 0;
            _loc3_ = targetTeam.heroes.length;
            while(_loc2_ < _loc3_)
            {
               _loc2_++;
               _loc4_ = _loc2_;
               _loc5_ = targetTeam.heroes[_loc4_];
               if(!(_loc5_ == self || _loc5_.state != null && _loc5_.state.isDead == true || !_loc5_.canBeTargeted.enabled))
               {
                  param1.addObject(_loc5_.body);
               }
            }
         }
      }
      
      public function addActive(param1:MovingBody) : void
      {
         var _loc2_:* = null as String;
         var _loc5_:* = null as PrimeRange;
         if(int(active.indexOf(param1)) != -1)
         {
            _loc2_ = "inconsistent add " + Std.string(Context.engine.objects.heroesByBody[param1]) + " in " + Std.string(self) + " from " + Std.string(Context.engine.objects.bodiesToHeroes(active));
            if(BattleLog.doLog)
            {
               BattleLog.m.logString(_loc2_);
            }
            return;
         }
         var _loc3_:Vector.<PrimeRange> = ranges;
         var _loc4_:int = _loc3_.length;
         while(true)
         {
            _loc4_--;
            if(_loc4_ <= 0)
            {
               break;
            }
            _loc5_ = _loc3_[_loc4_];
            _loc5_.addObject(param1);
         }
         active.push(param1);
         self.adjustToTarget();
      }
   }
}
