package game.mechanics.expedition.popup
{
   import engine.core.assets.AssetList;
   import engine.core.assets.RequestableAsset;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.data.storage.DataStorage;
   import game.mechanics.expedition.mediator.ExpeditionBriefingPopupMediator;
   import game.view.gui.components.HeroPreview;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   
   public class ExpeditionBriefingPopup extends AsyncClipBasedPopupWithPreloader
   {
       
      
      private var mediator:ExpeditionBriefingPopupMediator;
      
      private var heroPreview:HeroPreview;
      
      private var clip:ExpeditionBriefingPopupClip;
      
      private var heroWinTimer:int;
      
      private var _progressAsset:RequestableAsset;
      
      public function ExpeditionBriefingPopup(param1:ExpeditionBriefingPopupMediator)
      {
         this.mediator = param1;
         super(param1,AssetStorage.rsx.dialog_expedition);
         var _loc2_:AssetList = new AssetList();
         _loc2_.addAssets(AssetStorage.rsx.dialog_zeppelin,AssetStorage.rsx.dialog_expedition);
         _progressAsset = _loc2_;
         AssetStorage.instance.globalLoader.requestAsset(_loc2_);
      }
      
      override public function dispose() : void
      {
         clearTimeout(heroWinTimer);
         if(heroPreview)
         {
            heroPreview.dispose();
         }
         super.dispose();
      }
      
      override protected function get progressAsset() : RequestableAsset
      {
         return _progressAsset;
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         var _loc2_:* = null;
         super.onAssetLoaded(param1);
         clip = AssetStorage.rsx.dialog_expedition.create(ExpeditionBriefingPopupClip,"dialog_expedition_briefing");
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         if(mediator.expedition.storyDesc_unitId)
         {
            heroPreview = new HeroPreview();
            var _loc4_:* = mediator.expedition.storyDesc_assetScale;
            heroPreview.graphics.scaleY = _loc4_;
            heroPreview.graphics.scaleX = _loc4_;
            clip.hero_position_after.container.addChild(heroPreview.graphics);
            heroPreview.graphics.touchable = false;
            _playWinAnimation(true);
            heroPreview.loadHero(DataStorage.hero.getUnitById(mediator.expedition.storyDesc_unitId));
         }
         else
         {
            _loc2_ = AssetStorage.rsx.dialog_zeppelin.create(GuiAnimation,"val_idle_expedition_briefing");
            clip.hero_position_after.container.addChild(_loc2_.graphics);
         }
         clip.item.setData(mediator.expedition,mediator);
         var _loc3_:ClipSprite = AssetStorage.rsx.asset_bundle.create(ClipSprite,"skin_background");
         clip.skin_bg.container.addChild(_loc3_.container);
         clip.button_close.signal_click.add(close);
         clip.item.button_lock_info.signal_click.add(handler_lockButtonClick);
      }
      
      private function _playWinAnimation(param1:Boolean = false) : void
      {
         heroWinTimer = setTimeout(_playWinAnimation,!!param1?1000:Number(3000 + Math.random() * (!!param1?0:Number(3500))));
         if(heroPreview)
         {
            if(Math.random() > 0.5)
            {
               heroPreview.attack();
            }
            else
            {
               heroPreview.win();
            }
         }
      }
      
      private function handler_lockButtonClick() : void
      {
         mediator.action_navigateToExpeditionUnlock();
      }
   }
}
