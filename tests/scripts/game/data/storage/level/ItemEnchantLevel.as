package game.data.storage.level
{
   public class ItemEnchantLevel extends LevelBase
   {
       
      
      public function ItemEnchantLevel(param1:Object)
      {
         super(param1);
         exp = param1.enchantValue;
      }
      
      public function get enchantValue() : int
      {
         return exp;
      }
   }
}
