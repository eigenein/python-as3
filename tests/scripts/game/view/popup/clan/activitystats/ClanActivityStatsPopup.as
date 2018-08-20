package game.view.popup.clan.activitystats
{
   import com.progrestar.common.lang.Translate;
   import flash.utils.Dictionary;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.clan.activitystats.ClanActivityStatsPopupMediator;
   import game.view.gui.components.toggle.ToggleGroup;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.IEscClosable;
   import game.view.popup.common.PopupSideTab;
   
   public class ClanActivityStatsPopup extends ClipBasedPopup implements IEscClosable
   {
       
      
      private var mediator:ClanActivityStatsPopupMediator;
      
      private var clip:ClanActivityStatsPopupClip;
      
      private var toggle:ToggleGroup;
      
      private var tabButtons:Dictionary;
      
      public function ClanActivityStatsPopup(param1:ClanActivityStatsPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         clip.stats_content.dispose();
         clip.send_gift_content.dispose();
      }
      
      override protected function initialize() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         super.initialize();
         width = 950;
         height = 500;
         clip = AssetStorage.rsx.popup_theme.create(ClanActivityStatsPopupClip,"dialog_clan_activity_stats");
         addChild(clip.graphics);
         clip.button_close.signal_click.add(mediator.close);
         tabButtons = new Dictionary();
         toggle = new ToggleGroup();
         _loc1_ = 0;
         while(_loc1_ < mediator.tabs.length)
         {
            _loc2_ = AssetStorage.rsx.popup_theme.create_side_dialog_tab_hero();
            _loc2_.NewIcon_inst0.graphics.visible = false;
            if(mediator.tabs[_loc1_] == "tab_titanit")
            {
               _loc2_.label = Translate.translate("LIB_PSEUDO_DUNGEON_ACTIVITY");
            }
            else
            {
               _loc2_.label = Translate.translate("UI_DIALOG_CLAN_ACTIVITY_" + mediator.tabs[_loc1_].toUpperCase());
            }
            toggle.addItem(_loc2_);
            clip.layout_tabs.addChild(_loc2_.graphics);
            tabButtons[mediator.tabs[_loc1_]] = _loc2_;
            _loc1_++;
         }
         toggle.signal_updateSelectedItem.add(handler_tabSelected);
         mediator.signal_data.add(handler_data);
         handler_tabSelected();
         mediator.property_redMarkState.signal_update.add(handler_redMarkState);
         handler_redMarkState();
      }
      
      private function handler_tabSelected() : void
      {
         mediator.action_setTab(toggle.selectedIndex);
         switch(int(toggle.selectedIndex))
         {
            case 0:
               clip.stats_content.container.visible = true;
               clip.send_gift_content.container.visible = false;
               clip.header_layout_container.container.removeChildren();
               clip.title = Translate.translate("UI_DIALOG_CLAN_ACTIVITY_TITLE");
               clip.stats_content.update();
               break;
            case 1:
               clip.stats_content.container.visible = true;
               clip.send_gift_content.container.visible = false;
               clip.header_layout_container.container.removeChildren();
               clip.title = Translate.translate("UI_DIALOG_CLAN_DUNGEON_ACTIVITY_TITLE");
               clip.stats_content.update();
               break;
            case 2:
               clip.stats_content.container.visible = false;
               clip.send_gift_content.container.visible = true;
               clip.header_layout_container.container.removeChildren();
               clip.title = Translate.translate("UI_DIALOG_SEND_GIFT_TITLE");
         }
      }
      
      private function handler_data() : void
      {
         clip.stats_content.initialize(mediator);
         clip.send_gift_content.initialize(mediator);
      }
      
      private function handler_redMarkState(param1:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc2_:uint = mediator.tabs.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = tabButtons[mediator.tabs[_loc3_]];
            if(mediator.tabs[_loc3_] == "tab_gifts")
            {
               _loc4_.NewIcon_inst0.graphics.visible = mediator.property_redMarkState.value;
            }
            else
            {
               _loc4_.NewIcon_inst0.graphics.visible = false;
            }
            _loc3_++;
         }
      }
   }
}
