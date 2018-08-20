package game.view.popup.ny.gifts
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButtonLabeledAnimated;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class NYReceivedGiftRendererClip extends GuiClipNestedContainer
   {
       
      
      public var tf_title:ClipLabel;
      
      public var tf_time:ClipLabel;
      
      public var dark_bg:GuiClipImage;
      
      public var gift_container:GuiClipLayoutContainer;
      
      public var drop_container:GuiClipLayoutContainer;
      
      public var info_content:NYReceivedGiftRendererInfoContentClip;
      
      public var btn_open:ClipButtonLabeledAnimated;
      
      public var tf_gift_sent:ClipLabel;
      
      public var icon_tick:GuiClipImage;
      
      public var layout_gift_sent:ClipLayout;
      
      public var bg:GuiClipScale9Image;
      
      public var tf_reason:ClipLabel;
      
      public var layout_reason:ClipLayout;
      
      public function NYReceivedGiftRendererClip()
      {
         tf_title = new ClipLabel();
         tf_time = new ClipLabel();
         dark_bg = new GuiClipImage();
         gift_container = new GuiClipLayoutContainer();
         drop_container = new GuiClipLayoutContainer();
         info_content = new NYReceivedGiftRendererInfoContentClip();
         btn_open = new ClipButtonLabeledAnimated();
         tf_gift_sent = new ClipLabel();
         icon_tick = new GuiClipImage();
         layout_gift_sent = ClipLayout.horizontalMiddleCentered(5,tf_gift_sent,icon_tick);
         bg = new GuiClipScale9Image(new Rectangle(16,16,16,16));
         tf_reason = new ClipLabel();
         layout_reason = ClipLayout.horizontalMiddleCentered(4,tf_reason);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
      }
   }
}
