package game.data.storage.quest
{
   public class SpecialQuestEventChainElementDescription
   {
       
      
      public var id:int;
      
      public var eventId:int;
      
      public var localeKey:String;
      
      public var sortOrder:int;
      
      public function SpecialQuestEventChainElementDescription(param1:Object)
      {
         super();
         this.id = param1.id;
         this.eventId = param1.eventId;
         this.localeKey = param1.localeKey;
         this.sortOrder = param1.sortOrder;
      }
   }
}
