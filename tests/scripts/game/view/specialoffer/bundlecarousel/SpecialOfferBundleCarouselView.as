package game.view.specialoffer.bundlecarousel
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.model.user.specialoffer.PlayerSpecialOfferBundleCarousel;
   import game.view.popup.common.IPopupSideBarBlock;
   import game.view.popup.common.PopupSideBarSide;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   import starling.display.DisplayObject;
   import starling.events.Event;
   
   public class SpecialOfferBundleCarouselView implements IPopupSideBarBlock
   {
       
      
      private var data:PlayerSpecialOfferBundleCarousel;
      
      private var _stashParams:PopupStashEventParams;
      
      private var clip:SpecialOfferBundleCarouselClip;
      
      public function SpecialOfferBundleCarouselView(param1:PlayerSpecialOfferBundleCarousel)
      {
         clip = new SpecialOfferBundleCarouselClip();
         super();
         this.data = param1;
         AssetStorage.instance.globalLoader.requestAssetWithCallback(AssetStorage.rsx.getByName(param1.assetIdent),handler_onAssetLoaded);
         param1.signal_removed.add(handler_removed);
      }
      
      public function dispose() : void
      {
         data.signal_updated.remove(handler_updateProgress);
         data.signal_removed.remove(handler_removed);
      }
      
      public function get graphics() : DisplayObject
      {
         return clip.graphics;
      }
      
      public function get popupOffset() : Number
      {
         return 15;
      }
      
      public function get popupGap() : Number
      {
         return 0;
      }
      
      public function get popupSide() : PopupSideBarSide
      {
         return PopupSideBarSide.bottom;
      }
      
      public function initialize(param1:PopupStashEventParams) : void
      {
         this._stashParams = param1;
      }
      
      protected function handler_onAssetLoaded(param1:RsxGuiAsset) : void
      {
         param1.initGuiClip(clip,data.assetClip);
         clip.tf_title.text = data.localeTitle;
         clip.button_next.initialize(data.localeButton,handler_buttonNext);
         data.signal_updated.add(handler_updateProgress);
         handler_updateProgress();
         clip.graphics.dispatchEvent(new Event("layoutDataChange"));
      }
      
      protected function handler_buttonNext() : void
      {
         data.action_next(_stashParams);
      }
      
      private function handler_updateProgress() : void
      {
         var _loc1_:int = data.indicesTotal;
         var _loc2_:String = ColorUtils.hexToRGBFormat(16705796) + _loc1_ + ColorUtils.hexToRGBFormat(16449533);
         clip.tf_description.text = Translate.translateArgs(data.localeDescKey,_loc1_,_loc2_);
         clip.tf_offer_num.text = data.currentIndex + "/" + _loc1_;
         clip.tf_timer.text = data.timerString;
      }
      
      protected function handler_removed() : void
      {
         clip.graphics.touchable = false;
         dispose();
      }
   }
}
