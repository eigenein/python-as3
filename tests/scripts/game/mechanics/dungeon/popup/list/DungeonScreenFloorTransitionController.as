package game.mechanics.dungeon.popup.list
{
   import game.mechanics.dungeon.mediator.DungeonFloorGroupValueObject;
   import game.mechanics.dungeon.mediator.DungeonFloorValueObject;
   import game.mechanics.dungeon.mediator.DungeonScreenMediator;
   import starling.animation.IAnimatable;
   import starling.animation.Juggler;
   
   public class DungeonScreenFloorTransitionController
   {
      
      private static const STAIRS_SIDE_MOVEMENT_DELAY:Number = 2;
      
      private static const STAIRS_VERTICAL_MOVEMENT_DURATION:Number = 1.5;
      
      private static const STAIRS_SIDE_MOVEMENT_BACK_DELAY:Number = 2;
      
      private static const STAIRS_SIDE_MOVEMENT_BACK_DURATION:Number = 3;
      
      private static const DURATION_BRIDGE_INTRO:Number = 3;
      
      private static const DURATION_BRIDGE_DELAY:Number = 0.5;
      
      private static const DURATION_BRIDGE_OUTRO:Number = 2;
      
      private static const DURATION_BRIDGE_INTRO_FAST:Number = 1.3;
      
      private static const DURATION_BRIDGE_DELAY_FAST:Number = 0.5;
      
      private static const DURATION_BRIDGE_OUTRO_FAST:Number = 1.5;
      
      private static const NUM_BRIDGE_TRANSITIONS_BEFORE_FAST:int = 3;
      
      private static const DURATION_SAVE_UP:Number = 1.5;
      
      private static const DURATION_SAVE_DELAY:Number = 1.5;
      
      private static const DURATION_SAVE_DOWN:Number = 4.5;
      
      private static var numBridgeTransitionsInSession:int = 0;
       
      
      private var juggler:Juggler;
      
      private var animatables:Vector.<IAnimatable>;
      
      private var mediator:DungeonScreenMediator;
      
      private var list:DungeonFloorGroupList;
      
      private var _prevFloor:DungeonFloorValueObject;
      
      private var _nextFloor:DungeonFloorValueObject;
      
      public function DungeonScreenFloorTransitionController(param1:DungeonScreenMediator)
      {
         animatables = new Vector.<IAnimatable>();
         super();
         this.mediator = param1;
      }
      
      public function dispose() : void
      {
         if(juggler)
         {
            juggler.purge();
         }
      }
      
      protected function get useFastTransition() : Boolean
      {
         return numBridgeTransitionsInSession > 3;
      }
      
      public function initialize(param1:DungeonFloorGroupList) : void
      {
         this.list = param1;
         list.throwEase = "easeInOut";
      }
      
      public function addToJuggler(param1:Juggler) : void
      {
         this.juggler = param1;
         action_transition(-1,mediator.currentFloor);
      }
      
      public function action_startSave(param1:int, param2:int) : void
      {
         var _loc4_:DungeonFloorValueObject = getFloor(param1);
         var _loc3_:DungeonFloorValueObject = getFloor(param2);
         if(_loc3_)
         {
            _loc3_.action_playSaveAnimation();
         }
         if(_loc4_)
         {
            _loc4_.action_playSaveAnimation();
         }
         scrollToSave();
         delayCall(dispatchReadyToSave,1.5 + 1.5);
      }
      
      public function action_completeSave(param1:int, param2:int) : void
      {
         _prevFloor = getFloor(param1);
         _nextFloor = getFloor(param2);
         var _loc3_:* = 0;
         delayCall(scrollFromSave,_loc3_);
         _loc3_ = Number(_loc3_ + 4.5);
         delayCall(cheatTeleportHeroes,_loc3_);
         delayCall(scrollFromStairs,_loc3_ + 1.5);
      }
      
      public function action_transition(param1:int, param2:int) : void
      {
         action_reset();
         _prevFloor = getFloor(param1);
         _nextFloor = getFloor(param2);
         if(_prevFloor)
         {
            if(_prevFloor.rightExit && _prevFloor.isRightmost || !_prevFloor.rightExit && _prevFloor.isLeftmost)
            {
               transitionStairsDown();
            }
            else
            {
               transitionBridge();
            }
            mediator.state.signal_startHeroTravel.dispatch();
         }
         else
         {
            scrollInitial();
         }
      }
      
      public function action_scrollToSaveLever() : void
      {
         horizontalScrollToIndex(mediator.currentFloorColumnIndex,0.5,"easeOut");
      }
      
      public function action_reset() : void
      {
         if(list)
         {
            list.touchable = true;
         }
         var _loc3_:int = 0;
         var _loc2_:* = animatables;
         for each(var _loc1_ in animatables)
         {
            juggler.remove(_loc1_);
         }
         animatables.length = 0;
      }
      
      protected function transitionStairsDown() : void
      {
         var _loc1_:* = 0.3;
         delayCall(scrollToStairs,_loc1_);
         delayCall(scrollStairs,_loc1_ + 2);
         delayCall(cheatTeleportHeroes,_loc1_ + 2 + 1.5 * 0.5);
         delayCall(scrollFromStairs,_loc1_ + 2 + 1.5 + 3);
      }
      
      protected function transitionBridge() : void
      {
         numBridgeTransitionsInSession = Number(numBridgeTransitionsInSession) + 1;
         var _loc3_:Number = !!useFastTransition?1.3:3;
         var _loc2_:Number = !!useFastTransition?0.5:0.5;
         var _loc4_:Number = !!useFastTransition?1.5:2;
         var _loc1_:Number = !!useFastTransition?0:0.3;
         delayCall(scrollToBridge,_loc1_);
         delayCall(_prevFloor.action_playBridgeAnimation,_loc1_ + 1);
         delayCall(scrollFromBridge,_loc1_ + _loc3_ + _loc2_);
         delayCall(cheatTeleportHeroes,_loc1_ + _loc3_ + _loc2_ + _loc4_ - 0.2);
      }
      
      protected function delayCall(param1:Function, param2:Number) : void
      {
         animatables.push(juggler.delayCall(param1,param2));
      }
      
      private function getFloor(param1:int) : DungeonFloorValueObject
      {
         return mediator.findFloorValueObject(param1);
      }
      
      protected function scrollToBridge() : void
      {
         var _loc5_:Number = !!useFastTransition?1.3:3;
         var _loc2_:Number = !!useFastTransition?0.5:0.5;
         var _loc6_:Number = !!useFastTransition?1.5:2;
         var _loc3_:int = !!_prevFloor.rightExit?1:-1;
         var _loc4_:Number = 290 + mediator.prevFloorColumnIndex * (1000 + 300);
         var _loc1_:Number = _loc4_ + (150 + 1000 * 0.5) * _loc3_;
         horizontalScrollToPosition(_loc1_,_loc5_,!!useFastTransition?"easeOut":"easeInOut");
      }
      
      protected function scrollFromBridge() : void
      {
         scrollVerticalList(2);
         var _loc2_:Number = !!useFastTransition?1.3:3;
         var _loc1_:Number = !!useFastTransition?0.5:0.5;
         var _loc3_:Number = !!useFastTransition?1.5:2;
         horizontalScrollToIndex(mediator.currentFloorColumnIndex,_loc3_,"easeInOut");
      }
      
      protected function scrollToStairs() : void
      {
         var _loc1_:* = NaN;
         if(_prevFloor.rightExit)
         {
            _loc1_ = Number(290 + mediator.currentFloorColumnIndex * (1000 + 300) + 290);
         }
         else
         {
            _loc1_ = 0;
         }
         horizontalScrollToPosition(_loc1_,2,"easeInOut");
      }
      
      protected function scrollStairs() : void
      {
         scrollVerticalList(1.5);
      }
      
      protected function scrollFromStairs() : void
      {
         scrollVerticalList(3);
         horizontalScrollToIndex(mediator.currentFloorColumnIndex,3,"easeInOut");
      }
      
      protected function scrollToSave() : void
      {
         verticalScrollToPosition((mediator.currentFloorGroupIndex - 1) * (490 + 650),1.5);
      }
      
      protected function scrollFromSave() : void
      {
         var _loc1_:* = NaN;
         mediator.state.signal_startHeroTravel.dispatch();
         scrollVerticalList(4.5);
         if(!_prevFloor.rightExit)
         {
            _loc1_ = Number(290 + mediator.currentFloorColumnIndex * (1000 + 300) + 290);
         }
         else
         {
            _loc1_ = 0;
         }
         _loc1_ = 0;
         horizontalScrollToPosition(_loc1_,4.5,"easeInOut");
      }
      
      protected function dispatchReadyToSave() : void
      {
         mediator.state.signal_readyToSave.dispatch();
      }
      
      protected function scrollVerticalList(param1:Number) : void
      {
         verticalScrollToPosition(mediator.currentFloorGroupIndex * (490 + 650),param1);
      }
      
      protected function verticalScrollToPosition(param1:Number, param2:Number) : void
      {
         animatables.push(juggler.tween(list,param2,{
            "verticalScrollPosition":param1,
            "transition":"easeInOut"
         }));
      }
      
      protected function horizontalScrollToIndex(param1:int, param2:Number, param3:String) : void
      {
         horizontalScrollToPosition(290 + param1 * (1000 + 300),param2,param3);
      }
      
      protected function horizontalScrollToPosition(param1:Number, param2:Number, param3:String) : void
      {
         var _loc4_:DungeonRoomList = DungeonFloorGroupValueObject.listToTween;
         if(_loc4_)
         {
            animatables.push(juggler.tween(_loc4_,param2,{
               "horizontalScrollPosition":param1,
               "transition":param3
            }));
         }
      }
      
      protected function scrollInitial() : void
      {
         scrollVerticalList(0);
         list.validate();
         horizontalScrollToIndex(mediator.currentFloorColumnIndex,0,"easeInOut");
      }
      
      protected function cheatTeleportHeroes() : void
      {
         mediator.state.signal_cheatTeleportHeroes.dispatch();
      }
   }
}
