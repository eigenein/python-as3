package game.view.popup.activity
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.FramedImageClipLoader;
   import game.view.gui.components.GameScrollBar;
   
   public class SpecialQuestEventPopupClip extends PopupClipBase
   {
       
      
      public var tf_header:ClipLabel;
      
      public var content_container:GuiClipContainer;
      
      public var bg_image:FramedImageClipLoader;
      
      public var content_frame:GuiClipScale9Image;
      
      public var scrollbar:GameScrollBar;
      
      public var arrow_up:ClipButton;
      
      public var arrow_down:ClipButton;
      
      public var red_dot_top:ClipSprite;
      
      public var red_dot_bottom:ClipSprite;
      
      public var event_list:QuestEventList;
      
      public function SpecialQuestEventPopupClip()
      {
         tf_header = new ClipLabel();
         content_container = new GuiClipContainer();
         bg_image = new FramedImageClipLoader();
         content_frame = new GuiClipScale9Image();
         scrollbar = new GameScrollBar();
         arrow_up = new ClipButton();
         arrow_down = new ClipButton();
         red_dot_top = new ClipSprite();
         red_dot_bottom = new ClipSprite();
         event_list = new QuestEventList(scrollbar,arrow_up,arrow_down,red_dot_top,red_dot_bottom);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         if(content_frame.graphics)
         {
            content_frame.graphics.touchable = false;
         }
      }
   }
}
