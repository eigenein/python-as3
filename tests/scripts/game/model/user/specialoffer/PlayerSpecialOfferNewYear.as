package game.model.user.specialoffer
{
   import game.model.user.Player;
   
   public class PlayerSpecialOfferNewYear extends PlayerSpecialOfferEvent
   {
      
      public static const OFFER_TYPE:String = "newYear2016Tree";
       
      
      public function PlayerSpecialOfferNewYear(param1:Player, param2:*)
      {
         super(param1,param2);
      }
   }
}
