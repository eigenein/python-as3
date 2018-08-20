package game.mediator.gui.popup.friends
{
   import feathers.data.ListCollection;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import idv.cjcat.signals.Signal;
   
   public class SearchableFriendListPopupMediatorBase extends PopupMediator
   {
       
      
      protected var valueObjects:Vector.<FriendDataProvider>;
      
      protected var _friendList:ListCollection;
      
      protected var _signal_updateData:Signal;
      
      public function SearchableFriendListPopupMediatorBase(param1:Player)
      {
         _signal_updateData = new Signal(Boolean);
         super(param1);
      }
      
      public function get friendList() : ListCollection
      {
         return _friendList;
      }
      
      public function get signal_updateData() : Signal
      {
         return _signal_updateData;
      }
      
      public function action_searchUpdate(param1:String) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         param1 = param1.toLowerCase();
         var _loc2_:Vector.<FriendDataProvider> = new Vector.<FriendDataProvider>();
         var _loc3_:int = valueObjects.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = valueObjects[_loc5_];
            if(param1 == "" || _loc4_.name.toLowerCase().indexOf(param1) != -1 || _loc4_.nickname.toLowerCase().indexOf(param1) != -1)
            {
               _loc2_.push(_loc4_);
            }
            _loc5_++;
         }
         _friendList = new ListCollection(_loc2_);
         _signal_updateData.dispatch(param1 == "");
      }
   }
}
