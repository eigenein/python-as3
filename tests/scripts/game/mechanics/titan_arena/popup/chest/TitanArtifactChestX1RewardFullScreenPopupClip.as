package game.mechanics.titan_arena.popup.chest
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import game.mechanics.titan_arena.mediator.chest.TitanArtifactChestRewardPopupMediator;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.artifactchest.rewardpopup.ArtifactChestRewardPopupItemTile;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   
   public class TitanArtifactChestX1RewardFullScreenPopupClip extends TitanArtifactChestRewardFullScreenPopupClipBase
   {
       
      
      public const tf_item_name:ClipLabel = new ClipLabel();
      
      public const tf_label_item_name:ClipLabel = new ClipLabel();
      
      public const reward_item:ArtifactChestRewardPopupItemTile = new ArtifactChestRewardPopupItemTile();
      
      public function TitanArtifactChestX1RewardFullScreenPopupClip()
      {
         super();
      }
      
      override public function get rewardContainer() : DisplayObjectContainer
      {
         return reward_item.graphics.parent;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_label_item_name.text = Translate.translate("UI_POPUP_CHEST_REWARD");
         reward_item.marker_new.graphics.visible = false;
         reward_item.showMultiplier = true;
      }
      
      override public function setReward(param1:Vector.<InventoryItem>) : void
      {
         super.setReward(param1);
         tf_item_name.text = param1[0].name;
         reward_item.data = param1[0];
         breakApart(reward_item.graphics,1);
      }
      
      override public function setBuyMoreCost(param1:TitanArtifactChestRewardPopupMediator) : void
      {
         cost_button_more.cost = param1.openCostX1.outputDisplayFirst;
      }
      
      override public function tweenHideGui(param1:Number) : void
      {
         super.tweenHideGui(param1);
         Starling.juggler.tween(reward_item.graphics,param1,{"alpha":0});
      }
      
      override public function showGuiWithDelay(param1:Number) : void
      {
         graphics.alpha = 0;
         graphics.visible = true;
         var _loc2_:Number = param1 + 0.1;
         Starling.juggler.tween(graphics,0.5,{
            "alpha":1,
            "delay":_loc2_
         });
      }
      
      override public function hideDropInList() : void
      {
         reward_item.graphics.visible = false;
      }
      
      override public function getItemDisplayObject(param1:InventoryItem) : DisplayObject
      {
         return reward_item.graphics;
      }
      
      override public function getItemTile(param1:InventoryItem) : ArtifactChestRewardPopupItemTile
      {
         return reward_item;
      }
      
      override public function showDropItem(param1:InventoryItem) : void
      {
         getItemDisplayObject(param1).visible = true;
         getItemTile(param1).push();
      }
   }
}
