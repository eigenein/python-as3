package game.mediator.gui.popup.hero
{
   import battle.BattleStats;
   import feathers.data.ListCollection;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.resource.ConsumableDescription;
   import game.data.storage.titan.TitanGiftDescription;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.hero.slot.BattleStatValueObjectProvider;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.view.popup.PopupBase;
   import game.view.popup.hero.rune.HeroElementPopup;
   import idv.cjcat.signals.Signal;
   
   public class HeroElementPopupMediator extends PopupMediator
   {
      
      public static const TAB_SYMBOLS:String = "tab_symbols";
      
      public static const TAB_ELEMENTS:String = "tab_elements";
       
      
      public const signal_heroUpdated:Signal = new Signal();
      
      public const miniHeroListDataProvider:ListCollection = new ListCollection();
      
      private var _signal_heroChangeTitanGiftLevel:Signal;
      
      private var _signal_statsUpdate:Signal;
      
      private var _hero:PlayerHeroEntryValueObject;
      
      private var _tabs:Vector.<String>;
      
      private var _statList:ListCollection;
      
      public function HeroElementPopupMediator(param1:Player, param2:HeroDescription)
      {
         _signal_heroChangeTitanGiftLevel = new Signal();
         _signal_statsUpdate = new Signal(Vector.<BattleStatValueObject>);
         super(param1);
         _tabs = new Vector.<String>();
         _tabs.push("tab_symbols");
         _tabs.push("tab_elements");
         param1.heroes.signal_heroChangeTitanGiftLevel.add(handler_heroChangeTitanGiftLevel);
         setHero(param2);
         createMiniList();
      }
      
      override protected function dispose() : void
      {
         player.heroes.signal_heroChangeTitanGiftLevel.remove(handler_heroChangeTitanGiftLevel);
         if(_hero)
         {
            _hero.playerEntry.signal_updateBattleStats.remove(handler_heroUpdateBattleStats);
         }
         super.dispose();
      }
      
      public function get signal_heroChangeTitanGiftLevel() : Signal
      {
         return _signal_heroChangeTitanGiftLevel;
      }
      
      public function get signal_statsUpdate() : Signal
      {
         return _signal_statsUpdate;
      }
      
      public function get hero() : PlayerHeroEntryValueObject
      {
         return _hero;
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
      
      public function get heroTitanGiftLevel() : int
      {
         return hero.playerEntry.titanGiftLevel;
      }
      
      public function get heroGiftLevelMin() : int
      {
         return 0;
      }
      
      public function get heroGiftLevelMax() : int
      {
         var _loc1_:TitanGiftDescription = DataStorage.titanGift.getTitanGiftWithMaxLevel();
         return !!_loc1_?_loc1_.level:0;
      }
      
      public function get titanGiftCurrent() : TitanGiftDescription
      {
         return DataStorage.titanGift.getTitanGiftByLevel(hero.playerEntry.titanGiftLevel);
      }
      
      public function get titanGiftNext() : TitanGiftDescription
      {
         return DataStorage.titanGift.getTitanGiftByLevel(hero.playerEntry.titanGiftLevel + 1);
      }
      
      public function get battleStatsCurrent() : BattleStats
      {
         var _loc1_:TitanGiftDescription = titanGiftCurrent;
         return !!_loc1_?_loc1_.getBattleStatByBaseStat(hero.hero.mainStat.name):null;
      }
      
      public function get battleStatsNext() : BattleStats
      {
         var _loc1_:TitanGiftDescription = titanGiftNext;
         return !!_loc1_?_loc1_.getBattleStatByBaseStat(hero.hero.mainStat.name):null;
      }
      
      public function get tabs() : Vector.<String>
      {
         return _tabs;
      }
      
      public function get statList() : ListCollection
      {
         return _statList;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         var _loc2_:Vector.<ConsumableDescription> = DataStorage.consumable.getItemsByType("titanGift");
         _loc1_.requre_consumable(_loc2_[0]);
         _loc1_.requre_gold();
         return _loc1_;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new HeroElementPopup(this);
         return new HeroElementPopup(this);
      }
      
      public function action_miniListSelectionUpdate(param1:PlayerHeroEntryValueObject) : void
      {
         setHero(param1.hero);
      }
      
      public function action_heroGiftLevelUpgrade() : void
      {
         GameModel.instance.actionManager.hero.heroTitanGiftLevelUp(hero.playerEntry,titanGiftNext.cost);
      }
      
      public function action_heroTitanGiftDrop() : void
      {
         var _loc1_:HeroTitanGiftLevelDropPopUpMediator = new HeroTitanGiftLevelDropPopUpMediator(player,hero.playerEntry);
         _loc1_.open(_popup.stashParams);
      }
      
      private function setHero(param1:HeroDescription) : void
      {
         if(_hero)
         {
            _hero.playerEntry.signal_updateBattleStats.remove(handler_heroUpdateBattleStats);
         }
         var _loc2_:PlayerHeroEntry = player.heroes.getById(param1.id);
         _hero = new PlayerHeroEntryValueObject(param1,_loc2_);
         signal_heroUpdated.dispatch();
         _hero.playerEntry.signal_updateBattleStats.add(handler_heroUpdateBattleStats);
         statListData_reset();
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
                  _loc7_ = new PlayerHeroElementListValueObject(_loc5_,player);
                  _loc1_.push(_loc7_);
               }
            }
            _loc6_++;
         }
         _loc1_.sort(PlayerHeroListValueObject.sort);
         miniHeroListDataProvider.data = _loc1_;
      }
      
      private function handler_heroChangeTitanGiftLevel(param1:PlayerHeroEntry) : void
      {
         signal_heroChangeTitanGiftLevel.dispatch();
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
      
      private function handler_heroUpdateBattleStats(param1:PlayerHeroEntry, param2:BattleStats) : void
      {
         statListData_update();
      }
      
      private function statListData_reset() : void
      {
         var _loc1_:Vector.<BattleStatValueObject> = BattleStatValueObjectProvider.fromBattleStats(hero.playerEntry.battleStats);
         _statList = new ListCollection(_loc1_);
      }
      
      private function statListData_update() : void
      {
         var _loc1_:* = undefined;
         var _loc3_:Vector.<BattleStatValueObject> = BattleStatValueObjectProvider.fromBattleStats(hero.playerEntry.battleStats);
         var _loc2_:Vector.<BattleStatValueObject> = _statList.data as Vector.<BattleStatValueObject>;
         _statList = new ListCollection(_loc3_);
         if(_loc2_)
         {
            _loc1_ = BattleStatValueObjectProvider.calculateDiff(_loc2_,_loc3_);
            _signal_statsUpdate.dispatch(_loc1_);
         }
         else
         {
            _signal_statsUpdate.dispatch(_loc3_);
         }
      }
   }
}
