package battle
{
   import battle.data.InputEventDescription;
   import battle.timeline.Timeline;
   import flash.Boot;
   
   public class InputEventHolder
   {
       
      
      public var team:Team;
      
      public var queue:Vector.<InputEventDescription>;
      
      public var index:int;
      
      public function InputEventHolder(param1:Team = undefined, param2:Vector.<InputEventDescription> = undefined)
      {
         var _loc3_:* = null as InputEventDescription;
         var _loc4_:int = 0;
         if(Boot.skip_constructor)
         {
            return;
         }
         team = param1;
         queue = param2;
         var _loc5_:int = 0;
         var _loc6_:int = param2.length;
         while(true)
         {
            _loc5_++;
            if(_loc5_ >= _loc6_)
            {
               break;
            }
            _loc3_ = param2[_loc5_];
            _loc4_ = _loc5_;
            while(_loc4_ > 0 && param2[_loc4_ - 1].time > _loc3_.time)
            {
               param2[_loc4_] = param2[_loc4_ - 1];
               _loc4_--;
            }
            param2[_loc4_] = _loc3_;
         }
         index = 0;
      }
      
      public function replayEvent(param1:InputEventDescription) : void
      {
         var _loc2_:* = null as Hero;
         if(param1.act == "cast")
         {
            _loc2_ = team.getHeroById(param1.hero);
            if(_loc2_ == null)
            {
               return;
            }
            _loc2_.actionUserInput();
         }
         else if(param1.act == "custom")
         {
            _loc2_ = team.getHeroById(param1.hero);
            if(_loc2_ == null)
            {
               return;
            }
            _loc2_.customActionUserInput(param1.id);
         }
         else if(param1.act == "auto")
         {
            team.onAutoFightToggle.fire();
         }
         else if(param1.act == "teamCustom")
         {
            team.customActionTeamInput(param1.id);
         }
      }
      
      public function nextTime() : Number
      {
         if(index < int(queue.length))
         {
            return queue[index].time;
         }
         return Timeline.INFINITY_TIME;
      }
      
      public function nextIndex() : int
      {
         var _loc2_:* = null as Hero;
         var _loc1_:InputEventDescription = queue[index];
         index = index + 1;
         team.engine.timeline.setupTime(_loc1_.time);
         if(_loc1_.act == "cast")
         {
            _loc2_ = team.getHeroById(_loc1_.hero);
            if(_loc2_ == null)
            {
               null;
            }
            else
            {
               _loc2_.actionUserInput();
            }
         }
         else if(_loc1_.act == "custom")
         {
            _loc2_ = team.getHeroById(_loc1_.hero);
            if(_loc2_ == null)
            {
               null;
            }
            else
            {
               _loc2_.customActionUserInput(_loc1_.id);
            }
         }
         else if(_loc1_.act == "auto")
         {
            team.onAutoFightToggle.fire();
         }
         else if(_loc1_.act == "teamCustom")
         {
            team.customActionTeamInput(_loc1_.id);
         }
         return int(getNextIndex());
      }
      
      public function next() : Number
      {
         var _loc2_:* = null as Hero;
         var _loc1_:InputEventDescription = queue[index];
         index = index + 1;
         team.engine.timeline.setupTime(_loc1_.time);
         if(_loc1_.act == "cast")
         {
            _loc2_ = team.getHeroById(_loc1_.hero);
            if(_loc2_ == null)
            {
               null;
            }
            else
            {
               _loc2_.actionUserInput();
            }
         }
         else if(_loc1_.act == "custom")
         {
            _loc2_ = team.getHeroById(_loc1_.hero);
            if(_loc2_ == null)
            {
               null;
            }
            else
            {
               _loc2_.customActionUserInput(_loc1_.id);
            }
         }
         else if(_loc1_.act == "auto")
         {
            team.onAutoFightToggle.fire();
         }
         else if(_loc1_.act == "teamCustom")
         {
            team.customActionTeamInput(_loc1_.id);
         }
         if(index < int(queue.length))
         {
            return queue[index].time;
         }
         return Timeline.INFINITY_TIME;
      }
      
      public function getNextTime() : Number
      {
         if(index < int(queue.length))
         {
            return queue[index].time;
         }
         return Timeline.INFINITY_TIME;
      }
      
      public function getNextIndex() : int
      {
         if(index < int(queue.length))
         {
            return queue[index].i;
         }
         return 1000000;
      }
   }
}
