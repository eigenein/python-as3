package game.model.user.specialoffer
{
   import game.model.user.Player;
   
   public class PlayerSpecialOfferEnergySpentWithoutTimer extends PlayerSpecialOfferEnergySpent
   {
      
      public static const OFFER_TYPE:String = "energySpentWithoutTimer";
       
      
      public function PlayerSpecialOfferEnergySpentWithoutTimer(param1:Player, param2:*)
      {
         super(param1,param2);
      }
      
      override public function get hasEndTime() : Boolean
      {
         return false;
      }
   }
}
