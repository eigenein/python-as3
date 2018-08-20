package game.mechanics.boss.popup.dropparticle
{
   import flash.geom.Point;
   
   public class DropParticleSystem
   {
       
      
      private var route:Vector.<DropParticleMovement>;
      
      private var particles:Vector.<DropParticlePosition>;
      
      public function DropParticleSystem()
      {
         route = new Vector.<DropParticleMovement>();
         particles = new Vector.<DropParticlePosition>();
         super();
      }
      
      public static function test() : void
      {
         var _loc1_:* = NaN;
         var _loc2_:DropParticleSystem = new DropParticleSystem();
         _loc2_.add(new DropParticleMovementPoint(0,0,0,-100));
         _loc2_.add(new DropParticleMovementToPointInTime(-50,-200,1));
         _loc2_.add(new DropParticleMovementSpringStop(2,1));
         _loc2_.add(new DropParticleMovementToPointInTime(50,-300,1));
         _loc2_.addParticle(null,null);
         _loc1_ = 0;
         while(_loc1_ < 3.5)
         {
            _loc2_.advanceTime(0.1);
            _loc1_ = Number(_loc1_ + 0.1);
         }
      }
      
      public function add(param1:DropParticleMovement) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = route.length;
         if(_loc3_ > 0)
         {
            _loc2_ = route[_loc3_ - 1];
            _loc2_.next = param1;
            param1.prev = _loc2_;
         }
         route[_loc3_] = param1;
      }
      
      public function addParticle(param1:IDropParticleView, param2:Vector.<DropParticleMovement>) : DropParticlePosition
      {
         var _loc4_:int = 0;
         var _loc3_:DropParticlePosition = new DropParticlePosition();
         if(param2 != null)
         {
            _loc3_.route = param2;
         }
         else
         {
            _loc3_.route = param2;
         }
         var _loc5_:int = param2.length;
         _loc4_ = 1;
         while(_loc4_ < _loc5_)
         {
            param2[_loc4_].prev = param2[_loc4_ - 1];
            param2[_loc4_ - 1].next = param2[_loc4_];
            _loc4_++;
         }
         particles.push(_loc3_);
         _loc3_.view = param1;
         return _loc3_;
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = NaN;
         var _loc8_:* = null;
         var _loc4_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc6_:* = null;
         var _loc7_:int = particles.length;
         _loc5_ = 0;
         while(_loc5_ < _loc7_)
         {
            _loc2_ = particles[_loc5_];
            if(_loc2_ != null)
            {
               _loc3_ = param1;
               while(_loc3_ > 0)
               {
                  _loc8_ = _loc2_.route[_loc2_.step];
                  _loc4_ = _loc8_.duration;
                  _loc9_ = (1 - _loc2_.t) * _loc4_;
                  if(_loc3_ < _loc9_)
                  {
                     _loc2_.t = _loc2_.t + _loc3_ / _loc4_;
                     _loc3_ = 0;
                  }
                  else
                  {
                     _loc3_ = Number(_loc3_ - _loc9_);
                     _loc2_.t = 0;
                     _loc8_.complete();
                     _loc2_.step = Number(_loc2_.step) + 1;
                     if(_loc2_.step > _loc2_.route.length - 1)
                     {
                        remove(_loc2_,_loc5_);
                        _loc2_ = null;
                        break;
                     }
                  }
               }
               if(_loc2_ && _loc8_)
               {
                  _loc6_ = _loc8_.getPosition(_loc2_.t);
                  _loc2_.position.x = _loc6_.x;
                  _loc2_.position.y = _loc6_.y;
                  if(_loc2_.view)
                  {
                     _loc2_.view.setParticlePosition(_loc6_.x,_loc6_.y);
                  }
                  _loc8_.pool(_loc6_);
               }
            }
            _loc5_++;
         }
      }
      
      public function remove(param1:DropParticlePosition, param2:int) : void
      {
         if(param1.view)
         {
            param1.view.removeParticle();
         }
         particles[param2] = null;
      }
   }
}
