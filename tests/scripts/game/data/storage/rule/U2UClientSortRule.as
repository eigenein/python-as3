package game.data.storage.rule
{
   public class U2UClientSortRule
   {
       
      
      private var _day0Value:int;
      
      private var _dayWeight:int;
      
      private var _requestWeight:int;
      
      private var _wipedUserValue:int;
      
      public function U2UClientSortRule(param1:Object)
      {
         super();
         _day0Value = param1.day0Value;
         _dayWeight = param1.dayWeight;
         _requestWeight = param1.requestWeight;
         _wipedUserValue = param1.wipedUserValue;
      }
      
      public function get day0Value() : int
      {
         return _day0Value;
      }
      
      public function get dayWeight() : int
      {
         return _dayWeight;
      }
      
      public function get requestWeight() : int
      {
         return _requestWeight;
      }
      
      public function get wipedUserValue() : int
      {
         return _wipedUserValue;
      }
   }
}
