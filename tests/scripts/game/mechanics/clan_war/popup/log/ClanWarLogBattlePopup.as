package game.mechanics.clan_war.popup.log
{
   import com.progrestar.common.lang.Translate;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.clan_war.mediator.log.ClanWarLogBattlePopupMediator;
   import game.mechanics.clan_war.mediator.log.ClanWarLogBattleValueObjectBase;
   import game.view.gui.components.toggle.ToggleGroup;
   import game.view.popup.AsyncClipBasedPopup;
   import game.view.popup.common.PopupSideTab;
   import starling.events.Event;
   
   public class ClanWarLogBattlePopup extends AsyncClipBasedPopup
   {
       
      
      private var mediator:ClanWarLogBattlePopupMediator;
      
      private var clip:ClanWarLogBattlePopupClip;
      
      private var toggle:ToggleGroup;
      
      public function ClanWarLogBattlePopup(param1:ClanWarLogBattlePopupMediator)
      {
         super(param1,AssetStorage.rsx.clan_war_map);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         mediator.attacker.unsubscribe(clip.vs_header.attacker_info.setData);
         mediator.defender.unsubscribe(clip.vs_header.defender_info.setData);
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         clip = param1.create(ClanWarLogBattlePopupClip,"popup_clan_war_battle_log");
         addChild(clip.graphics);
         centerPopupBy(clip.dialog_frame.graphics,clip.tab_layout_container.layoutGroup.width * 0.5 - 20,15);
         clip.title = Translate.translate("UI_CLAN_WAR_LOG_DAY_TITLE");
         clip.button_close.signal_click.add(mediator.close);
         createTabs();
         createList();
         clip.tf_message.text = Translate.translate("UI_DIALOG_LOG_ARENA_EMPTY");
         clip.tf_date.text = mediator.warDateString;
         mediator.attacker.onValue(clip.vs_header.attacker_info.setData);
         mediator.defender.onValue(clip.vs_header.defender_info.setData);
         var _loc2_:Boolean = mediator.isCurrentWar;
         if(_loc2_)
         {
            clip.vs_header.attacker_info.button_list.signal_click.add(mediator.action_openMemberList_attacker);
            clip.vs_header.defender_info.button_list.signal_click.add(mediator.action_openMemberList_defender);
         }
         clip.vs_header.attacker_info.button_list.graphics.visible = _loc2_;
         clip.vs_header.defender_info.button_list.graphics.visible = _loc2_;
      }
      
      protected function createTabs() : void
      {
         var _loc3_:* = null;
         var _loc1_:VerticalLayout = new VerticalLayout();
         _loc1_.gap = -12;
         clip.tab_layout_container.layoutGroup.layout = _loc1_;
         toggle = new ToggleGroup();
         var _loc5_:int = 0;
         var _loc4_:* = mediator.tabsNames;
         for each(var _loc2_ in mediator.tabsNames)
         {
            _loc3_ = createTabButton(_loc2_);
            toggle.addItem(_loc3_);
            clip.tab_layout_container.layoutGroup.addChild(_loc3_.graphics);
         }
         toggle.selectedIndex = mediator.selectedTabIndex;
         toggle.signal_updateSelectedItem.add(handler_tabSelected);
      }
      
      protected function createTabButton(param1:String) : PopupSideTab
      {
         var _loc2_:PopupSideTab = AssetStorage.rsx.popup_theme.create(PopupSideTab,"dialog_side_tab_shop");
         _loc2_.label = param1;
         return _loc2_;
      }
      
      protected function createList() : void
      {
         var _loc1_:VerticalLayout = new VerticalLayout();
         _loc1_.gap = 6;
         _loc1_.paddingTop = 10;
         _loc1_.paddingBottom = 20;
         _loc1_.hasVariableItemDimensions = true;
         clip.list.layout = _loc1_;
         clip.list.itemRendererType = ClanWarLogBattleItemRenderer;
         clip.list.dataProvider = mediator.dataProvider;
         mediator.dataProvider.addEventListener("change",handler_dataChange);
         handler_dataChange(null);
      }
      
      private function handler_dataChange(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc4_:Array = (clip.list.layout as VerticalLayout).heightCache;
         var _loc3_:int = mediator.dataProvider.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_[_loc2_] = ClanWarLogBattleItemRenderer.getHeight(mediator.dataProvider.data[_loc2_] as ClanWarLogBattleValueObjectBase);
            _loc2_++;
         }
         if(mediator.dataProvider.length == 0)
         {
            clip.tf_message.visible = true;
         }
         else
         {
            clip.tf_message.visible = false;
         }
      }
      
      private function handler_tabSelected() : void
      {
         mediator.action_selectTab(toggle.selectedIndex);
      }
   }
}
