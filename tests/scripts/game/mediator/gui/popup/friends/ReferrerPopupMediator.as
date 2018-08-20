package game.mediator.gui.popup.friends
{
   import feathers.data.ListCollection;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.friends.PlayerFriendEntry;
   import game.view.popup.PopupBase;
   import game.view.popup.friends.referrer.ReferrerPopup;
   
   public class ReferrerPopupMediator extends SearchableFriendListPopupMediatorBase
   {
       
      
      public function ReferrerPopupMediator(param1:Player)
      {
         var _loc4_:int = 0;
         super(param1);
         valueObjects = new Vector.<FriendDataProvider>();
         var _loc3_:Vector.<PlayerFriendEntry> = param1.friends.getAppFriends();
         var _loc2_:int = _loc3_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            valueObjects[_loc4_] = new FriendDataProvider(_loc3_[_loc4_]);
            _loc4_++;
         }
         _friendList = new ListCollection(valueObjects);
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ReferrerPopup(this);
         return _popup;
      }
      
      public function action_select(param1:FriendDataProvider) : void
      {
         GameModel.instance.actionManager.friends.setInvitedBy(param1.player);
         close();
      }
      
      public function action_selectNone() : void
      {
         GameModel.instance.actionManager.friends.setInvitedBy(null);
         close();
      }
   }
}
