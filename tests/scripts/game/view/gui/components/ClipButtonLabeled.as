package game.view.gui.components
{
   public class ClipButtonLabeled extends ClipButton
   {
       
      
      public var guiClipLabel:SpecialClipLabel;
      
      public function ClipButtonLabeled()
      {
         super();
      }
      
      public function initialize(param1:String, param2:Function) : void
      {
         label = param1;
         signal_click.add(param2);
      }
      
      public function get label() : String
      {
         return guiClipLabel.text;
      }
      
      public function set label(param1:String) : void
      {
         guiClipLabel.text = param1;
      }
   }
}
