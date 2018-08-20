package game.view.specialoffer.welcomeback
{
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class SpecialOfferWelcomeBackBonusesPopupClip extends PopupClipBase
   {
       
      
      public var tf_header:ClipLabel;
      
      public var tf_desc:ClipLabel;
      
      public var layout_billing:Vector.<GuiClipLayoutContainer>;
      
      public var button_billing:ClipButtonLabeled;
      
      public var tf_panel_billing_header:ClipLabel;
      
      public var tf_billing_sale:ClipLabelInContainer;
      
      public var button_chest:ClipButtonLabeled;
      
      public var tf_panel_chest_header:ClipLabel;
      
      public var tf_chest_sale:ClipLabelInContainer;
      
      public var tf_label_timer:ClipLabel;
      
      public var tf_timer:ClipLabel;
      
      public var layout_timer:ClipLayout;
      
      public function SpecialOfferWelcomeBackBonusesPopupClip()
      {
         tf_header = new ClipLabel();
         tf_desc = new ClipLabel();
         layout_billing = new Vector.<GuiClipLayoutContainer>();
         button_billing = new ClipButtonLabeled();
         tf_panel_billing_header = new ClipLabel();
         tf_billing_sale = new ClipLabelInContainer();
         button_chest = new ClipButtonLabeled();
         tf_panel_chest_header = new ClipLabel();
         tf_chest_sale = new ClipLabelInContainer();
         tf_label_timer = new ClipLabel(true);
         tf_timer = new ClipLabel(true);
         layout_timer = ClipLayout.horizontalCentered(4,tf_label_timer,tf_timer);
         super();
      }
   }
}
