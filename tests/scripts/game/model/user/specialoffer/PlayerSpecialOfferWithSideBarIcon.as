package game.model.user.specialoffer
{
   import game.model.user.Player;
   
   public class PlayerSpecialOfferWithSideBarIcon extends PlayerSpecialOfferWithTimer
   {
      
      public static const OFFER_TYPE:String = "sideBarIcon";
       
      
      public var showOnStart:Boolean;
      
      public var showTimeout:int;
      
      public function PlayerSpecialOfferWithSideBarIcon(param1:Player, param2:*)
      {
         super(param1,param2);
         if(param2.clientData)
         {
            showOnStart = param2.clientData.showOnStart;
            showTimeout = param2.clientData.showTimeout;
         }
      }
      
      override public function start(param1:PlayerSpecialOfferData) : void
      {
         super.start(param1);
      }
   }
}
