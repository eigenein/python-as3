package game.view.popup.shop.special
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class SpecialShopWelcomePopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_promote:ClipButtonLabeled;
      
      public var tf_label_desc:ClipLabel;
      
      public var vendor_container:GuiClipContainer;
      
      public var girl_container:ClipLayout;
      
      public function SpecialShopWelcomePopupClip()
      {
         button_promote = new ClipButtonLabeled();
         tf_label_desc = new ClipLabel();
         vendor_container = new GuiClipContainer();
         girl_container = ClipLayout.none(vendor_container);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_label_desc.text = Translate.translate("UI_POPUP_SPECIAL_SHOP_WELCOME");
         button_promote.label = Translate.translate("UI_POPUP_SPECIAL_SHOP_WELCOME_BUTTON");
      }
   }
}
