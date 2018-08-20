package battle.skills
{
   import battle.BattleEngine;
   import battle.BattleLog;
   import battle.Hero;
   import battle.objects.BattleEntity;
   import battle.proxy.IEffectProxy;
   import battle.proxy.empty.EmptyEffectProxy;
   import battle.skills._Effect.EffectRemoveEvent;
   import battle.timeline.Timeline;
   import flash.Boot;
   
   public class Effect extends BattleEntity
   {
      
      public static var MAX_DURATION:Number = 1.0e100;
      
      public static var MAX_HITRATE:int = 2147483647;
       
      
      public var viewProxy:IEffectProxy;
      
      public var target:Hero;
      
      public var skillCast:SkillCast;
      
      public var removeEvent:EffectRemoveEvent;
      
      public var keepHeroDirection:Boolean;
      
      public var ident:String;
      
      public var hooks:EffectHooks;
      
      public var execution;
      
      public var environmental:Boolean;
      
      public var dynamicParamsIndex:int;
      
      public var dynamicParams:Array;
      
      public var durationMultiplier:Number;
      
      public var disposed:Boolean;
      
      public var canceled:Boolean;
      
      public function Effect(param1:Timeline = undefined, param2:String = undefined, param3:Array = undefined, param4:Boolean = false)
      {
         var _loc6_:int = 0;
         var _loc7_:* = null;
         var _loc8_:Number = NaN;
         if(Boot.skip_constructor)
         {
            return;
         }
         keepHeroDirection = false;
         viewProxy = EmptyEffectProxy.instance;
         canceled = false;
         disposed = false;
         dynamicParamsIndex = 0;
         durationMultiplier = 1;
         super(param1);
         ident = param2;
         dynamicParams = param3;
         environmental = param4;
         onRemove.name = "Effect.onRemove";
         var _loc5_:* = int(param2.indexOf("(")) + 1;
         if(_loc5_ > 0)
         {
            if(dynamicParams == null)
            {
               dynamicParams = [];
            }
            param3 = param2.substring(_loc5_,param2.length - 1).split(",");
            _loc6_ = 0;
            while(_loc6_ < int(param3.length))
            {
               _loc7_ = param3[_loc6_];
               _loc6_++;
               _loc8_ = Std.parseFloat(_loc7_);
               if(_loc8_ != Number(Math.NaN))
               {
                  _loc7_ = _loc8_;
               }
               dynamicParams.push(_loc7_);
            }
            ident = param2.substr(0,_loc5_ - 1);
         }
      }
      
      public function updateDuration(param1:Number) : void
      {
         if(removeEvent == null)
         {
            removeEvent = new EffectRemoveEvent(this);
            timeline.add(removeEvent);
         }
         timeline.update(removeEvent,Number(timeline.time + param1 * durationMultiplier));
      }
      
      override public function toString() : String
      {
         var _loc1_:Number = time - timeline.time;
         return "`" + ident + "` for " + (_loc1_ * 0 == 0 && _loc1_ != 0?Timeline.timeToString(_loc1_) + "s":"?");
      }
      
      public function targetToString() : String
      {
         return target.toString();
      }
      
      public function setTarget(param1:Hero) : void
      {
         target = param1;
      }
      
      public function setSkillCast(param1:SkillCast) : void
      {
         skillCast = param1;
      }
      
      public function sameTeam(param1:Hero) : Boolean
      {
         if(param1 == null || skillCast.hero == null)
         {
            return false;
         }
         return skillCast.hero.team == param1.team;
      }
      
      public function remove() : void
      {
         dispose();
         timeline.remove(removeEvent);
      }
      
      public function readParam() : *
      {
         dynamicParamsIndex = dynamicParamsIndex + 1;
         if(dynamicParams == null || dynamicParamsIndex > int(dynamicParams.length))
         {
            return null;
         }
         return dynamicParams[dynamicParamsIndex - 1];
      }
      
      public function isDisposed() : Boolean
      {
         return disposed;
      }
      
      public function isControlEffect() : Boolean
      {
         return true;
      }
      
      public function isCanceled() : Boolean
      {
         return canceled;
      }
      
      public function init(param1:BattleEngine) : void
      {
         hooks = new EffectHooks();
         param1.createEffect(this);
      }
      
      public function getDurationLeft() : Number
      {
         if(removeEvent == null || removeEvent.time == Timeline.INFINITY_TIME)
         {
            return 0;
         }
         return removeEvent.time - timeline.time;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         skillCast.createdObjectsCount = skillCast.createdObjectsCount - 1;
         disposed = true;
         super.dispose();
         onRemove.fire();
         if(target != null)
         {
            target.effects.removeEffect(this);
            if(BattleLog.doLog)
            {
               BattleLog.m.heroEffectRemove(target,this);
            }
            if(hooks.removed != null)
            {
               hooks.removed(this,target);
            }
         }
      }
      
      public function deferredActionIfNotDisposed(param1:Number, param2:*) : void
      {
         if(!disposed)
         {
            add(param2,Number(timeline.time + param1));
         }
      }
      
      public function cancel() : void
      {
         canceled = true;
         dispose();
      }
      
      public function apply(param1:Hero) : void
      {
         if(target != null)
         {
            return;
         }
         target = param1;
         init(param1.engine);
         skillCast.createdObjectsCount = skillCast.createdObjectsCount + 1;
      }
   }
}
