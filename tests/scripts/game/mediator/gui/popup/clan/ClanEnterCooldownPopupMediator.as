package game.mediator.gui.popup.clan
{
   import game.command.rpc.clan.CommandClanSkipEnterCooldown;
   import game.data.storage.DataStorage;
   import game.data.storage.refillable.RefillableDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.refillable.PlayerRefillableEntry;
   import game.util.TimeFormatter;
   import game.view.popup.PopupBase;
   import game.view.popup.clan.ClanEnterCooldownPopup;
   import idv.cjcat.signals.Signal;
   
   public class ClanEnterCooldownPopupMediator extends PopupMediator
   {
       
      
      private var refillable:PlayerRefillableEntry;
      
      private var _signal_cooldownSkipped:Signal;
      
      private var _clan:ClanValueObject;
      
      private var _skipCost:InventoryItem;
      
      public function ClanEnterCooldownPopupMediator(param1:ClanValueObject, param2:Player)
      {
         _signal_cooldownSkipped = new Signal(ClanEnterCooldownPopupMediator);
         super(param2);
         this._clan = param1;
         var _loc4_:RefillableDescription = DataStorage.refillable.getByIdent("clanReenter_cooldown");
         refillable = param2.refillable.getById(_loc4_.id);
         var _loc3_:String = TimeFormatter.toMS2(refillable.refillTimeLeft);
         _skipCost = refillable.refillCost.outputDisplay[0];
      }
      
      override protected function dispose() : void
      {
         refillable = null;
         super.dispose();
      }
      
      public function get signal_cooldownSkipped() : Signal
      {
         return _signal_cooldownSkipped;
      }
      
      public function get clan() : ClanValueObject
      {
         return _clan;
      }
      
      public function get skipCost() : InventoryItem
      {
         return _skipCost;
      }
      
      public function get timeLeft() : String
      {
         return TimeFormatter.toMS2(refillable.refillTimeLeft);
      }
      
      public function get canAutoClose() : Boolean
      {
         return refillable.refillTimeLeft <= 0 || refillable.value >= 1;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ClanEnterCooldownPopup(this);
         return _popup;
      }
      
      public function action_skipCooldown() : void
      {
         var _loc1_:CommandClanSkipEnterCooldown = GameModel.instance.actionManager.clan.clanSkipEnterCooldown();
         _loc1_.onClientExecute(handler_commandComplete);
      }
      
      private function handler_commandComplete(param1:CommandClanSkipEnterCooldown) : void
      {
         _signal_cooldownSkipped.dispatch(this);
         close();
      }
   }
}
