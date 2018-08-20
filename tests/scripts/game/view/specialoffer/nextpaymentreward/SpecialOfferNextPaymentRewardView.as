package game.view.specialoffer.nextpaymentreward
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.INeedNestedParsing;
   import flash.geom.Rectangle;
   import game.assets.HeroAssetProvider;
   import game.assets.HeroRsxAssetDisposable;
   import game.assets.storage.AssetStorage;
   import game.battle.view.hero.HeroView;
   import game.data.storage.hero.HeroDescription;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.model.user.specialoffer.PlayerNextPaymentRewardSpecialOffer;
   import game.stat.Stash;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.popup.common.IPopupSideBarBlock;
   import game.view.popup.common.PopupSideBarSide;
   import starling.core.Starling;
   
   public class SpecialOfferNextPaymentRewardView extends GuiClipLayoutContainer implements IPopupSideBarBlock, INeedNestedParsing
   {
      
      private static const CLIP:String = "special_offer_payment_hero_billings";
       
      
      private var data:PlayerNextPaymentRewardSpecialOffer;
      
      private var _stashParams:PopupStashEventParams;
      
      private var heroView:HeroView;
      
      private var heroLoader:HeroAssetProvider;
      
      public var button_details:ClipButtonLabeled;
      
      public var tf_header:ClipLabel;
      
      public var tf_description:ClipLabel;
      
      public var tf_timer:ClipLabel;
      
      public var layout_description:ClipLayout;
      
      public var animation_front:GuiAnimation;
      
      public var animation_back1:GuiAnimation;
      
      public var animation_back2:GuiAnimation;
      
      public var animation_back3:GuiAnimation;
      
      public var layout_hero:GuiClipContainer;
      
      public var layout_hitArea:ClipLayout;
      
      public function SpecialOfferNextPaymentRewardView(param1:PlayerNextPaymentRewardSpecialOffer)
      {
         heroLoader = new HeroAssetProvider(handler_assetLoaded);
         tf_description = new ClipLabel();
         layout_description = ClipLayout.horizontalMiddleCentered(0,tf_description);
         animation_front = new GuiAnimation();
         animation_back1 = new GuiAnimation();
         animation_back2 = new GuiAnimation();
         animation_back3 = new GuiAnimation();
         layout_hero = new GuiClipContainer();
         layout_hitArea = ClipLayout.none(animation_back1,animation_back2,animation_back3,layout_hero,animation_front);
         super();
         this.data = param1;
         AssetStorage.rsx.asset_bundle.initGuiClip(this,"special_offer_payment_hero_billings");
         tf_description.text = Translate.translate("UI_SPECIALOFFER_PAYMENT_REPEAT_LILITH");
         button_details.initialize(Translate.translate("UI_SPECIALOFFER_BUTTON_DETAILS"),handler_buttonClick);
         heroView = new HeroView();
         heroView.addToParent(layout_hero.container);
         var _loc2_:HeroDescription = param1.heroDescription;
         if(_loc2_)
         {
            heroLoader.request(_loc2_.id);
            tf_header.text = _loc2_.name;
         }
         param1.signal_updated.add(handler_updateProgress);
         param1.signal_removed.add(handler_removed);
         handler_updateProgress();
      }
      
      public function dispose() : void
      {
         data.signal_updated.remove(handler_updateProgress);
         data.signal_removed.remove(handler_removed);
         heroView.dispose();
         heroLoader.dispose();
      }
      
      public function get popupOffset() : Number
      {
         return 50;
      }
      
      public function get popupGap() : Number
      {
         return 0;
      }
      
      public function get popupSide() : PopupSideBarSide
      {
         return PopupSideBarSide.left;
      }
      
      public function initialize(param1:PopupStashEventParams) : void
      {
         this._stashParams = param1;
         var _loc2_:Rectangle = animation_back3.graphics.getBounds(layoutGroup);
         layoutGroup.width = int(_loc2_.width + _loc2_.x * 2) - 10;
         layoutGroup.height = int(_loc2_.height + _loc2_.y * 2) - 50;
      }
      
      private function handler_assetLoaded(param1:HeroRsxAssetDisposable) : void
      {
         heroView.applyAsset(param1.getHeroData());
         heroView.updatePosition();
         Starling.juggler.add(heroView);
      }
      
      private function handler_updateProgress() : void
      {
         tf_timer.text = data.timerString;
      }
      
      protected function handler_removed() : void
      {
         container.touchable = false;
         dispose();
      }
      
      private function handler_buttonClick() : void
      {
         if(data)
         {
            data.action_details(true,Stash.click("specialOffer:" + data.id,_stashParams));
         }
      }
   }
}
