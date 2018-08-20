package game.command.rpc
{
   import flash.utils.Dictionary;
   
   public class CommandResultQuestUpdateData
   {
       
      
      private var _updates:Dictionary;
      
      private var _newQuests:Dictionary;
      
      public function CommandResultQuestUpdateData()
      {
         super();
         _updates = new Dictionary();
         _newQuests = new Dictionary();
      }
      
      public function get updates() : Array
      {
         var _loc1_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = _updates;
         for each(var _loc2_ in _updates)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function get newQuests() : Array
      {
         var _loc1_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = _newQuests;
         for each(var _loc2_ in _newQuests)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function addQuestUpdate(param1:Array) : void
      {
         var _loc3_:int = 0;
         if(!param1)
         {
            return;
         }
         var _loc2_:int = param1.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _updates[param1[_loc3_].id] = param1[_loc3_];
            _loc3_++;
         }
      }
      
      public function addNewQuests(param1:Array) : void
      {
         var _loc3_:int = 0;
         if(!param1)
         {
            return;
         }
         var _loc2_:int = param1.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _newQuests[param1[_loc3_].id] = param1[_loc3_];
            _loc3_++;
         }
      }
   }
}
