package game.model.user.freegift
{
   public class PlayerFreeGiftData
   {
       
      
      private var _hasOnceRecievedGiftsFromGroup:Boolean;
      
      public function PlayerFreeGiftData()
      {
         super();
      }
      
      public function get hasOnceRecievedGiftsFromGroup() : Boolean
      {
         return _hasOnceRecievedGiftsFromGroup;
      }
      
      public function init(param1:Object) : void
      {
         _hasOnceRecievedGiftsFromGroup = param1;
      }
   }
}
