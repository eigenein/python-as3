package game.view.popup.ny.treeupgrade
{
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayoutNone;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class NYTreeUpgradePopupClip extends GuiClipNestedContainer
   {
       
      
      public var show_1:GuiAnimation;
      
      public var show_2:GuiAnimation;
      
      public var header_layout_container:GuiClipLayoutContainer;
      
      public var btn_close:ClipButton;
      
      public var tf_server:ClipLabel;
      
      public var tf_level:ClipLabel;
      
      public var tf_toys_left:ClipLabel;
      
      public var tf_desc:ClipLabel;
      
      public var tf_toys:ClipLabel;
      
      public const progressbar_toys:NYTreeUpgradeProgressBarClip = new NYTreeUpgradeProgressBarClip();
      
      public var decorate_renderer_1:NYTreeDecorateRendederClip;
      
      public var decorate_renderer_2:NYTreeDecorateRendederClip;
      
      public var decorate_renderer_3:NYFireworksRendederClip;
      
      public var gift_container:GuiClipLayoutContainer;
      
      public var tree_container:GuiClipLayoutContainer;
      
      public var btn_send:ClipButtonLabeled;
      
      public var layout_giftdrop:ClipLayoutNone;
      
      public function NYTreeUpgradePopupClip()
      {
         show_1 = new GuiAnimation();
         show_2 = new GuiAnimation();
         header_layout_container = new GuiClipLayoutContainer();
         btn_close = new ClipButton();
         tf_server = new ClipLabel();
         tf_level = new ClipLabel();
         tf_toys_left = new ClipLabel();
         tf_desc = new ClipLabel();
         tf_toys = new ClipLabel();
         decorate_renderer_1 = new NYTreeDecorateRendederClip();
         decorate_renderer_2 = new NYTreeDecorateRendederClip();
         decorate_renderer_3 = new NYFireworksRendederClip();
         gift_container = new GuiClipLayoutContainer();
         tree_container = new GuiClipLayoutContainer();
         btn_send = new ClipButtonLabeled();
         layout_giftdrop = new ClipLayoutNone();
         super();
      }
   }
}
