package game.view.popup.artifactchest.rewardpopup
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import flash.geom.Rectangle;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.AssetStorageUtil;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.resource.ConsumableDescription;
   import game.data.storage.titan.TitanDescription;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.InventoryItemCounterClip;
   import starling.display.Image;
   import starling.events.Event;
   
   public class ArtifactChestRewardPopupItemTile extends GuiClipNestedContainer
   {
       
      
      private var _showMultiplier:Boolean = false;
      
      private var _pushTime:Number = 0;
      
      private var _maxPushTime:Number = 0.3;
      
      protected var _x0:Number;
      
      protected var _y0:Number;
      
      private var _data:InventoryItem;
      
      public var item_border_image:GuiClipImage;
      
      public var item_counter:InventoryItemCounterClip;
      
      public var item_image:GuiClipImage;
      
      public var marker_new:ClipSprite;
      
      public var icon_multiplier_container:ClipLayout;
      
      private var initialBounds:Rectangle;
      
      public function ArtifactChestRewardPopupItemTile()
      {
         icon_multiplier_container = ClipLayout.horizontalMiddleCentered(0);
         super();
      }
      
      public function set showMultiplier(param1:Boolean) : void
      {
         _showMultiplier = param1;
      }
      
      public function push() : void
      {
         if(_pushTime == 0)
         {
            graphics.addEventListener("enterFrame",handler_enterFrame);
         }
         _pushTime = _maxPushTime;
      }
      
      public function get data() : InventoryItem
      {
         return _data;
      }
      
      public function set data(param1:InventoryItem) : void
      {
         _data = param1;
         if(param1.item is TitanDescription)
         {
            item_counter.graphics.y = 43;
         }
         else
         {
            item_counter.graphics.y = 51;
         }
         item_counter.text = param1.amount.toString();
         item_counter.maxWidth = item_image.image.width;
         item_image.image.texture = AssetStorageUtil.getItemTexture(param1);
         item_border_image.image.texture = AssetStorageUtil.getItemFrameTexture(param1);
         icon_multiplier_container.removeChildren(0,-1,true);
         var _loc2_:int = param1.amount;
         var _loc3_:* = param1.item.type == InventoryItemType.ARTIFACT;
         var _loc4_:Boolean = param1.item.type == InventoryItemType.CONSUMABLE && (param1.item as ConsumableDescription).rewardType == "artifactEvolution";
         if(_showMultiplier && _loc2_ > 1 && (_loc3_ || _loc4_))
         {
            icon_multiplier_container.addChild(new Image(AssetStorage.rsx.popup_theme.getTexture("icon_x" + _loc2_)));
            item_counter.graphics.visible = false;
         }
         else
         {
            item_counter.graphics.visible = true;
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         _x0 = graphics.x;
         _y0 = graphics.y;
         if(marker_new)
         {
            marker_new.graphics.touchable = false;
         }
      }
      
      private function handler_enterFrame(param1:Event) : void
      {
         _pushTime = _pushTime - param1.data;
         if(_pushTime <= 0)
         {
            _pushTime = 0;
            graphics.removeEventListener("enterFrame",handler_enterFrame);
         }
         var _loc2_:Number = _pushTime / _maxPushTime;
         var _loc3_:* = 1 + _loc2_ * _loc2_ * _loc2_ * 0.2;
         graphics.scaleY = _loc3_;
         graphics.scaleX = _loc3_;
         graphics.x = _x0 - (graphics.scaleX - 1) * 40;
         graphics.y = _y0 - (graphics.scaleY - 1) * 40;
      }
   }
}
