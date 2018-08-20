package game.view.gui.components
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.controller.IButtonView;
   import game.view.gui.components.controller.TouchButtonController;
   import game.view.gui.tutorial.ITutorialButton;
   import game.view.popup.test.NativeMouseClickController;
   import idv.cjcat.signals.Signal;
   import starling.events.Event;
   import starling.filters.ColorMatrixFilter;
   import starling.filters.FragmentFilter;
   
   public class ClipButtonBase extends GuiClipNestedContainer implements IButtonView, ITutorialButton
   {
       
      
      protected var controller:TouchButtonController;
      
      protected var defaultFilter:FragmentFilter;
      
      protected var hoverFilter:ColorMatrixFilter;
      
      protected var isInHover:Boolean = false;
      
      public function ClipButtonBase()
      {
         super();
         createTouchController();
         _container.useHandCursor = true;
         _container.addEventListener("disposed",__handler_disposed);
      }
      
      protected function __handler_disposed(param1:Event) : void
      {
         handler_disposed();
      }
      
      protected function handler_disposed() : void
      {
         if(defaultFilter)
         {
            defaultFilter.dispose();
         }
         if(hoverFilter)
         {
            hoverFilter.dispose();
         }
         controller.dispose();
      }
      
      public function set isEnabled(param1:Boolean) : void
      {
         controller.isEnabled = param1;
      }
      
      public function get isEnabled() : Boolean
      {
         return controller.isEnabled;
      }
      
      public function setupState(param1:String, param2:Boolean) : void
      {
         var _loc3_:* = param1 == "hover";
         if(isInHover != _loc3_)
         {
            isInHover = _loc3_;
            if(isInHover)
            {
               if(true || !hoverFilter)
               {
                  if(hoverFilter)
                  {
                     hoverFilter.dispose();
                  }
                  hoverFilter = new ColorMatrixFilter();
                  hoverFilter.adjustBrightness(0.1);
               }
               if(_container.filter != hoverFilter)
               {
                  if(defaultFilter != _container.filter)
                  {
                     if(defaultFilter)
                     {
                        defaultFilter.dispose();
                     }
                     defaultFilter = _container.filter;
                  }
                  _container.filter = hoverFilter;
               }
            }
            else
            {
               _container.filter = defaultFilter;
            }
         }
         if(param2 && param1 == "down")
         {
            playClickSound();
         }
      }
      
      public function click() : void
      {
         dispatchClickSignal();
      }
      
      public function createNativeClickHandler() : Signal
      {
         var signal:Signal = new Signal();
         var controller:NativeMouseClickController = new NativeMouseClickController(_container);
         controller.signal_click.add(function():*
         {
            signal.dispatch();
         });
         _container.addEventListener("disposed",function(param1:Event):void
         {
            controller.dispose();
         });
         return signal;
      }
      
      protected function playClickSound() : void
      {
      }
      
      protected function createTouchController() : void
      {
         controller = new TouchButtonController(_container,this);
      }
      
      protected function dispatchClickSignal() : void
      {
      }
   }
}
