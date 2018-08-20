package game.model.user.specialoffer
{
   import engine.core.utils.property.BooleanPropertyWriteable;
   import feathers.core.PopUpManager;
   import game.command.rpc.player.CommandOfferFarmReward;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.view.popup.skincoinsdailyreward.SkinCoinsDailyRewardPopup;
   
   public class PlayerSpecialOfferDailyReward extends PlayerSpecialOfferEntry
   {
      
      public static const OFFER_TYPE:String = "dailyReward";
       
      
      private var _commandFarm:CommandOfferFarmReward;
      
      public var freeRewardObtained:BooleanPropertyWriteable;
      
      public function PlayerSpecialOfferDailyReward(param1:Player, param2:*)
      {
         freeRewardObtained = new BooleanPropertyWriteable(false);
         super(param1,param2);
      }
      
      public function action_farm_daily_reward() : void
      {
         if(!_commandFarm)
         {
            _commandFarm = GameModel.instance.actionManager.playerCommands.specialOfferFarmReward(id);
            _commandFarm.onClientExecute(handler_commandReward);
         }
      }
      
      override protected function update(param1:*) : void
      {
         super.update(param1);
         freeRewardObtained.value = param1.freeRewardObtained;
      }
      
      private function handler_commandReward(param1:CommandOfferFarmReward) : void
      {
         freeRewardObtained.value = true;
         param1.farmReward(player);
         var _loc2_:SkinCoinsDailyRewardPopup = new SkinCoinsDailyRewardPopup(param1.reward.outputDisplay);
         PopUpManager.addPopUp(_loc2_);
      }
   }
}
