package game.view.popup.player
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class PlayerProfileLabeledNumberClip extends GuiClipNestedContainer
   {
       
      
      public var tf_label:ClipLabel;
      
      public var tf_number:ClipLabel;
      
      public var layout_group:ClipLayout;
      
      public function PlayerProfileLabeledNumberClip()
      {
         tf_label = new ClipLabel(true);
         tf_number = new ClipLabel(true);
         layout_group = ClipLayout.horizontal(4,tf_label,tf_number);
         super();
      }
   }
}
