package game.mechanics.boss.popup
{
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.reward.RewardPopup;
   
   public class BossDailyRewardPopup extends RewardPopup
   {
       
      
      public function BossDailyRewardPopup(param1:Vector.<InventoryItem>, param2:String = "reward")
      {
         super(param1,param2);
      }
      
      override public function get clipName() : String
      {
         return "popup_boss_reward";
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip.list_item_1.item_counter.graphics.visible = false;
      }
   }
}
