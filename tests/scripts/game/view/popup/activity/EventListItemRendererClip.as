package game.view.popup.activity
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipScale3Image;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class EventListItemRendererClip extends ClipButton
   {
       
      
      public var icon_container:GuiClipContainer;
      
      public var selected_marker:ClipSprite;
      
      public var frame:GuiClipScale9Image;
      
      public var frame_selected:GuiClipScale9Image;
      
      public var timer_bg:GuiClipScale3Image;
      
      public var tf_timer:ClipLabel;
      
      public var title_bg:GuiClipImage;
      
      public var title_bg_left:GuiClipImage;
      
      public var tf_title:ClipLabel;
      
      public var container_title:ClipLayout;
      
      public var red_dot:ClipSprite;
      
      public function EventListItemRendererClip()
      {
         icon_container = new GuiClipContainer();
         selected_marker = new ClipSprite();
         frame = new GuiClipScale9Image();
         frame_selected = new GuiClipScale9Image();
         timer_bg = new GuiClipScale3Image();
         tf_timer = new ClipLabel();
         title_bg = new GuiClipImage();
         title_bg_left = new GuiClipImage();
         tf_title = new ClipLabel();
         container_title = ClipLayout.verticalBottomRight(0,tf_title);
         red_dot = new ClipSprite();
         super();
      }
   }
}
