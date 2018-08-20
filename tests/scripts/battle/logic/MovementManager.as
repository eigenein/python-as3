package battle.logic
{
   import battle.timeline.IUpdateable;
   import battle.timeline.Timeline;
   import flash.Boot;
   
   public class MovementManager implements IUpdateable
   {
       
      
      public var oldTime:Number;
      
      public var objects:Vector.<MovingBody>;
      
      public function MovementManager()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         objects = new Vector.<MovingBody>();
         oldTime = 0;
      }
      
      public function update(param1:Timeline) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         if(param1.time > oldTime)
         {
            _loc2_ = param1.time - oldTime;
            _loc3_ = objects.length;
            while(true)
            {
               _loc3_--;
               if(_loc3_ <= 0)
               {
                  break;
               }
               objects[_loc3_].x = Number(objects[_loc3_].x + objects[_loc3_].vx * _loc2_);
            }
            oldTime = param1.time;
         }
      }
      
      public function setVelocity(param1:MovingBody, param2:Number) : void
      {
         param1.vx = param2;
      }
      
      public function setPosition(param1:MovingBody, param2:Number) : void
      {
         param1.x = param2;
      }
      
      public function remove(param1:MovingBody) : void
      {
         var _loc2_:Vector.<MovingBody> = objects;
         var _loc3_:int = _loc2_.length;
         var _loc4_:int = _loc3_;
         while(true)
         {
            _loc3_--;
            if(_loc3_ > 0)
            {
               if(_loc2_[_loc3_] == param1)
               {
                  while(true)
                  {
                     _loc3_++;
                     if(_loc3_ >= _loc4_)
                     {
                        break;
                     }
                     _loc2_[_loc3_ - 1] = _loc2_[_loc3_];
                  }
                  _loc2_.length = _loc4_ - 1;
                  break;
               }
               continue;
            }
            break;
         }
      }
      
      public function has(param1:MovingBody) : Boolean
      {
         return int(objects.indexOf(param1)) != -1;
      }
      
      public function getCurrentPosition(param1:MovingBody, param2:Timeline) : Number
      {
         return Number(param1.x + param1.vx * (param2.time - oldTime));
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc2_:int = objects.length;
         while(true)
         {
            _loc2_--;
            if(_loc2_ <= 0)
            {
               break;
            }
            objects[_loc2_].x = Number(objects[_loc2_].x + objects[_loc2_].vx * param1);
         }
      }
      
      public function add(param1:MovingBody) : void
      {
         objects.push(param1);
      }
   }
}
