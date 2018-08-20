package game.data.storage.quest
{
   import game.data.storage.DataStorage;
   
   public class QuestNormalDescription extends QuestDescription
   {
       
      
      private var _chain:QuestChainDescription;
      
      private var _chainOrder:int;
      
      public function QuestNormalDescription(param1:Object)
      {
         super(param1);
         _chain = DataStorage.quest.getChain(param1.chain);
         _chainOrder = param1.chainOrder;
      }
      
      public function get chain() : QuestChainDescription
      {
         return _chain;
      }
      
      public function get chainOrder() : int
      {
         return _chainOrder;
      }
   }
}
