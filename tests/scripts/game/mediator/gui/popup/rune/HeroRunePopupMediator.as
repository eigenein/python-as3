package game.mediator.gui.popup.rune
{
   import feathers.data.ListCollection;
   import flash.utils.Dictionary;
   import game.command.rpc.hero.CommandHeroEnchantRune;
   import game.command.rpc.hero.CommandHeroEnchantRuneStaromoney;
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.resource.ConsumableDescription;
   import game.data.storage.rune.RuneLevelDescription;
   import game.mediator.gui.component.SelectableInventoryItemValueObject;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.clan.ClanActivityRewardPopupMediator;
   import game.mediator.gui.popup.hero.BattleStatValueObject;
   import game.mediator.gui.popup.hero.PlayerHeroEntryValueObject;
   import game.mediator.gui.popup.hero.PlayerHeroListValueObject;
   import game.mediator.gui.popup.hero.PlayerHeroRuneListValueObject;
   import game.mediator.gui.popup.hero.slot.BattleStatValueObjectProvider;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.inventory.InventoryFragmentItem;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.PopupBase;
   import game.view.popup.hero.rune.HeroRunePopup;
   import idv.cjcat.signals.Signal;
   
   public class HeroRunePopupMediator extends PopupMediator
   {
      
      public static const TAB_SYMBOLS:String = "tab_symbols";
      
      public static const TAB_ELEMENTS:String = "tab_elements";
       
      
      private var _hero:PlayerHeroEntryValueObject;
      
      private var _rune:PlayerHeroRuneValueObject;
      
      private var _selectedValue:int;
      
      private var selectedItemsAmounts:Dictionary;
      
      private const enchantGemProgress:HeroRuneEnchantProgress = new HeroRuneEnchantProgress();
      
      private var _oldStats:Vector.<BattleStatValueObject>;
      
      public const signal_heroUpdated:Signal = new Signal();
      
      public const signal_runeUpdated:Signal = new Signal();
      
      public const signal_selectionUpdated:Signal = new Signal();
      
      public const signal_runeEnchanted:Signal = new Signal();
      
      public const signal_statsUpdated:Signal = new Signal(Vector.<BattleStatValueObject>);
      
      public const runeMediator:PlayerHeroRuneMediator = new PlayerHeroRuneMediator();
      
      public const enchantProgress:HeroRuneEnchantProgress = new HeroRuneEnchantProgress();
      
      public const inventoryItemListDataProvider:ListCollection = new ListCollection();
      
      public const miniHeroListDataProvider:ListCollection = new ListCollection();
      
      private var _tabs:Vector.<String>;
      
      public function HeroRunePopupMediator(param1:Player, param2:HeroDescription)
      {
         selectedItemsAmounts = new Dictionary();
         super(param1);
         _tabs = new Vector.<String>();
         _tabs.push("tab_symbols");
         _tabs.push("tab_elements");
         setHero(param2);
         createMiniList();
         updateItems();
         runeMediator.signal_updated.add(handler_runesUpdated);
      }
      
      public function get hero() : PlayerHeroEntryValueObject
      {
         return _hero;
      }
      
      public function get rune() : PlayerHeroRuneValueObject
      {
         return _rune;
      }
      
      public function get miniHeroListSelectedItem() : PlayerHeroEntryValueObject
      {
         var _loc3_:int = 0;
         var _loc2_:Vector.<PlayerHeroListValueObject> = miniHeroListDataProvider.data as Vector.<PlayerHeroListValueObject>;
         if(!_loc2_)
         {
            return null;
         }
         var _loc1_:int = _loc2_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            if(_loc2_[_loc3_].hero == hero.hero)
            {
               return _loc2_[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney(true);
         _loc1_.requre_gold(true);
         return _loc1_;
      }
      
      public function get noItems() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = inventoryItemListDataProvider.data;
         for each(var _loc1_ in inventoryItemListDataProvider.data)
         {
            if(_loc1_.ownedAmount > 0)
            {
               return false;
            }
         }
         return true;
      }
      
      public function get tabs() : Vector.<String>
      {
         return _tabs;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new HeroRunePopup(this);
         return new HeroRunePopup(this);
      }
      
      public function action_miniListSelectionUpdate(param1:PlayerHeroEntryValueObject) : void
      {
         setHero(param1.hero);
      }
      
      public function action_selectRune(param1:PlayerHeroRuneValueObject) : void
      {
         setRune(param1);
      }
      
      public function action_enchant() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function action_enchantStarmoney() : void
      {
         _oldStats = BattleStatValueObjectProvider.fromBattleStats(hero.playerEntry.battleStats);
         var _loc1_:CommandHeroEnchantRuneStaromoney = GameModel.instance.actionManager.hero.heroEnchantRuneStarmoney(hero.heroEntry as PlayerHeroEntry,_rune.tier);
         _loc1_.onClientExecute(handler_commandEnchantRuneStarmoney);
      }
      
      public function action_toActivityRewards() : void
      {
         var _loc1_:* = null;
         if(player.clan.clan)
         {
            _loc1_ = new ClanActivityRewardPopupMediator(player);
            _loc1_.open();
         }
      }
      
      public function clear() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function getGemProgress() : HeroRuneEnchantProgress
      {
         enchantGemProgress.setupValues(_hero.level,_rune,rune.nextLevelValue - rune.currentValue);
         return enchantGemProgress;
      }
      
      protected function removeOvercap() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function setHero(param1:HeroDescription) : void
      {
         var _loc2_:PlayerHeroEntry = player.heroes.getById(param1.id);
         _hero = new PlayerHeroEntryValueObject(param1,_loc2_);
         signal_heroUpdated.dispatch();
         runeMediator.setHero(_loc2_);
         setRune(runeMediator.runes[0]);
         clear();
      }
      
      private function setRune(param1:PlayerHeroRuneValueObject) : void
      {
         _rune = param1;
         enchantProgress.setupValues(_hero.level,_rune,_selectedValue);
         signal_runeUpdated.dispatch();
         clear();
      }
      
      private function createMiniList() : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc7_:* = null;
         var _loc1_:Vector.<PlayerHeroListValueObject> = new Vector.<PlayerHeroListValueObject>();
         var _loc2_:Vector.<HeroDescription> = DataStorage.hero.getPlayableHeroes();
         var _loc3_:int = _loc2_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc5_ = _loc2_[_loc6_];
            if(_loc5_.isPlayable)
            {
               _loc4_ = player.heroes.getById(_loc5_.id);
               if(_loc4_)
               {
                  _loc7_ = new PlayerHeroRuneListValueObject(_loc5_,player);
                  _loc1_.push(_loc7_);
               }
            }
            _loc6_++;
         }
         _loc1_.sort(PlayerHeroListValueObject.sort);
         miniHeroListDataProvider.data = _loc1_;
      }
      
      private function updateItems() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc3_:Vector.<HeroRunePopupInventoryItemValueObject> = new Vector.<HeroRunePopupInventoryItemValueObject>();
         var _loc4_:Vector.<ConsumableDescription> = DataStorage.consumable.getItemsByType("enchantValue");
         var _loc7_:int = 0;
         var _loc6_:* = _loc4_;
         for each(var _loc5_ in _loc4_)
         {
            _loc1_ = new InventoryItem(_loc5_);
            _loc2_ = new HeroRunePopupInventoryItemValueObject(player,_loc1_,this);
            _loc3_.push(_loc2_);
            _loc2_.signal_selectedAmountChanged.add(handler_selectedAmountChanged);
         }
         _loc3_.sort(SelectableInventoryItemValueObject.sort);
         inventoryItemListDataProvider.data = _loc3_;
      }
      
      private function updateItemsOthers() : void
      {
         var _loc4_:* = null;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:Vector.<HeroRunePopupInventoryItemValueObject> = new Vector.<HeroRunePopupInventoryItemValueObject>();
         var _loc7_:int = 0;
         var _loc6_:* = [InventoryItemType.GEAR,InventoryItemType.SCROLL];
         for each(var _loc5_ in [InventoryItemType.GEAR,InventoryItemType.SCROLL])
         {
            _loc4_ = player.inventory.getItemCollection().getCollectionByType(_loc5_).getArray();
            _loc1_ = _loc4_.length;
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               _addItem(_loc4_[_loc3_],_loc2_);
               _loc3_++;
            }
         }
         var _loc9_:int = 0;
         var _loc8_:* = [InventoryItemType.GEAR,InventoryItemType.SCROLL];
         for each(_loc5_ in [InventoryItemType.GEAR,InventoryItemType.SCROLL])
         {
            _loc4_ = player.inventory.getFragmentCollection().getCollectionByType(_loc5_).getArray();
            _loc1_ = _loc4_.length;
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               _addItem(_loc4_[_loc3_],_loc2_);
               _loc3_++;
            }
         }
         _loc2_.sort(SelectableInventoryItemValueObject.sort);
         inventoryItemListDataProvider.data = _loc2_;
      }
      
      private function _addItem(param1:InventoryItem, param2:Vector.<HeroRunePopupInventoryItemValueObject>) : Boolean
      {
         var _loc3_:* = null;
         if(param1 && param1.item && !param1.item.hidden && (param1.item.enchantValue > 0 || param1.item.fragmentEnchantValue > 0))
         {
            _loc3_ = new HeroRunePopupInventoryItemValueObject(player,param1,this);
            param2.push(_loc3_);
            _loc3_.signal_selectedAmountChanged.add(handler_selectedAmountChanged);
            return true;
         }
         return false;
      }
      
      private function whenRuneEnchanted(param1:PlayerHeroEntry, param2:int) : void
      {
         var _loc4_:* = undefined;
         var _loc3_:* = undefined;
         if(param1 == this.hero.heroEntry)
         {
            signal_runeEnchanted.dispatch();
            _loc4_ = BattleStatValueObjectProvider.fromBattleStats(param1.battleStats);
            if(_oldStats)
            {
               _loc3_ = BattleStatValueObjectProvider.calculateDiff(_oldStats,_loc4_);
               signal_statsUpdated.dispatch(_loc3_);
            }
            else
            {
               signal_statsUpdated.dispatch(_loc4_);
            }
            _oldStats = _loc4_;
         }
      }
      
      private function handler_selectedAmountChanged(param1:HeroRunePopupInventoryItemValueObject) : void
      {
         _selectedValue = _selectedValue - int(selectedItemsAmounts[param1]);
         selectedItemsAmounts[param1] = param1.selectedAmount * param1.value;
         _selectedValue = _selectedValue + int(selectedItemsAmounts[param1]);
         enchantProgress.setupValues(_hero.level,_rune,_selectedValue);
         signal_selectionUpdated.dispatch();
      }
      
      private function handler_runesUpdated() : void
      {
         enchantProgress.setupValues(_hero.level,_rune,_selectedValue);
      }
      
      private function handler_commandEnchantRune(param1:CommandHeroEnchantRune) : void
      {
         clear();
         whenRuneEnchanted(param1.hero,param1.runeTier);
      }
      
      private function handler_commandEnchantRuneStarmoney(param1:CommandHeroEnchantRuneStaromoney) : void
      {
         removeOvercap();
         whenRuneEnchanted(param1.hero,param1.runeTier);
      }
      
      public function action_tabSelect(param1:int) : void
      {
         if(param1 == 0)
         {
            PopupList.instance.dialog_runes(hero.hero,_popup.stashParams);
         }
         else if(param1 == 1)
         {
            PopupList.instance.dialog_elements(hero.hero,_popup.stashParams);
         }
         close();
      }
   }
}
