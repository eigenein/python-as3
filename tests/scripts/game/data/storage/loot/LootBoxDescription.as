package game.data.storage.loot
{
   public class LootBoxDescription
   {
       
      
      public var ident:String;
      
      public var drop:Vector.<LootBoxDropItemDescription>;
      
      public function LootBoxDescription(param1:Object)
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         super();
         ident = param1.ident;
         var _loc4_:Array = param1.dropTable;
         if(_loc4_)
         {
            drop = new Vector.<LootBoxDropItemDescription>();
            _loc3_ = 0;
            while(_loc3_ < _loc4_.length)
            {
               drop.push(new LootBoxDropItemDescription(_loc4_[_loc3_]));
               _loc3_++;
            }
         }
      }
   }
}
