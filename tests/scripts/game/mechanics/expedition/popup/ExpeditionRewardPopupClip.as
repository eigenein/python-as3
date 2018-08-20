package game.mechanics.expedition.popup
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.mechanics.boss.popup.ArtifactFlyingDropLayer;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.reward.multi.InventoryItemFlyingRenderer;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   import starling.display.DisplayObject;
   
   public class ExpeditionRewardPopupClip extends GuiClipNestedContainer
   {
       
      
      private var mergedRewardsList:Vector.<InventoryItem>;
      
      public var tf_title:ClipLabel;
      
      public var scene:ExpeditionRewardPopupSceneClip;
      
      public var rarity:ExpeditionBriefingPopupRarityClip;
      
      public var button_ok:ClipButtonLabeled;
      
      public var tf_header:ClipLabel;
      
      public var tf_label_reward:ClipLabel;
      
      public var glow:ClipSprite;
      
      public var list_item_1:InventoryItemFlyingRenderer;
      
      public var list_item_2:InventoryItemFlyingRenderer;
      
      public var list_item_3:InventoryItemFlyingRenderer;
      
      public var list_item_4:InventoryItemFlyingRenderer;
      
      public var list_item_5:InventoryItemFlyingRenderer;
      
      public var list_item_6:InventoryItemFlyingRenderer;
      
      public var bg:GuiClipScale9Image;
      
      public var layout_item_list:ClipLayout;
      
      public var cutePanel_BG_12_12_12_12_inst0:GuiClipScale9Image;
      
      public var tf_story:ClipLabel;
      
      public var layout_story:ClipLayout;
      
      public var layout_rewards:ClipLayout;
      
      public function ExpeditionRewardPopupClip()
      {
         tf_title = new ClipLabel();
         scene = new ExpeditionRewardPopupSceneClip();
         rarity = new ExpeditionBriefingPopupRarityClip();
         button_ok = new ClipButtonLabeled();
         tf_header = new ClipLabel();
         tf_label_reward = new ClipLabel();
         glow = new ClipSprite();
         list_item_1 = new InventoryItemFlyingRenderer();
         list_item_2 = new InventoryItemFlyingRenderer();
         list_item_3 = new InventoryItemFlyingRenderer();
         list_item_4 = new InventoryItemFlyingRenderer();
         list_item_5 = new InventoryItemFlyingRenderer();
         list_item_6 = new InventoryItemFlyingRenderer();
         bg = new GuiClipScale9Image();
         layout_item_list = ClipLayout.horizontalMiddleCentered(0,list_item_1,list_item_2,list_item_3,list_item_4,list_item_5,list_item_6);
         cutePanel_BG_12_12_12_12_inst0 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         tf_story = new ClipLabel();
         layout_story = ClipLayout.horizontalMiddleCentered(4,tf_story);
         layout_rewards = ClipLayout.none(button_ok,tf_label_reward,cutePanel_BG_12_12_12_12_inst0,layout_story);
         super();
      }
      
      public function dropItem(param1:ArtifactFlyingDropLayer, param2:InventoryItem, param3:int) : void
      {
         var _loc4_:Rectangle = getItemDisplayObject(param2).getBounds(param1.graphics);
         var _loc6_:Number = scene.graphics.x + scene.hero_position_after.graphics.x;
         var _loc7_:Number = scene.graphics.y + scene.hero_position_after.graphics.y + 20;
         var _loc5_:* = 0;
         param1.addChestItem(_loc6_,_loc7_,param2,_loc4_.x + _loc4_.width * 0.5,_loc4_.y + _loc4_.height * 0.5,_loc5_,0.6 + param3 * 0.11,1);
      }
      
      protected function getItemDisplayObject(param1:InventoryItem) : DisplayObject
      {
         return getItemTile(param1).graphics;
      }
      
      public function setRewardList(param1:Vector.<InventoryItem>) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         mergedRewardsList = param1;
         var _loc3_:int = 6;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = this["list_item_" + (_loc4_ + 1)];
            if(_loc2_)
            {
               if(_loc4_ < param1.length)
               {
                  _loc2_.setData(param1[_loc4_]);
                  _loc2_.graphics.alpha = 0;
               }
               else
               {
                  _loc2_.graphics.visible = false;
               }
            }
            _loc4_++;
         }
      }
      
      public function showDropItem(param1:InventoryItem) : void
      {
         getItemDisplayObject(param1).alpha = 1;
         var _loc2_:InventoryItemFlyingRenderer = getItemTile(param1);
         if(_loc2_)
         {
            _loc2_.push();
         }
      }
      
      public function getItemTile(param1:InventoryItem) : InventoryItemFlyingRenderer
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
