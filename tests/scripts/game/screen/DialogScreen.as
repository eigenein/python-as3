package game.screen
{
   import idv.cjcat.signals.Signal;
   
   public class DialogScreen extends GameScreen
   {
       
      
      public const signal_hidden:Signal = new Signal();
      
      public function DialogScreen()
      {
         super(2);
      }
      
      override public function hide() : void
      {
         if(graphics && graphics.parent)
         {
            graphics.parent.removeChild(graphics);
         }
         signal_hidden.dispatch();
      }
      
      override public function isPermanent() : Boolean
      {
         return false;
      }
   }
}
