package game.mechanics.titan_arena.popup
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import feathers.layout.TiledRowsLayout;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.data.storage.shop.ShopDescription;
   import game.data.storage.shop.StaticSlotsShopTabDescription;
   import game.mechanics.titan_arena.mediator.TitanArtifactShopPopupMediator;
   import game.mediator.gui.popup.shop.ShopSlotValueObject;
   import game.view.gui.components.toggle.ToggleGroup;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.common.PopupSideTab;
   import game.view.popup.shop.ShopPopup;
   import game.view.popup.shop.ShopPopupItemRenderer;
   import game.view.popup.shop.clanwar.ClanWarShopUpperTab;
   import starling.events.Event;
   
   public class TitanArtifactShopPopup extends ClipBasedPopup implements ITutorialActionProvider, ITutorialNodePresenter
   {
       
      
      private var mediator:TitanArtifactShopPopupMediator;
      
      private var clip:TitanArtifactShopPopupClip;
      
      private var toggle:ToggleGroup;
      
      private var upperTabsToggle:ToggleGroup;
      
      public function TitanArtifactShopPopup(param1:TitanArtifactShopPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "store_clanwar";
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.TITAN_VALLEY_MERCHANT;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:* = null;
         if(clip == null)
         {
            return TutorialActionsHolder.create(this);
         }
         _loc2_ = TutorialActionsHolder.create(clip.graphics);
         _loc2_.addCloseButton(clip.button_close);
         return _loc2_;
      }
      
      override protected function initialize() : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         super.initialize();
         ShopPopup.music.shopOpen();
         clip = AssetStorage.rsx.popup_theme.create(TitanArtifactShopPopupClip,"dialog_shop_titan_artifact");
         addChild(clip.graphics);
         centerPopupBy(clip.dialog_frame.graphics,50,25);
         clip.list.itemRendererType = ShopPopupItemRenderer;
         clip.list.addEventListener("rendererAdd",onListRendererAdded);
         clip.list.addEventListener("rendererRemove",onListRendererRemoved);
         var _loc3_:TiledRowsLayout = new TiledRowsLayout();
         _loc3_.useSquareTiles = false;
         _loc3_.gap = 5;
         var _loc6_:int = 10;
         _loc3_.paddingBottom = _loc6_;
         _loc3_.paddingTop = _loc6_;
         clip.list.layout = _loc3_;
         clip.list.interactionMode = "mouse";
         clip.list.scrollBarDisplayMode = "fixed";
         clip.list.horizontalScrollPolicy = "off";
         clip.list.verticalScrollPolicy = "on";
         clip.tf_header.text = mediator.name;
         clip.button_close.signal_click.add(mediator.close);
         var _loc1_:VerticalLayout = new VerticalLayout();
         _loc1_.gap = -12;
         clip.tab_layout_container.layoutGroup.layout = _loc1_;
         upperTabsToggle = new ToggleGroup();
         upperTabsToggle.signal_updateSelectedItem.add(handler_upperTabSelected);
         mediator.upperTabsVector.onValue(handler_upperTabs);
         toggle = new ToggleGroup();
         var _loc2_:int = mediator.tabs.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = createButton(mediator.tabs[_loc4_],_loc4_);
            toggle.addItem(_loc5_);
            clip.tab_layout_container.layoutGroup.addChild(_loc5_.graphics);
            _loc4_++;
         }
         if(_loc2_ > 6)
         {
            _loc1_.verticalAlign = "middle";
         }
         else
         {
            _loc1_.paddingTop = 50;
         }
         toggle.selectedIndex = mediator.tabs.indexOf(mediator.shop);
         toggle.signal_updateSelectedItem.add(handler_tabSelected);
         mediator.dataIsUpToDate.onValue(handler_dataIsUpToDate);
         clip.tf_refresh_text.text = Translate.translate("UI_SHOP_REFRESH_AT");
         mediator.signal_shopUpdate.add(mediator_onShopUpdate);
         mediator.signal_slotUpdate.add(mediator_onSlotUpdate);
         mediator.signal_refreshTimeUpdate.add(handler_refreshTimeUpdate);
         mediator.signal_refreshCostUpdate.add(handler_refillCostUpdate);
         handler_refillCostUpdate();
         mediator.action_getShop();
         clip.refresh_button.signal_click.add(mediator.action_refreshShop);
         clip.tf_voucher_goods_desc.text = Translate.translate("UI_DIALOG_SHOP_TITAN_ARTIFACT_TF_VOUCHER_GOODS_DESC");
      }
      
      protected function createUpperTabs(param1:Vector.<StaticSlotsShopTabDescription>) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc5_:* = null;
         upperTabsToggle.isSelectionRequired = false;
         upperTabsToggle.removeAllItems();
         var _loc2_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = param1[_loc4_];
            _loc5_ = createUpperTabButton(_loc3_.title);
            upperTabsToggle.addItem(_loc5_);
            clip.layout_upper_tabs.addChild(_loc5_.graphics);
            if(_loc4_ == _loc2_ - 1)
            {
               _loc5_.width = 120;
            }
            else
            {
               _loc5_.width = 192;
            }
            _loc4_++;
         }
         if(_loc2_ > 0)
         {
            upperTabsToggle.selectedIndex = mediator.upperTabIndex.value;
         }
         upperTabsToggle.isSelectionRequired = true;
      }
      
      protected function createUpperTabButton(param1:String) : ClanWarShopUpperTab
      {
         var _loc2_:ClanWarShopUpperTab = AssetStorage.rsx.popup_theme.create(ClanWarShopUpperTab,clip.clip_upper_tab.clip.className);
         var _loc3_:* = param1;
         _loc2_.tf_text_selected.text = _loc3_;
         _loc2_.tf_text.text = _loc3_;
         return _loc2_;
      }
      
      protected function handler_upperTabs(param1:Vector.<StaticSlotsShopTabDescription>) : void
      {
         if(param1)
         {
            clip.layout_upper_tabs.removeChildren(0,-1,true);
            createUpperTabs(param1);
         }
      }
      
      private function createButton(param1:ShopDescription, param2:int) : PopupSideTab
      {
         var _loc3_:PopupSideTab = AssetStorage.rsx.popup_theme.create(PopupSideTab,"dialog_side_tab_shop");
         _loc3_.label = Translate.translate("UI_TITAN_ARTIFACT_SHOP_TAB_" + (param2 + 1));
         return _loc3_;
      }
      
      private function updateRefillCost() : void
      {
         clip.tf_voucher_goods_desc.visible = mediator.refreshCost == null;
         clip.refresh_block_layout_container.graphics.visible = mediator.refreshCost;
         clip.cost_panel.graphics.visible = true;
         if(mediator.refreshCost)
         {
            clip.cost_panel.costData = mediator.refreshCost.outputDisplay[0];
         }
      }
      
      private function onListRendererAdded(param1:Event, param2:ShopPopupItemRenderer) : void
      {
         param2.signal_buySlot.add(onBuySignal);
         param2.signal_showInfo.add(onShowInfoSignal);
      }
      
      private function onListRendererRemoved(param1:Event, param2:ShopPopupItemRenderer) : void
      {
         param2.signal_buySlot.remove(onBuySignal);
         param2.signal_showInfo.remove(onShowInfoSignal);
      }
      
      private function onShowInfoSignal(param1:ShopSlotValueObject) : void
      {
         mediator.action_showInfo(param1);
      }
      
      private function onBuySignal(param1:ShopSlotValueObject) : void
      {
         mediator.action_buySlot(param1);
      }
      
      private function handler_tabSelected() : void
      {
         mediator.action_selectTab(toggle.selectedIndex);
      }
      
      private function handler_upperTabSelected() : void
      {
         mediator.action_selectUpperTab(upperTabsToggle.selectedIndex);
      }
      
      private function handler_dataIsUpToDate(param1:Boolean) : void
      {
         clip.list.touchable = param1;
      }
      
      private function handler_refreshTimeUpdate() : void
      {
         clip.tf_refresh_time.text = mediator.nextRefreshTime;
      }
      
      private function handler_refillCostUpdate() : void
      {
         updateRefillCost();
      }
      
      private function mediator_onShopUpdate() : void
      {
         clip.list.dataProvider = new ListCollection(mediator.itemList);
         clip.tf_header.text = mediator.name;
      }
      
      private function mediator_onSlotUpdate() : void
      {
      }
   }
}
