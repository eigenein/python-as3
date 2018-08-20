package battle.objects
{
   import battle.Team;
   import battle.logic.MovingBody;
   import battle.objects._ProjectileEntityCoupled.ProjectileUncoupleTimeEvent;
   import battle.skills.SkillCast;
   import flash.Boot;
   
   public class ProjectileEntityCoupled extends ProjectileEntity
   {
       
      
      public var uncoupleEvent:ProjectileUncoupleTimeEvent;
      
      public var targetBothTeams:Boolean;
      
      public var coupledBody:BattleBody;
      
      public function ProjectileEntityCoupled(param1:SkillCast = undefined, param2:Team = undefined, param3:MovingBody = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1,param2,param3);
      }
      
      public function updateUncoupleTimeEvent() : void
      {
         var _loc1_:Number = NaN;
         if(coupledBody != null)
         {
            _loc1_ = Number(range.getCollisionTime(coupledBody.body)) + 0.2;
            if(_loc1_ > timeline.time)
            {
               if(uncoupleEvent == null)
               {
                  uncoupleEvent = new ProjectileUncoupleTimeEvent(this);
                  uncoupleEvent.time = _loc1_;
                  engine.timeline.add(uncoupleEvent);
               }
               else
               {
                  engine.timeline.update(uncoupleEvent,_loc1_);
               }
            }
            else if(uncoupleEvent != null)
            {
               engine.timeline.remove(uncoupleEvent);
            }
         }
         else if(uncoupleEvent != null)
         {
            engine.timeline.remove(uncoupleEvent);
         }
      }
      
      public function uncouple() : void
      {
         if(coupledBody != null)
         {
            coupledBody.body.onMove.remove(onTargetMove);
            coupledBody.onRemove.remove(onTargetRemove);
            coupledBody = null;
            updateUncoupleTimeEvent();
         }
         targetTeam.addRange(range);
         if(targetBothTeams)
         {
            targetTeam.enemyTeam.addRange(range);
         }
      }
      
      public function onTargetRemove(param1:BattleBody) : void
      {
         if(coupledBody != null)
         {
            coupledBody.body.onMove.remove(onTargetMove);
            coupledBody.onRemove.remove(onTargetRemove);
            coupledBody = null;
            updateUncoupleTimeEvent();
         }
      }
      
      public function onTargetMove(param1:MovingBody) : void
      {
         updateUncoupleTimeEvent();
      }
      
      override public function dispose() : void
      {
         if(coupledBody != null)
         {
            coupledBody.body.onMove.remove(onTargetMove);
            coupledBody.onRemove.remove(onTargetRemove);
            coupledBody = null;
            updateUncoupleTimeEvent();
         }
      }
      
      public function couple(param1:BattleBody, param2:Boolean) : void
      {
         targetBothTeams = param2;
         if(coupledBody != null)
         {
            coupledBody.body.onMove.remove(onTargetMove);
            coupledBody.onRemove.remove(onTargetRemove);
         }
         coupledBody = param1;
         coupledBody.body.onMove.add(onTargetMove);
         coupledBody.onRemove.add(onTargetRemove);
         updateUncoupleTimeEvent();
      }
   }
}
