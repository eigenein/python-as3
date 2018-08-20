package game.view.popup.clan
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.clan.ClanValueObject;
   import game.mediator.gui.popup.clan.FriendClanValueObject;
   import game.view.gui.components.list.ListItemRenderer;
   import game.view.popup.clan.editicon.ClanIconClip;
   import idv.cjcat.signals.Signal;
   
   public class ClanSearchListItemRenderer extends ListItemRenderer
   {
       
      
      private var clip:ClanSearchListItemRendererClip;
      
      private var icon:ClanIconClip;
      
      private var _signal_select:Signal;
      
      private var _signal_friendList:Signal;
      
      private var _signal_clanProfile:Signal;
      
      public function ClanSearchListItemRenderer()
      {
         _signal_select = new Signal(ClanValueObject);
         _signal_friendList = new Signal(FriendClanValueObject);
         _signal_clanProfile = new Signal(ClanValueObject);
         super();
      }
      
      public function get signal_select() : Signal
      {
         return _signal_select;
      }
      
      public function get signal_friendList() : Signal
      {
         return _signal_friendList;
      }
      
      public function get signal_clanProfile() : Signal
      {
         return _signal_clanProfile;
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:ClanValueObject = data as ClanValueObject;
         if(!_loc2_)
         {
         }
         .super.data = param1;
         _loc2_ = data as ClanValueObject;
         if(!_loc2_)
         {
         }
      }
      
      override protected function commitData() : void
      {
         super.commitData();
         var _loc1_:ClanValueObject = data as ClanValueObject;
         if(_loc1_)
         {
            clip.tf_guild_name.text = _loc1_.title;
            clip.tf_guild_members.text = _loc1_.membersCount + "/" + _loc1_.maxMembersCount;
            clip.tf_guild_level_req.text = Translate.translateArgs("UI_POPUP_CLAN_LIST_MIN_LVL",_loc1_.minLevel);
            clip.tf_guild_points.text = _loc1_.topActivity.toString();
            clip.lock_icon.graphics.visible = !_loc1_.playerCanJoin;
            clip.button_join.graphics.visible = _loc1_.playerCanJoin;
            clip.button_friends.graphics.visible = _loc1_ is FriendClanValueObject;
            AssetStorage.rsx.clan_icons.setupIcon(icon,_loc1_.icon);
            clip.layout_icon.addChild(icon.graphics);
         }
         else
         {
            clip.layout_icon.removeChild(icon.graphics);
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(ClanSearchListItemRendererClip,"clan_list_renderer");
         addChild(clip.graphics);
         icon = AssetStorage.rsx.clan_icons.createIconClip();
         clip.layout_icon.addChild(icon.graphics);
         clip.button_join.label = Translate.translate("UI_POPUP_CLAN_LIST_JOIN");
         clip.button_join.signal_click.add(handler_buttonClick);
         clip.button_friends.signal_click.add(handler_friendListButtonClick);
         clip.bg_button.signal_click.add(handler_infoButtonClick);
      }
      
      private function handler_buttonClick() : void
      {
         _signal_select.dispatch(data as ClanValueObject);
      }
      
      private function handler_friendListButtonClick() : void
      {
         _signal_friendList.dispatch(data as FriendClanValueObject);
      }
      
      private function handler_infoButtonClick() : void
      {
         _signal_clanProfile.dispatch(data as ClanValueObject);
      }
   }
}
