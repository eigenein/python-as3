package game.view.popup.shop
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import feathers.layout.TiledRowsLayout;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.data.storage.shop.ShopDescription;
   import game.mediator.gui.popup.shop.ShopPopupMediator;
   import game.mediator.gui.popup.shop.ShopSlotValueObject;
   import game.view.gui.components.toggle.ToggleGroup;
   import game.view.gui.homescreen.ShopHoverSound;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.IEscClosable;
   import game.view.popup.common.PopupSideTab;
   import game.view.popup.common.PopupTitle;
   import starling.events.Event;
   
   public class ShopPopup extends ClipBasedPopup implements IEscClosable, ITutorialNodePresenter
   {
      
      private static var _music:ShopHoverSound;
      
      public static const MIN_TABS_TO_VERTICAL_ALIGN_MIDDLE:int = 6;
       
      
      private var mediator:ShopPopupMediator;
      
      private var clip:ShopRsxPopupClip;
      
      private var toggle:ToggleGroup;
      
      private var header:PopupTitle;
      
      public function ShopPopup(param1:ShopPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "store";
         param1.signal_shopUpdate.add(mediator_onShopUpdate);
         param1.signal_slotUpdate.add(mediator_onSlotUpdate);
         param1.signal_refreshTimeUpdate.add(handler_refreshTimeUpdate);
         param1.signal_refreshCostUpdate.add(handler_refillCostUpdate);
      }
      
      public static function get music() : ShopHoverSound
      {
         if(!_music)
         {
            _music = new ShopHoverSound(3,1,AssetStorage.sound.shopHover);
         }
         return _music;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _music.shopClosed();
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.SHOP;
      }
      
      override protected function initialize() : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         super.initialize();
         _music.shopOpen();
         clip = AssetStorage.rsx.popup_theme.create_dialog_shop();
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
         clip.cost_panel.graphics.visible = false;
         header = PopupTitle.create(mediator.name,clip.header_layout_container);
         if(!mediator.itemList.length)
         {
            mediator.action_getShop();
         }
         clip.button_close.signal_click.add(mediator.close);
         clip.refresh_button.signal_click.add(mediator.action_refreshShop);
         clip.tf_refresh_text.text = Translate.translate("UI_SHOP_REFRESH_AT");
         var _loc1_:VerticalLayout = new VerticalLayout();
         _loc1_.gap = -12;
         clip.tab_layout_container.layoutGroup.layout = _loc1_;
         toggle = new ToggleGroup();
         var _loc2_:int = mediator.tabs.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = createButton(mediator.tabs[_loc4_]);
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
      }
      
      private function createButton(param1:ShopDescription) : PopupSideTab
      {
         var _loc2_:PopupSideTab = AssetStorage.rsx.popup_theme.create(PopupSideTab,"dialog_side_tab_shop");
         _loc2_.label = param1.name;
         return _loc2_;
      }
      
      private function updateRefillCost() : void
      {
         clip.cost_panel.graphics.visible = true;
         if(mediator.hasRefillable)
         {
            clip.cost_panel.costData = mediator.refreshCost.outputDisplayFirst;
            clip.refresh_block_layout_container.graphics.visible = true;
         }
         else
         {
            clip.refresh_block_layout_container.graphics.visible = false;
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
      
      private function mediator_onSlotUpdate(param1:ShopSlotValueObject) : void
      {
      }
      
      private function mediator_onShopUpdate() : void
      {
         clip.list.dataProvider = new ListCollection(mediator.itemList);
         header.text = mediator.name;
      }
      
      private function handler_refreshTimeUpdate() : void
      {
         clip.tf_refresh_time.text = mediator.nextRefreshTime;
      }
      
      private function handler_tabSelected() : void
      {
         mediator.action_selectTab(toggle.selectedIndex);
      }
      
      private function handler_refillCostUpdate() : void
      {
         updateRefillCost();
      }
   }
}
