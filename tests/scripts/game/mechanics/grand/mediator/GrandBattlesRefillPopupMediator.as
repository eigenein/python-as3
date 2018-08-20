package game.mechanics.grand.mediator
{
   import game.command.rpc.grand.CommandGrandBuyBattles;
   import game.data.storage.arena.ArenaDescription;
   import game.mediator.gui.popup.refillable.ArenaBattlesRefillPopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   
   public class GrandBattlesRefillPopupMediator extends ArenaBattlesRefillPopupMediator
   {
       
      
      public function GrandBattlesRefillPopupMediator(param1:Player, param2:ArenaDescription)
      {
         super(param1,param2);
      }
      
      override public function action_buy() : void
      {
         var _loc1_:CommandGrandBuyBattles = GameModel.instance.actionManager.refillableGrandBattlesBuy();
         _loc1_.onClientExecute(handler_commandComplete);
      }
   }
}
