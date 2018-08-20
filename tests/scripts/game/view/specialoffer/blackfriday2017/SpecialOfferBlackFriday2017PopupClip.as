package game.view.specialoffer.blackfriday2017
{
   import engine.core.clipgui.ClipSprite;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.popup.billing.bundle.BundlePopupTimerBlockClip;
   import game.view.specialoffer.welcomeback.ClipLabelInContainer;
   
   public class SpecialOfferBlackFriday2017PopupClip extends PopupClipBase
   {
       
      
      public const tf_header:ClipLabel = new ClipLabel();
      
      public const tf_desc:ClipLabel = new ClipLabel();
      
      public const layout_billing:Vector.<GuiClipLayoutContainer> = new Vector.<GuiClipLayoutContainer>();
      
      public const panel1:SpecialOfferBlackFriday2017PanelClip = new SpecialOfferBlackFriday2017PanelClip();
      
      public const tf_billing_sale:ClipLabelInContainer = new ClipLabelInContainer();
      
      public const panel2:SpecialOfferBlackFriday2017PanelClip = new SpecialOfferBlackFriday2017PanelClip();
      
      public const tf_chest_sale:ClipLabelInContainer = new ClipLabelInContainer();
      
      public const panel3:SpecialOfferBlackFriday2017PanelClip = new SpecialOfferBlackFriday2017PanelClip();
      
      public const tf_summoningCircle_sale:ClipLabelInContainer = new ClipLabelInContainer();
      
      public const panel4:SpecialOfferBlackFriday2017PanelClip = new SpecialOfferBlackFriday2017PanelClip();
      
      public const tf_artifactChest_sale:ClipLabelInContainer = new ClipLabelInContainer();
      
      public const icon_billing_bought:ClipSprite = new ClipSprite();
      
      public const tf_billing_bought:ClipLabel = new ClipLabel(true);
      
      public const layout_billing_bought:ClipLayout = ClipLayout.horizontalMiddleCentered(2,icon_billing_bought,tf_billing_bought);
      
      public const timer:BundlePopupTimerBlockClip = new BundlePopupTimerBlockClip();
      
      public function SpecialOfferBlackFriday2017PopupClip()
      {
         super();
      }
   }
}
