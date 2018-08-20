package game.mediator.gui.popup.billing
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mediator.gui.popup.billing.bundle.BundleIconList;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLayout;
   
   public class BundleListPopupClip extends GuiClipNestedContainer
   {
       
      
      public const list_leftArrow:ClipButton = new ClipButton();
      
      public const list_rightArrow:ClipButton = new ClipButton();
      
      public const list_layout:ClipLayout = ClipLayout.horizontalMiddleCentered(5);
      
      public const list:BundleIconList = new BundleIconList(list_layout,list_leftArrow,list_rightArrow);
      
      public const layout:ClipLayout = ClipLayout.horizontalBottomCentered(0);
      
      public function BundleListPopupClip()
      {
         super();
      }
   }
}
