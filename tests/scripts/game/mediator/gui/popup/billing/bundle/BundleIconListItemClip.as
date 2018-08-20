package game.mediator.gui.popup.billing.bundle
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.assets.storage.AssetStorageUtil;
   import game.data.reward.BundleRewardHeroInventoryItem;
   import game.data.storage.resource.InventoryItemDescription;
   import game.mediator.gui.popup.shop.InventoryFragmentSkinItem;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.inventory.InventoryItemCountProxy;
   import game.view.gui.components.ClipButton;
   
   public class BundleIconListItemClip extends ClipButton
   {
       
      
      public const image_frame:GuiClipImage = new GuiClipImage();
      
      public const image_item:GuiClipImage = new GuiClipImage();
      
      public const simple_frame:GuiClipImage = new GuiClipImage();
      
      public const selection:GuiClipScale9Image = new GuiClipScale9Image();
      
      public const hover:ClipSprite = new ClipSprite();
      
      public const items:BundleListItemContainersClip = new BundleListItemContainersClip();
      
      public function BundleIconListItemClip()
      {
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         hover.graphics.visible = false;
         selection.graphics.visible = false;
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         var _loc3_:Boolean = param1 == "hover" || param1 == "down";
         if(isInHover != _loc3_)
         {
            hover.graphics.visible = _loc3_;
            isInHover = _loc3_;
            if(_loc3_)
            {
               items.playHoverAnimation();
            }
         }
         if(param2 && param1 == "down")
         {
            playClickSound();
         }
      }
      
      public function setSimple() : void
      {
         image_frame.image.visible = false;
         image_item.image.visible = false;
         simple_frame.image.visible = true;
      }
      
      public function setItemDescription(param1:InventoryItemDescription) : void
      {
         image_frame.image.texture = AssetStorageUtil.getItemDescFrameTexture(param1);
         image_item.image.texture = AssetStorageUtil.getItemDescTexture(param1);
      }
      
      public function setItem(param1:InventoryItem) : void
      {
         var _loc2_:* = null;
         image_frame.image.visible = true;
         image_item.image.visible = true;
         simple_frame.image.visible = false;
         image_frame.image.visible = false;
         simple_frame.image.visible = true;
         if(param1 is BundleRewardHeroInventoryItem)
         {
            _loc2_ = param1 as BundleRewardHeroInventoryItem;
            if(_loc2_.bundleHeroReward.skin)
            {
               image_frame.image.texture = AssetStorageUtil.getItemFrameTexture(new InventoryFragmentSkinItem(_loc2_.bundleHeroReward.skin,1));
               image_item.image.texture = AssetStorageUtil.getItemDescTexture(_loc2_.bundleHeroReward.skin);
            }
            else if(_loc2_.bundleHeroReward.hero)
            {
               image_frame.image.texture = AssetStorageUtil.getItemDescFrameTexture(_loc2_.bundleHeroReward.hero);
               image_item.image.texture = AssetStorageUtil.getItemDescTexture(_loc2_.bundleHeroReward.hero);
            }
         }
         else
         {
            image_frame.image.texture = AssetStorageUtil.getItemFrameTexture(param1);
            image_item.image.texture = AssetStorageUtil.getItemTexture(param1);
         }
      }
      
      public function setItemProxy(param1:InventoryItemCountProxy) : void
      {
         image_frame.image.texture = AssetStorageUtil.getProxyFrameTexture(param1);
         image_item.image.texture = AssetStorageUtil.getItemDescTexture(param1.item);
      }
   }
}
