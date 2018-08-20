package game.view.popup.activity
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.ClipSpriteUntouchable;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipLayoutNone;
   
   public class SkinShopViewClip extends GuiClipNestedContainer
   {
       
      
      public var tf_header:ClipLabel;
      
      public var tf_label_timer:ClipLabel;
      
      public var tf_timer:ClipLabel;
      
      public var button_close:ClipButton;
      
      public var blindSideTop:ClipSprite;
      
      public var renderer:Vector.<SkinShopViewRendererClip>;
      
      public var layout_content:ClipLayout;
      
      public var header:ClipLayout;
      
      public var layout_timer:ClipLayout;
      
      public var layout_vip_header:ClipLayout;
      
      public var tf_label_skin_name:ClipLabel;
      
      public var layout_skin_name:ClipLayout;
      
      public var untouchable:ClipSpriteUntouchable;
      
      public function SkinShopViewClip()
      {
         tf_header = new ClipLabel();
         tf_label_timer = new ClipLabel(true);
         tf_timer = new ClipLabel(true);
         button_close = new ClipButton();
         blindSideTop = new ClipSprite();
         renderer = new Vector.<SkinShopViewRendererClip>();
         layout_content = ClipLayout.horizontalMiddleCentered(10);
         header = new ClipLayoutNone();
         layout_timer = ClipLayout.horizontalMiddleCentered(4,tf_label_timer,tf_timer);
         layout_vip_header = ClipLayout.horizontalMiddleCentered(4,tf_header);
         tf_label_skin_name = new ClipLabel();
         layout_skin_name = ClipLayout.horizontalMiddleCentered(4,tf_label_skin_name);
         untouchable = new ClipSpriteUntouchable();
         super();
      }
   }
}
