package game.mediator.gui.popup.arena
{
   import game.command.rpc.grand.CommandGrandSkipCooldown;
   import game.data.storage.arena.ArenaDescription;
   import game.model.GameModel;
   import game.model.user.Player;
   
   public class GrandArenaCooldownRefillPopupMediator extends ArenaCooldownRefillPopupMediator
   {
       
      
      public function GrandArenaCooldownRefillPopupMediator(param1:Player, param2:ArenaDescription)
      {
         super(param1,param2);
      }
      
      override public function action_skipCooldown() : void
      {
         var _loc1_:CommandGrandSkipCooldown = GameModel.instance.actionManager.refillableGrandSkipCooldown();
         _loc1_.onClientExecute(handler_commandComplete);
      }
   }
}
