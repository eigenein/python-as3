package game.view.popup.hero
{
   import com.progrestar.common.lang.Translate;
   import feathers.controls.List;
   import feathers.data.ListCollection;
   import feathers.layout.TiledRowsLayout;
   import flash.utils.Dictionary;
   import game.assets.storage.AssetStorage;
   import game.data.storage.hero.HeroDescription;
   import game.mediator.gui.popup.hero.HeroRuneListPopupMediator;
   import game.mediator.gui.popup.hero.PlayerHeroListValueObject;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.toggle.ToggleGroup;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.IEscClosable;
   import game.view.popup.common.PopupSideTab;
   import game.view.popup.common.PopupTitle;
   import starling.events.Event;
   
   public class HeroRuneListPopup extends ClipBasedPopup implements ITutorialActionProvider, ITutorialNodePresenter, IEscClosable
   {
       
      
      private var mediator:HeroRuneListPopupMediator;
      
      private var list:List;
      
      private var elementList:List;
      
      private var asset:HeroListForgeDialogClip;
      
      private var toggle:ToggleGroup;
      
      private var slider:GameScrollBar;
      
      private var tabButtons:Dictionary;
      
      public function HeroRuneListPopup(param1:HeroRuneListPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "heroes";
         param1.signal_updateData.add(handler_mediatorDataUpdate);
         param1.signal_tabChange.add(handler_tabChange);
         param1.signal_updateTitanGiftLevelUpAvaliable.add(handler_updateTitanGiftLevelUpAvaliable);
      }
      
      override public function dispose() : void
      {
         if(list)
         {
            list.removeEventListener("rendererAdd",handler_listRendererAdded);
            list.removeEventListener("rendererRemove",handler_listRendererRemoved);
            list.dispose();
         }
         if(elementList)
         {
            elementList.removeEventListener("rendererAdd",handler_elementListRendererAdded);
            elementList.removeEventListener("rendererRemove",handler_elementListRendererRemoved);
            elementList.dispose();
         }
         super.dispose();
      }
      
      public function get isHorizontal() : Boolean
      {
         return true;
      }
      
      protected function get isOnRunesTab() : Boolean
      {
         return mediator.selectedTabIndex == 0;
      }
      
      protected function get isOnTitanGiftTab() : Boolean
      {
         return mediator.selectedTabIndex == 1;
      }
      
      public function get tutorialNode() : TutorialNode
      {
         if(isOnRunesTab)
         {
            return TutorialNavigator.RUNE_HEROES;
         }
         return TutorialNavigator.TITAN_GIFT_HEROES;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc3_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         var _loc2_:HeroDescription = param1.unit as HeroDescription;
         if(_loc2_)
         {
            scrollToHero(_loc2_);
         }
         else
         {
            if(list)
            {
               list.verticalScrollPolicy = "auto";
            }
            if(elementList)
            {
               elementList.verticalScrollPolicy = "auto";
            }
         }
         _loc3_.addButton(TutorialNavigator.TITAN_GIFT_HEROES,tabButtons["tab_elements"]);
         _loc3_.addButton(TutorialNavigator.RUNE_HEROES,tabButtons["tab_symbols"]);
         _loc3_.addCloseButton(asset.button_close);
         return _loc3_;
      }
      
      override protected function initialize() : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         super.initialize();
         asset = AssetStorage.rsx.popup_theme.create_dialog_hero_list_forge();
         addChild(asset.graphics);
         PopupTitle.create(Translate.translate("UI_DIALOG_HERO_RUNE_LIST_TITLE"),asset.header_layout_container);
         width = asset.dialog_frame.graphics.width;
         height = asset.dialog_frame.graphics.height;
         slider = new GameScrollBar();
         slider.height = asset.scroll_slider_container.container.height;
         asset.scroll_slider_container.container.addChild(slider);
         asset.button_close.signal_click.add(close);
         tabButtons = new Dictionary();
         toggle = new ToggleGroup();
         var _loc1_:int = mediator.tabs.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = AssetStorage.rsx.popup_theme.create_side_dialog_tab_hero();
            _loc3_.NewIcon_inst0.graphics.visible = false;
            _loc3_.label = Translate.translate("UI_DIALOG_FORGE_" + mediator.tabs[_loc2_].toUpperCase());
            toggle.addItem(_loc3_);
            asset.layout_tabs.addChild(_loc3_.graphics);
            tabButtons[mediator.tabs[_loc2_]] = _loc3_;
            _loc2_++;
         }
         toggle.selectedIndex = mediator.selectedTabIndex;
         toggle.signal_updateSelectedItem.add(handler_tabSelected);
         updateContent();
         updateTabs();
      }
      
      private function updateTabs() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = tabButtons;
         for(var _loc1_ in tabButtons)
         {
            (tabButtons[_loc1_] as PopupSideTab).NewIcon_inst0.graphics.visible = mediator.getTabVisibleByID(_loc1_);
         }
      }
      
      private function scrollToHero(param1:HeroDescription) : void
      {
         var _loc5_:int = 0;
         var _loc3_:List = null;
         if(isOnRunesTab)
         {
            _loc3_ = list;
         }
         else if(isOnTitanGiftTab)
         {
            _loc3_ = elementList;
         }
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:Vector.<PlayerHeroListValueObject> = mediator.data;
         var _loc4_:int = _loc2_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            if(_loc2_[_loc5_].hero == param1)
            {
               _loc3_.scrollToDisplayIndex(_loc5_,0.5);
               _loc3_.verticalScrollPolicy = "off";
               return;
            }
            _loc5_++;
         }
         _loc3_.verticalScrollPolicy = "auto";
      }
      
      private function updateContent() : void
      {
         Tutorial.unregister(this);
         asset.team_list_container.layoutGroup.removeChildren();
         if(isOnRunesTab)
         {
            if(!list)
            {
               list = new HeroList(slider,asset.gradient_top.graphics,asset.gradient_bottom.graphics);
               list.width = asset.team_list_container.graphics.width;
               list.height = asset.team_list_container.graphics.height;
               (list.layout as TiledRowsLayout).paddingTop = 24;
               list.addEventListener("rendererAdd",handler_listRendererAdded);
               list.addEventListener("rendererRemove",handler_listRendererRemoved);
               list.itemRendererType = HeroRuneListItemRenderer;
               list.dataProvider = new ListCollection(mediator.data);
            }
            asset.team_list_container.layoutGroup.addChild(list);
         }
         else if(isOnTitanGiftTab)
         {
            if(!elementList)
            {
               elementList = new HeroList(slider,asset.gradient_top.graphics,asset.gradient_bottom.graphics);
               elementList.width = asset.team_list_container.graphics.width;
               elementList.height = asset.team_list_container.graphics.height;
               (elementList.layout as TiledRowsLayout).paddingTop = 24;
               elementList.addEventListener("rendererAdd",handler_elementListRendererAdded);
               elementList.addEventListener("rendererRemove",handler_elementListRendererRemoved);
               elementList.itemRendererType = HeroElementListItemRenderer;
               elementList.dataProvider = new ListCollection(mediator.data);
            }
            asset.team_list_container.layoutGroup.addChild(elementList);
         }
         Tutorial.updateActionsFrom(this);
         Tutorial.registerNode(this);
      }
      
      private function handler_listRendererAdded(param1:Event, param2:HeroRuneListItemRenderer) : void
      {
         param2.signal_select.add(handler_heroSelect);
      }
      
      private function handler_listRendererRemoved(param1:Event, param2:HeroRuneListItemRenderer) : void
      {
         param2.signal_select.remove(handler_heroSelect);
      }
      
      private function handler_elementListRendererAdded(param1:Event, param2:HeroElementListItemRenderer) : void
      {
         param2.signal_select.add(handler_heroSelect);
      }
      
      private function handler_elementListRendererRemoved(param1:Event, param2:HeroElementListItemRenderer) : void
      {
         param2.signal_select.remove(handler_heroSelect);
      }
      
      private function handler_heroSelect(param1:PlayerHeroListValueObject) : void
      {
         mediator.action_select(param1);
      }
      
      protected function handler_toggleGroupChange(param1:Event) : void
      {
         mediator.action_tabSelect((param1.target as ToggleGroup).selectedIndex);
      }
      
      private function handler_mediatorDataUpdate() : void
      {
         if(list)
         {
            list.dataProvider = new ListCollection(mediator.data);
         }
         if(elementList)
         {
            elementList.dataProvider = new ListCollection(mediator.data);
         }
      }
      
      private function handler_tabChange() : void
      {
         updateContent();
      }
      
      private function handler_tabSelected() : void
      {
         mediator.action_tabSelect(toggle.selectedIndex);
      }
      
      private function handler_updateTitanGiftLevelUpAvaliable() : void
      {
         updateTabs();
      }
   }
}
