package game.mechanics.dungeon.storage
{
   import flash.utils.Dictionary;
   
   public class SaveInteractionType
   {
      
      public static const LEVER:SaveInteractionType = new SaveInteractionType("lever");
      
      public static const ENTRANCE:SaveInteractionType = new SaveInteractionType("entrance");
      
      private static var dict:Dictionary;
       
      
      private var _ident:String;
      
      public function SaveInteractionType(param1:String)
      {
         super();
         if(!dict)
         {
            dict = new Dictionary();
         }
         _ident = param1;
         dict[_ident] = this;
      }
      
      public static function getByIdent(param1:String) : SaveInteractionType
      {
         return dict[param1];
      }
      
      public function get ident() : String
      {
         return _ident;
      }
   }
}
