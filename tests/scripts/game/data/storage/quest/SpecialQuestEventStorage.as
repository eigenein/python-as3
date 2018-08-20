package game.data.storage.quest
{
   import flash.utils.Dictionary;
   
   public class SpecialQuestEventStorage
   {
       
      
      private var eventNameLocaleKeyById:Dictionary;
      
      public var chain:Vector.<SpecialQuestEventChainElementDescription>;
      
      public function SpecialQuestEventStorage()
      {
         eventNameLocaleKeyById = new Dictionary();
         super();
      }
      
      public function init(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         chain = new Vector.<SpecialQuestEventChainElementDescription>();
         if(!param1)
         {
            return;
         }
         if(param1.chain)
         {
            var _loc7_:int = 0;
            var _loc6_:* = param1.chain;
            for(var _loc5_ in param1.chain)
            {
               chain.push(new SpecialQuestEventChainElementDescription(param1.chain[_loc5_]));
            }
         }
         chain.sort(_chainSort);
         if(param1.type)
         {
            var _loc9_:int = 0;
            var _loc8_:* = param1.type;
            for each(var _loc4_ in param1.type)
            {
               _loc2_ = _loc4_.id;
               _loc3_ = _loc4_.localeKey;
               eventNameLocaleKeyById[_loc2_] = _loc3_;
            }
         }
      }
      
      public function getEventNameLocaleKeyById(param1:int) : String
      {
         return eventNameLocaleKeyById[param1];
      }
      
      public function getChainByEventId(param1:int) : Vector.<SpecialQuestEventChainElementDescription>
      {
         var _loc3_:int = 0;
         var _loc2_:Vector.<SpecialQuestEventChainElementDescription> = new Vector.<SpecialQuestEventChainElementDescription>();
         _loc3_ = 0;
         while(_loc3_ < chain.length)
         {
            if(chain[_loc3_].eventId == param1)
            {
               _loc2_.push(chain[_loc3_]);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getChainById(param1:int) : SpecialQuestEventChainElementDescription
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < chain.length)
         {
            if(chain[_loc2_].id == param1)
            {
               return chain[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      private function _chainSort(param1:SpecialQuestEventChainElementDescription, param2:SpecialQuestEventChainElementDescription) : int
      {
         return param1.sortOrder - param2.sortOrder;
      }
   }
}
