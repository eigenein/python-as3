package game.view.specialoffer.bundlereward
{
   import engine.core.clipgui.ClipSpriteUntouchable;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.specialoffer.PlayerSpecialOfferBundleReward;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.reward.GuiElementExternalStyle;
   import game.view.popup.reward.RelativeAlignment;
   
   public class SpecialOfferBundleRewardOnPopupView extends GuiClipNestedContainer
   {
       
      
      private var offer:PlayerSpecialOfferBundleReward;
      
      private var clip:ClipSpriteUntouchable;
      
      public var tf_title:ClipLabel;
      
      public var tf_reward_gem:ClipLabel;
      
      public var icon_resource:GuiClipImage;
      
      public var layout_reward:ClipLayout;
      
      public const displayStyle:GuiElementExternalStyle = new GuiElementExternalStyle();
      
      public function SpecialOfferBundleRewardOnPopupView(param1:PlayerSpecialOfferBundleReward)
      {
         tf_title = new ClipLabel();
         tf_reward_gem = new ClipLabel(true);
         icon_resource = new GuiClipImage();
         layout_reward = ClipLayout.horizontalMiddleCentered(2,tf_reward_gem,icon_resource);
         super();
         this.offer = param1;
         AssetStorage.instance.globalLoader.requestAssetWithCallback(param1.asset,handler_assetLoaded);
         var _loc2_:RelativeAlignment = new RelativeAlignment();
         displayStyle.setOverlay(graphics,_loc2_);
         displayStyle.signal_dispose.add(dispose);
         param1.signal_removed.add(handler_removed);
      }
      
      public function dispose() : void
      {
         displayStyle.signal_dispose.remove(dispose);
         offer.signal_removed.remove(handler_removed);
      }
      
      private function handler_assetLoaded(param1:RsxGuiAsset) : void
      {
         offer.asset.initGuiClip(this,offer.assetClipOnPopup);
         var _loc2_:InventoryItem = offer.rewardItem;
         tf_reward_gem.text = "+" + _loc2_.amount;
         icon_resource.image.texture = AssetStorage.inventory.getItemGUIIconTexture(_loc2_.item);
         tf_title.text = offer.title;
      }
      
      private function handler_removed() : void
      {
         displayStyle.dispose();
      }
   }
}
