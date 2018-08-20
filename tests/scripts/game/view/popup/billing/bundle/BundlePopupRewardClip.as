package game.view.popup.billing.bundle
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.AssetStorageUtil;
   import game.data.reward.BundleRewardHeroInventoryItem;
   import game.data.storage.hero.UnitDescription;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.model.user.inventory.InventoryFragmentItem;
   import game.model.user.inventory.InventoryItem;
   import game.util.NumberUtils;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.tooltip.InventoryItemInfoTooltip;
   
   public class BundlePopupRewardClip extends GuiClipNestedContainer
   {
       
      
      public var tf_item_amount:ClipLabel;
      
      public var tf_item_name:ClipLabel;
      
      public var layout_text:ClipLayout;
      
      public var image_frame:GuiClipImage;
      
      public var image_item:GuiClipImage;
      
      public function BundlePopupRewardClip()
      {
         tf_item_amount = new ClipLabel();
         tf_item_name = new ClipLabel();
         layout_text = ClipLayout.verticalMiddleLeft(4,tf_item_name,tf_item_amount);
         super();
      }
      
      public function dispose() : void
      {
         TooltipHelper.removeTooltip(graphics);
      }
      
      public function setData(param1:InventoryItem) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         _loc3_ = null;
         if(param1 is BundleRewardHeroInventoryItem)
         {
            _loc2_ = param1 as BundleRewardHeroInventoryItem;
            if(_loc2_.bundleHeroReward.type == "skin")
            {
               image_frame.image.texture = AssetStorage.rsx.popup_theme.getTexture("border_item_skin");
               image_item.image.texture = AssetStorage.inventory.getSkinTexture(_loc2_.bundleHeroReward.hero,_loc2_.bundleHeroReward.skin);
            }
            else
            {
               image_frame.image.texture = AssetStorageUtil.getItemFrameTexture(param1);
               image_item.image.texture = AssetStorageUtil.getItemTexture(param1);
            }
            tf_item_amount.text = (param1 as BundleRewardHeroInventoryItem).description;
            tf_item_name.text = param1.name;
            _loc3_ = new TooltipVO(InventoryItemInfoTooltip,param1);
            TooltipHelper.addTooltip(graphics,_loc3_);
         }
         else
         {
            image_frame.image.texture = AssetStorageUtil.getItemFrameTexture(param1);
            image_item.image.texture = AssetStorageUtil.getItemTexture(param1);
            tf_item_amount.text = NumberUtils.numberToString(param1.amount);
            tf_item_name.text = param1.name;
            _loc3_ = new TooltipVO(InventoryItemInfoTooltip,param1);
            TooltipHelper.addTooltip(graphics,_loc3_);
            if(param1.item is UnitDescription && !(param1 is InventoryFragmentItem))
            {
               tf_item_amount.text = Translate.translate("UI_POPUP_BUNDLE_HERO_REWARD");
            }
         }
      }
   }
}
