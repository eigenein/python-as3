package game.view.gui.worldmap
{
   import game.view.gui.components.DataClipButton;
   
   public class ClipButtonMapSecret extends DataClipButton
   {
       
      
      private var _index:int;
      
      public function ClipButtonMapSecret()
      {
         super(int);
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set index(param1:int) : void
      {
         _index = param1;
      }
      
      override protected function getClickData() : *
      {
         return _index;
      }
   }
}
