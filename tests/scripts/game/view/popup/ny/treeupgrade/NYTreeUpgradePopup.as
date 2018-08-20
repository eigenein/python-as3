package game.view.popup.ny.treeupgrade
{
   import com.progrestar.common.lang.Translate;
   import engine.core.assets.AssetProgressProvider;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.command.rpc.ny.CommandNYTreeDecorate;
   import game.data.storage.rule.ny2018tree.NY2018TreeDecorateAction;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.model.user.specialoffer.NY2018SecretRewardOfferViewOwner;
   import game.view.gui.components.ClipProgressBar;
   import game.view.gui.components.tooltip.TooltipTextView;
   import game.view.gui.homescreen.HomeScreenNYVagonButton;
   import game.view.popup.AsyncClipBasedPopup;
   import game.view.popup.IEscClosable;
   import game.view.popup.chest.ChestPopupTitle;
   import game.view.popup.ny.gifts.UserNYGiftAnimationView;
   import starling.events.Event;
   
   public class NYTreeUpgradePopup extends AsyncClipBasedPopup implements IEscClosable
   {
       
      
      private var mediator:NYTreeUpgradePopupMediator;
      
      private var clip:NYTreeUpgradePopupClip;
      
      private var treeAnimation:HomeScreenNYVagonButton;
      
      private var popupTitle:ChestPopupTitle;
      
      private var giftAnimationView:UserNYGiftAnimationView;
      
      private var dropController:NYTreeUpgradePopupDropAnimationController;
      
      private var progressbar:ClipProgressBar;
      
      private var assetProgress:AssetProgressProvider;
      
      public function NYTreeUpgradePopup(param1:NYTreeUpgradePopupMediator)
      {
         dropController = new NYTreeUpgradePopupDropAnimationController();
         super(param1,AssetStorage.rsx.ny_gifts);
         this.mediator = param1;
         param1.signal_treeExpChange.add(handler_treeExpChange);
         param1.signal_treeLevelChange.add(handler_treeLevelChange);
         param1.signal_nyTreeCoinUpdate.add(handler_nyTreeCoinUpdate);
      }
      
      override public function dispose() : void
      {
         dropController.dispose();
         mediator.signal_treeExpChange.remove(handler_treeExpChange);
         mediator.signal_treeLevelChange.remove(handler_treeLevelChange);
         mediator.signal_nyTreeCoinUpdate.remove(handler_nyTreeCoinUpdate);
         TooltipHelper.removeTooltip(clip.gift_container.container);
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         addChild(dropController.graphics);
         addEventListener("enterFrame",handler_enterFrame);
         if(!asset.completed)
         {
            progressbar = AssetStorage.rsx.popup_theme.create_component_progressbar();
            addChild(progressbar.graphics);
            assetProgress = AssetStorage.instance.globalLoader.getAssetProgress(asset);
            if(!assetProgress.completed)
            {
               assetProgress.signal_onProgress.add(handler_assetProgress);
               handler_assetProgress(assetProgress);
            }
         }
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         if(_isDisposed)
         {
            return;
         }
         width = 1000;
         height = 650;
         if(progressbar)
         {
            removeChild(progressbar.graphics);
         }
         var _loc2_:GuiClipNestedContainer = param1.create(GuiClipNestedContainer,"bg_town");
         addChild(_loc2_.graphics);
         clip = param1.create(NYTreeUpgradePopupClip,"ny_tree_upgrade_popup_gui");
         addChild(clip.graphics);
         mediator.specialOfferHooks.registerNY2018SecretRewardOffer(new NY2018SecretRewardOfferViewOwner(clip.layout_giftdrop,this,"tree"));
         popupTitle = new ChestPopupTitle(Translate.translate("UI_DIALOG_NY_TREE_UPGRADE_HEADER"),clip.header_layout_container);
         popupTitle.minBgWidth = 550;
         TooltipHelper.addTooltip(clip.gift_container.container,new TooltipVO(TooltipTextView,Translate.translate("UI_DIALOG_NY_TREE_UPGRADE_DESC2")));
         clip.btn_close.signal_click.add(mediator.close);
         clip.tf_toys_left.text = Translate.translate("UI_DIALOG_NY_TREE_UPGRADE_TOYS");
         clip.decorate_renderer_1.setData(mediator.decorateActions[0]);
         clip.decorate_renderer_2.setData(mediator.decorateActions[1]);
         clip.decorate_renderer_3.setData(mediator.decorateActions[2]);
         updateDecorateRenderers();
         clip.decorate_renderer_1.signal_decorate.add(handler_decorate);
         clip.decorate_renderer_2.signal_decorate.add(handler_decorate);
         clip.decorate_renderer_3.signal_decorate.add(handler_firewoks);
         clip.tf_desc.text = Translate.translate("UI_DIALOG_NY_TREE_UPGRADE_DESC") + " " + Translate.translate("UI_DIALOG_NY_TREE_UPGRADE_DESC2");
         clip.tf_server.text = Translate.translateArgs("UI_DIALOG_NY_TREE_UPGRADE_SERVER",mediator.playerClanTitle);
         clip.btn_send.label = Translate.translate("UI_DIALOG_NY_TREE_UPGRADE_SEND_GIFTS");
         clip.btn_send.signal_click.add(mediator.action_showNYGifts);
         updateProgress();
         updateTreeState();
         updateGift();
         dropController.init(mediator,clip,treeAnimation);
      }
      
      private function updateDecorateRenderers() : void
      {
         clip.decorate_renderer_1.multiplier = mediator.decorateMultiplierNYTreeCoin;
      }
      
      private function updateTreeState() : void
      {
         if(!treeAnimation)
         {
            treeAnimation = AssetStorage.rsx.main_screen.create(HomeScreenNYVagonButton,"button_vagon");
            treeAnimation.container.touchable = false;
            treeAnimation.red_dot.graphics.visible = false;
            treeAnimation.labelBackground.graphics.visible = false;
            clip.tree_container.container.addChild(treeAnimation.graphics);
         }
         treeAnimation.setNYTreeLevel(mediator.nyTreeAssetLevel);
      }
      
      private function updateGift() : void
      {
         if(giftAnimationView)
         {
            giftAnimationView.signal_click.remove(handler_giftClick);
            giftAnimationView.graphics.removeFromParent();
         }
         giftAnimationView = AssetStorage.rsx.ny_gifts.create(UserNYGiftAnimationView,"user_" + mediator.currentGiftAsset);
         giftAnimationView.signal_click.add(handler_giftClick);
         var _loc1_:* = 0.4;
         giftAnimationView.container.scaleY = _loc1_;
         giftAnimationView.container.scaleX = _loc1_;
         giftAnimationView.giftOpened = false;
         clip.gift_container.container.addChild(giftAnimationView.graphics);
      }
      
      private function updateProgress() : void
      {
         clip.tf_level.text = Translate.translateArgs("UI_DIALOG_NY_TREE_UPGRADE_LEVEL",mediator.nyTreeDisplayedLevel);
         clip.progressbar_toys.minValue = 0;
         clip.progressbar_toys.maxValue = 100;
         clip.progressbar_toys.value = mediator.treeExpPercent;
         clip.tf_toys.text = mediator.treeExpPercentText;
      }
      
      private function handler_giftClick() : void
      {
         mediator.action_showNYGiftInfo(mediator.currentGift);
      }
      
      private function handler_treeExpChange() : void
      {
         updateProgress();
      }
      
      private function handler_treeLevelChange() : void
      {
         updateTreeState();
         updateGift();
      }
      
      private function handler_nyTreeCoinUpdate() : void
      {
         updateDecorateRenderers();
      }
      
      private function handler_assetProgress(param1:AssetProgressProvider) : void
      {
         if(progressbar)
         {
            progressbar.maxValue = param1.progressTotal;
            progressbar.value = param1.progressCurrent;
         }
      }
      
      private function handler_decorate(param1:NY2018TreeDecorateAction, param2:int) : void
      {
         if(!mediator.canDecorateNYTree(param1,param2))
         {
            mediator.action_decorateNYTree(param1,param2);
            return;
         }
         var _loc3_:CommandNYTreeDecorate = mediator.action_decorateNYTree(param1,param2);
         if(_loc3_ == null)
         {
            return;
         }
         dropController.animateDrop(param1,param2,_loc3_);
      }
      
      private function handler_firewoks(param1:NY2018TreeDecorateAction, param2:int) : void
      {
         mediator.action_fireworks();
      }
      
      private function handler_enterFrame(param1:Event) : void
      {
         dropController.advanceTime(Number(param1.data));
      }
   }
}
