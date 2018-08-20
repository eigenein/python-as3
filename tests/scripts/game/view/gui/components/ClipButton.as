package game.view.gui.components
{
   import idv.cjcat.signals.Signal;
   
   public class ClipButton extends ClipButtonBase
   {
       
      
      private const _signal_click:Signal = new Signal();
      
      public function ClipButton()
      {
         super();
      }
      
      public final function get signal_click() : Signal
      {
         return _signal_click;
      }
      
      override protected final function dispatchClickSignal() : void
      {
         signal_click.dispatch();
      }
   }
}
