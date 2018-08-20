package battle.proxy
{
   import battle.BattleEngine;
   import battle.Hero;
   import battle.Team;
   import flash.Boot;
   
   public class InputActionHolder
   {
       
      
      public var team:Team;
      
      public var hero:Hero;
      
      public var engine:BattleEngine;
      
      public var actions:Vector.<CustomManualAction>;
      
      public function InputActionHolder(param1:BattleEngine = undefined, param2:Hero = undefined, param3:Team = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         engine = param1;
         hero = param2;
         team = param3;
         actions = new Vector.<CustomManualAction>();
      }
      
      public function trigger(param1:int) : void
      {
         var _loc4_:* = null as CustomManualAction;
         var _loc2_:Vector.<CustomManualAction> = actions;
         var _loc3_:int = _loc2_.length;
         while(true)
         {
            _loc3_--;
            if(_loc3_ > 0)
            {
               _loc4_ = _loc2_[_loc3_];
               if(_loc4_.actionId == param1)
               {
                  engine.movement.update(engine.timeline);
                  if(team.desc.logInput)
                  {
                     if(hero != null)
                     {
                        hero.team.desc.logCustomEvent(hero,param1,engine.timeline.time,engine.timeline.eventIndex);
                     }
                     else if(team != null)
                     {
                        team.desc.logTeamInput(param1,engine.timeline.time,engine.timeline.eventIndex);
                     }
                  }
                  _loc4_.execute();
                  break;
               }
               continue;
            }
            break;
         }
      }
      
      public function add(param1:CustomManualAction) : void
      {
         var _loc5_:int = 0;
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:int = actions.length;
         while(_loc3_ < _loc4_)
         {
            _loc3_++;
            _loc5_ = _loc3_;
            if(actions[_loc5_].actionId == param1.actionId)
            {
               actions[_loc5_] = param1;
               _loc2_ = true;
               break;
            }
         }
         if(!_loc2_)
         {
            actions.push(param1);
         }
      }
   }
}
