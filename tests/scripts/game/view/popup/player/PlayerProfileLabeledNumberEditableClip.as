package game.view.popup.player
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class PlayerProfileLabeledNumberEditableClip extends GuiClipNestedContainer
   {
       
      
      public var tf_label:ClipLabel;
      
      public var tf_number:ClipLabel;
      
      public var edit_button:ClipButton;
      
      public var layout_group:ClipLayout;
      
      public function PlayerProfileLabeledNumberEditableClip()
      {
         tf_label = new ClipLabel(true);
         tf_number = new ClipLabel(true);
         edit_button = new ClipButton();
         layout_group = ClipLayout.horizontalMiddle(4,tf_label,tf_number,edit_button);
         super();
      }
   }
}
