package game.view.popup.summoningcircle
{
   import com.progrestar.common.lang.Translate;
   import engine.core.assets.AssetProgressProvider;
   import engine.core.clipgui.GuiAnimation;
   import feathers.controls.LayoutGroup;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.data.storage.titan.TitanDescription;
   import game.model.user.specialoffer.SpecialOfferViewSlot;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipProgressBar;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.AsyncClipBasedPopup;
   import game.view.popup.chest.ChestPopupTitle;
   import game.view.popup.common.PopupReloadController;
   import game.view.popup.summoningcircle.portrait.TitanPortraitButton;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   import starling.filters.BlurFilter;
   
   public class SummoningCirclePopUp extends AsyncClipBasedPopup implements ITutorialNodePresenter, ITutorialActionProvider
   {
       
      
      private var mediator:SummoningCirclePopUpMediator;
      
      private var clip:SummoningCirclePopUpClip;
      
      private var popupTitle:ChestPopupTitle;
      
      private var slotButtonPack:SpecialOfferViewSlot;
      
      private var slotButtonPack10:SpecialOfferViewSlot;
      
      private var slotSphere:SpecialOfferViewSlot;
      
      private var reloadController:PopupReloadController;
      
      private var progressbar:ClipProgressBar;
      
      private var assetProgress:AssetProgressProvider;
      
      public function SummoningCirclePopUp(param1:SummoningCirclePopUpMediator)
      {
         super(param1,AssetStorage.rsx.clan_screen);
         this.mediator = param1;
         reloadController = new PopupReloadController(this,param1);
         param1.signal_summonKeyCoinUpdate.add(handler_summonKeyCoinUpdate);
         param1.signal_starmoneySpent.add(updateX10);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         reloadController.dispose();
         if(mediator.dungeonActivityPoints)
         {
            mediator.dungeonActivityPoints.unsubscribe(onChangeDungeonActivityPoints);
         }
         if(slotButtonPack)
         {
            slotButtonPack.dispose();
         }
         if(slotButtonPack10)
         {
            slotButtonPack10.dispose();
         }
         if(slotSphere)
         {
            slotSphere.dispose();
         }
         mediator.signal_summonKeyCoinUpdate.remove(handler_summonKeyCoinUpdate);
         mediator.signal_starmoneySpent.remove(updateX10);
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.CLAN_SUMMONING_CIRCLE;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         if(clip)
         {
            _loc2_.addButton(TutorialNavigator.ACTION_CLAN_SUMMONING_CIRCLE_ONE,clip.cost_button_single);
            _loc2_.addButton(TutorialNavigator.ACTION_CLAN_SUMMONING_CIRCLE_PACK,clip.cost_button_pack);
            _loc2_.addCloseButton(clip.button_close);
         }
         return _loc2_;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
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
         var _loc4_:* = null;
         var _loc8_:* = null;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc3_:* = null;
         if(_isDisposed)
         {
            return;
         }
         height = 640;
         if(progressbar)
         {
            removeChild(progressbar.graphics);
         }
         clip = AssetStorage.rsx.clan_screen.create(SummoningCirclePopUpClip,"summoning_circle_popup");
         addChild(clip.graphics);
         mediator.specialOfferHooks.registerSummoningCirclePopupClip(clip);
         popupTitle = new ChestPopupTitle(Translate.translate("UI_DIALOG_SUMMONING_CIRCLE"),clip.header_layout_container);
         popupTitle.minBgWidth = 550;
         clip.line_top.container.filter = BlurFilter.createGlow(0,1,1,1);
         clip.line_bottom.container.filter = BlurFilter.createGlow(0,1,1,1);
         clip.button_close.signal_click.add(mediator.close);
         clip.bg_image.graphics.y = 0;
         clip.bg_container.addChild(clip.bg_image.graphics);
         clip.bg_container.clipContent = true;
         clip.tf_desc.text = Translate.translate("UI_DUNGEON_VIEW_MAIN_TF_TITANITE");
         clip.tf_receive.text = Translate.translate("UI_DIALOG_SUMMONING_CIRCLE_RECEIVE");
         clip.tf_open_pack.text = Translate.translate("UI_DIALOG_SUMMONING_CIRCLE_OPEN_PACK");
         clip.tf_open_pack10.text = Translate.translateArgs("UI_DIALOG_SUMMONING_CIRCLE_OPEN_N",mediator.packX10Amount);
         clip.btn_navigate.label = Translate.translate("LIB_MECHANIC_NAVIGATE_CLAN_DUNGEON");
         clip.btn_navigate.signal_click.add(handler_navigateButtonClick);
         clip.cost_button_pack.cost = mediator.openPaidCost;
         clip.cost_button_pack10.cost = mediator.openCostX10;
         clip.cost_button_single.signal_click.add(handler_costButtonSingleClick);
         clip.cost_button_pack.signal_click.add(handler_costButtonPackClick);
         clip.cost_button_pack10.signal_click.add(handler_costButtonPack10Click);
         if(mediator.x10Avaliable)
         {
            slotButtonPack10 = new SpecialOfferViewSlot(clip.cost_button_pack10.graphics,mediator.specialOfferHooks.summoningCircleOpenPack10);
         }
         else
         {
            slotButtonPack = new SpecialOfferViewSlot(clip.cost_button_pack.graphics,mediator.specialOfferHooks.summoningCircleOpenPack);
         }
         slotSphere = new SpecialOfferViewSlot(clip.anim_idle.graphics,mediator.specialOfferHooks.summoningCircleSphere);
         if(clip.buttons_layout_group.numChildren > 3)
         {
            _loc4_ = new LayoutGroup();
            _loc4_.width = !!mediator.x10Avaliable?60:100;
            clip.labels_layout_group.addChild(_loc4_);
         }
         var _loc2_:Vector.<TitanDescription> = mediator.titanSimpleList;
         _loc5_ = 0;
         while(_loc5_ < 9)
         {
            if(_loc5_ < _loc2_.length)
            {
               _loc8_ = new TitanPortraitButton();
               _loc8_.signal_click.add(mediator.action_showTitanInfo);
               var _loc9_:* = 0.75;
               _loc8_.scaleY = _loc9_;
               _loc8_.scaleX = _loc9_;
               _loc8_.dataDesc = _loc2_[_loc5_];
               (clip["slot" + (_loc5_ + 1)] as ClipLayout).addChild(_loc8_);
            }
            _loc5_++;
         }
         _loc2_ = mediator.titanUltraList;
         _loc7_ = 0;
         while(_loc7_ < 3)
         {
            if(_loc7_ < _loc2_.length)
            {
               _loc8_ = new TitanPortraitButton();
               _loc8_.signal_click.add(mediator.action_showTitanInfo);
               _loc8_.dataDesc = _loc2_[_loc7_];
               _loc6_ = clip["slotUltra" + (_loc7_ + 1)] as ClipLayout;
               _loc3_ = AssetStorage.rsx.chest_graphics.create(GuiAnimation,"heroitem_highlight_spot");
               _loc6_.addChild(_loc3_.graphics);
               _loc6_.addChild(_loc8_);
            }
            _loc7_++;
         }
         if(mediator.dungeonActivityPoints)
         {
            mediator.dungeonActivityPoints.onValue(onChangeDungeonActivityPoints);
         }
         onChangeDungeonActivityPoints(mediator.dungeonActivityPoints.value);
         mediator.signal_resetTimeUpdate.add(handler_updateTime);
         updateResetTime();
         mediator.action_updateClanActivity();
         Tutorial.updateActionsFrom(this);
         updateFreeOpenBlock();
         updateX10();
      }
      
      private function updateResetTime() : void
      {
         clip.tf_timer.text = Translate.translateArgs("UI_DIALOG_SUMMONING_CIRCLE_TIMER",ColorUtils.hexToRGBFormat(16645626) + mediator.timeLeft);
      }
      
      private function updateFreeOpenBlock() : void
      {
         clip.tf_open_single.text = Translate.translateArgs("UI_DIALOG_SUMMONING_CIRCLE_OPEN_N",mediator.openFreeMultiplier);
         clip.cost_button_single.cost = mediator.openFreeCost;
      }
      
      private function updateX10() : void
      {
         clip.cost_button_pack10.graphics.visible = mediator.x10Avaliable;
         clip.tf_open_pack10.visible = mediator.x10Avaliable;
      }
      
      private function handler_costButtonPackClick() : void
      {
         mediator.action_summon(true,mediator.packValueX1);
      }
      
      private function handler_costButtonPack10Click() : void
      {
         mediator.action_summon(true,mediator.packValueX10);
      }
      
      private function handler_costButtonSingleClick() : void
      {
         mediator.action_summon(false,mediator.openFreeMultiplier);
      }
      
      private function handler_updateTime() : void
      {
         updateResetTime();
      }
      
      private function handler_navigateButtonClick() : void
      {
         mediator.action_navigate_dungeon();
      }
      
      private function onChangeDungeonActivityPoints(param1:int) : void
      {
         clip.progress_titanite.value = param1;
         clip.progress_titanite.maxValue = mediator.dungeonActivityForNextKey;
         clip.reward_item.graphics.visible = mediator.dungeonRewardForNextKey;
         clip.reward_item.setData(mediator.dungeonRewardForNextKey);
      }
      
      private function handler_assetProgress(param1:AssetProgressProvider) : void
      {
         if(progressbar)
         {
            progressbar.maxValue = param1.progressTotal;
            progressbar.value = param1.progressCurrent;
         }
      }
      
      private function handler_summonKeyCoinUpdate() : void
      {
         updateFreeOpenBlock();
      }
   }
}
