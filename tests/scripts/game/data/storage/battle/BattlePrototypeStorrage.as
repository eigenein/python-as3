package game.data.storage.battle
{
   import game.data.storage.DescriptionStorage;
   
   public class BattlePrototypeStorrage extends DescriptionStorage
   {
       
      
      protected var items:Vector.<BattleDescription>;
      
      public function BattlePrototypeStorrage()
      {
         super();
         items = new Vector.<BattleDescription>();
      }
      
      public function get count() : int
      {
         return items.length;
      }
      
      public function getByIndex(param1:int) : BattleDescription
      {
         if(param1 >= items.length)
         {
            return null;
         }
         return items[param1];
      }
      
      public function getByName(param1:String) : BattleDescription
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc2_:BattleDescription = new BattleDescription(param1);
         items.push(_loc2_);
         _items[_loc2_.id] = _loc2_;
      }
   }
}
