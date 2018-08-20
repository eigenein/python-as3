package game.view.popup.mail
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class PlayerMailPopupClip extends PopupClipBase
   {
       
      
      public var button_farm_all:ClipButtonLabeled;
      
      public var tf_no_new_mail:ClipLabel;
      
      public var list_container:GuiClipLayoutContainer;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      public var gradient_bottom:ClipSprite;
      
      public var gradient_top:ClipSprite;
      
      public var sideBGLight_inst1:ClipSprite;
      
      public var sideBGLight_inst2:ClipSprite;
      
      public var LinePale_148_148_1_inst0:GuiClipScale3Image;
      
      public function PlayerMailPopupClip()
      {
         button_farm_all = new ClipButtonLabeled();
         tf_no_new_mail = new ClipLabel();
         list_container = new GuiClipLayoutContainer();
         scroll_slider_container = new GuiClipLayoutContainer();
         gradient_bottom = new ClipSprite();
         gradient_top = new ClipSprite();
         sideBGLight_inst1 = new ClipSprite();
         sideBGLight_inst2 = new ClipSprite();
         LinePale_148_148_1_inst0 = new GuiClipScale3Image(148,1);
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
