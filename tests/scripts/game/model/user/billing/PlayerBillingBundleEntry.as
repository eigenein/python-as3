package game.model.user.billing
{
   import game.data.storage.DataStorage;
   import game.data.storage.bundle.BundleDescription;
   
   public class PlayerBillingBundleEntry
   {
       
      
      private var _id:int;
      
      private var _available:Boolean;
      
      private var _bought:int;
      
      private var _endTime:int;
      
      public function PlayerBillingBundleEntry(param1:Object)
      {
         super();
         _id = param1.id;
         _available = param1.available;
         _bought = param1.bought;
         _endTime = param1.endTime;
      }
      
      public function dispose() : void
      {
         _available = false;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get groupId() : int
      {
         return desc.groupId;
      }
      
      public function get available() : Boolean
      {
         return _available;
      }
      
      public function get bought() : int
      {
         return _bought;
      }
      
      public function get endTime() : int
      {
         return _endTime;
      }
      
      public function get desc() : BundleDescription
      {
         return DataStorage.bundle.getById(_id) as BundleDescription;
      }
   }
}
