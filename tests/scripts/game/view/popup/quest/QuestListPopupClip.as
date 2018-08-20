package game.view.popup.quest
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.ClipSpriteUntouchable;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class QuestListPopupClip extends GuiClipNestedContainer
   {
       
      
      public var header_layout_container:GuiClipLayoutContainer;
      
      public var button_close:ClipButton;
      
      public var dialog_frame:GuiClipScale9Image;
      
      public var quest_list_container:GuiClipLayoutContainer;
      
      public var sideBGLight_inst0:ClipSprite;
      
      public var sideBGLight_inst1:ClipSprite;
      
      public var sideBGLight_inst2:ClipSprite;
      
      public var gradient_top:ClipSpriteUntouchable;
      
      public var gradient_bottom:ClipSpriteUntouchable;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      public function QuestListPopupClip()
      {
         super();
         header_layout_container = new GuiClipLayoutContainer();
         button_close = new ClipButton();
         dialog_frame = new GuiClipScale9Image(new Rectangle(64,64,2,2));
         sideBGLight_inst0 = new ClipSprite();
         sideBGLight_inst1 = new ClipSprite();
         sideBGLight_inst2 = new ClipSprite();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         dialog_frame.graphics.touchable = false;
      }
   }
}
