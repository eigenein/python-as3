package game.mediator.gui.popup.hero.evolve
{
   import game.command.rpc.RPCCommandBase;
   import game.data.storage.hero.HeroDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.hero.HeroEntryValueObject;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.PopupBase;
   import game.view.popup.hero.evolve.HeroEvolveCostPopup;
   import idv.cjcat.signals.Signal;
   
   public class HeroEvolveCostPopupMediator extends PopupMediator
   {
       
      
      private var _signal_complete:Signal;
      
      private var _entryValueObject:HeroEntryValueObject;
      
      public function HeroEvolveCostPopupMediator(param1:Player, param2:HeroDescription)
      {
         _signal_complete = new Signal();
         super(param1);
         _entryValueObject = new HeroEntryValueObject(param2,param1.heroes.getById(param2.id));
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
         return !_entryValueObject.heroEntry;
      }
      
      public function get name() : String
      {
         return _entryValueObject.hero.name;
      }
      
      public function get entryValueObject() : HeroEntryValueObject
      {
         return _entryValueObject;
      }
      
      public function get evolveCost() : InventoryItem
      {
         if(_entryValueObject.heroEntry)
         {
            if(_entryValueObject.heroEntry.star.next)
            {
               return _entryValueObject.heroEntry.star.next.star.evolveGoldCost.outputDisplay[0];
            }
         }
         return _entryValueObject.hero.startingStar.star.summonGoldCost.outputDisplay[0];
      }
      
      public function action_evolve() : void
      {
         var _loc1_:* = null;
         if(_entryValueObject.heroEntry)
         {
            _loc1_ = GameModel.instance.actionManager.hero.heroEvolve(_entryValueObject.heroEntry as PlayerHeroEntry);
         }
         else
         {
            _loc1_ = GameModel.instance.actionManager.hero.heroCraft(_entryValueObject.hero);
         }
         _loc1_.onClientExecute(handler_evolveComplete);
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new HeroEvolveCostPopup(this);
         return _popup;
      }
      
      private function handler_evolveComplete(param1:RPCCommandBase) : void
      {
         _signal_complete.dispatch();
         close();
      }
   }
}
