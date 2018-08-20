package game.mediator.gui.popup.tower
{
   import feathers.controls.List;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import game.data.storage.DataStorage;
   import game.model.GameModel;
   
   public class TowerScreenFloorTransitionController
   {
      
      private static var nextFloorNumber:int = 0;
       
      
      private var mediator:TowerScreenMediator;
      
      private var _prevFloor:TowerFloorValueObject;
      
      private var _nextFloor:TowerFloorValueObject;
      
      private var floorList:List;
      
      private var delay_min:int = 100;
      
      private var timer_scroll:Timer;
      
      private var timer_hideHeroes:Timer;
      
      public function TowerScreenFloorTransitionController(param1:TowerScreenMediator)
      {
         timer_scroll = new Timer(1000,1);
         timer_hideHeroes = new Timer(1000,1);
         super();
         this.mediator = param1;
         timer_scroll.addEventListener("timerComplete",handler_scrollTimer);
         timer_hideHeroes.addEventListener("timerComplete",handler_hideHeroesTimer);
      }
      
      public static function get heroHideDelay() : Number
      {
         return 0.3;
      }
      
      private static function get useSlowTransition() : Boolean
      {
         return nextFloorNumber < DataStorage.rule.towerRule.minFloorNumberToTransitionFastTo;
      }
      
      private static function get useSemiFastTransition() : Boolean
      {
         return GameModel.instance.player.levelData.level.level < DataStorage.rule.towerRule.teamLevelToTransitionRealyFast;
      }
      
      public static function getHeroMovementDelay() : Number
      {
         if(useSlowTransition)
         {
            return 2;
         }
         if(useSemiFastTransition)
         {
            return 0.5;
         }
         return 0;
      }
      
      public static function getScrollDuration() : Number
      {
         if(useSlowTransition)
         {
            return 1;
         }
         if(useSemiFastTransition)
         {
            return 1;
         }
         return 0.8;
      }
      
      public function dispose() : void
      {
         action_reset();
         timer_scroll.removeEventListener("timerComplete",handler_scrollTimer);
         timer_hideHeroes.removeEventListener("timerComplete",handler_hideHeroesTimer);
      }
      
      public function initialize(param1:List) : void
      {
         this.floorList = param1;
         action_transition(-1,mediator.currentFloor);
      }
      
      public function action_transition(param1:int, param2:int) : void
      {
         action_reset();
         nextFloorNumber = param2;
         floorList.touchable = false;
         _prevFloor = getFloor(param1);
         _nextFloor = getFloor(param2);
         if(_prevFloor)
         {
            _prevFloor.signal_heroExit.dispatch(0);
            TowerFloorValueObject.screenHero.signal_transitionComplete.add(handler_exitComplete);
         }
         else
         {
            handler_exitComplete();
         }
      }
      
      public function action_setupPosition() : void
      {
         floorList.scrollToDisplayIndex(mediator.currentFloorIndex);
      }
      
      public function action_reset() : void
      {
         if(floorList)
         {
            floorList.touchable = true;
         }
         timer_scroll.reset();
         timer_scroll.stop();
         timer_hideHeroes.reset();
         timer_hideHeroes.stop();
         TowerFloorValueObject.screenHero.signal_transitionComplete.remove(handler_exitComplete);
      }
      
      private function getFloor(param1:int) : TowerFloorValueObject
      {
         var _loc3_:int = 0;
         var _loc2_:int = mediator.floorList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(mediator.floorList[_loc3_].number == param1)
            {
               return mediator.floorList[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      private function handler_exitComplete() : void
      {
         var _loc1_:Number = NaN;
         if(floorList)
         {
            floorList.touchable = true;
         }
         if(_prevFloor)
         {
            _loc1_ = getScrollDuration();
            floorList.scrollToDisplayIndex(mediator.currentFloorIndex,_loc1_);
            timer_scroll.delay = _loc1_ * 1000;
            timer_scroll.start();
            timer_hideHeroes.delay = heroHideDelay * 1000;
            timer_hideHeroes.start();
            _prevFloor.signal_heroExit.dispatch(1);
         }
         else
         {
            floorList.scrollToDisplayIndex(mediator.currentFloorIndex);
            timer_scroll.delay = delay_min;
            timer_scroll.start();
         }
      }
      
      private function handler_enterComplete() : void
      {
      }
      
      protected function handler_scrollTimer(param1:TimerEvent) : void
      {
         _nextFloor.signal_heroEnter.dispatch();
         action_reset();
      }
      
      protected function handler_hideHeroesTimer(param1:TimerEvent) : void
      {
         _nextFloor.signal_heroHide.dispatch();
      }
   }
}
