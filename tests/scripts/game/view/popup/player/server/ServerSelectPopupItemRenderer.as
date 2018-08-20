package game.view.popup.player.server
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.command.rpc.player.server.ServerListValueObject;
   import game.view.gui.components.list.ListItemRenderer;
   import idv.cjcat.signals.Signal;
   
   public class ServerSelectPopupItemRenderer extends ListItemRenderer
   {
       
      
      private var clip:ServerSelectPopupItemRendererClip;
      
      private var _signal_listFriends:Signal;
      
      private var _signal_select:Signal;
      
      public function ServerSelectPopupItemRenderer()
      {
         _signal_listFriends = new Signal(ServerListValueObject);
         _signal_select = new Signal(ServerListValueObject);
         super();
      }
      
      public function get signal_listFriends() : Signal
      {
         return _signal_listFriends;
      }
      
      public function get signal_select() : Signal
      {
         return _signal_select;
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:* = null;
         _loc2_ = data as ServerListValueObject;
         if(!_loc2_)
         {
         }
         .super.data = param1;
         _loc2_ = param1 as ServerListValueObject;
         if(_loc2_)
         {
            clip.tf_server_id.text = _loc2_.id.toString();
            clip.tf_server_name.text = _loc2_.name;
            clip.friend_list.graphics.visible = _loc2_.friendCount;
            if(_loc2_.friendCount)
            {
               clip.tf_friend_count.text = Translate.translateArgs("UI_DIALOG_SERVER_SELECT_LIST_FRIENDS",_loc2_.friendCount.toString());
            }
            else
            {
               clip.tf_friend_count.text = "";
            }
            if(_loc2_.level)
            {
               clip.tf_level.text = Translate.translateArgs("UI_COMMON_LVL_SHORT",_loc2_.level);
            }
            else
            {
               clip.tf_level.text = "";
            }
            clip.tf_nickname.text = _loc2_.nickname;
         }
      }
      
      override public function set isSelected(param1:Boolean) : void
      {
         .super.isSelected = param1;
         clip.bg.bg_selected.graphics.visible = _isSelected;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(ServerSelectPopupItemRendererClip,"dialog_server_select_renderer");
         addChild(clip.graphics);
         clip.bg.signal_click.add(handler_select);
         clip.friend_list.signal_click.add(handler_list);
      }
      
      private function handler_list() : void
      {
         _signal_listFriends.dispatch(data as ServerListValueObject);
      }
      
      private function handler_select() : void
      {
         if(!_isSelected)
         {
            isSelected = true;
            _signal_select.dispatch(data as ServerListValueObject);
         }
      }
   }
}
