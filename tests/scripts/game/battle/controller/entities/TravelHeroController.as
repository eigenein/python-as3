package game.battle.controller.entities
{
   import flash.geom.Point;
   import game.battle.controller.position.HeroViewPositionValue;
   import game.battle.controller.position.IHeroController;
   import game.battle.view.hero.HeroView;
   import idv.cjcat.signals.Signal;
   
   public class TravelHeroController implements IHeroController
   {
       
      
      protected var view:HeroView;
      
      protected var speed:Number;
      
      protected var position:HeroViewPositionValue;
      
      private var target:Point;
      
      private var timeToWait:Number;
      
      public const onCompleted:Signal = new Signal();
      
      public function TravelHeroController(param1:HeroView, param2:Number, param3:Number, param4:Number, param5:Number = 0)
      {
         target = new Point();
         super();
         this.view = param1;
         this.speed = param4;
         position = param1.position;
         target.x = param2;
         target.y = param3;
         this.timeToWait = param5;
      }
      
      public function advanceTime(param1:Number) : void
      {
         position.direction = target.x > position.x?1:target.x < position.x?-1:position.direction;
         if(timeToWait > param1)
         {
            timeToWait = timeToWait - param1;
            position.movement = 0;
            view.updatePosition();
            return;
         }
         if(timeToWait > 0)
         {
            param1 = param1 - timeToWait;
            timeToWait = 0;
         }
         var _loc5_:Number = speed * param1;
         var _loc2_:Number = target.x - position.x;
         var _loc4_:Number = target.y - position.y;
         var _loc3_:Number = Math.sqrt(_loc2_ * _loc2_ + _loc4_ * _loc4_);
         if(_loc5_ >= _loc3_)
         {
            position.x = target.x;
            position.y = target.y;
            position.z = position.y;
            onCompleted.dispatch();
         }
         else
         {
            if(_loc3_ > 0)
            {
               position.x = position.x + _loc5_ * _loc2_ / _loc3_;
               position.y = position.y + _loc5_ * _loc4_ / _loc3_;
               position.z = position.y;
            }
            position.movement = _loc2_ * _loc2_ > _loc4_ * _loc4_?1:2;
         }
         view.updatePosition();
      }
      
      public function stop() : void
      {
         position.x = target.x;
         position.y = target.y;
         position.z = position.y;
         onCompleted.dispatch();
      }
   }
}
