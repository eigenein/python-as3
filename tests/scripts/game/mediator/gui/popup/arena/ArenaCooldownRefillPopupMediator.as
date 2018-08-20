package game.mediator.gui.popup.arena
{
   import game.command.rpc.arena.CommandArenaSkipCooldown;
   import game.data.storage.arena.ArenaDescription;
   import game.mechanics.boss.mediator.CooldownRefillPopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   
   public class ArenaCooldownRefillPopupMediator extends CooldownRefillPopupMediator
   {
       
      
      protected var arenaDesc:ArenaDescription;
      
      public function ArenaCooldownRefillPopupMediator(param1:Player, param2:ArenaDescription)
      {
         this.arenaDesc = param2;
         super(param1);
      }
      
      override public function action_skipCooldown() : void
      {
         var _loc1_:CommandArenaSkipCooldown = new CommandArenaSkipCooldown();
         if(GameModel.instance.actionManager.executeRPCCommand(_loc1_))
         {
            _loc1_.onClientExecute(handler_commandComplete);
         }
      }
      
      override protected function create() : void
      {
         _cooldown = player.refillable.getById(arenaDesc.refillableCooldownId);
         _attempts = player.refillable.getById(arenaDesc.refillableBattleId);
      }
   }
}
