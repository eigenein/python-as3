package game.battle.gui
{
   import engine.core.utils.property.NumberProperty;
   import engine.core.utils.property.NumberPropertyWriteable;
   import game.view.gui.components.controller.TouchClickController;
   import idv.cjcat.signals.Signal;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   
   public class BattleGuiDarkScreen
   {
      
      private static const DARK_SCREEN_VISIBLE_ALPHA:Number = 0.5;
      
      private static const DARK_SCREEN_COLOR:uint = 0;
      
      private static const DARK_SCREEN_TWEEN_DURATION:Number = 0.5;
      
      private static const DARK_SCREEN_TWEEN_EASING:String = "easeOut";
       
      
      private var displayObject:DisplayObject;
      
      private var circle:BattleGuiFragmentScreen;
      
      private var tween:Tween;
      
      private var onClickController:TouchClickController;
      
      private const _alpha:NumberPropertyWriteable = new NumberPropertyWriteable(0);
      
      public function BattleGuiDarkScreen(param1:Number, param2:Number)
      {
         super();
         circle = new BattleGuiFragmentScreen(param1,param2,0);
         displayObject = circle;
         _alpha.onValue(handler_alpha);
         tween = new Tween(displayObject,0.5,"easeOut");
      }
      
      public function dispose() : void
      {
         if(onClickController)
         {
            onClickController.dispose();
         }
      }
      
      public function get alpha() : NumberProperty
      {
         return _alpha;
      }
      
      public function get onClick() : Signal
      {
         if(!onClickController)
         {
            onClickController = new TouchClickController(displayObject);
         }
         return onClickController.onClick;
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
         circle.setSize(param1,param2);
      }
      
      public function setupTarget(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         circle.setup(param1,param2,param3,param4);
      }
      
      public function clear() : void
      {
         circle.clear();
      }
      
      public function show(param1:DisplayObjectContainer, param2:Number = NaN) : void
      {
         tween.reset(_alpha,0.5,"easeOut");
         tween.animate("value",param2 == param2?param2:0.5);
         Starling.juggler.add(tween);
         param1.addChild(displayObject);
         displayObject.touchable = true;
      }
      
      public function hide() : void
      {
         tween.reset(_alpha,0.5,"easeOut");
         tween.animate("value",0);
         tween.onComplete = onHideTweenComplete;
         Starling.juggler.add(tween);
         displayObject.touchable = false;
      }
      
      private function onHideTweenComplete() : void
      {
         if(displayObject.parent)
         {
            displayObject.parent.removeChild(displayObject);
         }
      }
      
      private function handler_alpha(param1:Number) : void
      {
         displayObject.alpha = param1;
      }
   }
}
