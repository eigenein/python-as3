package game.mediator.gui.popup.chat
{
   import com.progrestar.common.lang.Translate;
   import flash.utils.Dictionary;
   import game.assets.storage.AssetStorage;
   import game.view.gui.components.toggle.ToggleGroup;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.common.PopupSideTab;
   import game.view.popup.common.PopupTitle;
   import starling.display.DisplayObject;
   
   public class ChatPopup extends ClipBasedPopup
   {
      
      protected static const INVALIDATION_FLAG_TAB:String = "INVALIDATION_FLAG_TAB";
      
      protected static const INVALIDATION_FLAG_TABS:String = "INVALIDATION_FLAG_TABS";
       
      
      private var mediator:ChatPopupMediator;
      
      private var clip:ChatPopupClip;
      
      private var toggle:ToggleGroup;
      
      private var popUpTitle:PopupTitle;
      
      private var tabContent:Dictionary;
      
      private var tabButtons:Dictionary;
      
      public function ChatPopup(param1:ChatPopupMediator = null)
      {
         super(param1);
         mediator = param1;
         mediator.signal_tabSelect.add(onTabSelect);
         mediator.signal_tabsUpdate.add(onTabsUpdate);
         mediator.signal_blackListUpdate.add(chatContentUpdate);
      }
      
      override public function dispose() : void
      {
         clip.clanContent.dispose();
         clip.serverContent.dispose();
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(ChatPopupClip,"dialog_chat");
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         popUpTitle = PopupTitle.create(Translate.translate("UI_POPUP_CHAT_LIST_TITLE"),clip.header_layout_container);
         clip.button_close.signal_click.add(close);
         clip.clanContent.mediator = mediator;
         clip.serverContent.mediator = mediator;
         tabButtons = new Dictionary();
         tabContent = new Dictionary();
         tabContent["SERVER_TAB"] = clip.serverContent.graphics;
         tabContent["CLAN_TAB"] = clip.clanContent.graphics;
      }
      
      override protected function draw() : void
      {
         var _loc3_:* = 0;
         var _loc1_:int = 0;
         var _loc2_:* = null;
         if(isInvalid("INVALIDATION_FLAG_TABS"))
         {
            if(clip)
            {
               clip.layout_tabs.removeChildren();
            }
            if(toggle)
            {
               toggle.signal_updateSelectedItem.remove(handler_tabSelected);
            }
            _loc3_ = uint(0);
            toggle = new ToggleGroup();
            _loc1_ = 0;
            while(_loc1_ < mediator.tabs.length)
            {
               _loc2_ = createButton(mediator.tabs[_loc1_]);
               toggle.addItem(_loc2_);
               clip.layout_tabs.addChild(_loc2_.graphics);
               tabButtons[mediator.tabs[_loc1_]] = _loc2_;
               if(mediator.tabs[_loc1_] == mediator.selectedTab)
               {
                  _loc3_ = uint(_loc1_);
               }
               _loc1_++;
            }
            toggle.selectedIndex = _loc3_;
            toggle.signal_updateSelectedItem.add(handler_tabSelected);
         }
         if(isInvalid("INVALIDATION_FLAG_TAB"))
         {
            popUpTitle.text = Translate.translate("UI_POPUP_CHAT_" + mediator.selectedTab);
            commitTabContentVisibility();
            chatContentUpdate();
         }
         if(isInvalid("INVALIDATION_FLAG_TAB") || isInvalid("INVALIDATION_FLAG_TABS"))
         {
            updateTabs();
         }
         super.draw();
      }
      
      private function updateTabs() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = tabButtons;
         for(var _loc1_ in tabButtons)
         {
            (tabButtons[_loc1_] as PopupSideTab).NewIcon_inst0.graphics.visible = mediator.getTabMarkerVisibleByID(_loc1_);
         }
      }
      
      private function handler_tabSelected() : void
      {
         mediator.action_tabSelect(toggle.selectedIndex);
      }
      
      private function createButton(param1:String) : PopupSideTab
      {
         var _loc2_:PopupSideTab = AssetStorage.rsx.popup_theme.create_side_dialog_tab_hero();
         _loc2_.label = Translate.translate("UI_POPUP_CHAT_" + param1.toUpperCase());
         return _loc2_;
      }
      
      private function onTabSelect() : void
      {
         invalidate("INVALIDATION_FLAG_TAB");
      }
      
      private function onTabsUpdate() : void
      {
         invalidate("INVALIDATION_FLAG_TABS");
      }
      
      private function commitTabContentVisibility() : void
      {
         var _loc1_:* = null;
         var _loc3_:int = 0;
         var _loc2_:* = tabContent;
         for each(_loc1_ in tabContent)
         {
            if(_loc1_.parent)
            {
               _loc1_.removeFromParent();
            }
         }
         _loc1_ = tabContent[mediator.selectedTab];
         if(_loc1_)
         {
            _loc3_ = 0;
            _loc1_.y = _loc3_;
            _loc1_.x = _loc3_;
            clip.content_layout_container.addChild(_loc1_);
         }
      }
      
      private function chatContentUpdate() : void
      {
         if(!clip.serverContent.graphics.parent)
         {
            clip.serverContent.remove();
         }
         if(!clip.clanContent.graphics.parent)
         {
            clip.clanContent.remove();
         }
         var _loc1_:* = mediator.selectedTab;
         if("SERVER_TAB" !== _loc1_)
         {
            if("CLAN_TAB" === _loc1_)
            {
               clip.clanContent.update();
            }
         }
         else
         {
            clip.serverContent.update();
         }
      }
   }
}
