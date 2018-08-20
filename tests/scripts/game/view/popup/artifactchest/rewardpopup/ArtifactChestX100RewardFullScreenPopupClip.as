package game.view.popup.artifactchest.rewardpopup
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.common.util.CollectionUtil;
   import com.progrestar.framework.ares.core.Node;
   import flash.geom.Rectangle;
   import game.mechanics.boss.popup.ArtifactFlyingDropLayer;
   import game.model.user.inventory.InventoryItem;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   
   public class ArtifactChestX100RewardFullScreenPopupClip extends ArtifactChestRewardFullScreenPopupClipBase
   {
       
      
      private var mergedRewardsList:Vector.<InventoryItem>;
      
      public var multi_reward_list_100:ArtifactChestRewardPopupClipMulti100;
      
      public function ArtifactChestX100RewardFullScreenPopupClip()
      {
         multi_reward_list_100 = new ArtifactChestRewardPopupClipMulti100();
         super();
      }
      
      override public function get rewardContainer() : DisplayObjectContainer
      {
         return multi_reward_list_100.reward_list_container;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         multi_reward_list_100.tf_reward_title.text = Translate.translate("UI_DIALOG_ARTIFACT_CHEST_REWARD");
      }
      
      public function setMergedRewardList(param1:Vector.<InventoryItem>) : void
      {
         this.mergedRewardsList = param1.slice(0,15);
      }
      
      override public function setReward(param1:Vector.<InventoryItem>) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      override public function setBuyMoreCost(param1:ArtifactChestRewardPopupMediator) : void
      {
         cost_button_more.cost = param1.openCostX100.outputDisplayFirst;
      }
      
      override public function tweenHideGui(param1:Number) : void
      {
         super.tweenHideGui(param1);
         Starling.juggler.tween(multi_reward_list_100.reward_title_container,0.15,{"alpha":0});
      }
      
      override public function showGuiWithDelay(param1:Number) : void
      {
         graphics.alpha = 0;
         graphics.visible = true;
         var _loc2_:Number = param1 + 2.5;
         multi_reward_list_100.reward_title_container.alpha = 0;
         multi_reward_list_100.reward_title_container.visible = true;
         Starling.juggler.tween(multi_reward_list_100.reward_title_container,1,{
            "alpha":1,
            "delay":param1
         });
         Starling.juggler.tween(graphics,0.5,{
            "alpha":1,
            "delay":_loc2_
         });
      }
      
      override public function getItemDisplayObject(param1:InventoryItem) : DisplayObject
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      override public function getItemTile(param1:InventoryItem) : ArtifactChestRewardPopupItemTile
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      override public function showDropItem(param1:InventoryItem) : void
      {
         getItemDisplayObject(param1).visible = true;
         var _loc2_:ArtifactChestRewardPopupItemTile = getItemTile(param1);
         if(_loc2_)
         {
            _loc2_.push();
            _loc2_.data.amount = _loc2_.data.amount + param1.amount;
            _loc2_.data = _loc2_.data;
         }
      }
      
      override public function dropItem(param1:ArtifactFlyingDropLayer, param2:InventoryItem, param3:int) : void
      {
         var _loc4_:Rectangle = getItemDisplayObject(param2).getBounds(param1.graphics);
         var _loc6_:Number = 500;
         var _loc7_:Number = 380;
         var _loc8_:Number = 1.3 + (param3 % 10 * 0.009 + int(param3 / 10) * 0.2) / 2;
         var _loc5_:Number = 0.3 + param3 * 0.005 / 2;
         param1.addChestItem(_loc6_ + (Math.random() - 0.5) * 50,_loc7_,param2,_loc4_.x + _loc4_.width * 0.5,_loc4_.y + _loc4_.height * 0.5,_loc8_,_loc5_,_loc4_.width / 84);
      }
   }
}
