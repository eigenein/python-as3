package game.view.popup.inventory
{
   import com.progrestar.common.lang.Translate;
   import feathers.controls.Button;
   import feathers.data.ListCollection;
   import feathers.layout.VerticalLayout;
   import flash.utils.Dictionary;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.inventory.PlayerInventoryPopupMediator;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.toggle.ToggleGroup;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.common.PopupSideTab;
   import game.view.popup.common.PopupTitle;
   import starling.events.Event;
   
   public class PlayerInventoryPopup extends ClipBasedPopup
   {
       
      
      private var mediator:PlayerInventoryPopupMediator;
      
      private var itemList:PlayerInventoryPopupList;
      
      private var toggle:ToggleGroup;
      
      private var closeButton:Button;
      
      private var clip:PlayerInventoryPopupClip;
      
      private var tabButtons:Dictionary;
      
      public function PlayerInventoryPopup(param1:PlayerInventoryPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "inventory";
         param1.signal_updateItems.add(mediator_onListUpdate);
         param1.signal_updateSelectedItem.add(mediator_onSelectedItemUpdate);
      }
      
      override protected function initialize() : void
      {
         var _loc5_:int = 0;
         var _loc6_:* = null;
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_player_inventory();
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         var _loc4_:PopupTitle = PopupTitle.create(Translate.translate("UI_DIALOG_POPUP_INVENTORY_TITLE"),clip.header_layout_container);
         clip.button_close.signal_click.add(mediator.close);
         var _loc1_:VerticalLayout = new VerticalLayout();
         _loc1_.gap = -12;
         clip.tab_layout_container.layoutGroup.layout = _loc1_;
         tabButtons = new Dictionary();
         toggle = new ToggleGroup();
         var _loc3_:int = mediator.tabs.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc6_ = createButton(mediator.tabs[_loc5_]);
            toggle.addItem(_loc6_);
            clip.tab_layout_container.layoutGroup.addChild(_loc6_.graphics);
            tabButtons[mediator.tabs[_loc5_]] = _loc6_;
            _loc5_++;
         }
         toggle.signal_updateSelectedItem.add(onTabSelected);
         var _loc2_:GameScrollBar = new GameScrollBar();
         _loc2_.height = clip.scroll_slider_container.container.height;
         clip.scroll_slider_container.container.addChild(_loc2_);
         itemList = new PlayerInventoryPopupList(mediator,_loc2_,clip.gradient_top.graphics,clip.gradient_bottom.graphics);
         itemList.width = clip.list_container.graphics.width;
         itemList.height = clip.list_container.graphics.height;
         itemList.addEventListener("change",handler_listSelectionChange);
         clip.list_container.container.addChild(itemList);
         clip.selected_item.button_sell.label = Translate.translate("UI_DIALOG_INVENTORY_SELL");
         clip.selected_item.button_sell.signal_click.add(handler_sellClick);
         clip.selected_item.button_use.signal_click.add(handler_useClick);
         clip.selected_item.item_icon.signal_click.add(mediator.handler_selectedItemClick);
         updateListDisplay();
         updateTabs();
         updateSelectedItemDisplay();
      }
      
      private function updateTabs() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = tabButtons;
         for(var _loc1_ in tabButtons)
         {
            (tabButtons[_loc1_] as PopupSideTab).NewIcon_inst0.graphics.visible = mediator.getTabHasNotificationByID(_loc1_);
         }
      }
      
      private function updateListDisplay() : void
      {
         itemList.dataProvider = new ListCollection(mediator.items);
         itemList.removeEventListener("change",handler_listSelectionChange);
         itemList.selectedItem = mediator.selectedItem;
         trace("new selected item",!!mediator.selectedItem?mediator.selectedItem.name:"null");
         itemList.addEventListener("change",handler_listSelectionChange);
      }
      
      private function updateSelectedItemDisplay() : void
      {
         if(mediator.selectedItem)
         {
            clip.selected_item.setSelectedItem(mediator.selectedItem,mediator.selectedItemStats,mediator.selectedItemCanBeUsed,mediator.selectedItemCanBeSold,mediator.selectedItemHasInfo);
         }
      }
      
      private function createButton(param1:String) : PopupSideTab
      {
         var _loc2_:PopupSideTab = AssetStorage.rsx.popup_theme.create_side_dialog_tab_inventory();
         _loc2_.label = Translate.translate("UI_DIALOG_INVENTORY_TAB_" + param1.toUpperCase());
         return _loc2_;
      }
      
      private function onTabSelected() : void
      {
         mediator.action_selectTab(toggle.selectedIndex);
      }
      
      private function mediator_onListUpdate() : void
      {
         updateListDisplay();
         updateTabs();
      }
      
      private function mediator_onSelectedItemUpdate() : void
      {
         updateSelectedItemDisplay();
      }
      
      private function handler_sellClick() : void
      {
         mediator.action_sellItem();
      }
      
      private function handler_useClick() : void
      {
         mediator.action_useItem();
      }
      
      private function handler_listSelectionChange(param1:Event) : void
      {
         if(itemList.selectedItem is InventoryItem)
         {
            mediator.action_selectItem(itemList.selectedItem as InventoryItem);
         }
      }
   }
}
