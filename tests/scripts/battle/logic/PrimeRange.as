package battle.logic
{
   import battle.Hero;
   import battle.skills.Context;
   import battle.timeline.Timeline;
   import battle.utils.Version;
   import flash.Boot;
   
   public class PrimeRange extends RangeBase
   {
      
      public static var OCCUPATION_DELAY:Number = 0.01;
       
      
      public var outputTime:Number;
      
      public var occupied:Boolean;
      
      public var occupator:MovingBody;
      
      public var objects:Vector.<MovingBody>;
      
      public var inputTime:Number;
      
      public var inertOccupied:Boolean;
      
      public function PrimeRange(param1:Timeline = undefined, param2:MovingBody = undefined, param3:Number = 0.0)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         objects = new Vector.<MovingBody>();
         super(param1,param2,param3);
         time = Timeline.INFINITY_TIME;
         param1.add(this);
      }
      
      override public function verify(param1:Boolean = false) : Boolean
      {
         var _loc5_:int = 0;
         var _loc6_:* = null as MovingBody;
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:int = objects.length;
         while(_loc3_ < _loc4_)
         {
            _loc3_++;
            _loc5_ = _loc3_;
            _loc6_ = objects[_loc5_];
            if(base != _loc6_ && (Number(Number(_loc6_.x + _loc6_.size) + r) > base.x - 1.0e-12 && _loc6_.x - _loc6_.size - r < Number(base.x + 1.0e-12)))
            {
               if(!isOccupied())
               {
                  null;
               }
               _loc2_ = true;
               break;
            }
         }
         if(_loc2_ != Boolean(isOccupied()))
         {
            null;
         }
         else if(param1)
         {
            null;
         }
         return _loc2_;
      }
      
      override public function updateRangeEvent(param1:Number) : void
      {
      }
      
      public function updateAll(param1:Boolean = false) : void
      {
         var _loc4_:Number = NaN;
         var _loc6_:* = null as MovingBody;
         var _loc2_:MovingBody = base;
         var _loc3_:Number = timeline.time;
         occupied = false;
         inputTime = Timeline.INFINITY_TIME;
         outputTime = -Timeline.INFINITY_TIME;
         var _loc5_:int = objects.length;
         while(true)
         {
            _loc5_--;
            if(_loc5_ <= 0)
            {
               break;
            }
            _loc6_ = objects[_loc5_];
            if(Number(Number(_loc6_.x + _loc6_.size) + r) > base.x - 1.0e-10 && _loc6_.x - _loc6_.size - r < Number(base.x + 1.0e-10))
            {
               if(_loc2_.vx > _loc6_.vx)
               {
                  _loc4_ = Math.round((timeline.time + (Number(Number(_loc6_.x - _loc2_.x + _loc6_.size) + r)) / (_loc2_.vx - _loc6_.vx)) * 1000000000000) / 1000000000000;
               }
               else if(_loc2_.vx < _loc6_.vx)
               {
                  _loc4_ = Math.round((timeline.time + (_loc6_.x - _loc2_.x - _loc6_.size - r) / (_loc2_.vx - _loc6_.vx)) * 1000000000000) / 1000000000000;
               }
               else
               {
                  occupator = _loc6_;
                  occupied = true;
                  if(!inertOccupied && time > Number(timeline.time + 0.01))
                  {
                     timeline.update(this,Number(timeline.time + 0.01));
                  }
                  outputTime = -Timeline.INFINITY_TIME;
                  updateRangeEvent(Timeline.INFINITY_TIME);
                  return;
               }
               if(_loc4_ > Number(_loc3_ + 1.0e-12))
               {
                  outputTime = _loc4_;
                  if(Version.current > 119)
                  {
                     occupator = _loc6_;
                  }
                  while(true)
                  {
                     _loc5_--;
                     if(_loc5_ <= 0)
                     {
                        break;
                     }
                     _loc6_ = objects[_loc5_];
                     if(Number(Number(_loc6_.x + _loc6_.size) + r) > base.x - 1.0e-10 && _loc6_.x - _loc6_.size - r < Number(base.x + 1.0e-10))
                     {
                        if(_loc2_.vx > _loc6_.vx)
                        {
                           _loc4_ = Math.round((timeline.time + (Number(Number(_loc6_.x - _loc2_.x + _loc6_.size) + r)) / (_loc2_.vx - _loc6_.vx)) * 1000000000000) / 1000000000000;
                        }
                        else if(_loc2_.vx < _loc6_.vx)
                        {
                           _loc4_ = Math.round((timeline.time + (_loc6_.x - _loc2_.x - _loc6_.size - r) / (_loc2_.vx - _loc6_.vx)) * 1000000000000) / 1000000000000;
                        }
                        else
                        {
                           occupator = _loc6_;
                           occupied = true;
                           if(!inertOccupied && time > Number(timeline.time + 0.01))
                           {
                              timeline.update(this,Number(timeline.time + 0.01));
                           }
                           outputTime = -Timeline.INFINITY_TIME;
                           updateRangeEvent(Timeline.INFINITY_TIME);
                           return;
                        }
                        if(_loc4_ > outputTime)
                        {
                           outputTime = _loc4_;
                           occupator = _loc6_;
                        }
                     }
                  }
                  occupator = occupator;
                  occupied = true;
                  if(!inertOccupied && time > Number(timeline.time + 0.01))
                  {
                     timeline.update(this,Number(timeline.time + 0.01));
                  }
                  updateRangeEvent(outputTime);
                  return;
               }
               if(!occupied)
               {
                  outputTime = _loc4_;
               }
            }
            else
            {
               if(base.vx < _loc6_.vx)
               {
                  _loc4_ = Math.round((timeline.time + (Number(Number(_loc6_.x - base.x + _loc6_.size) + r)) / (base.vx - _loc6_.vx)) * 1000000000000) / 1000000000000;
               }
               else if(base.vx > _loc6_.vx)
               {
                  _loc4_ = Math.round((timeline.time + (_loc6_.x - base.x - _loc6_.size - r) / (base.vx - _loc6_.vx)) * 1000000000000) / 1000000000000;
               }
               else
               {
                  _loc4_ = Timeline.INFINITY_TIME;
               }
               if(inputTime > _loc4_ && timeline.time < _loc4_)
               {
                  occupator = _loc6_;
                  inputTime = _loc4_;
               }
            }
         }
         if(param1)
         {
            occupied = false;
            inertOccupied = false;
            onEmpty.fire();
         }
         else
         {
            occupied = false;
            if(inertOccupied)
            {
               inertOccupied = false;
               onEmpty.fire();
            }
         }
         updateRangeEvent(inputTime);
      }
      
      public function unsafeInRange(param1:MovingBody) : Boolean
      {
         return Number(Number(param1.x + param1.size) + r) > base.x - 1.0e-10 && param1.x - param1.size - r < Number(base.x + 1.0e-10);
      }
      
      override public function toString() : String
      {
         return (!!occupied?"(!":"(") + Std.string(base) + ",~" + int(base.x) + ">" + r + ")";
      }
      
      override public function setTargets(param1:Vector.<MovingBody>) : void
      {
         objects = param1;
         updateAll();
      }
      
      override public function setRadius(param1:Number) : void
      {
         r = param1;
         updateAll();
      }
      
      override public function removeObject(param1:MovingBody) : void
      {
         var _loc5_:Boolean = false;
         var _loc2_:int = objects.indexOf(param1);
         if(_loc2_ == -1)
         {
            return;
         }
         var _loc3_:Vector.<MovingBody> = objects;
         var _loc4_:* = int(_loc3_.length) - 1;
         if(_loc4_ >= 0)
         {
            _loc3_[_loc2_] = _loc3_[_loc4_];
            _loc3_.length = _loc4_;
         }
         param1.onMove.remove(onMove);
         if(int(objects.length) == 0)
         {
            _loc5_ = false;
            inertOccupied = _loc5_;
            occupied = _loc5_;
            onEmpty.fire();
            updateRangeEvent(Timeline.INFINITY_TIME);
            return;
         }
         if(param1 == occupator)
         {
            if(Version.current >= 92)
            {
               updateAll(true);
            }
            else
            {
               updateAll(false);
            }
         }
      }
      
      override public function onTime(param1:Timeline) : void
      {
         timeline.update(this,Timeline.INFINITY_TIME);
         if(occupied)
         {
            if(!inertOccupied)
            {
               inertOccupied = true;
               onOccupied.fire();
            }
         }
      }
      
      override public function onRangeCrossed() : void
      {
         timeline.update(this,Timeline.INFINITY_TIME);
         if(!occupied)
         {
            objectOnRange(occupator);
         }
         else
         {
            updateAll();
         }
      }
      
      public function onMove(param1:MovingBody) : void
      {
         var _loc4_:Number = NaN;
         var _loc2_:Number = timeline.time;
         var _loc3_:MovingBody = base;
         if(!occupied)
         {
            if(Number(Number(param1.x + param1.size) + r) > base.x - 1.0e-10 && param1.x - param1.size - r < Number(base.x + 1.0e-10))
            {
               objectOnRange(param1,false);
            }
            else
            {
               if(base.vx < param1.vx)
               {
                  _loc4_ = Math.round((timeline.time + (Number(Number(param1.x - base.x + param1.size) + r)) / (base.vx - param1.vx)) * 1000000000000) / 1000000000000;
               }
               else if(base.vx > param1.vx)
               {
                  _loc4_ = Math.round((timeline.time + (param1.x - base.x - param1.size - r) / (base.vx - param1.vx)) * 1000000000000) / 1000000000000;
               }
               else
               {
                  _loc4_ = Timeline.INFINITY_TIME;
               }
               if(inputTime > _loc4_ && timeline.time < _loc4_)
               {
                  occupator = param1;
                  inputTime = _loc4_;
                  updateRangeEvent(_loc4_);
               }
               else if(param1 == occupator)
               {
                  updateAll();
               }
            }
         }
         else if(param1 == occupator)
         {
            objectOnRange(occupator);
         }
      }
      
      public function onBaseMove(param1:MovingBody) : void
      {
         updateAll();
      }
      
      public function objectOnRange(param1:MovingBody, param2:Boolean = true) : void
      {
         if(base.vx > param1.vx)
         {
            outputTime = Math.round((timeline.time + (Number(Number(param1.x - base.x + param1.size) + r)) / (base.vx - param1.vx)) * 1000000000000) / 1000000000000;
         }
         else if(base.vx < param1.vx)
         {
            outputTime = Math.round((timeline.time + (param1.x - base.x - param1.size - r) / (base.vx - param1.vx)) * 1000000000000) / 1000000000000;
         }
         else
         {
            occupator = param1;
            occupied = true;
            if(!inertOccupied && time > Number(timeline.time + 0.01))
            {
               timeline.update(this,Number(timeline.time + 0.01));
            }
            outputTime = -Timeline.INFINITY_TIME;
            updateRangeEvent(Timeline.INFINITY_TIME);
            return;
         }
         if(outputTime > Number(timeline.time + 1.0e-12))
         {
            occupator = param1;
            occupied = true;
            if(!inertOccupied && time > Number(timeline.time + 0.01))
            {
               timeline.update(this,Number(timeline.time + 0.01));
            }
            updateRangeEvent(outputTime);
         }
         else
         {
            occupied = false;
            if(param2)
            {
               updateAll();
            }
         }
      }
      
      override public function isOccupied() : Boolean
      {
         return inertOccupied;
      }
      
      override public function init() : void
      {
         base.onMove.add(onBaseMove);
         var _loc1_:Boolean = false;
         inertOccupied = _loc1_;
         occupied = _loc1_;
         inputTime = Timeline.INFINITY_TIME;
         outputTime = -Timeline.INFINITY_TIME;
      }
      
      override public function hasNoObjects() : Boolean
      {
         return int(objects.length) == 0;
      }
      
      public function getInputTime(param1:MovingBody) : Number
      {
         if(base.vx < param1.vx)
         {
            return Math.round((timeline.time + (Number(Number(param1.x - base.x + param1.size) + r)) / (base.vx - param1.vx)) * 1000000000000) / 1000000000000;
         }
         if(base.vx > param1.vx)
         {
            return Math.round((timeline.time + (param1.x - base.x - param1.size - r) / (base.vx - param1.vx)) * 1000000000000) / 1000000000000;
         }
         return Timeline.INFINITY_TIME;
      }
      
      public function computeObjectCore(param1:MovingBody) : void
      {
         var _loc2_:Number = NaN;
         if(!occupied)
         {
            if(Number(Number(param1.x + param1.size) + r) > base.x - 1.0e-10 && param1.x - param1.size - r < Number(base.x + 1.0e-10))
            {
               objectOnRange(param1,false);
            }
            else
            {
               if(base.vx < param1.vx)
               {
                  _loc2_ = Math.round((timeline.time + (Number(Number(param1.x - base.x + param1.size) + r)) / (base.vx - param1.vx)) * 1000000000000) / 1000000000000;
               }
               else if(base.vx > param1.vx)
               {
                  _loc2_ = Math.round((timeline.time + (param1.x - base.x - param1.size - r) / (base.vx - param1.vx)) * 1000000000000) / 1000000000000;
               }
               else
               {
                  _loc2_ = Timeline.INFINITY_TIME;
               }
               if(inputTime > _loc2_ && timeline.time < _loc2_)
               {
                  occupator = param1;
                  inputTime = _loc2_;
                  updateRangeEvent(_loc2_);
               }
               else if(param1 == occupator)
               {
                  updateAll();
               }
            }
         }
         else if(param1 == occupator)
         {
            objectOnRange(occupator);
         }
      }
      
      public function checkObjectsForDuplicates() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:int = 1;
         var _loc2_:int = objects.length;
         while(_loc1_ < _loc2_)
         {
            _loc1_++;
            _loc3_ = _loc1_;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc4_++;
               _loc5_ = _loc4_;
               if(objects[_loc3_] == objects[_loc5_])
               {
                  throw "error " + _loc3_ + " " + _loc5_ + " " + Context.engine.objects.heroesByBody[objects[_loc3_]].desc.name + " " + Context.engine.objects.heroesByBody[objects[_loc5_]].desc.name;
               }
            }
         }
      }
      
      override public function addObject(param1:MovingBody) : void
      {
         var _loc4_:Number = NaN;
         if(param1 == base)
         {
            return;
         }
         objects.push(param1);
         param1.onMove.add(onMove);
         var _loc2_:Number = timeline.time;
         var _loc3_:MovingBody = base;
         if(!occupied)
         {
            if(Number(Number(param1.x + param1.size) + r) > base.x - 1.0e-10 && param1.x - param1.size - r < Number(base.x + 1.0e-10))
            {
               objectOnRange(param1,false);
            }
            else
            {
               if(base.vx < param1.vx)
               {
                  _loc4_ = Math.round((timeline.time + (Number(Number(param1.x - base.x + param1.size) + r)) / (base.vx - param1.vx)) * 1000000000000) / 1000000000000;
               }
               else if(base.vx > param1.vx)
               {
                  _loc4_ = Math.round((timeline.time + (param1.x - base.x - param1.size - r) / (base.vx - param1.vx)) * 1000000000000) / 1000000000000;
               }
               else
               {
                  _loc4_ = Timeline.INFINITY_TIME;
               }
               if(inputTime > _loc4_ && timeline.time < _loc4_)
               {
                  occupator = param1;
                  inputTime = _loc4_;
                  updateRangeEvent(_loc4_);
               }
               else if(param1 == occupator)
               {
                  updateAll();
               }
            }
         }
         else if(param1 == occupator)
         {
            objectOnRange(occupator);
         }
         if(int(objects.length) == 1 && !occupied)
         {
            onEmpty.fire();
         }
      }
   }
}
