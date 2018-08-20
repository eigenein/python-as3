package game.battle.controller.position
{
   import battle.Hero;
   import battle.Team;
   import battle.objects.BattleBody;
   import game.battle.view.hero.HeroView;
   
   public class BattleBodyStateSystem
   {
      
      public static const TITAN_SIZE:Number = 100;
      
      public static const HERO_SIZE:Number = 70;
      
      public static const Y_SPEED_MULTIPLYER:Number = 0.5;
      
      public static const MIN_Y:Number = -90;
      
      public static const MAX_Y:Number = 110;
      
      public static const MAX_RANGE_ATTACKER_Y_DELTA:Number = 76;
      
      public static const MELEE_MAX_RANGE:Number = 150;
      
      public static const BATTLE_HERO_SIZE:Number = 75;
      
      public static const ISO_SCALE:Number = 0.8;
       
      
      private var notInitedNodes:Vector.<BattleBodyEntry>;
      
      private var nodes:Vector.<BattleBodyEntry>;
      
      public function BattleBodyStateSystem()
      {
         notInitedNodes = new Vector.<BattleBodyEntry>();
         nodes = new Vector.<BattleBodyEntry>();
         super();
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc2_:* = null;
         if(notInitedNodes.length > 0)
         {
            preinit();
         }
         var _loc4_:int = 0;
         var _loc3_:* = nodes;
         for each(_loc2_ in nodes)
         {
            _loc2_.position.allyCollision = 0;
            _loc2_.position.targetYAiming = 0;
            _loc2_.position.targetYAimingCount = 0;
            updateFromModel(_loc2_.body,_loc2_.modelState);
            if(_loc2_.view)
            {
               updateFromView(_loc2_.view,_loc2_.viewState);
            }
         }
         updateYMovement(param1);
         var _loc6_:int = 0;
         var _loc5_:* = nodes;
         for each(_loc2_ in nodes)
         {
            updatePosition(_loc2_,_loc2_.modelState,_loc2_.viewState,_loc2_.position,_loc2_.viewPosition,param1);
            updateViewPosition(_loc2_);
         }
      }
      
      public function addEntry(param1:BattleBodyEntry, param2:Boolean = false) : BattleBodyEntry
      {
         if(param1.body)
         {
            param1.body.onRemove.add(handler_onRemove);
         }
         if(!param1.viewState)
         {
            param1.viewState = new BattleBodyViewState();
         }
         if(!param1.position)
         {
            param1.position = new BattleBodyViewPosition();
         }
         if(!param1.modelState)
         {
            param1.modelState = new BattleBodyState();
         }
         if(!param1.viewPosition)
         {
            param1.viewPosition = new HeroViewPositionValue();
         }
         updateFromModel(param1.body,param1.modelState);
         param1.position.x = param1.modelState.position;
         param1.position.y = param1.viewPosition.y;
         if(param2)
         {
            updateViewPosition(param1);
         }
         notInitedNodes.push(param1);
         return param1;
      }
      
      public function add(param1:BattleBody, param2:Team, param3:HeroViewPositionValue, param4:HeroView, param5:BattleBodyState) : BattleBodyEntry
      {
         var _loc7_:* = null;
         var _loc6_:BattleBodyEntry = new BattleBodyEntry();
         _loc6_.body = param1;
         _loc6_.modelState = param5;
         _loc6_.team = param2;
         _loc6_.viewPosition = param3;
         _loc6_.viewState = new BattleBodyViewState();
         _loc6_.view = param4;
         _loc6_.position = new BattleBodyViewPosition();
         notInitedNodes.push(_loc6_);
         if(param1 is Hero)
         {
            _loc7_ = param1 as Hero;
            _loc6_.autoAttackRange = _loc7_.skills.getAutoAttack().desc.range;
            _loc6_.meleeTypeTargeting = _loc6_.autoAttackRange + 75 < 150;
            _loc6_.rangeTypeTargeting = !_loc6_.meleeTypeTargeting;
         }
         param1.onRemove.add(handler_onRemove);
         return _loc6_;
      }
      
      public function remove(param1:BattleBody) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = nodes.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(nodes[_loc3_].body == param1)
            {
               nodes.splice(_loc3_,1);
               return;
            }
            _loc3_++;
         }
      }
      
      public function clear() : void
      {
         nodes.length = 0;
      }
      
      public function getBody(param1:BattleBody) : BattleBodyEntry
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function updateYMovement(param1:Number) : void
      {
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc7_:int = 0;
         var _loc3_:* = null;
         var _loc4_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc9_:* = 0.8;
         var _loc5_:int = nodes.length;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc2_ = nodes[_loc6_];
            _loc7_ = _loc6_ + 1;
            for(; _loc7_ < _loc5_; _loc7_++)
            {
               _loc3_ = nodes[_loc7_];
               _loc4_ = _loc2_.position.x - _loc3_.position.x;
               _loc13_ = _loc2_.position.y - _loc3_.position.y;
               _loc14_ = _loc2_.size + _loc3_.size;
               if(_loc2_.team == _loc3_.team)
               {
                  if(_loc4_ * _loc4_ <= _loc14_ * _loc14_)
                  {
                     _loc15_ = (_loc2_.modelState.size + _loc3_.modelState.size) / 25 * _loc14_ / 2;
                     if(_loc4_ * _loc4_ + _loc13_ * _loc13_ / _loc9_ / _loc9_ <= _loc15_ * _loc15_)
                     {
                        _loc10_ = Math.sqrt(_loc15_ * _loc15_ - _loc4_ * _loc4_) * _loc9_;
                        _loc11_ = _loc13_ > 0 && _loc10_ > 0 || _loc13_ <= 0 && _loc10_ <= 0?_loc13_ - _loc10_:Number(_loc13_ + _loc10_);
                        if(_loc11_ < 0)
                        {
                           _loc11_ = -Math.sqrt(-_loc11_) * 6;
                        }
                        else
                        {
                           _loc11_ = Math.sqrt(_loc11_) * 6;
                        }
                        _loc2_.position.allyCollision = _loc2_.position.allyCollision - _loc11_ * _loc3_.modelState.mass / (_loc2_.modelState.mass + _loc3_.modelState.mass);
                        _loc3_.position.allyCollision = _loc3_.position.allyCollision + _loc11_ * _loc2_.modelState.mass / (_loc2_.modelState.mass + _loc3_.modelState.mass);
                     }
                     continue;
                  }
               }
               else
               {
                  if(_loc4_ * _loc4_ <= _loc2_.modelState.meleeTypeTargetingRange * _loc2_.modelState.meleeTypeTargetingRange)
                  {
                     _loc8_ = Math.sqrt(_loc4_ > 0?_loc4_:Number(-_loc4_)) * 0.5;
                     _loc2_.position.targetYAiming = _loc2_.position.targetYAiming - _loc13_ / (1 + _loc8_ / (_loc14_ / 2)) * 0.2;
                     _loc2_.position.targetYAimingCount++;
                  }
                  if(_loc4_ * _loc4_ <= _loc3_.modelState.meleeTypeTargetingRange * _loc3_.modelState.meleeTypeTargetingRange)
                  {
                     _loc8_ = Math.sqrt(_loc4_ > 0?_loc4_:Number(-_loc4_)) * 0.5;
                     _loc3_.position.targetYAiming = _loc3_.position.targetYAiming + _loc13_ / (1 + _loc8_ / (_loc14_ / 2)) * 0.2;
                     _loc3_.position.targetYAimingCount++;
                  }
               }
               if(_loc2_.modelState.target == _loc3_.body)
               {
                  _loc12_ = _loc2_.autoAttackRange + 75;
                  if(_loc2_.meleeTypeTargeting && _loc4_ * _loc4_ < 4 * _loc12_ * _loc12_ || _loc2_.rangeTypeTargeting && _loc13_ * _loc13_ > 76 * 76 && _loc4_ * _loc4_ > _loc12_ * _loc12_)
                  {
                     _loc2_.position.targetYAiming = _loc2_.position.targetYAiming - _loc13_ * 0.07;
                     _loc2_.position.targetYAimingCount++;
                  }
               }
               if(_loc3_.modelState.target == _loc2_.body)
               {
                  _loc12_ = _loc3_.autoAttackRange + 75;
                  if(_loc3_.meleeTypeTargeting && _loc4_ * _loc4_ < 4 * _loc12_ * _loc12_ || _loc3_.rangeTypeTargeting && _loc13_ * _loc13_ > 76 * 76 && _loc4_ * _loc4_ > _loc12_ * _loc12_)
                  {
                     _loc3_.position.targetYAiming = _loc3_.position.targetYAiming + _loc13_ * 0.07;
                     _loc3_.position.targetYAimingCount++;
                     continue;
                  }
                  continue;
               }
            }
            _loc6_++;
         }
      }
      
      protected function preinit() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = notInitedNodes.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            nodes.push(notInitedNodes[_loc2_]);
            _loc2_++;
         }
         notInitedNodes.length = 0;
      }
      
      protected function updateViewPosition(param1:BattleBodyEntry) : void
      {
         var _loc2_:BattleBodyState = param1.modelState;
         var _loc3_:BattleBodyViewState = param1.viewState;
         var _loc4_:BattleBodyViewPosition = param1.position;
         var _loc5_:HeroViewPositionValue = param1.viewPosition;
         _loc5_.x = _loc4_.x;
         _loc5_.y = _loc4_.y;
         _loc5_.z = _loc4_.y + (!!_loc3_.isAttacking?_loc2_.size * 0.1:0);
         _loc5_.size = _loc2_.size;
         _loc5_.direction = _loc2_.direction;
         _loc5_.movement = _loc4_.movementDirection;
      }
      
      protected function updateFromModel(param1:BattleBody, param2:BattleBodyState) : void
      {
         var _loc3_:* = null;
         param2.position = param1.getVisualPosition();
         param2.direction = param1.getVisualDirection();
         param2.size = param1.body.size;
         if(param1 is Hero)
         {
            _loc3_ = param1 as Hero;
            param2.canMove = _loc3_.canMove.enabled && _loc3_.canWalk.enabled && !_loc3_.get_isDead();
            param2.speed = _loc3_.speed.get_value();
            param2.target = _loc3_.getTargetHero();
            if(param2.target != null)
            {
               param2.meleeTypeTargetingRange = Math.abs(param2.target.getVisualPosition() - param2.position) + 75;
            }
            else
            {
               param2.meleeTypeTargetingRange = -1;
            }
         }
      }
      
      protected function updateFromView(param1:HeroView, param2:BattleBodyViewState) : void
      {
         param2.isAttacking = param1.isAttacking;
         param2.canMoveVertically = param1.canStrafe;
      }
      
      protected function updatePosition(param1:BattleBodyEntry, param2:BattleBodyState, param3:BattleBodyViewState, param4:BattleBodyViewPosition, param5:HeroViewPositionValue, param6:Number) : void
      {
         var _loc10_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc13_:int = param4.movementDirection;
         var _loc9_:Number = param4.x;
         param4.x = param2.position;
         param4.y = param5.y;
         if(param2.canMove)
         {
            _loc10_ = param4.y;
            if(param3.canMoveVertically)
            {
               _loc12_ = 12 - param4.mobility * 6;
               _loc7_ = param2.speed * 0.5 * param6;
               _loc8_ = param4.allyCollision * 2 + param4.targetYAiming * 3 / (param4.targetYAimingCount + 1) - param4.y * 0.1;
               _loc8_ = param1.position.vy * 0.5 + _loc8_ * 0.5;
               param1.position.vy = param1.position.vy * 0.5 + _loc8_ * 0.5;
               _loc7_ = _loc7_ * Math.min(1,Math.abs(_loc8_) / 20);
               if(_loc8_ > _loc12_)
               {
                  param4.y = param4.y + _loc7_;
                  if(param4.y > 110)
                  {
                     param4.y = 110;
                  }
               }
               else if(_loc8_ < -_loc12_)
               {
                  param4.y = param4.y - _loc7_;
                  if(param4.y < -90)
                  {
                     param4.y = -90;
                  }
               }
            }
            if(param4.x != _loc9_ || param4.y != _loc10_)
            {
               param4.mobility = 1;
            }
            _loc11_ = (param4.x - _loc9_) * (param4.x - _loc9_) - (param4.y - _loc10_) * (param4.y - _loc10_);
            if(_loc11_ > 0)
            {
               _loc13_ = 1;
            }
            else if(_loc11_ < 0)
            {
               _loc13_ = 2;
            }
         }
         else if(param4.x != _loc9_)
         {
            _loc13_ = 1;
         }
         if(param1.ySpeedDuration > 0)
         {
            applyModelYVelocity(param4,param1,param6);
         }
         if(param4.mobility > 0)
         {
            param4.movementDirection = _loc13_;
         }
         else
         {
            param4.movementDirection = 0;
            param4.mobility = 0;
         }
         param4.mobility = param4.mobility - param6 * 12;
         if(param4.mobility <= 0)
         {
            param4.mobility = 0;
         }
      }
      
      protected function applyModelYVelocity(param1:BattleBodyViewPosition, param2:BattleBodyEntry, param3:Number) : void
      {
         var _loc4_:* = NaN;
         if(param2.ySpeedDuration > param3)
         {
            _loc4_ = param3;
         }
         else
         {
            _loc4_ = Number(param2.ySpeedDuration);
         }
         param2.ySpeedDuration = param2.ySpeedDuration - _loc4_;
         param1.y = param1.y + (param2.ySpeedTarget - param1.y) * _loc4_ * param2.ySpeedIntensity;
      }
      
      private function handler_onRemove(param1:BattleBody) : void
      {
         remove(param1);
      }
   }
}
