package game.mechanics.titan_arena.popup.reward
{
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class TitanArenaPointsRewardPopupClip extends PopupClipBase
   {
       
      
      public var tf_victory_reward:ClipLabel;
      
      public var tf_week_points:ClipLabel;
      
      public var tf_place_reward:ClipLabel;
      
      public var tf_points_reward:ClipLabel;
      
      public var tf_not_enought_to_farm_points:ClipLabel;
      
      public var victory_reward:TitanArenaPointsRewardsRenderer;
      
      public var place_reward:TitanArenaPointsPlaceRewardsRenderer;
      
      public var reward:InventoryItemRenderer;
      
      public var progressbar:TitanArenaPointsProgressBarClip;
      
      public var progress_and_reward_layout:ClipLayout;
      
      public var btn_farm:ClipButtonLabeled;
      
      public var tf_label_status:ClipLabel;
      
      public function TitanArenaPointsRewardPopupClip()
      {
         reward = new InventoryItemRenderer();
         progressbar = new TitanArenaPointsProgressBarClip();
         progress_and_reward_layout = ClipLayout.horizontalMiddleCentered(3,progressbar,reward);
         super();
      }
   }
}
