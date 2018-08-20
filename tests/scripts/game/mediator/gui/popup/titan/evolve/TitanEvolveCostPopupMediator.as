package game.mediator.gui.popup.titan.evolve
{
   import game.command.rpc.RPCCommandBase;
   import game.data.storage.titan.TitanDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.mediator.gui.popup.titan.TitanEntryValueObject;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerTitanEntry;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.PopupBase;
   import idv.cjcat.signals.Signal;
   
   public class TitanEvolveCostPopupMediator extends PopupMediator
   {
       
      
      private var _signal_complete:Signal;
      
      private var _entryValueObject:TitanEntryValueObject;
      
      public function TitanEvolveCostPopupMediator(param1:Player, param2:TitanDescription)
      {
         _signal_complete = new Signal();
         super(param1);
         _entryValueObject = new TitanEntryValueObject(param2,param1.titans.getById(param2.id));
      }
      
      public function get signal_complete() : Signal
      {
         return _signal_complete;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_gold(true);
         return _loc1_;
      }
      
      public function get isSummon() : Boolean
      {
         return !_entryValueObject.titanEntry;
      }
      
      public function get name() : String
      {
         return _entryValueObject.titan.name;
      }
      
      public function get entryValueObject() : TitanEntryValueObject
      {
         return _entryValueObject;
      }
      
      public function get evolveCost() : InventoryItem
      {
         if(_entryValueObject.titanEntry)
         {
            if(_entryValueObject.titanEntry.star.next)
            {
               return _entryValueObject.titanEntry.star.next.star.evolveGoldCost.outputDisplay[0];
            }
         }
         return _entryValueObject.titan.startingStar.star.summonGoldCost.outputDisplay[0];
      }
      
      public function action_evolve() : void
      {
         var _loc1_:* = null;
         if(_entryValueObject.titanEntry)
         {
            _loc1_ = GameModel.instance.actionManager.titan.titanEvolve(_entryValueObject.titanEntry as PlayerTitanEntry);
         }
         else
         {
            _loc1_ = GameModel.instance.actionManager.titan.titanCraft(_entryValueObject.titan);
         }
         _loc1_.onClientExecute(handler_evolveComplete);
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TitanEvolveCostPopup(this);
         return _popup;
      }
      
      private function handler_evolveComplete(param1:RPCCommandBase) : void
      {
         _signal_complete.dispatch();
         close();
      }
   }
}
