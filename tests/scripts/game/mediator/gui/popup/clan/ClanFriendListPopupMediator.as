package game.mediator.gui.popup.clan
{
   import feathers.data.ListCollection;
   import game.mediator.gui.popup.friends.FriendDataProvider;
   import game.mediator.gui.popup.friends.SearchableFriendListPopupMediatorBase;
   import game.model.user.Player;
   import game.model.user.friends.PlayerFriendEntry;
   import game.view.popup.PopupBase;
   import game.view.popup.clan.friendlist.ClanFriendListPopup;
   
   public class ClanFriendListPopupMediator extends SearchableFriendListPopupMediatorBase
   {
       
      
      private var _friends:Vector.<PlayerFriendEntry>;
      
      private var _clan:ClanValueObject;
      
      public function ClanFriendListPopupMediator(param1:Player, param2:Vector.<PlayerFriendEntry>, param3:ClanValueObject)
      {
         var _loc6_:int = 0;
         super(param1);
         this._clan = param3;
         this._friends = param2;
         valueObjects = new Vector.<FriendDataProvider>();
         var _loc5_:Vector.<PlayerFriendEntry> = _friends;
         var _loc4_:int = _loc5_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            valueObjects[_loc6_] = new FriendDataProvider(_loc5_[_loc6_]);
            _loc6_++;
         }
         _friendList = new ListCollection(valueObjects);
      }
      
      public function get friends() : Vector.<PlayerFriendEntry>
      {
         return _friends;
      }
      
      public function get clan() : ClanValueObject
      {
         return _clan;
      }
      
      public function get clanName() : String
      {
         return _clan.title;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ClanFriendListPopup(this);
         return _popup;
      }
   }
}
