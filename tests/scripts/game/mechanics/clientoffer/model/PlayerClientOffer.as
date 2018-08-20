package game.mechanics.clientoffer.model
{
   import game.data.storage.DataStorage;
   import game.mechanics.clientoffer.storage.ClientOfferBillingBonusReminderDescription;
   import game.model.user.Player;
   
   public class PlayerClientOffer
   {
       
      
      private var player:Player;
      
      public function PlayerClientOffer(param1:Player)
      {
         super();
         this.player = param1;
      }
      
      public function init() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = DataStorage.rule.clientOffer;
         for each(var _loc1_ in DataStorage.rule.clientOffer)
         {
            createEntryByDescription(_loc1_);
         }
      }
      
      protected function createEntryByDescription(param1:Object) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(param1.ident == "billingBonusReminder")
         {
            _loc3_ = new ClientOfferBillingBonusReminderDescription(param1);
            _loc2_ = new ClientOfferBillingBonusReminder(player,_loc3_);
            _loc2_.init();
         }
      }
   }
}
