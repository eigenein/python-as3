package game.view.popup.billing.bundle
{
   import engine.core.clipgui.GuiClipContainer;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeledAnimated;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.quest.QuestRewardItemRenderer;
   
   public class HeroEvolveUpsellBundlePopupClip extends PopupClipBase
   {
       
      
      public var button_to_store:ClipButtonLabeledAnimated;
      
      public var tf_discount:ClipLabel;
      
      public var tf_header:ClipLabel;
      
      public var tf_label_desc:ClipLabel;
      
      public var tf_label_reward:ClipLabel;
      
      public var tf_label_gold_desc:ClipLabel;
      
      public var tf_old_price:ClipLabel;
      
      public var layout_gold_label:ClipLayout;
      
      public var hero_position_after:GuiClipContainer;
      
      public var hero_position_before:GuiClipContainer;
      
      public var hero_position_rays:GuiClipContainer;
      
      public var gold_reward:QuestRewardItemRenderer;
      
      public var star_counter_after:HeroEvolveUpsellBundlePopupStarCounterClip;
      
      public var star_counter_before:HeroEvolveUpsellBundlePopupStarCounterClip;
      
      public var layout_special_offer:ClipLayout;
      
      public var timer:BundlePopupTimerBlockClip;
      
      public function HeroEvolveUpsellBundlePopupClip()
      {
         button_to_store = new ClipButtonLabeledAnimated();
         tf_discount = new ClipLabel();
         tf_header = new ClipLabel();
         tf_label_desc = new ClipLabel();
         tf_label_reward = new ClipLabel();
         tf_label_gold_desc = new ClipLabel();
         tf_old_price = new ClipLabel();
         layout_gold_label = ClipLayout.verticalMiddleCenter(0,tf_label_gold_desc);
         hero_position_after = new GuiClipContainer();
         hero_position_before = new GuiClipContainer();
         hero_position_rays = new GuiClipContainer();
         gold_reward = new QuestRewardItemRenderer();
         star_counter_after = new HeroEvolveUpsellBundlePopupStarCounterClip();
         star_counter_before = new HeroEvolveUpsellBundlePopupStarCounterClip();
         layout_special_offer = ClipLayout.none();
         timer = new BundlePopupTimerBlockClip();
         super();
      }
   }
}
