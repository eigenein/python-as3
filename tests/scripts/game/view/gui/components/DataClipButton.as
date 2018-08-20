package game.view.gui.components
{
   import idv.cjcat.signals.Signal;
   
   public class DataClipButton extends ClipButtonBase
   {
       
      
      private var _signal_click:Signal;
      
      public function DataClipButton(param1:*)
      {
         super();
         _signal_click = new Signal(param1);
      }
      
      public final function get signal_click() : Signal
      {
         return _signal_click;
      }
      
      protected function getClickData() : *
      {
         return null;
      }
      
      override protected function dispatchClickSignal() : void
      {
         _signal_click.dispatch(getClickData());
      }
   }
}
