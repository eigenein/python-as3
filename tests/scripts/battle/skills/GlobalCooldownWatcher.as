package battle.skills
{
   import battle.BattleEngine;
   import battle.Hero;
   import battle.Team;
   import battle.timeline.Timeline;
   import flash.Boot;
   
   public class GlobalCooldownWatcher
   {
      
      public static var cooldownAfterAnimation:Number = 0.2;
       
      
      public var timeline:Timeline;
      
      public var minTime:Number;
      
      public var maxTime:Number;
      
      public var maxAcceptableCooldown:Number;
      
      public var engine:BattleEngine;
      
      public function GlobalCooldownWatcher(param1:BattleEngine = undefined, param2:Timeline = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         engine = param1;
         timeline = param2;
         maxAcceptableCooldown = param1.config.maxGlobalCooldown;
      }
      
      public function update(param1:SkillSet, param2:Number, param3:Number) : void
      {
         var _loc4_:* = null as Vector.<Hero>;
         var _loc5_:int = 0;
         var _loc6_:* = null as SkillSet;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:int = 0;
         timeline.update(param1,param2);
         if(param2 == 1.0e100)
         {
            return;
         }
         minTime = 1.0e100;
         if(maxAcceptableCooldown > Number(param3 + 0.2))
         {
            maxTime = Number(timeline.time + maxAcceptableCooldown);
         }
         else
         {
            maxTime = Number(Number(timeline.time + param3) + 0.2);
         }
         _loc4_ = engine.objects.get_attackers().heroes;
         _loc5_ = _loc4_.length;
         while(true)
         {
            _loc5_--;
            if(_loc5_ <= 0)
            {
               break;
            }
            _loc6_ = _loc4_[_loc5_].skills;
            _loc7_ = _loc6_.time;
            if(_loc7_ < minTime && _loc7_ > timeline.time)
            {
               minTime = _loc7_;
            }
            if(_loc6_.animationEndTime > maxTime)
            {
               maxTime = _loc6_.animationEndTime;
            }
         }
         _loc4_ = engine.objects.get_defenders().heroes;
         _loc5_ = _loc4_.length;
         while(true)
         {
            _loc5_--;
            if(_loc5_ <= 0)
            {
               break;
            }
            _loc6_ = _loc4_[_loc5_].skills;
            _loc7_ = _loc6_.time;
            if(_loc7_ < minTime && _loc7_ > timeline.time)
            {
               minTime = _loc7_;
            }
            if(_loc6_.animationEndTime > maxTime)
            {
               maxTime = _loc6_.animationEndTime;
            }
         }
         if(minTime < maxTime)
         {
            return;
         }
         if(minTime > maxTime && minTime < 1.0e100)
         {
            _loc7_ = minTime - maxTime;
            _loc4_ = engine.objects.get_attackers().heroes;
            _loc8_ = -_loc7_;
            _loc5_ = _loc4_.length;
            while(true)
            {
               _loc5_--;
               if(_loc5_ <= 0)
               {
                  break;
               }
               _loc6_ = _loc4_[_loc5_].skills;
               _loc9_ = _loc6_.active.length;
               while(true)
               {
                  _loc9_--;
                  if(_loc9_ <= 0)
                  {
                     break;
                  }
                  _loc6_.active[_loc9_].nextCastTime = Number(_loc6_.active[_loc9_].nextCastTime + _loc8_);
               }
               if(_loc6_.timeline.time < _loc6_.time)
               {
                  _loc6_.timeline.update(_loc6_,Number(_loc6_.time + _loc8_));
               }
            }
            _loc4_ = engine.objects.get_defenders().heroes;
            _loc8_ = -_loc7_;
            _loc5_ = _loc4_.length;
            while(true)
            {
               _loc5_--;
               if(_loc5_ <= 0)
               {
                  break;
               }
               _loc6_ = _loc4_[_loc5_].skills;
               _loc9_ = _loc6_.active.length;
               while(true)
               {
                  _loc9_--;
                  if(_loc9_ <= 0)
                  {
                     break;
                  }
                  _loc6_.active[_loc9_].nextCastTime = Number(_loc6_.active[_loc9_].nextCastTime + _loc8_);
               }
               if(_loc6_.timeline.time < _loc6_.time)
               {
                  _loc6_.timeline.update(_loc6_,Number(_loc6_.time + _loc8_));
               }
            }
         }
      }
      
      public function tweakCooldowns(param1:Vector.<Hero>, param2:Number) : void
      {
         var _loc4_:* = null as SkillSet;
         var _loc5_:int = 0;
         var _loc3_:int = param1.length;
         while(true)
         {
            _loc3_--;
            if(_loc3_ <= 0)
            {
               break;
            }
            _loc4_ = param1[_loc3_].skills;
            _loc5_ = _loc4_.active.length;
            while(true)
            {
               _loc5_--;
               if(_loc5_ <= 0)
               {
                  break;
               }
               _loc4_.active[_loc5_].nextCastTime = Number(_loc4_.active[_loc5_].nextCastTime + param2);
            }
            if(_loc4_.timeline.time < _loc4_.time)
            {
               _loc4_.timeline.update(_loc4_,Number(_loc4_.time + param2));
            }
         }
      }
      
      public function minTimeByTeam(param1:Vector.<Hero>) : void
      {
         var _loc3_:* = null as SkillSet;
         var _loc4_:Number = NaN;
         var _loc2_:int = param1.length;
         while(true)
         {
            _loc2_--;
            if(_loc2_ <= 0)
            {
               break;
            }
            _loc3_ = param1[_loc2_].skills;
            _loc4_ = _loc3_.time;
            if(_loc4_ < minTime && _loc4_ > timeline.time)
            {
               minTime = _loc4_;
            }
            if(_loc3_.animationEndTime > maxTime)
            {
               maxTime = _loc3_.animationEndTime;
            }
         }
      }
   }
}
