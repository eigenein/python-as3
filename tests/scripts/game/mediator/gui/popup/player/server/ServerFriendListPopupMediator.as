package game.mediator.gui.popup.player.server
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import game.mediator.gui.popup.friends.FriendDataProvider;
   import game.mediator.gui.popup.friends.SearchableFriendListPopupMediatorBase;
   import game.model.user.Player;
   import game.model.user.friends.PlayerFriendEntry;
   import game.view.popup.PopupBase;
   import game.view.popup.player.server.ServerFriendListPopup;
   
   public class ServerFriendListPopupMediator extends SearchableFriendListPopupMediatorBase
   {
       
      
      private var serverId:int;
      
      private var _serverName:String;
      
      public function ServerFriendListPopupMediator(param1:Player, param2:int, param3:Vector.<PlayerFriendEntry>)
      {
         var _loc6_:int = 0;
         super(param1);
         this.serverId = param2;
         _serverName = param2 + " " + Translate.translate("LIB_SERVER_NAME_" + param2);
         valueObjects = new Vector.<FriendDataProvider>();
         var _loc5_:* = param3;
         var _loc4_:int = _loc5_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            valueObjects[_loc6_] = new FriendDataProvider(_loc5_[_loc6_]);
            _loc6_++;
         }
         _friendList = new ListCollection(valueObjects);
      }
      
      public function get serverName() : String
      {
         return _serverName;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ServerFriendListPopup(this);
         return _popup;
      }
   }
}
