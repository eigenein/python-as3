package game.view.specialoffer.herochoice
{
   import engine.core.clipgui.GuiClipContainer;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.hero.ClipHeroPreview;
   import game.view.popup.billing.bundle.BundlePopupRewardClip;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class SpecialOfferHeroChoicePopupClip extends PopupClipBase
   {
       
      
      public var tf_header:ClipLabel;
      
      public var tf_label_desc:ClipLabel;
      
      public var tf_label_hero:ClipLabel;
      
      public var tf_label_reward:ClipLabel;
      
      public var tf_label_hero_fragments:ClipLabel;
      
      public var tf_label_question_mark:ClipLabel;
      
      public var icon_hero:InventoryItemRenderer;
      
      public var hero_preview:ClipHeroPreview;
      
      public var button_select:ClipButtonLabeled;
      
      public var reward_item:Vector.<BundlePopupRewardClip>;
      
      public var tf_old_price:ClipLabel;
      
      public var tf_label_timer:ClipLabel;
      
      public var tf_timer:ClipLabel;
      
      public var tf_discount:ClipLabel;
      
      public var marker_bg:GuiClipContainer;
      
      public var layout_hero_rays:GuiClipContainer;
      
      public var layout_header:ClipLayout;
      
      public var layout_timer:ClipLayout;
      
      public var layout_special_offer:ClipLayout;
      
      public var button_buy:ClipButtonLabeled;
      
      public function SpecialOfferHeroChoicePopupClip()
      {
         tf_header = new ClipLabel();
         tf_label_desc = new ClipLabel();
         tf_label_hero = new ClipLabel();
         tf_label_reward = new ClipLabel();
         tf_label_hero_fragments = new ClipLabel();
         tf_label_question_mark = new ClipLabel();
         reward_item = new Vector.<BundlePopupRewardClip>();
         tf_old_price = new ClipLabel();
         tf_label_timer = new ClipLabel(true);
         tf_timer = new ClipLabel(true);
         tf_discount = new ClipLabel();
         marker_bg = new GuiClipContainer();
         layout_hero_rays = new GuiClipContainer();
         layout_header = ClipLayout.horizontalMiddleCentered(0,tf_header);
         layout_timer = ClipLayout.horizontalCentered(4,tf_label_timer,tf_timer);
         layout_special_offer = ClipLayout.none();
         button_buy = new ClipButtonLabeled();
         super();
      }
   }
}
