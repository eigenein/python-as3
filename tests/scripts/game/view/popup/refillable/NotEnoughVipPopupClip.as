package game.view.popup.refillable
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.billing.BillingVipLevelBlock;
   
   public class NotEnoughVipPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_ok:ClipButtonLabeled;
      
      public var button_close:ClipButton;
      
      public var tf_header:ClipLabel;
      
      public var tf_message:ClipLabel;
      
      public var next_vip_level:BillingVipLevelBlock;
      
      public var line:GuiClipScale3Image;
      
      public var bg:GuiClipScale9Image;
      
      public var layout_text:ClipLayout;
      
      public function NotEnoughVipPopupClip()
      {
         button_ok = new ClipButtonLabeled();
         button_close = new ClipButton();
         tf_header = new ClipLabel();
         tf_message = new ClipLabel();
         next_vip_level = new BillingVipLevelBlock();
         line = new GuiClipScale3Image(148,1);
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         layout_text = ClipLayout.verticalCenter(8,tf_header,line,tf_message,next_vip_level,button_ok);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         layout_text.height = NaN;
         tf_message.maxHeight = Infinity;
      }
   }
}
