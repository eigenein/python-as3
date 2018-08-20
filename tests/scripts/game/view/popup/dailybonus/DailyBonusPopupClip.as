package game.view.popup.dailybonus
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class DailyBonusPopupClip extends PopupClipBase
   {
       
      
      public var tf_caption:ClipLabel;
      
      public var gradient_bottom:ClipSprite;
      
      public var gradient_top:ClipSprite;
      
      public var list_container:GuiClipLayoutContainer;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      public function DailyBonusPopupClip()
      {
         tf_caption = new ClipLabel();
         gradient_bottom = new ClipSprite();
         gradient_top = new ClipSprite();
         list_container = new GuiClipLayoutContainer();
         scroll_slider_container = new GuiClipLayoutContainer();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         var _loc2_:Boolean = false;
         gradient_top.graphics.touchable = _loc2_;
         gradient_bottom.graphics.touchable = _loc2_;
      }
   }
}
