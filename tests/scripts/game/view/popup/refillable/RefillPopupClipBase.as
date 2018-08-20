package game.view.popup.refillable
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class RefillPopupClipBase extends GuiClipNestedContainer
   {
       
      
      public var button_buy:CostButton;
      
      public var button_close:ClipButton;
      
      public var refill_block:RefillNeedVIPBlock;
      
      public var tf_label_buy:ClipLabel;
      
      public var tf_label_tries:ClipLabel;
      
      public var tf_tries:ClipLabel;
      
      public var layout_tries:ClipLayout;
      
      public var bg:GuiClipScale9Image;
      
      public function RefillPopupClipBase()
      {
         button_buy = new CostButton();
         button_close = new ClipButton();
         refill_block = new RefillNeedVIPBlock();
         tf_label_buy = new ClipLabel();
         tf_label_tries = new ClipLabel(true);
         tf_tries = new ClipLabel(true);
         layout_tries = ClipLayout.horizontalMiddleCentered(4,tf_label_tries,tf_tries);
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         super();
      }
   }
}
