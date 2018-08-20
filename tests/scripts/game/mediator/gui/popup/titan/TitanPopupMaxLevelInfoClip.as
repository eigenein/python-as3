package game.mediator.gui.popup.titan
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class TitanPopupMaxLevelInfoClip extends GuiClipNestedContainer
   {
       
      
      public var tf_text:ClipLabel;
      
      public var layout:ClipLayout;
      
      public function TitanPopupMaxLevelInfoClip()
      {
         tf_text = new ClipLabel();
         layout = ClipLayout.horizontalMiddleCentered(0,tf_text);
         super();
      }
   }
}
