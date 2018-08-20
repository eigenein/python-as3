package game.view.popup.shop.clanwar
{
   import feathers.layout.TiledRowsLayout;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.data.storage.shop.ShopDescription;
   import game.data.storage.shop.StaticSlotsShopTabDescription;
   import game.mediator.gui.popup.shop.ShopSlotValueObject;
   import game.mediator.gui.popup.shop.clanwar.ClanWarShopPopupMediator;
   import game.view.gui.components.toggle.ToggleGroup;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.common.PopupSideTab;
   import game.view.popup.shop.ShopPopup;
   import game.view.popup.shop.ShopPopupItemRenderer;
   import starling.events.Event;
   
   public class ClanWarShopPopup extends ClipBasedPopup
   {
       
      
      private var mediator:ClanWarShopPopupMediator;
      
      private var clip:ClanWarShopPopupClip;
      
      private var toggle:ToggleGroup;
      
      private var upperTabsToggle:ToggleGroup;
      
      public function ClanWarShopPopup(param1:ClanWarShopPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "store_clanwar";
      }
      
      override protected function initialize() : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         super.initialize();
         ShopPopup.music.shopOpen();
         clip = AssetStorage.rsx.popup_theme.create(ClanWarShopPopupClip,"dialog_shop_clan_war");
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
         clip.list.dataProvider = mediator.itemList;
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
         mediator.dataIsUpToDate.onValue(handler_dataIsUpToDate);
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
      
      private function createButton(param1:ShopDescription) : PopupSideTab
      {
         var _loc2_:PopupSideTab = AssetStorage.rsx.popup_theme.create(PopupSideTab,"dialog_side_tab_shop");
         _loc2_.label = param1.name;
         return _loc2_;
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
   }
}
