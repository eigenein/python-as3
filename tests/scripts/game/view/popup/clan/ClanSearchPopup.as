package game.view.popup.clan
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.clan.ClanSearchPopupMediator;
   import game.mediator.gui.popup.clan.ClanValueObject;
   import game.view.popup.ClipBasedPopup;
   
   public class ClanSearchPopup extends ClipBasedPopup
   {
       
      
      private var mediator:ClanSearchPopupMediator;
      
      private var clip:ClanSearchPopupClip;
      
      public function ClanSearchPopup(param1:ClanSearchPopupMediator = null)
      {
         super(param1);
         mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(ClanSearchPopupClip,"dialog_clan_list");
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         clip.tf_name_input.prompt = mediator.promptSearch;
         clip.btn_search.signal_click.add(handler_searchClick);
         clip.title = Translate.translate("UI_POPUP_CLAN_LIST_TITLE");
         clip.tf_list_header_1.text = Translate.translate("UI_POPUP_CLAN_LIST_RECOMMENDED");
         clip.tf_list_header_2.text = Translate.translate("UI_POPUP_CLAN_LIST_FRIENDS");
         clip.btn_search.label = Translate.translate("UI_POPUP_CLAN_SEARCH");
         clip.button_create.label = Translate.translate("UI_POPUP_CLAN_CREATE");
         clip.button_create.signal_click.add(handler_createClan);
         mediator.signal_updateFriendClans.add(handler_updateFriendListData);
         mediator.signal_updateSearchResult.add(handler_updateSearchResultData);
         mediator.signal_updateRecommendedResults.add(handler_updateRecommendedResultData);
         mediator.action_getData();
         clip.button_close.signal_click.add(close);
         clip.clan_list_friends.signal_select.add(mediator.action_selectClan);
         clip.clan_list_friends.signal_clanProfile.add(mediator.action_selectClanProfile);
         clip.clan_list_friends.signal_showFriends.add(mediator.action_selectFriendList);
         clip.clan_list_search.signal_select.add(mediator.action_selectClan);
         clip.clan_list_search.signal_clanProfile.add(mediator.action_selectClanProfile);
         clip.tf_list_search_result_empty.text = Translate.translate("UI_DIALOG_CLAN_LIST_TF_LIST_SEARCH_RESULT_EMPTY");
         clip.tf_list_friends_empty.text = Translate.translate("UI_DIALOG_CLAN_LIST_TF_LIST_SEARCH_RESULT_EMPTY");
      }
      
      private function handler_clanSelect(param1:ClanValueObject) : void
      {
         mediator.action_selectClan(param1);
      }
      
      private function handler_updateFriendListData() : void
      {
         clip.clan_list_friends.updateListData(mediator.data_friendClans);
         clip.tf_list_friends_empty.graphics.visible = mediator.data_friendClans.length == 0;
      }
      
      private function handler_updateSearchResultData() : void
      {
         clip.tf_list_header_1.text = Translate.translate("UI_POPUP_CLAN_LIST_SEARCH_RESULT");
         var _loc1_:ListCollection = mediator.data_searchResults;
         clip.clan_list_search.updateListData(_loc1_);
         clip.tf_list_search_result_empty.graphics.visible = _loc1_ == null || _loc1_.length == 0;
      }
      
      private function handler_updateRecommendedResultData() : void
      {
         clip.tf_list_header_1.text = Translate.translate("UI_POPUP_CLAN_LIST_RECOMMENDED");
         var _loc1_:ListCollection = mediator.data_recommendedResult;
         clip.clan_list_search.updateListData(_loc1_);
         clip.tf_list_search_result_empty.graphics.visible = _loc1_ == null || _loc1_.length == 0;
      }
      
      private function handler_searchClick() : void
      {
         mediator.action_search(clip.tf_name_input.text);
      }
      
      private function handler_createClan() : void
      {
         mediator.action_createClan();
      }
   }
}
