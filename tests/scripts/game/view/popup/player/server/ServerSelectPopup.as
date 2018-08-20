package game.view.popup.player.server
{
   import com.progrestar.common.lang.Translate;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.command.rpc.player.server.ServerListValueObject;
   import game.mediator.gui.popup.player.server.ServerSelectPopupMediator;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import game.view.popup.ClipBasedPopup;
   import starling.events.Event;
   
   public class ServerSelectPopup extends ClipBasedPopup
   {
       
      
      private var mediator:ServerSelectPopupMediator;
      
      private var clip:ServerSelectPopupClip;
      
      public function ServerSelectPopup(param1:ServerSelectPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "server_select";
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(ServerSelectPopupClip,"dialog_server_select");
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         clip.title = Translate.translate("UI_DIALOG_SERVER_SELECT_HEADER");
         clip.tf_label_current_server.text = Translate.translate("UI_DIALOG_PLAYER_PROFILE_YOUR_SERVER");
         clip.tf_label_server_list.text = Translate.translate("UI_DIALOG_SERVER_SELECT_LIST");
         clip.current_server.tf_level.text = Translate.translateArgs("UI_COMMON_LVL_SHORT",mediator.level);
         clip.current_server.tf_nickname.text = mediator.nickname;
         clip.current_server.tf_server_id.text = mediator.serverId;
         clip.current_server.tf_server_name.text = mediator.serverName;
         var _loc1_:GameScrollBar = new GameScrollBar();
         _loc1_.height = clip.scroll_slider_container.container.height;
         clip.scroll_slider_container.container.addChild(_loc1_);
         var _loc3_:GameScrolledList = new GameScrolledList(_loc1_,clip.gradient_top.graphics,clip.gradient_bottom.graphics);
         _loc3_.addEventListener("rendererAdd",list_rendererAddHandler);
         _loc3_.addEventListener("rendererRemove",list_rendererRemoveHandler);
         _loc3_.itemRendererType = ServerSelectPopupItemRenderer;
         var _loc2_:VerticalLayout = new VerticalLayout();
         _loc2_.gap = 10;
         var _loc4_:int = 20;
         _loc2_.paddingBottom = _loc4_;
         _loc2_.paddingTop = _loc4_;
         _loc3_.layout = _loc2_;
         _loc3_.width = clip.list_container.container.width;
         _loc3_.height = clip.list_container.container.height;
         clip.list_container.container.addChild(_loc3_);
         _loc3_.dataProvider = mediator.listData;
         _loc3_.selectedIndex = mediator.currentServerItemIndex;
         clip.button_close.signal_click.add(mediator.close);
         clip.btn_select.label = Translate.translate("UI_DIALOG_SERVER_SELECT_BUTTON");
         clip.btn_select.signal_click.add(mediator.action_selectServer);
         handler_updateButton();
         mediator.signal_selectEnabledStateChange.add(handler_updateButton);
      }
      
      private function list_rendererRemoveHandler(param1:Event, param2:ServerSelectPopupItemRenderer) : void
      {
         param2.signal_select.remove(handler_itemSelect);
         param2.signal_listFriends.remove(handler_listFriends);
      }
      
      private function list_rendererAddHandler(param1:Event, param2:ServerSelectPopupItemRenderer) : void
      {
         param2.signal_select.add(handler_itemSelect);
         param2.signal_listFriends.add(handler_listFriends);
      }
      
      private function handler_itemSelect(param1:ServerListValueObject) : void
      {
         mediator.action_selectListItem(param1);
      }
      
      private function handler_listFriends(param1:ServerListValueObject) : void
      {
         mediator.action_listFriends(param1);
      }
      
      private function handler_updateButton() : void
      {
         clip.btn_select.isEnabled = mediator.selectEnabled;
         clip.btn_select.graphics.alpha = !!clip.btn_select.isEnabled?1:0.5;
      }
   }
}
