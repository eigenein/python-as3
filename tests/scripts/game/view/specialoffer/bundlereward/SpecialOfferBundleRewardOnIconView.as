package game.view.specialoffer.bundlereward
{
   import engine.core.clipgui.ClipSpriteUntouchable;
   import feathers.controls.LayoutGroup;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.model.user.specialoffer.PlayerSpecialOfferBundleReward;
   import game.view.popup.reward.GuiElementExternalStyle;
   import game.view.popup.reward.RelativeAlignment;
   
   public class SpecialOfferBundleRewardOnIconView extends LayoutGroup
   {
       
      
      private var offer:PlayerSpecialOfferBundleReward;
      
      private var clip:ClipSpriteUntouchable;
      
      public const displayStyle:GuiElementExternalStyle = new GuiElementExternalStyle();
      
      public function SpecialOfferBundleRewardOnIconView(param1:PlayerSpecialOfferBundleReward)
      {
         super();
         this.offer = param1;
         AssetStorage.instance.globalLoader.requestAssetWithCallback(param1.asset,handler_assetLoaded);
         var _loc2_:RelativeAlignment = new RelativeAlignment("left","bottom");
         displayStyle.setOverlay(this,_loc2_);
         param1.signal_removed.add(handler_removed);
      }
      
      override public function dispose() : void
      {
         removeFromParent();
         super.dispose();
      }
      
      private function handler_assetLoaded(param1:RsxGuiAsset) : void
      {
         clip = param1.create(ClipSpriteUntouchable,offer.assetClipOnIcon);
         addChild(clip.graphics);
         validate();
      }
      
      private function handler_removed() : void
      {
         displayStyle.dispose();
      }
   }
}
