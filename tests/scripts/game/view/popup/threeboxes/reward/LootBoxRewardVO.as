package game.view.popup.threeboxes.reward
{
   import game.mediator.gui.component.RewardValueObjectList;
   import game.model.user.Player;
   import game.model.user.specialoffer.PlayerSpecialOfferLootBox;
   
   public class LootBoxRewardVO
   {
       
      
      private var player:Player;
      
      public var box:PlayerSpecialOfferLootBox;
      
      public var pack:Boolean;
      
      public var reward:RewardValueObjectList;
      
      public function LootBoxRewardVO(param1:Player, param2:PlayerSpecialOfferLootBox, param3:Boolean, param4:RewardValueObjectList)
      {
         super();
         this.player = param1;
         this.box = param2;
         this.pack = param3;
         this.reward = param4;
      }
   }
}
