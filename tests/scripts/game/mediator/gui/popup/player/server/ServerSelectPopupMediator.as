package game.mediator.gui.popup.player.server
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import game.command.rpc.player.server.CommandServerGetAll;
   import game.command.rpc.player.server.ServerListValueObject;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.friends.PlayerFriendEntry;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.player.server.ServerSelectPopup;
   import idv.cjcat.signals.Signal;
   
   public class ServerSelectPopupMediator extends PopupMediator
   {
       
      
      private var selectedServer:ServerListValueObject;
      
      private var _signal_selectEnabledStateChange:Signal;
      
      private var _listData:ListCollection;
      
      private var _serverName:String;
      
      private var _serverId:String;
      
      private var _nickname:String;
      
      private var _level:String;
      
      private var _selectEnabled:Boolean;
      
      private var _maxMigrateServer:int;
      
      public function ServerSelectPopupMediator(param1:Player, param2:CommandServerGetAll)
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         _signal_selectEnabledStateChange = new Signal();
         super(param1);
         _maxMigrateServer = param2.maxServer;
         var _loc7_:Vector.<PlayerFriendEntry> = param1.friends.getAppFriends();
         var _loc3_:int = param2.servers.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = param2.servers[_loc5_];
            _loc8_ = _loc7_.length;
            _loc6_ = 0;
            while(_loc6_ < _loc8_)
            {
               if(_loc7_[_loc6_].serverId == _loc4_.id)
               {
                  _loc4_.friends.push(_loc7_[_loc6_]);
               }
               _loc6_++;
            }
            _loc5_++;
         }
         _listData = new ListCollection(param2.servers);
         _serverName = Translate.translate("LIB_SERVER_NAME_" + param1.serverId);
         _serverId = param1.serverId.toString();
         _nickname = param1.nickname;
         _level = param1.levelData.level.level.toString();
      }
      
      override protected function dispose() : void
      {
         super.dispose();
         _signal_selectEnabledStateChange.clear();
      }
      
      public function get signal_selectEnabledStateChange() : Signal
      {
         return _signal_selectEnabledStateChange;
      }
      
      public function get listData() : ListCollection
      {
         return _listData;
      }
      
      public function get serverName() : String
      {
         return _serverName;
      }
      
      public function get serverId() : String
      {
         return _serverId;
      }
      
      public function get nickname() : String
      {
         return _nickname;
      }
      
      public function get level() : String
      {
         return _level;
      }
      
      public function get selectEnabled() : Boolean
      {
         return _selectEnabled;
      }
      
      public function get currentServerItemIndex() : int
      {
         if(_listData)
         {
            var _loc3_:int = 0;
            var _loc2_:* = _listData.data;
            for(var _loc1_ in _listData.data)
            {
               if(_listData.data[_loc1_] && _listData.data[_loc1_] is ServerListValueObject && String((_listData.data[_loc1_] as ServerListValueObject).id) == serverId)
               {
                  return _loc1_;
               }
            }
         }
         return -1;
      }
      
      public function get maxMigrateServer() : int
      {
         return _maxMigrateServer;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ServerSelectPopup(this);
         return _popup;
      }
      
      public function action_selectServer() : void
      {
         var _loc1_:* = null;
         if(selectedServer.id == player.serverId)
         {
            close();
            return;
         }
         if(selectedServer.user)
         {
            GameModel.instance.actionManager.playerCommands.serverChangeUser(selectedServer.user);
         }
         else
         {
            _loc1_ = new ServerSelectActionPopupMediator(player,selectedServer.id,maxMigrateServer);
            _loc1_.open(Stash.click("server_select",_popup.stashParams));
         }
      }
      
      public function action_selectListItem(param1:ServerListValueObject) : void
      {
         _selectEnabled = param1.id != player.serverId;
         this.selectedServer = param1;
         _signal_selectEnabledStateChange.dispatch();
      }
      
      public function action_listFriends(param1:ServerListValueObject) : void
      {
         var _loc2_:ServerFriendListPopupMediator = new ServerFriendListPopupMediator(player,param1.id,param1.friends);
         var _loc3_:PopupStashEventParams = Stash.click("server_friend_list",_popup.stashParams);
         _loc2_.open(_loc3_);
      }
   }
}
