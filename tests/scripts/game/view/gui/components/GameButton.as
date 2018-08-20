package game.view.gui.components
{
   import com.progrestar.common.lang.Translate;
   import feathers.controls.Button;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.tutorial.ITutorialButton;
   import idv.cjcat.signals.Signal;
   import starling.display.DisplayObject;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   public class GameButton extends Button implements ITooltipSource, ITutorialButton
   {
       
      
      protected var _tooltipVO:TooltipVO;
      
      protected var _signal_click:Signal;
      
      public function GameButton()
      {
         super();
         createSignal();
         addEventListener("addedToStage",handler_addedToStage);
         addEventListener("removedFromStage",handler_removedFromStage);
      }
      
      public static function emptyButton(param1:Boolean = true) : GameButton
      {
         var _loc2_:GameButton = new GameButton();
         if(param1)
         {
            _loc2_.styleNameList.add("STYLE_BUTTON_LABELED");
         }
         return _loc2_;
      }
      
      public static function staticButton(param1:String, param2:Function, param3:String = "STYLE_BUTTON_LABELED") : GameButton
      {
         var _loc4_:GameButton = new GameButton();
         _loc4_.label = Translate.translate(param1);
         param2 && _loc4_.signal_click.add(param2);
         if(param3)
         {
            _loc4_.styleNameList.add(param3);
         }
         return _loc4_;
      }
      
      public static function multilineButton(param1:String, param2:Function, param3:Boolean = true) : GameButton
      {
         var _loc4_:GameButton = new GameButton();
         _loc4_.label = Translate.translate(param1);
         param2 && _loc4_.signal_click.add(param2);
         if(param3)
         {
            _loc4_.styleNameList.add("STYLE_BUTTON_LABELED_MULTILINE");
         }
         return _loc4_;
      }
      
      override public function dispose() : void
      {
         if(_signal_click)
         {
            _signal_click.clear();
         }
         super.dispose();
      }
      
      public function get tooltipVO() : TooltipVO
      {
         return _tooltipVO;
      }
      
      public function get graphics() : DisplayObject
      {
         return this;
      }
      
      public function get signal_click() : Signal
      {
         return _signal_click;
      }
      
      protected function createSignal() : void
      {
         _signal_click = new Signal();
      }
      
      protected function dispatchSignal() : void
      {
         _signal_click.dispatch();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         useHandCursor = true;
         addEventListener("touch",onTouch);
      }
      
      private function onTouch(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(param1.currentTarget as DisplayObject,"ended");
         if(_loc2_)
         {
            dispatchSignal();
         }
      }
      
      private function handler_addedToStage(param1:Event) : void
      {
         dispatchEventWith("TooltipEventType.SOURCE_ADDED",true);
      }
      
      private function handler_removedFromStage(param1:Event) : void
      {
         dispatchEventWith("TooltipEventType.SOURCE_REMOVED",true);
      }
   }
}
