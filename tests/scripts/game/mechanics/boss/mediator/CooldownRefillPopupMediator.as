package game.mechanics.boss.mediator
{
   import avmplus.getQualifiedClassName;
   import game.command.rpc.RefillableRefillCommand;
   import game.mechanics.boss.model.CommandBossSkipCooldown;
   import game.mechanics.boss.popup.BossCooldownRefillPopup;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.refillable.PlayerRefillableEntry;
   import game.screen.navigator.IRefillableNavigatorResult;
   import game.view.popup.PopupBase;
   import idv.cjcat.signals.Signal;
   
   public class CooldownRefillPopupMediator extends PopupMediator implements IRefillableNavigatorResult
   {
       
      
      protected var _cooldown:PlayerRefillableEntry;
      
      protected var _attempts:PlayerRefillableEntry;
      
      protected var _closeAfterRefill:Boolean = true;
      
      private var _signal_refillComplete:Signal;
      
      private var _signal_refillCancel:Signal;
      
      public function CooldownRefillPopupMediator(param1:Player)
      {
         _signal_refillComplete = new Signal();
         _signal_refillCancel = new Signal();
         super(param1);
         create();
      }
      
      public function set closeAfterRefill(param1:Boolean) : void
      {
         _closeAfterRefill = param1;
      }
      
      public function get signal_refillComplete() : Signal
      {
         return _signal_refillComplete;
      }
      
      public function get signal_refillCancel() : Signal
      {
         return _signal_refillCancel;
      }
      
      public function get battleCooldown() : int
      {
         return _cooldown.refillTimeLeft;
      }
      
      public function get cost_skipCooldown() : InventoryItem
      {
         return _cooldown.refillCost.outputDisplay[0];
      }
      
      public function get skippedCooldowns() : int
      {
         return _cooldown.value;
      }
      
      public function get attemptsCount() : int
      {
         return _attempts.value;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney(true);
         return _loc1_;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new BossCooldownRefillPopup(this);
         _popup.stashParams.windowName = getQualifiedClassName(this);
         return _popup;
      }
      
      public function action_skipCooldown() : void
      {
         var _loc1_:CommandBossSkipCooldown = new CommandBossSkipCooldown();
         if(GameModel.instance.actionManager.executeRPCCommand(_loc1_))
         {
            _loc1_.onClientExecute(handler_commandComplete);
         }
      }
      
      protected function create() : void
      {
         _cooldown = player.boss.cooldown;
         _attempts = player.boss.tries;
      }
      
      protected function handler_commandComplete(param1:RefillableRefillCommand) : void
      {
         close();
         _signal_refillComplete.dispatch();
      }
   }
}
