package game.mechanics.titan_arena.popup.chest
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import game.mechanics.boss.popup.ArtifactFlyingDropLayer;
   import game.mechanics.titan_arena.mediator.chest.TitanArtifactChestRewardPopupMediator;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.artifactchest.rewardpopup.ArtifactChestRewardPopupItemTile;
   import game.view.popup.chest.SoundGuiAnimation;
   import game.view.popup.fightresult.RewardDialogRibbonHeader;
   import game.view.popup.refillable.CostButton;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   
   public class TitanArtifactChestRewardFullScreenPopupClipBase extends GuiClipNestedContainer
   {
       
      
      protected var _rewardList:Vector.<InventoryItem>;
      
      public const button_close:ClipButton = new ClipButton();
      
      public const button_ok:ClipButtonLabeled = new ClipButtonLabeled();
      
      public const cost_button_more:CostButton = new CostButton();
      
      public const tf_open_pack:ClipLabel = new ClipLabel();
      
      public const artifact_chest_animation:SoundGuiAnimation = new SoundGuiAnimation();
      
      public const ribbon:RewardDialogRibbonHeader = new RewardDialogRibbonHeader();
      
      public var additionalStartDelay:Number = 0;
      
      public function TitanArtifactChestRewardFullScreenPopupClipBase()
      {
         super();
      }
      
      public function get rewardContainer() : DisplayObjectContainer
      {
         return null;
      }
      
      public function get rewardList() : Vector.<InventoryItem>
      {
         return _rewardList;
      }
      
      public function setReward(param1:Vector.<InventoryItem>) : void
      {
         this._rewardList = param1;
      }
      
      public function setBuyMoreCost(param1:TitanArtifactChestRewardPopupMediator) : void
      {
      }
      
      public function tweenHideGui(param1:Number) : void
      {
         Starling.juggler.tween(graphics,0.15,{"alpha":0});
      }
      
      public function showGuiWithDelay(param1:Number) : void
      {
         graphics.alpha = 0;
         graphics.visible = true;
         Starling.juggler.tween(graphics,0.5,{
            "alpha":1,
            "delay":param1 + 0.6
         });
      }
      
      public function getItemDisplayObject(param1:InventoryItem) : DisplayObject
      {
         return null;
      }
      
      public function getItemTile(param1:InventoryItem) : ArtifactChestRewardPopupItemTile
      {
         return null;
      }
      
      public function hideDropInList() : void
      {
         var _loc3_:int = 0;
         var _loc1_:DisplayObjectContainer = rewardContainer;
         var _loc2_:int = _loc1_.numChildren;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_.getChildAt(_loc3_).visible = false;
            _loc3_++;
         }
      }
      
      public function showDropItem(param1:InventoryItem) : void
      {
      }
      
      public function dropItem(param1:ArtifactFlyingDropLayer, param2:InventoryItem, param3:int) : void
      {
         var _loc4_:Rectangle = getItemDisplayObject(param2).getBounds(param1.graphics);
         var _loc5_:Number = 500;
         var _loc6_:Number = 380;
         var _loc7_:Number = 2.1 + additionalStartDelay;
         param1.addChestItem(_loc5_,_loc6_,param2,_loc4_.x + _loc4_.width * 0.5,_loc4_.y + _loc4_.height * 0.5,_loc7_,0.2 + param3 * 0.11,_loc4_.width / 84);
      }
      
      protected function breakApart(param1:DisplayObject, param2:int) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
   }
}
