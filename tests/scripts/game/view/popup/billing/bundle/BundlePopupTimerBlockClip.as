package game.view.popup.billing.bundle
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class BundlePopupTimerBlockClip extends GuiClipNestedContainer
   {
       
      
      public const tf_label_timer:ClipLabel = new ClipLabel(true);
      
      public const tf_timer:ClipLabel = new ClipLabel(true);
      
      public const layout_timer:ClipLayout = ClipLayout.horizontalMiddleCentered(4,tf_label_timer,tf_timer);
      
      public function BundlePopupTimerBlockClip()
      {
         super();
      }
   }
}
