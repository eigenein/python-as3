package game.data.storage.notification
{
   import game.data.storage.DescriptionStorage;
   
   public class NotificationStorage extends DescriptionStorage
   {
       
      
      public function NotificationStorage()
      {
         super();
         NotificationType.A2U = new NotificationType();
         NotificationType.U2U = new NotificationType();
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc2_:NotificationDescription = new NotificationDescription(param1);
         _items[_loc2_.ident] = _loc2_;
      }
      
      public function getByIdent(param1:String) : NotificationDescription
      {
         return _items[param1];
      }
   }
}
