package game.view.specialoffer.nextpaymentreward
{
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.INeedNestedParsing;
   import game.assets.HeroAssetProvider;
   import game.assets.HeroRsxAssetDisposable;
   import game.assets.storage.AssetStorage;
   import game.battle.view.hero.HeroView;
   import game.data.storage.hero.HeroDescription;
   import game.model.user.specialoffer.PlayerNextPaymentRewardSpecialOffer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.reward.GuiElementExternalStyle;
   import game.view.popup.reward.RelativeAlignment;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import starling.filters.BlurFilter;
   import starling.filters.ColorMatrixFilter;
   
   public class SpecialOfferNextPaymentHeroView extends ClipButton implements INeedNestedParsing
   {
       
      
      private var data:PlayerNextPaymentRewardSpecialOffer;
      
      private var heroView:HeroView;
      
      private var heroLoader:HeroAssetProvider;
      
      private var heroViewContainer:Sprite;
      
      public var animation_rays:GuiAnimation;
      
      public var animation_sparkles:GuiAnimation;
      
      public var layout_hero:GuiClipContainer;
      
      public var tf_time:ClipLabel;
      
      public const displayStyle:GuiElementExternalStyle = new GuiElementExternalStyle();
      
      public function SpecialOfferNextPaymentHeroView(param1:PlayerNextPaymentRewardSpecialOffer)
      {
         heroLoader = new HeroAssetProvider(handler_assetLoaded);
         layout_hero = new GuiClipContainer();
         super();
         this.data = param1;
         AssetStorage.rsx.asset_bundle.initGuiClip(this,"special_offer_payment_hero");
         animation_rays.graphics.touchable = false;
         animation_sparkles.graphics.touchable = false;
         heroView = new HeroView();
         heroViewContainer = new Sprite();
         heroView.transform.setParent(heroViewContainer);
         layout_hero.container.addChild(heroViewContainer);
         var _loc2_:HeroDescription = param1.heroDescription;
         if(_loc2_)
         {
            heroLoader.request(_loc2_.id);
         }
         var _loc3_:RelativeAlignment = new RelativeAlignment("right","middle",false);
         _loc3_.paddingLeft = -95;
         _loc3_.paddingBottom = 20;
         displayStyle.setBackground(graphics,_loc3_);
         displayStyle.signal_dispose.add(dispose);
         param1.signal_updated.add(handler_updated);
         param1.signal_removed.add(handler_remove);
      }
      
      public function dispose() : void
      {
         signal_click.clear();
         data.signal_updated.remove(handler_updated);
         data.signal_removed.remove(handler_remove);
         displayStyle.signal_dispose.remove(dispose);
         displayStyle.dispose();
         Starling.juggler.remove(heroView);
         heroView.dispose();
         heroLoader.dispose();
         graphics.removeFromParent(true);
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         var _loc3_:DisplayObject = layout_hero.graphics;
         if(param1 == "hover")
         {
            _loc3_.filter = BlurFilter.createGlow(16777215,1,6,0.5);
         }
         else if(_loc3_.filter != null)
         {
            _loc3_.filter.dispose();
            _loc3_.filter = null;
         }
      }
      
      private function handler_assetLoaded(param1:HeroRsxAssetDisposable) : void
      {
         heroView.applyAsset(param1.getHeroData(0.6));
         heroView.updatePosition();
         var _loc2_:ColorMatrixFilter = new ColorMatrixFilter();
         _loc2_.tint(0,0.94);
         heroViewContainer.filter = _loc2_;
         Starling.juggler.add(heroView);
      }
      
      private function handler_updated() : void
      {
         tf_time.text = data.timerString;
      }
      
      private function handler_remove() : void
      {
         container.touchable = false;
         Starling.juggler.tween(graphics,0.5,{
            "alpha":0,
            "onComplete":displayStyle.dispose
         });
      }
   }
}
