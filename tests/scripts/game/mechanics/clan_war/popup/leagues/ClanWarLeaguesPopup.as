package game.mechanics.clan_war.popup.leagues
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.mechanics.clan_war.mediator.ClanWarLeaguesPopupMediator;
   import game.mechanics.clan_war.storage.ClanWarLeagueDescription;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import game.view.gui.components.toggle.ToggleGroup;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.common.PopupTitle;
   
   public class ClanWarLeaguesPopup extends ClipBasedPopup
   {
       
      
      private var mediator:ClanWarLeaguesPopupMediator;
      
      private var initialized:Boolean;
      
      private var clip:ClanWarLeaguesPopupClip;
      
      private var title:PopupTitle;
      
      private var list:GameScrolledList;
      
      private var toggle:ToggleGroup;
      
      public function ClanWarLeaguesPopup(param1:ClanWarLeaguesPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         this.mediator.signal_ratingUpdate.add(handler_raitingUpdate);
         this.mediator.signal_leagueInfoUpdate.add(handler_leagueInfoUpdate);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         mediator.signal_ratingUpdate.remove(handler_raitingUpdate);
         mediator.signal_leagueInfoUpdate.remove(handler_leagueInfoUpdate);
         clip.clan_self.dispose();
      }
      
      override protected function initialize() : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         clip = AssetStorage.rsx.popup_theme.create(ClanWarLeaguesPopupClip,"clan_war_leagues");
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width - 100;
         height = clip.dialog_frame.graphics.height;
         title = PopupTitle.create(Translate.translate("UI_DIALOG_CLAN_WAR_LEAGUES_TITLE"),clip.header_layout_container);
         clip.button_close.signal_click.add(mediator.close);
         clip.clan_self.clan_icon.setData(mediator.playerClan.clan);
         clip.clan_self.name_tf.text = mediator.playerClan.clan.title;
         clip.button_rewards.label = Translate.translate("UI_DIALOG_CLAN_INFO_REWARD");
         clip.button_rewards.signal_click.add(mediator.action_showRewardsPopup);
         var _loc2_:GameScrollBar = new GameScrollBar();
         _loc2_.height = clip.scroll_slider_container.container.height;
         clip.scroll_slider_container.container.addChild(_loc2_);
         var _loc1_:VerticalLayout = new VerticalLayout();
         var _loc5_:int = 10;
         _loc1_.paddingBottom = _loc5_;
         _loc1_.paddingTop = _loc5_;
         _loc1_.gap = 4;
         list = new GameScrolledList(_loc2_,clip.gradient_top.graphics,clip.gradient_bottom.graphics);
         list.layout = _loc1_;
         list.width = clip.list_container.container.width;
         list.height = clip.list_container.container.height;
         clip.list_container.container.addChild(list);
         toggle = new ToggleGroup();
         toggle.signal_updateSelectedItem.add(handler_tabSelected);
         _loc3_ = 0;
         while(_loc3_ < mediator.tabs.length)
         {
            _loc4_ = createTabButton(mediator.tabs[_loc3_]);
            toggle.addItem(_loc4_);
            clip.layout_tabs.addChild(_loc4_.graphics);
            _loc3_++;
         }
         toggle.selectedIndex = 1;
         (toggle.selectedItem as ClanWarLeaguesPopupTab).selectedIndex = mediator.playerClanLeagueIndex;
         initialized = true;
         handler_subTabSelected();
      }
      
      private function createTabButton(param1:String) : ClanWarLeaguesPopupTab
      {
         var _loc2_:ClanWarLeaguesPopupTab = AssetStorage.rsx.popup_theme.create(ClanWarLeaguesPopupTab,"dialog_side_tab_composite");
         _loc2_.signal_subTabChange.add(handler_subTabSelected);
         _loc2_.label = Translate.translate("UI_DIALOG_TAB_" + param1.toUpperCase());
         _loc2_.subTabs = mediator.clanWarLeagues;
         return _loc2_;
      }
      
      private function updateContent() : void
      {
         clip.league_tf.text = mediator.selecetdLeague.name;
         if(mediator.currentWeekFlag)
         {
            list.itemRendererType = ClanWarRatingClanItemRenderer;
            switch(int(mediator.selecetdLeague.id) - 1)
            {
               case 0:
                  clip.league_desc_tf.text = Translate.translateArgs("LIB_CLANWAR_LEAGUE_DESC_" + mediator.selecetdLeague.id,mediator.selecetdLeague.divisionSize * mediator.selecetdLeague.divisions.length,mediator.rating.promoCount > 0?mediator.rating.promoCount:int(mediator.selecetdLeague.divisionSize));
                  break;
               case 1:
                  clip.league_desc_tf.text = Translate.translateArgs("LIB_CLANWAR_LEAGUE_DESC_" + mediator.selecetdLeague.id,mediator.selecetdLeague.divisionSize * mediator.selecetdLeague.divisions.length,mediator.selecetdLeague.divisionSize,mediator.rating.promoCount > 0?mediator.rating.promoCount:int(mediator.selecetdLeague.bestCount));
                  break;
               case 2:
                  clip.league_desc_tf.text = Translate.translateArgs("LIB_CLANWAR_LEAGUE_DESC_" + mediator.selecetdLeague.id,mediator.selecetdLeague.divisionSize * mediator.selecetdLeague.divisions.length,mediator.selecetdLeague.divisionSize,mediator.rating.promoCount > 0?mediator.rating.promoCount:int(mediator.selecetdLeague.bestCount));
                  break;
               case 3:
                  clip.league_desc_tf.text = Translate.translateArgs("LIB_CLANWAR_LEAGUE_DESC_" + mediator.selecetdLeague.id,mediator.rating.promoCount > 0?mediator.rating.promoCount:int(mediator.selecetdLeague.bestCount));
            }
         }
         else
         {
            list.itemRendererType = ClanWarLastWeekRatingClanItemRenderer;
            if(mediator.selecetdLeague.id == 4)
            {
               if(mediator.rating.topList.length > 0)
               {
                  clip.league_desc_tf.text = Translate.translateArgs("LIB_CLANWAR_LEAGUE_DESC_0",mediator.rating.topList.length);
               }
               else
               {
                  clip.league_desc_tf.text = Translate.translate("UI_DIALOG_CLAN_WAR_LEAGUES_EMPTY_LIST");
               }
            }
            else
            {
               clip.league_desc_tf.text = Translate.translateArgs("LIB_CLANWAR_LEAGUE_DESC_0",mediator.selecetdLeague.divisionSize * mediator.selecetdLeague.divisions.length);
            }
         }
         list.dataProvider = new ListCollection(mediator.rating.topList);
         clip.empty_tf.text = Translate.translate("UI_DIALOG_CLAN_WAR_LEAGUES_EMPTY_LIST");
         clip.empty_tf.visible = mediator.rating.topList.length == 0;
      }
      
      private function updatePlayerClanPlate() : void
      {
         if(!mediator.leagueInfo)
         {
            return;
         }
         clip.clan_self.league_tf.text = mediator.leagueText;
         clip.clan_self.layout_vp.visible = mediator.playerClanInRating;
         clip.clan_self.points_tf.text = mediator.leaguePoints.toString();
      }
      
      private function handler_tabSelected() : void
      {
         clip.layout_tabs.invalidate("layout");
      }
      
      private function handler_subTabSelected() : void
      {
         var _loc2_:* = null;
         if(!initialized)
         {
            return;
         }
         var _loc1_:ClanWarLeaguesPopupTab = toggle.selectedItem as ClanWarLeaguesPopupTab;
         if(_loc1_)
         {
            _loc2_ = _loc1_.selectedItem as ClanWarLeagueDescription;
            if(_loc2_)
            {
               mediator.action_getTop(_loc2_,toggle.selectedIndex == 1);
            }
         }
         updatePlayerClanPlate();
      }
      
      private function handler_raitingUpdate() : void
      {
         updateContent();
      }
      
      private function handler_leagueInfoUpdate() : void
      {
         updatePlayerClanPlate();
      }
   }
}
