package game.view.popup.skinunlock
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipContainer;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeledAnimated;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.popup.refillable.CostButton;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class SkinUnlockPopupClip extends PopupClipBase
   {
       
      
      public var marker_bg:GuiClipContainer;
      
      public var tf_header:ClipLabel;
      
      public var stat_tf:SpecialClipLabel;
      
      public var skin_bg:GuiClipContainer;
      
      public var hero_position_after:ClipSprite;
      
      public var hero_position_rays:ClipSprite;
      
      public var tf_unlock_1:ClipLabel;
      
      public var tf_unlock_2:SpecialClipLabel;
      
      public var tf_skin_1:ClipLabel;
      
      public var tf_skin_2:ClipLabel;
      
      public var tf_skin_name_1:ClipLabel;
      
      public var tf_skin_name_2:ClipLabel;
      
      public var btn_unclock_1:CostButton;
      
      public var btn_unclock_2:ClipButtonLabeledAnimated;
      
      public var tf_discount:ClipLabel;
      
      public var tf_old_price:ClipLabel;
      
      public var skin_image_1:ClipSprite;
      
      public var skin_image_2:ClipSprite;
      
      public var reward_item_coin:InventoryItemRenderer;
      
      public var tf_reward_coin:ClipLabel;
      
      public var tf_reward_coin_amount:ClipLabel;
      
      public function SkinUnlockPopupClip()
      {
         marker_bg = new GuiClipContainer();
         tf_header = new ClipLabel();
         stat_tf = new SpecialClipLabel();
         skin_bg = new GuiClipContainer();
         hero_position_after = new ClipSprite();
         hero_position_rays = new ClipSprite();
         tf_unlock_1 = new ClipLabel();
         tf_unlock_2 = new SpecialClipLabel();
         tf_skin_1 = new ClipLabel();
         tf_skin_2 = new ClipLabel();
         tf_skin_name_1 = new ClipLabel();
         tf_skin_name_2 = new ClipLabel();
         btn_unclock_1 = new CostButton();
         btn_unclock_2 = new ClipButtonLabeledAnimated();
         tf_discount = new ClipLabel();
         tf_old_price = new ClipLabel();
         skin_image_1 = new ClipSprite();
         skin_image_2 = new ClipSprite();
         reward_item_coin = new InventoryItemRenderer();
         tf_reward_coin = new ClipLabel();
         tf_reward_coin_amount = new ClipLabel();
         super();
      }
   }
}
