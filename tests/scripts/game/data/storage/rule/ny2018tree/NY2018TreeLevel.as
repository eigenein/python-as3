package game.data.storage.rule.ny2018tree
{
   public class NY2018TreeLevel
   {
       
      
      private var _id:uint;
      
      private var _assetLevel:int;
      
      private var _giftIds:Array;
      
      public function NY2018TreeLevel(param1:Object)
      {
         super();
         _id = param1.level;
         _assetLevel = param1.assetLevel;
         _giftIds = param1.giftId;
      }
      
      public function get id() : uint
      {
         return _id;
      }
      
      public function get assetLevel() : int
      {
         return _assetLevel;
      }
      
      public function get giftIds() : Array
      {
         return _giftIds;
      }
   }
}
