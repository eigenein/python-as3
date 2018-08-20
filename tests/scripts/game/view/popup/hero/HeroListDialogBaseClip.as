package game.view.popup.hero
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.ClipSpriteUntouchable;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class HeroListDialogBaseClip extends PopupClipBase
   {
       
      
      public var team_list_container:GuiClipLayoutContainer;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      public var BGforFrame_inst0:ClipSprite;
      
      public var gradient_top:ClipSpriteUntouchable;
      
      public var gradient_bottom:ClipSpriteUntouchable;
      
      public function HeroListDialogBaseClip()
      {
         super();
         button_close = new ClipButton();
         dialog_frame = new GuiClipScale9Image(new Rectangle(64,64,2,2));
         team_list_container = new GuiClipLayoutContainer();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         dialog_frame.graphics.touchable = false;
      }
   }
}
