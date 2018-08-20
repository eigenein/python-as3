package game.data.storage.resource
{
   public class ConsumableEffectDescriptionLootBox extends ConsumableEffectDescription
   {
       
      
      private var _lootBoxIdent:String;
      
      private var _playerChoice:Boolean;
      
      public function ConsumableEffectDescriptionLootBox(param1:Object)
      {
         super(param1);
         _lootBoxIdent = param1.lootBox;
         _playerChoice = param1.playerChoice;
      }
      
      public function get lootBoxIdent() : String
      {
         return _lootBoxIdent;
      }
      
      public function get playerChoice() : Boolean
      {
         return _playerChoice;
      }
   }
}
