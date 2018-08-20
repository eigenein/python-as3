package game.mediator.gui.popup.hero.slot
{
   import feathers.core.PopUpManager;
   import game.command.rpc.hero.CommandHeroInsertItem;
   import game.data.storage.gear.GearItemDescription;
   import game.data.storage.level.ItemEnchantLevel;
   import game.mediator.gui.popup.inventory.ItemInfoPopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.view.popup.PopupBase;
   import game.view.popup.hero.slot.HeroSlotPopup;
   import idv.cjcat.signals.Signal;
   
   public class HeroSlotPopupMediator extends ItemInfoPopupMediator
   {
       
      
      private var slot:HeroInventorySlotValueObject;
      
      private var _insertItemSignal:Signal;
      
      public function HeroSlotPopupMediator(param1:Player, param2:HeroInventorySlotValueObject)
      {
         _insertItemSignal = new Signal(HeroInventorySlotValueObject);
         super(param1,param2.item);
         this.slot = param2;
         if(param2)
         {
            param2.hero.signal_promote.add(handler_heroPromote);
         }
      }
      
      override protected function dispose() : void
      {
         if(slot)
         {
            slot.hero.signal_promote.remove(handler_heroPromote);
         }
         super.dispose();
      }
      
      public function get insertItemSignal() : Signal
      {
         return _insertItemSignal;
      }
      
      public function get itemInserted() : Boolean
      {
         return slot.slotState == 2;
      }
      
      public function get heroLevelAcceptable() : Boolean
      {
         return (slot.item as GearItemDescription).heroLevel <= slot.hero.level.level;
      }
      
      public function get itemIsEnchantable() : Boolean
      {
         return slot.item.color.getNextEnchantLevel(slot.enchantValue);
      }
      
      public function get itemOwned() : Boolean
      {
         return player.inventory.getItemCollection().hasItem(slot.item);
      }
      
      public function get itemIsDroppable() : Boolean
      {
         return player.missions.getItemDropList(slot.item).length > 0;
      }
      
      public function get itemIsInsertable() : Boolean
      {
         return itemOwned && !itemInserted && heroLevelAcceptable;
      }
      
      public function get enchantLevel() : int
      {
         var _loc1_:ItemEnchantLevel = slot.item.color.getEnchantLevel(slot.enchantValue);
         if(!_loc1_)
         {
            return 0;
         }
         return _loc1_.level;
      }
      
      public function get maxEnchantLevel() : int
      {
         var _loc1_:ItemEnchantLevel = slot.item.color.getMaxEnchantLevel();
         if(!_loc1_)
         {
            return 0;
         }
         return _loc1_.level;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new HeroSlotPopup(this);
         return _popup;
      }
      
      public function action_insertItem() : void
      {
         var _loc1_:* = null;
         if(!slot.hero.isItemSlotBusy(slot.slot))
         {
            _loc1_ = GameModel.instance.actionManager.hero.heroInsertItem(slot.hero,slot.slot);
            _loc1_.onClientExecute(onAction_insertItem);
         }
      }
      
      public function action_enchantItem() : void
      {
      }
      
      protected function onAction_insertItem(param1:CommandHeroInsertItem) : void
      {
         signal_amountChanged.dispatch();
         _insertItemSignal.dispatch(slot);
         PopUpManager.removePopUp(_popup);
      }
      
      private function handler_heroPromote(param1:PlayerHeroEntry) : void
      {
         close();
      }
   }
}
