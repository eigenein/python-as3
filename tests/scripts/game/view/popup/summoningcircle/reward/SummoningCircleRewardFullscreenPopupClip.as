package game.view.popup.summoningcircle.reward
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.chest.SoundGuiAnimation;
   import game.view.popup.fightresult.RewardDialogRibbonHeader;
   import game.view.popup.refillable.CostButton;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class SummoningCircleRewardFullscreenPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var button_ok:ClipButtonLabeled;
      
      public var cost_button_more:CostButton;
      
      public var tf_item_name:ClipLabel;
      
      public var tf_label_item_name:ClipLabel;
      
      public var tf_label_item_name_multi:ClipLabel;
      
      public var tf_open_pack:ClipLabel;
      
      public var tf_hero_drop_desc:ClipLabel;
      
      public var tf_chest_promt:ClipLabel;
      
      public var multi_reward_list:SummoningCircleRewardPopupClipMulti;
      
      public var multi_reward_extended_list:SummoningCircleRewardPopupClipMultiExtended;
      
      public var reward_item:InventoryItemRenderer;
      
      public var tf_bonus:ClipLabel;
      
      public var reward_bonus:InventoryItemRenderer;
      
      public var bonus_shadow:ClipSprite;
      
      public var ball_animation:SoundGuiAnimation;
      
      public var ribbon:RewardDialogRibbonHeader;
      
      public function SummoningCircleRewardFullscreenPopupClip()
      {
         button_close = new ClipButton();
         button_ok = new ClipButtonLabeled();
         cost_button_more = new CostButton();
         tf_item_name = new ClipLabel();
         tf_label_item_name = new ClipLabel();
         tf_label_item_name_multi = new ClipLabel();
         tf_open_pack = new ClipLabel();
         tf_hero_drop_desc = new ClipLabel();
         tf_chest_promt = new ClipLabel();
         multi_reward_list = new SummoningCircleRewardPopupClipMulti();
         multi_reward_extended_list = new SummoningCircleRewardPopupClipMultiExtended();
         reward_item = new InventoryItemRenderer();
         tf_bonus = new ClipLabel();
         reward_bonus = new InventoryItemRenderer();
         bonus_shadow = new ClipSprite();
         ball_animation = new SoundGuiAnimation();
         ribbon = new RewardDialogRibbonHeader();
         super();
      }
   }
}
