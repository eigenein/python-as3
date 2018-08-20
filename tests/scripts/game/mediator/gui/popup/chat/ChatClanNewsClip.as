package game.mediator.gui.popup.chat
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import feathers.controls.LayoutGroup;
   import feathers.layout.HorizontalLayout;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   
   public class ChatClanNewsClip extends GuiClipNestedContainer
   {
       
      
      public var button_edit_news:ClipButton;
      
      public var tf_clan_news_header:ClipLabel;
      
      public var layout_header:ClipLayout;
      
      public var tf_clan_news:SpecialClipLabel;
      
      public var layout_main:ClipLayout;
      
      public var input_text_clip:InputTextClip;
      
      public var newsLG:LayoutGroup;
      
      public function ChatClanNewsClip()
      {
         button_edit_news = new ClipButton();
         tf_clan_news_header = new ClipLabel(true);
         layout_header = ClipLayout.horizontalMiddleCentered(4);
         tf_clan_news = new SpecialClipLabel(true);
         layout_main = ClipLayout.verticalMiddleCenter(4);
         input_text_clip = new InputTextClip();
         newsLG = new LayoutGroup();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         var _loc2_:HorizontalLayout = new HorizontalLayout();
         _loc2_.paddingTop = 5;
         _loc2_.paddingBottom = 5;
         newsLG = new LayoutGroup();
         newsLG.layout = _loc2_;
         newsLG.addChild(tf_clan_news);
         tf_clan_news.maxWidth = 670;
         tf_clan_news.maxHeight = 63;
         tf_clan_news.wordWrap = true;
         tf_clan_news.clipRect = new Rectangle(0,0,670,63);
         (layout_header.layout as HorizontalLayout).paddingLeft = button_edit_news.graphics.width;
         layout_header.addChild(tf_clan_news_header);
         layout_header.addChild(button_edit_news.graphics);
         layout_main.addChild(layout_header.graphics);
         layout_main.addChild(newsLG);
         layout_main.addChild(input_text_clip.graphics);
      }
   }
}
