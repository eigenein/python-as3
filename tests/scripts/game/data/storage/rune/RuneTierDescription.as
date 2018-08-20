package game.data.storage.rune
{
   import game.data.storage.DataStorage;
   import game.data.storage.enum.lib.HeroColor;
   
   public class RuneTierDescription
   {
       
      
      private var _id:int;
      
      private var _color:HeroColor;
      
      public function RuneTierDescription(param1:*)
      {
         super();
         _id = param1.id;
         _color = DataStorage.enum.getById_HeroColor(param1.color);
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get color() : HeroColor
      {
         return _color;
      }
   }
}
