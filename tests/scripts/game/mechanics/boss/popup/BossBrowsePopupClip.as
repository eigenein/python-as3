package game.mechanics.boss.popup
{
   import engine.core.clipgui.ClipSprite;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class BossBrowsePopupClip extends PopupClipBase
   {
       
      
      public var boss_renderer:BossFrameExtRenderer;
      
      public var every_win_reward_1:InventoryItemRenderer;
      
      public var every_win_reward_2:InventoryItemRenderer;
      
      public var first_win_reward_1:InventoryItemRenderer;
      
      public var first_win_reward_2:InventoryItemRenderer;
      
      public var first_win_reward_3:InventoryItemRenderer;
      
      public var tf_reward_every_win:ClipLabel;
      
      public var tf_reward_first_win:ClipLabel;
      
      public var bg_reward_received:ClipSprite;
      
      public var tf_reward_received:ClipLabel;
      
      public var tf_attempts:ClipLabel;
      
      public var action_btn:ClipButtonLabeled;
      
      public function BossBrowsePopupClip()
      {
         boss_renderer = new BossFrameExtRenderer();
         every_win_reward_1 = new InventoryItemRenderer();
         every_win_reward_2 = new InventoryItemRenderer();
         first_win_reward_1 = new InventoryItemRenderer();
         first_win_reward_2 = new InventoryItemRenderer();
         first_win_reward_3 = new InventoryItemRenderer();
         tf_reward_every_win = new ClipLabel();
         tf_reward_first_win = new ClipLabel();
         bg_reward_received = new ClipSprite();
         tf_reward_received = new ClipLabel();
         tf_attempts = new ClipLabel();
         action_btn = new ClipButtonLabeled();
         super();
      }
   }
}
