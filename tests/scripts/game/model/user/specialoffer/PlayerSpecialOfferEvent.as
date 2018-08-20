package game.model.user.specialoffer
{
   import game.model.user.Player;
   
   public class PlayerSpecialOfferEvent extends PlayerSpecialOfferEntry
   {
      
      public static const PHASE_1:uint = 0;
      
      public static const PHASE_2:uint = 1;
      
      public static const PHASE_3:uint = 2;
       
      
      public var endTime:Number;
      
      public var currentPhase:uint;
      
      public var boxesForBuy:Array;
      
      public var boxesOpenForbidden:Array;
      
      public function PlayerSpecialOfferEvent(param1:Player, param2:*)
      {
         super(param1,param2);
         initialize(param2);
      }
      
      override protected function update(param1:*) : void
      {
         super.update(param1);
         initialize(param1);
      }
      
      private function initialize(param1:*) : void
      {
         if(param1.offerData)
         {
            endTime = param1.endTime;
            boxesForBuy = param1.offerData.boxesForBuy;
            boxesOpenForbidden = param1.offerData.boxesOpenForbidden;
            currentPhase = param1.offerData.phaseId;
         }
      }
   }
}
