package game.view.popup.player
{
   import com.progrestar.common.lang.Translate;
   import flash.utils.Dictionary;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.player.AvatarSelectPopupMediator;
   import game.mediator.gui.popup.player.AvatarSelectValueObject;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.toggle.ToggleGroup;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.common.PopupSideTab;
   import starling.events.Event;
   
   public class AvatarSelectPopup extends ClipBasedPopup
   {
      
      public static const INVALIDATION_FLAG_TABS:String = "INVALIDATION_FLAG_TABS";
       
      
      private var mediator:AvatarSelectPopupMediator;
      
      private var list:AvatarSelectList;
      
      private var clip:AvatarSelectPopupClip;
      
      private var toggle:ToggleGroup;
      
      private var tabButtons:Dictionary;
      
      public function AvatarSelectPopup(param1:AvatarSelectPopupMediator = null)
      {
         mediator = param1;
         mediator.signal_tabUpdate.add(onTabUpdate);
         mediator.signal_dataReady.add(handler_dataReady);
         super(param1);
      }
      
      override protected function draw() : void
      {
         if(isInvalid("INVALIDATION_FLAG_TABS"))
         {
            updateTabs();
         }
         super.draw();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_popup_avatar_select();
         addChild(clip.graphics);
         clip.tf_caption.text = Translate.translate("UI_POPUP_PLAYER_AVATAR_SELECT");
         clip.button_close.signal_click.add(mediator.close);
         var _loc1_:GameScrollBar = new GameScrollBar();
         _loc1_.height = clip.scroll_slider_container.container.height;
         clip.scroll_slider_container.container.addChild(_loc1_);
         list = new AvatarSelectList(_loc1_,clip.gradient_top.graphics,clip.gradient_bottom.graphics);
         list.width = clip.list_container.container.width;
         list.height = clip.list_container.container.height;
         clip.list_container.container.addChild(list);
         list.addEventListener("rendererAdd",onListRendererAdded);
         list.addEventListener("rendererRemove",onListRendererRemoved);
         tabButtons = new Dictionary();
         toggle = new ToggleGroup();
         mediator.signal_recreateTabs.add(recreateTabs);
         recreateTabs();
         width = clip.bg.graphics.width;
      }
      
      private function recreateTabs() : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         toggle.signal_updateSelectedItem.remove(handler_tabSelected);
         var _loc5_:int = 0;
         var _loc4_:* = tabButtons;
         for each(var _loc1_ in tabButtons)
         {
            toggle.removeItem(_loc1_);
            clip.layout_tabs.removeChild(_loc1_.graphics);
         }
         _loc2_ = 0;
         while(_loc2_ < mediator.tabs.length)
         {
            _loc3_ = createButton(mediator.tabs[_loc2_]);
            toggle.addItem(_loc3_);
            clip.layout_tabs.addChild(_loc3_.graphics);
            tabButtons[mediator.tabs[_loc2_]] = _loc3_;
            _loc2_++;
         }
         toggle.selectedIndex = mediator.selectedTabIndex;
         toggle.signal_updateSelectedItem.add(handler_tabSelected);
         invalidate("INVALIDATION_FLAG_TABS");
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
      
      private function createButton(param1:String) : PopupSideTab
      {
         var _loc2_:PopupSideTab = AssetStorage.rsx.popup_theme.create_side_dialog_tab_hero();
         var _loc3_:* = param1;
         if("TAB_CAMPAIGN" !== _loc3_)
         {
            if("TAB_HEROES" !== _loc3_)
            {
               if("TAB_ALL" !== _loc3_)
               {
                  if("TAB_SKINS" !== _loc3_)
                  {
                     if("TAB_TITANS" !== _loc3_)
                     {
                        if("TAB_UNIQUE" === _loc3_)
                        {
                           _loc2_.label = Translate.translate("UI_AVATAR_UNIQUE");
                        }
                     }
                     else
                     {
                        _loc2_.label = Translate.translate("UI_CLANMENU_TITANHALL");
                     }
                  }
                  else
                  {
                     _loc2_.label = Translate.translate("UI_DIALOG_HERO_TAB_SKINS");
                  }
               }
               else
               {
                  _loc2_.label = Translate.translate("UI_DIALOG_HERO_LIST_TAB_ALL");
               }
            }
            else
            {
               _loc2_.label = Translate.translate("UI_MAINMENU_HEROES");
            }
         }
         else
         {
            _loc2_.label = Translate.translate("UI_MAINMENU_PORTAL");
         }
         return _loc2_;
      }
      
      private function handler_tabSelected() : void
      {
         mediator.action_tabSelect(toggle.selectedIndex);
      }
      
      private function onTabUpdate() : void
      {
         list.dataProvider = mediator.dataProvider;
      }
      
      private function handler_dataReady() : void
      {
         mediator.action_tabSelect(toggle.selectedIndex);
      }
      
      private function onListRendererAdded(param1:Event, param2:AvatarSelectListItem) : void
      {
         param2.signal_select.add(handler_select);
      }
      
      private function onListRendererRemoved(param1:Event, param2:AvatarSelectListItem) : void
      {
         param2.signal_select.remove(handler_select);
      }
      
      private function handler_select(param1:AvatarSelectValueObject) : void
      {
         mediator.action_selectAvatar(param1);
      }
   }
}
