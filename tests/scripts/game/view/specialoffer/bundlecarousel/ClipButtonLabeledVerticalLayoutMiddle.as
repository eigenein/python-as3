package game.view.specialoffer.bundlecarousel
{
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class ClipButtonLabeledVerticalLayoutMiddle extends ClipButton
   {
       
      
      public var guiClipLabel:ClipLabel;
      
      public var layout:ClipLayout;
      
      public function ClipButtonLabeledVerticalLayoutMiddle()
      {
         guiClipLabel = new ClipLabel();
         layout = ClipLayout.verticalMiddleCenter(0,guiClipLabel);
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
