package game.view.popup.arena.log
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.ClipSpriteUntouchable;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class ArenaLogPopupClip extends PopupClipBase
   {
       
      
      public var gradient_bottom:ClipSpriteUntouchable;
      
      public var gradient_top:ClipSpriteUntouchable;
      
      public var list_container:GuiClipLayoutContainer;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      public var sideBGLight_inst0:ClipSprite;
      
      public var sideBGLight_inst1:ClipSprite;
      
      public var sideBGLight_inst2:ClipSprite;
      
      public var tf_message:ClipLabel;
      
      public function ArenaLogPopupClip()
      {
         gradient_bottom = new ClipSpriteUntouchable();
         gradient_top = new ClipSpriteUntouchable();
         list_container = new GuiClipLayoutContainer();
         scroll_slider_container = new GuiClipLayoutContainer();
         sideBGLight_inst0 = new ClipSprite();
         sideBGLight_inst1 = new ClipSprite();
         sideBGLight_inst2 = new ClipSprite();
         tf_message = new ClipLabel();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_message.text = Translate.translate("UI_DIALOG_LOG_ARENA_EMPTY");
      }
   }
}
