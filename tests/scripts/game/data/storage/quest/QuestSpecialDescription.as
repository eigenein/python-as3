package game.data.storage.quest
{
   public class QuestSpecialDescription extends QuestDescription
   {
       
      
      private var _eventChainId:int;
      
      private var _daily:Boolean;
      
      private var _chainOrder:int;
      
      public function QuestSpecialDescription(param1:Object)
      {
         super(param1);
         _eventChainId = param1.eventChainId;
         _daily = param1.daily;
         _chainOrder = param1.chainOrder;
      }
      
      public function get eventChainId() : int
      {
         return _eventChainId;
      }
      
      public function get daily() : Boolean
      {
         return _daily;
      }
      
      public function get chainOrder() : int
      {
         return _chainOrder;
      }
   }
}
