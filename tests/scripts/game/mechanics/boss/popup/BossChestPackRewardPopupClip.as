package game.mechanics.boss.popup
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.fightresult.RewardDialogRibbonHeader;
   import game.view.popup.refillable.CostButton;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class BossChestPackRewardPopupClip extends GuiClipNestedContainer
   {
       
      
      public var ribbon:RewardDialogRibbonHeader;
      
      public var button_close:ClipButton;
      
      public var item_reward_:Vector.<InventoryItemRenderer>;
      
      public var tf_reward:ClipLabel;
      
      public var tf_bonus:ClipLabel;
      
      public var tf_reopen:ClipLabel;
      
      public var btn_reopen:CostButton;
      
      public function BossChestPackRewardPopupClip()
      {
         ribbon = new RewardDialogRibbonHeader();
         button_close = new ClipButton();
         item_reward_ = new Vector.<InventoryItemRenderer>();
         tf_reward = new ClipLabel();
         tf_bonus = new ClipLabel();
         tf_reopen = new ClipLabel();
         btn_reopen = new CostButton();
         super();
      }
   }
}
