package game.view.popup.threeboxes
{
   import com.progrestar.common.lang.Translate;
   import engine.core.assets.AssetProgressProvider;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipImage;
   import feathers.data.ListCollection;
   import feathers.layout.TiledRowsLayout;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipProgressBar;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.IEscClosable;
   import game.view.popup.chest.ChestPopupTitle;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   import game.view.popup.threeboxes.easter.EasterFullScreenPopUpBg;
   import starling.animation.Tween;
   import starling.core.Starling;
   
   public class ThreeBoxesFullScreenPopUp extends ClipBasedPopup implements IEscClosable
   {
       
      
      private var mediator:ThreeBoxesFullScreenPopUpMediator;
      
      private var graph:EasterFullScreenPopUpBg;
      
      private var clipThreeBoxes:ThreeBoxesFullScreenPopUpClip;
      
      private var clipCurrentBox:ThreeBoxesFullScreenPopUpCurrentBoxClip;
      
      private var popupTitle:ChestPopupTitle;
      
      private var currentBoxPopupTitle:ChestPopupTitle;
      
      private var assetProgress:AssetProgressProvider;
      
      private var progressbar:ClipProgressBar;
      
      private var tweenBlindSide:Tween;
      
      private var tweenClip:Tween;
      
      public function ThreeBoxesFullScreenPopUp(param1:ThreeBoxesFullScreenPopUpMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         AssetStorage.instance.globalLoader.cancelCallback(handler_assetLoaded);
         if(mediator != null)
         {
            mediator.signalTimerUpdate.remove(onTimerUpdate);
            mediator.signalRefillableUpdate.remove(handler_refillableUpdate);
         }
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         width = 1000;
         height = 650;
         if(AssetStorage.rsx.easter_graphics.completed)
         {
            handler_assetLoaded(AssetStorage.rsx.easter_graphics);
         }
         else
         {
            progressbar = AssetStorage.rsx.popup_theme.create_component_progressbar();
            progressbar.graphics.x = int((Starling.current.stage.stageWidth - progressbar.graphics.width) / 2);
            progressbar.graphics.y = int((Starling.current.stage.stageHeight - progressbar.graphics.height) / 2);
            addChild(progressbar.graphics);
            AssetStorage.instance.globalLoader.requestAssetWithCallback(AssetStorage.rsx.easter_graphics,handler_assetLoaded);
            assetProgress = AssetStorage.instance.globalLoader.getAssetProgress(AssetStorage.rsx.easter_graphics);
            if(!assetProgress.completed)
            {
               assetProgress.signal_onProgress.add(handler_assetProgress);
               handler_assetProgress(assetProgress);
            }
         }
      }
      
      private function $initialize() : void
      {
         graph = AssetStorage.rsx.easter_graphics.create(EasterFullScreenPopUpBg,"easter_popup_graphic");
         addChild(graph.graphics);
         graph.blindSideRight.graphics.x = graph.graphics.width + graph.blindSideRight.graphics.width;
         graph.blindSideLeft.graphics.x = -graph.blindSideLeft.graphics.width;
         clipThreeBoxes = AssetStorage.rsx.popup_theme.create(ThreeBoxesFullScreenPopUpClip,"three_box_popup_gui");
         addChild(clipThreeBoxes.graphics);
         popupTitle = new ChestPopupTitle(mediator.popupTitle,clipThreeBoxes.header_layout_container);
         popupTitle.minBgWidth = 600;
         var _loc1_:GuiAnimation = AssetStorage.rsx.easter_graphics.create(GuiAnimation,"three_eggs");
         clipThreeBoxes.three_boxes_place_holder.container.addChild(_loc1_.graphics);
         clipThreeBoxes.info_text.text = Translate.translate("UI_DIALOG_THREE_BOXES_INFO");
         clipThreeBoxes.button_open_1.label = Translate.translate("UI_DIALOG_BOSS_CHEST_OPEN");
         clipThreeBoxes.button_open_2.label = Translate.translate("UI_DIALOG_BOSS_CHEST_OPEN");
         clipThreeBoxes.button_open_3.label = Translate.translate("UI_DIALOG_BOSS_CHEST_OPEN");
         clipThreeBoxes.button_open_1.signal_click.add(handler_openBox1ButtonClick);
         clipThreeBoxes.button_open_2.signal_click.add(handler_openBox2ButtonClick);
         clipThreeBoxes.button_open_3.signal_click.add(handler_openBox3ButtonClick);
         clipThreeBoxes.tf_box_1.text = mediator.getTitleByBox(mediator.box1);
         clipThreeBoxes.tf_box_2.text = mediator.getTitleByBox(mediator.box2);
         clipThreeBoxes.tf_box_3.text = mediator.getTitleByBox(mediator.box3);
         fillDrop(clipThreeBoxes.layout_box_1,mediator.getDropByBox(mediator.box1));
         fillDrop(clipThreeBoxes.layout_box_2,mediator.getDropByBox(mediator.box2));
         fillDrop(clipThreeBoxes.layout_box_3,mediator.getDropByBox(mediator.box3));
         clipThreeBoxes.button_close.signal_click.add(mediator.close);
         clipCurrentBox = AssetStorage.rsx.popup_theme.create(ThreeBoxesFullScreenPopUpCurrentBoxClip,"three_box_popup_current_box_gui");
         addChild(clipCurrentBox.graphics);
         currentBoxPopupTitle = new ChestPopupTitle("",clipCurrentBox.header_layout_container);
         currentBoxPopupTitle.minBgWidth = 600;
         clipCurrentBox.reward_text.text = Translate.translate("UI_DIALOG_THREE_BOXES_REWARD");
         clipCurrentBox.btn_back.label = Translate.translate("UI_DIALOG_CHEST_BUTTON_BACK");
         clipCurrentBox.btn_back.signal_click.add(handler_backButtonClick);
         clipCurrentBox.list.list.layout = new TiledRowsLayout();
         (clipCurrentBox.list.list.layout as TiledRowsLayout).horizontalGap = 5;
         (clipCurrentBox.list.list.layout as TiledRowsLayout).verticalGap = 5;
         clipCurrentBox.tf_open_single.text = Translate.translateArgs("UI_DIALOG_CHEST_BUTTON_GET_PACK",1);
         clipCurrentBox.tf_open_pack.text = Translate.translateArgs("UI_DIALOG_CHEST_BUTTON_GET_PACK",10);
         clipCurrentBox.tf_discount.text = Translate.translateArgs("UI_POPUP_BUNDLE_DISCOUNT",20);
         clipCurrentBox.free_button_single.label = Translate.translate("UI_DIALOG_CHEST_FREE");
         clipCurrentBox.free_button_single.signal_click.add(handler_boxOpenFree);
         clipCurrentBox.cost_button_single.signal_click.add(handler_boxBuySingle);
         clipCurrentBox.cost_button_pack.signal_click.add(handler_boxBuyPack);
         mediator.signalTimerUpdate.add(onTimerUpdate);
         mediator.signalRefillableUpdate.add(handler_refillableUpdate);
         updateClips();
      }
      
      private function fillDrop(param1:ClipLayout, param2:Vector.<InventoryItem>) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         param1.removeChildren();
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            _loc3_ = AssetStorage.rsx.popup_theme.create(InventoryItemRenderer,"inventory_item_small");
            _loc3_.setData(param2[_loc4_]);
            param1.addChild(_loc3_.graphics);
            _loc4_++;
         }
      }
      
      private function updateClips(param1:Boolean = false) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = NaN;
         mediator.updateTime();
         if(mediator.currentBox)
         {
            currentBoxPopupTitle.text = mediator.getTitleByBox(mediator.currentBox);
            clipCurrentBox.list.list.dataProvider = new ListCollection(mediator.getDropByBox(mediator.currentBox));
            clipCurrentBox.cost_button_single.cost = mediator.currentBox.x1Cost.outputDisplay[0];
            clipCurrentBox.cost_button_pack.cost = mediator.currentBox.x10Cost.outputDisplay[0];
            clipCurrentBox.animation_place_holder.container.removeChildren();
            _loc3_ = AssetStorage.rsx.easter_graphics.create(GuiClipImage,mediator.currentBox.id + "_pillow");
            _loc3_.graphics.y = 40;
            clipCurrentBox.animation_place_holder.container.addChild(_loc3_.graphics);
            _loc2_ = AssetStorage.rsx.easter_graphics.create(GuiAnimation,mediator.currentBox.id + "_idle_animation");
            clipCurrentBox.animation_place_holder.container.addChild(_loc2_.graphics);
            handler_refillableUpdate();
         }
         else
         {
            clipThreeBoxes.marker_button_open_1.graphics.visible = mediator.getBoxAvailableFreeNowStatus(mediator.box1);
            clipThreeBoxes.marker_button_open_2.graphics.visible = mediator.getBoxAvailableFreeNowStatus(mediator.box2);
            clipThreeBoxes.marker_button_open_3.graphics.visible = mediator.getBoxAvailableFreeNowStatus(mediator.box3);
         }
         if(!param1)
         {
            if(mediator.currentBox)
            {
               graph.blindSideLeft.graphics.x = 0;
               clipThreeBoxes.graphics.x = -clipThreeBoxes.graphics.width;
            }
            else
            {
               graph.blindSideLeft.graphics.x = -graph.blindSideLeft.graphics.width;
               clipThreeBoxes.graphics.x = 0;
            }
            clipCurrentBox.graphics.x = clipThreeBoxes.graphics.x + clipThreeBoxes.graphics.width;
            graph.blindSideRight.graphics.x = clipThreeBoxes.graphics.width - graph.blindSideLeft.graphics.x;
            clipThreeBoxes.graphics.visible = mediator.currentBox == null;
            clipCurrentBox.graphics.visible = mediator.currentBox != null;
         }
         else
         {
            clearTweens();
            clipThreeBoxes.graphics.visible = true;
            clipCurrentBox.graphics.visible = true;
            _loc4_ = 0.4;
            if(mediator.currentBox)
            {
               tweenBlindSide = new Tween(graph.blindSideLeft.graphics,_loc4_,"easeOut");
               tweenBlindSide.onUpdate = tweenBlindSideUpdate;
               tweenBlindSide.animate("x",0);
               tweenBlindSide.animate("alpha",1);
               Starling.juggler.add(tweenBlindSide);
               tweenClip = new Tween(clipThreeBoxes.graphics,_loc4_,"easeOut");
               tweenClip.onUpdate = tweenUpdate;
               tweenClip.onComplete = clearTweens;
               tweenClip.animate("x",-clipThreeBoxes.graphics.width);
               tweenClip.animate("alpha",0);
               Starling.juggler.add(tweenClip);
            }
            else
            {
               tweenBlindSide = new Tween(graph.blindSideLeft.graphics,_loc4_,"easeOut");
               tweenBlindSide.onUpdate = tweenBlindSideUpdate;
               tweenBlindSide.animate("x",-graph.blindSideLeft.graphics.width);
               tweenBlindSide.animate("alpha",0);
               Starling.juggler.add(tweenBlindSide);
               tweenClip = new Tween(clipThreeBoxes.graphics,_loc4_,"easeOut");
               tweenClip.onUpdate = tweenUpdate;
               tweenClip.onComplete = clearTweens;
               tweenClip.animate("x",0);
               tweenClip.animate("alpha",1);
               Starling.juggler.add(tweenClip);
            }
         }
      }
      
      private function clearTweens() : void
      {
         if(tweenBlindSide)
         {
            Starling.juggler.remove(tweenBlindSide);
            tweenBlindSide = null;
         }
         if(tweenClip)
         {
            Starling.juggler.remove(tweenClip);
            tweenClip = null;
         }
      }
      
      private function tweenBlindSideUpdate() : void
      {
         graph.blindSideRight.graphics.x = clipThreeBoxes.graphics.width - graph.blindSideLeft.graphics.x;
      }
      
      private function tweenUpdate() : void
      {
         clipCurrentBox.graphics.x = clipThreeBoxes.graphics.x + clipThreeBoxes.graphics.width;
      }
      
      private function handler_assetProgress(param1:AssetProgressProvider) : void
      {
         if(progressbar)
         {
            progressbar.maxValue = param1.progressTotal;
            progressbar.value = param1.progressCurrent;
         }
      }
      
      protected function handler_assetLoaded(param1:RsxGuiAsset) : void
      {
         if(progressbar)
         {
            progressbar.graphics.removeFromParent(true);
            progressbar = null;
         }
         $initialize();
      }
      
      private function onTimerUpdate(param1:String) : void
      {
         clipThreeBoxes.timer_text.text = param1;
      }
      
      private function handler_refillableUpdate() : void
      {
         clipCurrentBox.free_button_single.graphics.visible = mediator.currentBoxAvailableFreeNow;
         clipCurrentBox.cost_button_single.graphics.visible = !mediator.currentBoxAvailableFreeNow;
         clipCurrentBox.tf_cooldown.text = mediator.currentBoxCooldownFormatted;
         clipCurrentBox.tf_cooldown.graphics.visible = true;
      }
      
      private function handler_boxOpenFree() : void
      {
         mediator.action_boxBuy(true,false);
      }
      
      private function handler_boxBuySingle() : void
      {
         mediator.action_boxBuy(false,false);
      }
      
      private function handler_boxBuyPack() : void
      {
         mediator.action_boxBuy(false,true);
      }
      
      private function handler_openBox1ButtonClick() : void
      {
         mediator.currentBox = mediator.box1;
         updateClips(true);
      }
      
      private function handler_openBox2ButtonClick() : void
      {
         mediator.currentBox = mediator.box2;
         updateClips(true);
      }
      
      private function handler_openBox3ButtonClick() : void
      {
         mediator.currentBox = mediator.box3;
         updateClips(true);
      }
      
      private function handler_backButtonClick() : void
      {
         mediator.currentBox = null;
         updateClips(true);
      }
   }
}
