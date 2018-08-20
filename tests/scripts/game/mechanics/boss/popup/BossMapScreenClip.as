package game.mechanics.boss.popup
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayoutNone;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class BossMapScreenClip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var button_shop:ClipButtonLabeled;
      
      public var header_layout_container:GuiClipLayoutContainer;
      
      public var tf_label_description:ClipLabel;
      
      public var container_map:ClipLayoutNone;
      
      public var bg_preloader:ClipSprite;
      
      public var renderer_left:BossFrameRenderer;
      
      public var renderer_center:BossFrameExtRenderer;
      
      public var renderer_right:BossFrameRenderer;
      
      public var renderer_left_marker:ClipSprite;
      
      public var renderer_right_marker:ClipSprite;
      
      public var arrow_left:ClipButton;
      
      public var arrow_right:ClipButton;
      
      public function BossMapScreenClip()
      {
         renderer_left = new BossFrameRenderer();
         renderer_center = new BossFrameExtRenderer();
         renderer_right = new BossFrameRenderer();
         renderer_left_marker = new ClipSprite();
         renderer_right_marker = new ClipSprite();
         arrow_left = new ClipButton();
         arrow_right = new ClipButton();
         super();
      }
   }
}
