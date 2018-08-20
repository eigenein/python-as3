package game.mediator.gui.popup.hero
{
   import battle.BattleStats;
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import game.command.rpc.hero.CommandHeroInsertItem;
   import game.command.rpc.hero.CommandHeroPromote;
   import game.command.rpc.hero.CommandHeroSkillUpgrade;
   import game.command.timer.GameTimer;
   import game.data.storage.DataStorage;
   import game.data.storage.artifact.ArtifactDescription;
   import game.data.storage.enum.lib.EvolutionStar;
   import game.data.storage.enum.lib.HeroColor;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.hero.HeroColorData;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.resource.CoinDescription;
   import game.data.storage.skin.SkinDescription;
   import game.mediator.gui.popup.GamePopupManager;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.artifacts.PlayerHeroArtifactVO;
   import game.mediator.gui.popup.element.PlayerHeroElementMediator;
   import game.mediator.gui.popup.hero.evolve.HeroEvolveCostPopupMediator;
   import game.mediator.gui.popup.hero.skill.HeroPopupSkillValueObject;
   import game.mediator.gui.popup.hero.skin.HeroPopupSkinValueObject;
   import game.mediator.gui.popup.hero.slot.BattleStatValueObjectProvider;
   import game.mediator.gui.popup.hero.slot.HeroInventorySlotValueObject;
   import game.mediator.gui.popup.hero.slot.HeroSlotPopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.mediator.gui.popup.rune.PlayerHeroRuneMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.HeroEntry;
   import game.model.user.hero.PlayerHeroArtifact;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.hero.PlayerHeroSkill;
   import game.model.user.hero.watch.PlayerHeroWatcherEntry;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.inventory.InventoryItemCountProxy;
   import game.model.user.refillable.PlayerRefillableEntry;
   import game.stat.Stash;
   import game.view.gui.floatingtext.FloatingTextContainer;
   import game.view.gui.tutorial.Tutorial;
   import game.view.popup.PopupBase;
   import game.view.popup.hero.HeroPopup;
   import game.view.popup.hero.TimerQueueDispenser;
   import idv.cjcat.signals.Signal;
   
   public class HeroPopupMediator extends PopupMediator
   {
      
      public static const TAB_SKINS:String = "TAB_SKINS";
      
      public static const TAB_SKILLS:String = "TAB_SKILLS";
      
      public static const TAB_STATS:String = "TAB_STATS";
      
      public static const TAB_PORTRAIT:String = "TAB_PORTRAIT";
      
      public static const TAB_GEAR:String = "TAB_GEAR";
      
      public static const TAB_RUNE:String = "TAB_RUNE";
      
      public static const TAB_ELEMENT:String = "TAB_ELEMENT";
      
      public static const TAB_ARTIFACTS:String = "TAB_ARTIFACTS";
       
      
      private var watch:PlayerHeroWatcherEntry;
      
      private var fragmentInventoryItem:InventoryItemCountProxy;
      
      private var _inventory:HeroInventoryProxy;
      
      private var queue_autoEquip:TimerQueueDispenser;
      
      private var _hero:PlayerHeroEntry;
      
      private var _signal_heroChanged:Signal;
      
      private var _miniHeroListDataProvider:ListCollection;
      
      public const runeMediator:PlayerHeroRuneMediator = new PlayerHeroRuneMediator();
      
      public var elementMediator:PlayerHeroElementMediator;
      
      private var _skinItems:ListCollection;
      
      private var _statList:ListCollection;
      
      private var _skillList:Vector.<HeroPopupSkillValueObject>;
      
      private var _gearList:ListCollection;
      
      private var _tabs:Vector.<String>;
      
      private var _signal_levelUp:Signal;
      
      private var _signal_experienceUpdate:Signal;
      
      private var _signal_statsUpdate:Signal;
      
      private var _signal_powerUpdate:Signal;
      
      private var _signal_heroPromote:Signal;
      
      private var _signal_heroEvolve:Signal;
      
      public const signal_skillUpgrade:Signal = new Signal(HeroPopupSkillValueObject);
      
      private var _signal_skillPointsUpdate:Signal;
      
      private var _signal_skillPointTimerUpdate:Signal;
      
      private var _signal_skillWatchUpdate:Signal;
      
      private var _signal_skinWatchUpdate:Signal;
      
      private var _signal_promotableStatusUpdate:Signal;
      
      private var _signal_expIncreaseUpdate:Signal;
      
      private var _signal_evolvableStatusUpdate:Signal;
      
      private var _signal_inventorySlotActionAvailableUpdate:Signal;
      
      private var _signal_updateTitanGiftLevelUpAvaliable:Signal;
      
      private var _signal_runeUpgrade:Signal;
      
      private var _signal_skinUpgrade:Signal;
      
      private var _signal_skinBrowse:Signal;
      
      private var _signl_fragmentCountUpdate:Signal;
      
      private var _signal_tabUpdate:Signal;
      
      private var _signal_heroArtifactUpgrade:Signal;
      
      private var _tabSelected:String;
      
      public function HeroPopupMediator(param1:Player, param2:PlayerHeroEntry)
      {
         queue_autoEquip = new TimerQueueDispenser(HeroInventorySlotValueObject,200);
         _signal_levelUp = new Signal();
         _signal_experienceUpdate = new Signal();
         _signal_statsUpdate = new Signal(Vector.<BattleStatValueObject>);
         _signal_powerUpdate = new Signal();
         _signal_inventorySlotActionAvailableUpdate = new Signal();
         _signal_updateTitanGiftLevelUpAvaliable = new Signal();
         _signal_runeUpgrade = new Signal();
         _signal_skinUpgrade = new Signal(SkinDescription,int);
         _signal_skinBrowse = new Signal(SkinDescription);
         super(param1);
         _tabs = new Vector.<String>();
         _tabs.push("TAB_SKILLS");
         if(MechanicStorage.BOSS.enabled && DataStorage.mechanic.getByType(MechanicStorage.BOSS.type).enabled)
         {
            _tabs.push("TAB_SKINS");
         }
         _tabs.push("TAB_STATS");
         _tabs.push("TAB_GEAR");
         if(runeMediator.runesEnabled)
         {
            _tabs.push("TAB_RUNE");
         }
         _tabs.push("TAB_ELEMENT");
         _tabs.push("TAB_ARTIFACTS");
         _signal_heroPromote = new Signal();
         _signal_heroEvolve = new Signal();
         _signal_skillPointsUpdate = new Signal();
         _signal_skillWatchUpdate = new Signal();
         _signal_skinWatchUpdate = new Signal();
         _signal_promotableStatusUpdate = new Signal();
         _signal_expIncreaseUpdate = new Signal();
         _signal_evolvableStatusUpdate = new Signal();
         _signal_skillPointTimerUpdate = new Signal();
         _signl_fragmentCountUpdate = new Signal();
         _signal_tabUpdate = new Signal();
         _signal_heroChanged = new Signal();
         _signal_heroArtifactUpgrade = new Signal();
         param1.signal_update.level.add(handler_playerLevelUp);
         param1.refillable.signal_update.add(onPlayerRefillableUpdate);
         param1.heroes.signal_heroUpgradeSkin.add(onUpgradeSkin);
         param1.heroes.signal_heroArtifactEvolveStar.add(onHeroArtifactEvolve);
         param1.heroes.signal_heroArtifactLevelUp.add(onHeroArtifactLevelUp);
         GameTimer.instance.oneSecTimer.add(onTimer);
         _tabSelected = tabs[0];
         createMiniList();
         queue_autoEquip.signal_onElement.add(handler_queueAutoEquip);
         elementMediator = new PlayerHeroElementMediator(param1);
         this.hero = param2;
      }
      
      override protected function dispose() : void
      {
         queue_autoEquip.reset();
         queue_autoEquip.signal_onElement.remove(handler_queueAutoEquip);
         _inventory.dispose();
         GameTimer.instance.oneSecTimer.remove(onTimer);
         player.refillable.signal_update.remove(onPlayerRefillableUpdate);
         player.signal_update.level.remove(handler_playerLevelUp);
         player.heroes.signal_heroUpgradeSkin.remove(onUpgradeSkin);
         player.heroes.signal_heroArtifactEvolveStar.remove(onHeroArtifactEvolve);
         player.heroes.signal_heroArtifactLevelUp.remove(onHeroArtifactLevelUp);
         watch.signal_updateSkillsAvailable.remove(updateSkillsWatch);
         watch.signal_updateSkinsAvailable.remove(updateSkinsWatch);
         watch.signal_updatePromotableStatus.remove(updatePromotableWatch);
         watch.signal_updateEvolvableStatus.remove(updateEvolveWatch);
         watch.signal_updateExpIncreasable.remove(updateExpWatch);
         if(fragmentInventoryItem)
         {
            fragmentInventoryItem.signal_update.remove(handler_fragmentCountProxyUpdate);
         }
         fragmentInventoryItem.dispose();
         hero = null;
         super.dispose();
      }
      
      public function get selectedTabIndex() : uint
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < tabs.length)
         {
            if(tabs[_loc1_] == tabSelected)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return 0;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney(true);
         if(tabSelected == "TAB_SKINS")
         {
            _loc1_.requre_coin(DataStorage.coin.getCoinById(heroDefaultSkinFirstLevelCostCoinType.id));
         }
         else
         {
            _loc1_.requre_gold(true);
         }
         return _loc1_;
      }
      
      override public function close() : void
      {
         var _loc1_:InventoryItem = player.inventory.getFragmentCollection().getItem(hero.hero);
         if(_loc1_)
         {
            _loc1_.signal_update.remove(handler_fragmentCountUpdate);
         }
         player.refillable.signal_update.remove(onPlayerRefillableUpdate);
         super.close();
      }
      
      public function get hero() : PlayerHeroEntry
      {
         return _hero;
      }
      
      public function set hero(param1:PlayerHeroEntry) : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc11_:* = null;
         var _loc3_:* = null;
         if(_hero == param1)
         {
            return;
         }
         queue_autoEquip.reset();
         var _loc7_:Boolean = false;
         if(_hero)
         {
            _hero.signal_updateBattleStats.remove(handler_heroUpdateBattleStats);
            hero.signal_updateExp.remove(handler_experienceUpdate);
            hero.signal_levelUp.remove(handler_levelUp);
            hero.signal_promote.remove(handler_promote);
            watch.signal_updateSkillsAvailable.remove(updateSkillsWatch);
            watch.signal_updateSkinsAvailable.remove(updateSkinsWatch);
            watch.signal_updatePromotableStatus.remove(updatePromotableWatch);
            watch.signal_updateEvolvableStatus.remove(updateEvolveWatch);
            watch.signal_updateExpIncreasable.remove(updateExpWatch);
            watch.signal_updateTitanGiftLevelUpAvaliable.remove(updateTitanGiftLevelUpAvaliableWatch);
            watch.property_canEnchantRune.signal_update.remove(updateCanEnchantRuneWatch);
            _inventory.signal_slotStatesUpdate.remove(updateInventorySlotsAction);
            if(fragmentInventoryItem)
            {
               fragmentInventoryItem.signal_update.remove(handler_fragmentCountProxyUpdate);
            }
            _loc7_ = true;
         }
         _hero = param1;
         runeMediator.setHero(_hero);
         elementMediator.setHero(_hero);
         if(!_hero)
         {
            return;
         }
         hero.signal_updateBattleStats.add(handler_heroUpdateBattleStats);
         hero.signal_updateExp.add(handler_experienceUpdate);
         hero.signal_levelUp.add(handler_levelUp);
         hero.signal_promote.add(handler_promote);
         watch = player.heroes.watcher.getHeroWatch(hero.hero);
         watch.signal_updateSkillsAvailable.add(updateSkillsWatch);
         watch.signal_updateSkinsAvailable.add(updateSkinsWatch);
         watch.signal_updatePromotableStatus.add(updatePromotableWatch);
         watch.signal_updateEvolvableStatus.add(updateEvolveWatch);
         watch.signal_updateExpIncreasable.add(updateExpWatch);
         watch.signal_updateTitanGiftLevelUpAvaliable.add(updateTitanGiftLevelUpAvaliableWatch);
         watch.property_canEnchantRune.signal_update.add(updateCanEnchantRuneWatch);
         _inventory = new HeroInventoryProxy(player,hero);
         _inventory.signal_slotStatesUpdate.add(updateInventorySlotsAction);
         _skinItems = new ListCollection();
         var _loc8_:Vector.<SkinDescription> = DataStorage.skin.getSkinsByHeroId(hero.id);
         _loc5_ = 0;
         while(_loc5_ < _loc8_.length)
         {
            _loc2_ = new HeroPopupSkinValueObject(hero,_loc8_[_loc5_]);
            if(_loc2_.skin.enabled)
            {
               _skinItems.push(_loc2_);
            }
            _loc5_++;
         }
         var _loc13_:* = player.levelData.level.level >= MechanicStorage.SKILLS.teamLevel;
         _skillList = new Vector.<HeroPopupSkillValueObject>();
         var _loc9_:Vector.<PlayerHeroSkill> = hero.skillData.getSkillList();
         var _loc10_:int = _loc9_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc10_)
         {
            _loc11_ = new HeroPopupSkillValueObject(hero,_loc9_[_loc4_],_loc13_ && hero.canUpgradeSkill(_loc9_[_loc4_].skill));
            _skillList[_loc4_] = _loc11_;
            _loc4_++;
         }
         statListData_reset();
         var _loc12_:Vector.<HeroGearListValueObject> = new Vector.<HeroGearListValueObject>();
         var _loc6_:HeroColorData = hero.hero.startingColor;
         while(_loc6_)
         {
            _loc3_ = new HeroGearListValueObject(_loc6_);
            _loc6_ = _loc6_.next;
            _loc12_.push(_loc3_);
         }
         _gearList = new ListCollection(_loc12_);
         if(fragmentInventoryItem)
         {
            fragmentInventoryItem.signal_update.remove(handler_fragmentCountProxyUpdate);
         }
         fragmentInventoryItem = player.inventory.getItemCounterProxy(hero.hero,true);
         fragmentInventoryItem.signal_update.add(handler_fragmentCountProxyUpdate);
         if(_loc7_)
         {
            _signal_heroChanged.dispatch();
         }
         if(_popup)
         {
            GamePopupManager.instance.resourcePanel.setMediator(_popup as HeroPopup,GamePopupManager.instance.root);
         }
      }
      
      public function get signal_heroChanged() : Signal
      {
         return _signal_heroChanged;
      }
      
      public function get miniHeroListDataProvider() : ListCollection
      {
         return _miniHeroListDataProvider;
      }
      
      public function get miniHeroListSelectedItem() : PlayerHeroEntryValueObject
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc1_:int = _miniHeroListDataProvider.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = _miniHeroListDataProvider.getItemAt(_loc2_) as PlayerHeroEntryValueObject;
            if(_loc3_.hero == hero.hero)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function get title() : String
      {
         return hero.hero.name;
      }
      
      public function get description() : String
      {
         return hero.hero.descText;
      }
      
      public function get roleDescription_line() : String
      {
         return hero.hero.role.localizedPrimaryRoleDesc;
      }
      
      public function get roleDescription_extended() : Vector.<String>
      {
         return hero.hero.role.localizedExtendedRoleList;
      }
      
      public function get roleDescription_mainStatName() : String
      {
         return Translate.translate("LIB_BATTLESTATDATA_" + hero.hero.mainStat.name.toUpperCase());
      }
      
      public function get star() : EvolutionStar
      {
         return hero.star.star;
      }
      
      public function get heroEntry() : HeroEntry
      {
         return hero;
      }
      
      public function get level() : int
      {
         return hero.level.level;
      }
      
      public function get xpCurrent() : int
      {
         return hero.experience;
      }
      
      public function get xpNextLevel() : int
      {
         return !!hero.level.nextLevel?hero.level.nextLevel.exp:0;
      }
      
      public function get xpCurrentLevel() : int
      {
         return !!hero.level?hero.level.exp:0;
      }
      
      public function get soulstoneCount() : int
      {
         return !!fragmentInventoryItem?fragmentInventoryItem.amount:0;
      }
      
      public function get soulstoneMaxCount() : int
      {
         return !!hero.star.next?hero.star.next.star.evolveFragmentCost:0;
      }
      
      public function get soulstoneMax() : Boolean
      {
         return hero.star.next == null;
      }
      
      public function get starCount() : int
      {
         return star.id;
      }
      
      public function get skillPointsAvailable() : int
      {
         return player.refillable.skillpoints.value;
      }
      
      public function get skillPointsMax() : int
      {
         return player.refillable.skillpoints.maxValue;
      }
      
      public function get skillPointsRegenTimer() : int
      {
         if(player.refillable.skillpoints.value < player.refillable.skillpoints.maxValue)
         {
            return player.refillable.skillpoints.refillTimeLeft;
         }
         return -1;
      }
      
      public function get power() : int
      {
         return hero.getPower();
      }
      
      public function get actionAvailable_skillUpgrade() : Boolean
      {
         return watch.skillUpgradeAvailable;
      }
      
      public function get actionAvailable_evolve() : Boolean
      {
         return watch.evolvable;
      }
      
      public function get actionAvailable_promote() : Boolean
      {
         return watch.promotable;
      }
      
      public function get actionAvailable_skinUpgrade() : Boolean
      {
         return watch.skinUpgradeAvailable;
      }
      
      public function get actionAvailable_expIncrease() : Boolean
      {
         return watch.expIncreasable;
      }
      
      public function get actionAvailable_titanGiftLevelUp() : Boolean
      {
         return watch.titanGiftLevelUpAvaliable;
      }
      
      public function get actionAvailable_canEnchantRun() : Boolean
      {
         return watch.property_canEnchantRune.value;
      }
      
      public function get actionAvailable_artifactUpgrade() : Boolean
      {
         return watch.artifactUpgradeAvaliable;
      }
      
      public function get skinItems() : ListCollection
      {
         return _skinItems;
      }
      
      public function get currentSkin() : int
      {
         return hero.currentSkin;
      }
      
      public function getPlayerCoinsAmountByDefaultSkin() : uint
      {
         var _loc1_:InventoryItem = player.inventory.getItemCollection().getCollectionByType(InventoryItemType.COIN).getItemById(heroDefaultSkinFirstLevelCostCoinType.id);
         if(_loc1_)
         {
            return _loc1_.amount;
         }
         return 0;
      }
      
      public function get heroDefaultSkinFirstLevelCostCoinType() : CoinDescription
      {
         var _loc3_:int = 0;
         var _loc2_:* = DataStorage.skin.getSkinsByHeroId(hero.id);
         for each(var _loc1_ in DataStorage.skin.getSkinsByHeroId(hero.id))
         {
            if(_loc1_.isDefault)
            {
               if(_loc1_.levels.length)
               {
                  if(_loc1_.levels[0].cost != null && _loc1_.levels[0].cost.outputDisplay.length != 0)
                  {
                     return DataStorage.coin.getCoinById(_loc1_.levels[0].cost.outputDisplay[0].id);
                  }
               }
            }
         }
         return null;
      }
      
      public function get statList() : ListCollection
      {
         return _statList;
      }
      
      public function get skillList() : Vector.<HeroPopupSkillValueObject>
      {
         return _skillList;
      }
      
      public function get gearList() : ListCollection
      {
         return _gearList;
      }
      
      public function get inventoryList() : Vector.<HeroInventorySlotValueObject>
      {
         return _inventory.inventory;
      }
      
      public function get tabs() : Vector.<String>
      {
         return _tabs;
      }
      
      public function get signal_levelUp() : Signal
      {
         return _signal_levelUp;
      }
      
      public function get signal_experienceUpdate() : Signal
      {
         return _signal_experienceUpdate;
      }
      
      public function get signal_statsUpdate() : Signal
      {
         return _signal_statsUpdate;
      }
      
      public function get signal_powerUpdate() : Signal
      {
         return _signal_powerUpdate;
      }
      
      public function get signal_heroPromote() : Signal
      {
         return _signal_heroPromote;
      }
      
      public function get signal_heroEvolve() : Signal
      {
         return _signal_heroEvolve;
      }
      
      public function get signal_skillPointsUpdate() : Signal
      {
         return _signal_skillPointsUpdate;
      }
      
      public function get signal_skillPointTimerUpdate() : Signal
      {
         return _signal_skillPointTimerUpdate;
      }
      
      public function get signal_skillWatchUpdate() : Signal
      {
         return _signal_skillWatchUpdate;
      }
      
      public function get signal_skinWatchUpdate() : Signal
      {
         return _signal_skinWatchUpdate;
      }
      
      public function get signal_promotableStatusUpdate() : Signal
      {
         return _signal_promotableStatusUpdate;
      }
      
      public function get signal_expIncreaseUpdate() : Signal
      {
         return _signal_expIncreaseUpdate;
      }
      
      public function get signal_evolvableStatusUpdate() : Signal
      {
         return _signal_evolvableStatusUpdate;
      }
      
      public function get signal_inventorySlotActionAvailableUpdate() : Signal
      {
         return _signal_inventorySlotActionAvailableUpdate;
      }
      
      public function get signal_updateTitanGiftLevelUpAvaliable() : Signal
      {
         return _signal_updateTitanGiftLevelUpAvaliable;
      }
      
      public function get signal_runeUpgrade() : Signal
      {
         return _signal_runeUpgrade;
      }
      
      public function get signal_skinUpgrade() : Signal
      {
         return _signal_skinUpgrade;
      }
      
      public function get signal_skinBrowse() : Signal
      {
         return _signal_skinBrowse;
      }
      
      public function get signl_fragmentCountUpdate() : Signal
      {
         return _signl_fragmentCountUpdate;
      }
      
      public function get signal_tabUpdate() : Signal
      {
         return _signal_tabUpdate;
      }
      
      public function get signal_heroArtifactUpgrade() : Signal
      {
         return _signal_heroArtifactUpgrade;
      }
      
      public function get tabSelected() : String
      {
         return _tabSelected;
      }
      
      public function set tabSelected(param1:String) : void
      {
         if(_tabSelected != param1)
         {
            _tabSelected = param1;
         }
      }
      
      public function get heroColor() : HeroColor
      {
         return hero.color.color;
      }
      
      public function get slotsToFill() : Vector.<HeroInventorySlotValueObject>
      {
         var _loc3_:int = 0;
         var _loc1_:Vector.<HeroInventorySlotValueObject> = new Vector.<HeroInventorySlotValueObject>();
         var _loc2_:int = inventoryList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(inventoryList[_loc3_].slotState == 1)
            {
               _loc1_.push(inventoryList[_loc3_]);
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function get heroArtifactsList() : Vector.<PlayerHeroArtifactVO>
      {
         var _loc2_:int = 0;
         var _loc1_:Vector.<PlayerHeroArtifactVO> = new Vector.<PlayerHeroArtifactVO>();
         if(hero)
         {
            _loc2_ = 0;
            while(_loc2_ < hero.artifacts.list.length)
            {
               _loc1_.push(new PlayerHeroArtifactVO(player,hero.artifacts.list[_loc2_],hero));
               _loc2_++;
            }
         }
         return _loc1_;
      }
      
      public function action_tabSelect(param1:int) : void
      {
         _tabSelected = tabs[param1];
         _signal_tabUpdate.dispatch();
         GamePopupManager.instance.resourcePanel.setMediator(_popup as HeroPopup,GamePopupManager.instance.root);
      }
      
      public function action_promoteHero() : void
      {
         var _loc2_:* = null;
         queue_autoEquip.reset();
         var _loc1_:Vector.<HeroInventorySlotValueObject> = slotsToFill;
         if(_loc1_.length)
         {
            queue_autoEquip.add(_loc1_);
            return;
         }
         if(actionAvailable_promote)
         {
            _loc2_ = GameModel.instance.actionManager.hero.heroPromote(hero);
         }
         else
         {
            PopupList.instance.message(Translate.translate("UI_DIALOG_HERO_PROMOTE_REQUIREMENT"));
         }
      }
      
      public function action_evolveHero() : void
      {
         var _loc1_:* = null;
         if(!hero.star.next)
         {
            PopupList.instance.message(Translate.translate("UI_DIALOG_HERO_EVOLVE_MAX"));
            return;
         }
         if(soulstoneCount >= soulstoneMaxCount)
         {
            _loc1_ = PopupList.instance.popup_hero_evolve_cost(hero.hero);
            _loc1_.signal_complete.addOnce(onAction_heroEvolve);
         }
         else
         {
            PopupList.instance.message(Translate.translateArgs("UI_DIALOG_HERO_EVOLVE_REQUIREMENT",soulstoneMaxCount - soulstoneCount));
         }
      }
      
      public function action_inventorySlotSelect(param1:HeroInventorySlotValueObject) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(param1.slotState == 1)
         {
            if(!param1.hero.isItemSlotBusy(param1.slot))
            {
               _loc2_ = GameModel.instance.actionManager.hero.heroInsertItem(param1.hero,param1.slot);
            }
         }
         else
         {
            _loc3_ = new HeroSlotPopupMediator(player,param1);
            _loc3_.open();
         }
      }
      
      public function action_skillPointsRefill() : void
      {
         Game.instance.navigator.navigateToRefillable(DataStorage.refillable.getByIdent("skill_point"),Stash.click("refill_skillpoints",_popup.stashParams));
      }
      
      public function action_skillUpgrade(param1:HeroPopupSkillValueObject) : void
      {
         var _loc3_:* = null;
         if(player.refillable.skillpoints.value <= 0)
         {
            _loc3_ = Game.instance.navigator.navigateToRefillable(DataStorage.refillable.getByIdent("skill_point"),Stash.click("not_enough_skillpoints",_popup.stashParams)) as PopupMediator;
            FloatingTextContainer.show(Translate.translate("UI_POPUP_MESSAGE_NOTENOUGH_SKILL_POINTS"),_loc3_);
            return;
         }
         var _loc2_:CommandHeroSkillUpgrade = GameModel.instance.actionManager.hero.heroSkillUpgrade(hero,param1.skill.skill,player.refillable.skillpoints.value == player.refillable.skillpoints.maxValue);
         _loc2_.onClientExecute(onAction_skillUpgrade);
      }
      
      public function action_evolveGetDropList() : void
      {
         PopupList.instance.popup_item_info(hero.hero,hero.hero,Stash.click("fragments_info",_popup.stashParams));
      }
      
      public function action_addExp() : void
      {
         PopupList.instance.dialog_hero_add_exp(hero);
      }
      
      public function action_miniListSelectionUpdate(param1:PlayerHeroEntryValueObject) : void
      {
         hero = param1.playerEntry;
      }
      
      public function action_goForRunes() : void
      {
         if(runeMediator.runesAvailable && Tutorial.flags.clanScreenIsIntroduced)
         {
            PopupList.instance.dialog_runes(hero.hero,Stash.click("hero_runes",_popup.stashParams));
         }
         else
         {
            Game.instance.navigator.navigateToClan(Stash.click("hero_guilds",_popup.stashParams));
         }
      }
      
      public function action_navigate_to_artifacts(param1:ArtifactDescription = null) : void
      {
         var _loc2_:* = null;
         if(MechanicStorage.ARTIFACT.enabled && player.levelData.level.level >= MechanicStorage.ARTIFACT.teamLevel)
         {
            _loc2_ = new PopupStashEventParams();
            _loc2_.windowName = "dialog_hero";
            PopupList.instance.dialog_artifacts(hero.hero,param1,_loc2_);
         }
         else
         {
            Game.instance.navigator.navigateToMechanic(MechanicStorage.ARTIFACT,Stash.click("artifacts",_popup.stashParams));
         }
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new HeroPopup(this);
         return _popup;
      }
      
      private function statListData_reset() : void
      {
         var _loc1_:Vector.<BattleStatValueObject> = BattleStatValueObjectProvider.fromBattleStats(hero.battleStats);
         _statList = new ListCollection(_loc1_);
      }
      
      private function statListData_update() : void
      {
         var _loc1_:* = undefined;
         var _loc3_:Vector.<BattleStatValueObject> = BattleStatValueObjectProvider.fromBattleStats(hero.battleStats);
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
         _signal_powerUpdate.dispatch();
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
            _loc4_ = player.heroes.getById(_loc5_.id);
            if(_loc4_)
            {
               _loc7_ = new PlayerHeroListValueObject(_loc5_,player);
               _loc1_.push(_loc7_);
            }
            _loc6_++;
         }
         _loc1_.sort(PlayerHeroListValueObject.sort);
         _miniHeroListDataProvider = new ListCollection(_loc1_);
      }
      
      private function onUpgradeSkin(param1:PlayerHeroEntry, param2:SkinDescription, param3:Boolean) : void
      {
         signal_skinUpgrade.dispatch(param2,hero.skinData.getSkinLevelByID(param2.id));
      }
      
      private function onPlayerRefillableUpdate(param1:PlayerRefillableEntry) : void
      {
         if(param1 == player.refillable.skillpoints)
         {
            _signal_skillPointsUpdate.dispatch();
         }
      }
      
      private function updateInventorySlotsAction() : void
      {
         _signal_inventorySlotActionAvailableUpdate.dispatch();
      }
      
      private function updateEvolveWatch(param1:PlayerHeroWatcherEntry) : void
      {
         _signal_evolvableStatusUpdate.dispatch();
      }
      
      private function updateSkillsWatch(param1:PlayerHeroWatcherEntry) : void
      {
         _signal_skillWatchUpdate.dispatch();
      }
      
      private function updateSkinsWatch(param1:PlayerHeroWatcherEntry) : void
      {
         _signal_skinWatchUpdate.dispatch();
      }
      
      private function updatePromotableWatch(param1:PlayerHeroWatcherEntry) : void
      {
         _signal_promotableStatusUpdate.dispatch();
      }
      
      private function updateExpWatch(param1:PlayerHeroWatcherEntry) : void
      {
         _signal_expIncreaseUpdate.dispatch();
      }
      
      private function updateTitanGiftLevelUpAvaliableWatch(param1:PlayerHeroWatcherEntry) : void
      {
         _signal_updateTitanGiftLevelUpAvaliable.dispatch();
      }
      
      private function updateCanEnchantRuneWatch(param1:Boolean) : void
      {
         _signal_runeUpgrade.dispatch();
      }
      
      private function onAction_skillUpgrade(param1:CommandHeroSkillUpgrade) : void
      {
         var _loc3_:int = 0;
         skillList_updateUpgradeAvailability();
         var _loc2_:int = _skillList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_skillList[_loc3_].skill.skill == param1.skill)
            {
               signal_skillUpgrade.dispatch(_skillList[_loc3_]);
               break;
            }
            _loc3_++;
         }
         _signal_powerUpdate.dispatch();
      }
      
      private function skillList_updateUpgradeAvailability() : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = player.levelData.level.level >= MechanicStorage.SKILLS.teamLevel;
         var _loc1_:int = _skillList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _skillList[_loc2_].canUpgrade = _loc3_ && hero.canUpgradeSkill(_skillList[_loc2_].skill.skill);
            _skillList[_loc2_].updateCost();
            _skillList[_loc2_].updateTooltipData();
            _skillList[_loc2_].updateSignal.dispatch();
            _loc2_++;
         }
      }
      
      private function onAction_heroEvolve() : void
      {
         _signal_heroEvolve.dispatch();
      }
      
      private function onTimer() : void
      {
         if(skillPointsRegenTimer > 0)
         {
            _signal_skillPointTimerUpdate.dispatch();
         }
      }
      
      private function handler_heroUpdateBattleStats(param1:PlayerHeroEntry, param2:BattleStats) : void
      {
         statListData_update();
      }
      
      private function handler_fragmentCountProxyUpdate(param1:InventoryItemCountProxy) : void
      {
         _signl_fragmentCountUpdate.dispatch();
      }
      
      private function handler_fragmentCountUpdate(param1:InventoryItem) : void
      {
         _signl_fragmentCountUpdate.dispatch();
      }
      
      private function handler_experienceUpdate(param1:PlayerHeroEntry) : void
      {
         _signal_experienceUpdate.dispatch();
      }
      
      private function handler_levelUp(param1:PlayerHeroEntry) : void
      {
         skillList_updateUpgradeAvailability();
         _signal_levelUp.dispatch();
      }
      
      private function handler_promote(param1:PlayerHeroEntry) : void
      {
         skillList_updateUpgradeAvailability();
         _signal_heroPromote.dispatch();
      }
      
      private function handler_playerLevelUp() : void
      {
         if(player.levelData.level.level == MechanicStorage.SKILLS.teamLevel)
         {
            skillList_updateUpgradeAvailability();
         }
      }
      
      private function handler_queueAutoEquip(param1:HeroInventorySlotValueObject) : void
      {
         var _loc2_:* = null;
         if(param1 && param1.hero && param1.slotState == 1)
         {
            if(!param1.hero.isItemSlotBusy(param1.slot))
            {
               _loc2_ = GameModel.instance.actionManager.hero.heroInsertItem(param1.hero,param1.slot);
               if(queue_autoEquip.isEmpty)
               {
                  _loc2_.onClientExecute(triggerEventTutorialHeroEquip);
               }
            }
         }
      }
      
      private function onHeroArtifactLevelUp(param1:PlayerHeroEntry, param2:PlayerHeroArtifact) : void
      {
         signal_heroArtifactUpgrade.dispatch();
      }
      
      private function onHeroArtifactEvolve(param1:PlayerHeroEntry, param2:PlayerHeroArtifact) : void
      {
         signal_heroArtifactUpgrade.dispatch();
      }
      
      private function triggerEventTutorialHeroEquip(param1:CommandHeroInsertItem) : void
      {
         if(_hero)
         {
            Tutorial.events.triggerEvent_heroEquip(_hero.hero);
         }
      }
      
      public function getTabVisibleByID(param1:String) : Boolean
      {
         if(param1 == "TAB_SKILLS")
         {
            return actionAvailable_skillUpgrade;
         }
         if(param1 == "TAB_SKINS")
         {
            return actionAvailable_skinUpgrade;
         }
         if(param1 == "TAB_ELEMENT")
         {
            return actionAvailable_titanGiftLevelUp;
         }
         if(param1 == "TAB_RUNE")
         {
            return actionAvailable_canEnchantRun;
         }
         if(param1 == "TAB_ARTIFACTS")
         {
            return actionAvailable_artifactUpgrade;
         }
         return false;
      }
   }
}
