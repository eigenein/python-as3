package game.mechanics.titan_arena.popup.chest
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import feathers.data.ListCollection;
   import feathers.layout.TiledRowsLayout;
   import game.mechanics.boss.popup.ArtifactFlyingDropLayer;
   import game.mechanics.titan_arena.mediator.chest.TitanArtifactChestRewardPopupMediator;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.artifactchest.rewardpopup.ArtifactChestRewardPopupClipMulti;
   import game.view.popup.artifactchest.rewardpopup.ArtifactChestRewardPopupItemRendererWithMultiplier;
   import game.view.popup.artifactchest.rewardpopup.ArtifactChestRewardPopupItemTile;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   
   public class TitanArtifactChestX10RewardFullScreenPopupClip extends TitanArtifactChestRewardFullScreenPopupClipBase
   {
       
      
      public const multi_reward_list:ArtifactChestRewardPopupClipMulti = new ArtifactChestRewardPopupClipMulti();
      
      public const tf_label_item_name_multi:ClipLabel = new ClipLabel();
      
      public function TitanArtifactChestX10RewardFullScreenPopupClip()
      {
         super();
      }
      
      override public function get rewardContainer() : DisplayObjectContainer
      {
         return multi_reward_list.list_rewards.getChildAt(0) as DisplayObjectContainer;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_label_item_name_multi.text = Translate.translate("UI_POPUP_CHEST_REWARD");
         multi_reward_list.graphics.visible = true;
         multi_reward_list.scrollbar_rewards.graphics.visible = false;
         multi_reward_list.list_rewards.isSelectable = false;
         multi_reward_list.list_rewards.itemRendererType = ArtifactChestRewardPopupItemRendererWithMultiplier;
      }
      
      override public function setReward(param1:Vector.<InventoryItem>) : void
      {
         super.setReward(param1);
         multi_reward_list.list_rewards.dataProvider = new ListCollection(param1);
         var _loc2_:TiledRowsLayout = new TiledRowsLayout();
         _loc2_.horizontalAlign = "center";
         _loc2_.paddingTop = 11;
         _loc2_.paddingBottom = 5;
         _loc2_.horizontalGap = 10;
         _loc2_.verticalGap = 5;
         multi_reward_list.list_rewards.layout = _loc2_;
         multi_reward_list.list_rewards.validate();
         breakApart(multi_reward_list.list_rewards,2);
      }
      
      override public function setBuyMoreCost(param1:TitanArtifactChestRewardPopupMediator) : void
      {
         cost_button_more.cost = !!param1.free?param1.openCostX10Free.outputDisplayFirst:param1.openCostX10.outputDisplayFirst;
      }
      
      override public function tweenHideGui(param1:Number) : void
      {
         Starling.juggler.tween(graphics,0.15,{"alpha":0});
      }
      
      override public function showGuiWithDelay(param1:Number) : void
      {
         graphics.alpha = 0;
         graphics.visible = true;
         var _loc2_:Number = param1 + 0.6;
         Starling.juggler.tween(graphics,0.5,{
            "alpha":1,
            "delay":_loc2_
         });
      }
      
      override public function getItemDisplayObject(param1:InventoryItem) : DisplayObject
      {
         var _loc2_:int = _rewardList.indexOf(param1);
         return (multi_reward_list.list_rewards.getChildAt(0) as DisplayObjectContainer).getChildAt(_loc2_);
      }
      
      override public function getItemTile(param1:InventoryItem) : ArtifactChestRewardPopupItemTile
      {
         var _loc2_:int = _rewardList.indexOf(param1);
         return ((multi_reward_list.list_rewards.getChildAt(0) as DisplayObjectContainer).getChildAt(_loc2_) as ArtifactChestRewardPopupItemRendererWithMultiplier).tileClip;
      }
      
      override public function showDropItem(param1:InventoryItem) : void
      {
         getItemDisplayObject(param1).visible = true;
         var _loc2_:ArtifactChestRewardPopupItemTile = getItemTile(param1);
         _loc2_.push();
      }
      
      override public function dropItem(param1:ArtifactFlyingDropLayer, param2:InventoryItem, param3:int) : void
      {
         super.dropItem(param1,param2,param3);
      }
   }
}
