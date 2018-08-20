package battle.objects
{
   import battle.BattleEngine;
   import battle.BattleLog;
   import battle.logic.MovingBody;
   import battle.timeline.Timeline;
   import flash.Boot;
   
   public class BattleBody extends BattleEntity
   {
       
      
      public var lastDirection:int;
      
      public var isHero:Boolean;
      
      public var engine:BattleEngine;
      
      public var disposed:Boolean;
      
      public var body:MovingBody;
      
      public function BattleBody(param1:BattleEngine = undefined, param2:MovingBody = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         isHero = false;
         disposed = false;
         lastDirection = 0;
         super(param1 != null?param1.timeline:null);
         engine = param1;
         body = param2;
      }
      
      override public function toString() : String
      {
         if(body != null)
         {
            return "`" + (body.vx > 0?"+p":"-p") + int(body.x) + "`";
         }
         return "`nobody`";
      }
      
      public function stopMovement() : void
      {
         setVelocity(0);
      }
      
      public function setVelocityInBoundaries(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = NaN;
         param1 = Number(param1 + 0);
         if(body.vx != param1)
         {
            if(Number(body.x + param1 * param2) < engine.config.leftBattleBorder && param1 < 0)
            {
               param1 = 0;
            }
            else if(Number(body.x + param1 * param2) > engine.config.rightBattleBorder && param1 > 0)
            {
               param1 = 0;
            }
         }
         if(body.vx != param1)
         {
            _loc3_ = body.vx;
            body.vx = param1;
            body.onMove.fire();
            if(BattleLog.doLog)
            {
               BattleLog.m.heroMove(this,param1,body.x);
            }
         }
      }
      
      public function setVelocity(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         param1 = param1 + 0;
         if(body.vx != param1)
         {
            _loc2_ = body.vx;
            body.vx = param1;
            body.onMove.fire();
            if(BattleLog.doLog)
            {
               BattleLog.m.heroMove(this,param1,body.x);
            }
         }
      }
      
      public function setPosition(param1:Number) : Number
      {
         var _loc2_:Number = param1;
         body.x = _loc2_;
         return _loc2_;
      }
      
      public function moveTill(param1:Number, param2:Object = undefined, param3:Number = 0) : void
      {
         if(param3 == 0)
         {
            if(body.vx == 0)
            {
               return;
            }
            param3 = body.vx;
         }
         if(param1 > body.x != param3 > 0)
         {
            param3 = -param3;
         }
         if(param2 != null)
         {
            add(param2,Number(timeline.time + (param1 - body.x) / param3));
         }
         if(param3 != body.vx)
         {
            setVelocity(param3);
         }
      }
      
      public function get_updatedBody() : MovingBody
      {
         return body;
      }
      
      public function get position() : Number
      {
         return body.x;
      }
      
      public function get_position() : Number
      {
         return body.x;
      }
      
      public function get_isAvailable() : Boolean
      {
         return true;
      }
      
      public function getVisualPosition() : Number
      {
         var _loc1_:* = null as MovingBody;
         if(engine != null)
         {
            _loc1_ = body;
            return Number(_loc1_.x + _loc1_.vx * (engine.timeline.time - engine.movement.oldTime));
         }
         return body.x;
      }
      
      public function getVisualDirection() : int
      {
         return 0;
      }
      
      public function getCurrentDirection() : int
      {
         var _loc1_:int = 0;
         if(body.vx > 0)
         {
            _loc1_ = 1;
            lastDirection = _loc1_;
            return _loc1_;
         }
         else
         {
            _loc1_ = -1;
            lastDirection = _loc1_;
            return _loc1_;
         }
      }
      
      public function distanceTo(param1:Number) : Number
      {
         var _loc2_:Number = body.x;
         if(_loc2_ > param1)
         {
            return _loc2_ - param1;
         }
         return param1 - _loc2_;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         disposed = true;
      }
   }
}
