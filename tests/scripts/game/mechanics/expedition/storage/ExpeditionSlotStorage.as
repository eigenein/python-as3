package game.mechanics.expedition.storage
{
   import flash.utils.Dictionary;
   
   public class ExpeditionSlotStorage
   {
       
      
      protected const _items:Dictionary = new Dictionary();
      
      protected const _stories:Dictionary = new Dictionary();
      
      public function ExpeditionSlotStorage()
      {
         super();
      }
      
      public function init(param1:Object) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc2_ in param1)
         {
            _loc3_ = new ExpeditionSlotDescription(_loc2_);
            _items[_loc3_.id] = _loc3_;
         }
      }
      
      public function getById(param1:int) : ExpeditionSlotDescription
      {
         return _items[param1];
      }
      
      public function initStories(param1:Object) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for each(var _loc2_ in param1)
         {
            _stories[_loc2_.id] = new ExpeditionStoryDescription(_loc2_);
         }
      }
      
      public function getStoryById(param1:int) : ExpeditionStoryDescription
      {
         return _stories[param1];
      }
   }
}
