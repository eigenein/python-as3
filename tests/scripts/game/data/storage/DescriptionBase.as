package game.data.storage
{
   public class DescriptionBase
   {
       
      
      protected var _id:uint;
      
      protected var _name:String;
      
      protected var _descText:String;
      
      public function DescriptionBase()
      {
         super();
      }
      
      public function get id() : uint
      {
         return _id;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get descText() : String
      {
         return _descText;
      }
      
      public function applyLocale() : void
      {
      }
   }
}
