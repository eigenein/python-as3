package game.model.user.easteregg
{
   public class PlayerEasterEggData
   {
       
      
      private var _isAvailable_pirateTreasure:Boolean;
      
      public function PlayerEasterEggData()
      {
         super();
      }
      
      public function get isAvailable_pirateTreasure() : Boolean
      {
         return _isAvailable_pirateTreasure;
      }
      
      public function initialize(param1:Object) : void
      {
         _isAvailable_pirateTreasure = param1;
      }
      
      public function action_farmTreasure() : void
      {
         _isAvailable_pirateTreasure = false;
      }
   }
}
