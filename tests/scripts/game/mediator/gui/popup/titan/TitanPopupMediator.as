package game.mediator.gui.popup.titan
{
   import battle.BattleStats;
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.artifact.TitanArtifactDescription;
   import game.data.storage.enum.lib.TitanEvolutionStar;
   import game.data.storage.level.PlayerTeamLevel;
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.resource.ConsumableDescription;
   import game.data.storage.titan.TitanDescription;
   import game.mediator.gui.popup.GamePopupManager;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.artifacts.PlayerTitanArtifactVO;
   import game.mediator.gui.popup.hero.BattleStatValueObject;
   import game.mediator.gui.popup.hero.HeroRuneListPopupMediator;
   import game.mediator.gui.popup.hero.slot.BattleStatValueObjectProvider;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.mediator.gui.popup.titan.evolve.TitanEvolveCostPopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerTitanArtifact;
   import game.model.user.hero.PlayerTitanEntry;
   import game.model.user.hero.watch.PlayerTitanWatcherEntry;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.inventory.InventoryItemCountProxy;
   import game.stat.Stash;
   import game.view.popup.MessageWideButtonPopup;
   import game.view.popup.PopupBase;
   import idv.cjcat.signals.Signal;
   
   public class TitanPopupMediator extends PopupMediator
   {
      
      public static var current:TitanPopupMediator;
       
      
      private var fragmentInventoryItem:InventoryItemCountProxy;
      
      private var watch:PlayerTitanWatcherEntry;
      
      private var _titan:PlayerTitanEntry;
      
      private var _signl_fragmentCountUpdate:Signal;
      
      private var _signal_experienceUpdate:Signal;
      
      private var _signal_evolvableStatusUpdate:Signal;
      
      private var _signal_titanEvolve:Signal;
      
      private var _signal_titanChanged:Signal;
      
      private var _signal_powerUpdate:Signal;
      
      private var _signal_titanSparkUpdate:Signal;
      
      private var _signal_statsUpdate:Signal;
      
      private var _signal_titanArtifactUpgrade:Signal;
      
      private var _expComsumableCost:InventoryItem;
      
      private var _levelUpCost:InventoryItem;
      
      private var _statList:ListCollection;
      
      private var _miniTitanListDataProvider:ListCollection;
      
      private var _potionDesc:ConsumableDescription;
      
      public function TitanPopupMediator(param1:Player, param2:PlayerTitanEntry)
      {
         _signl_fragmentCountUpdate = new Signal();
         _signal_experienceUpdate = new Signal();
         _signal_evolvableStatusUpdate = new Signal();
         _signal_titanEvolve = new Signal();
         _signal_titanChanged = new Signal();
         _signal_powerUpdate = new Signal();
         _signal_titanSparkUpdate = new Signal();
         _signal_statsUpdate = new Signal(Vector.<BattleStatValueObject>);
         _signal_titanArtifactUpgrade = new Signal();
         _miniTitanListDataProvider = new ListCollection();
         super(param1);
         param1.signal_spendCost.add(handler_playerSpendCost);
         param1.signal_takeReward.add(handler_playerTakeReward);
         param1.titans.signal_newTitanObtained.add(handler_newTitanObtained);
         param1.titans.signal_titanArtifactEvolveStar.add(handler_tianArtifactEvolve);
         param1.titans.signal_titanArtifactLevelUp.add(handler_tianArtifactLevelUp);
         createMiniList();
         this.titan = param2;
         current = this;
      }
      
      public static function get artifactsMechanicAvaliable() : Boolean
      {
         return DataStorage.mechanic.getByType(MechanicStorage.TITAN_ARTIFACT.type).teamLevel <= GameModel.instance.player.levelData.level.level;
      }
      
      override protected function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         if(fragmentInventoryItem)
         {
            fragmentInventoryItem.signal_update.remove(handler_fragmentCountUpdate);
            fragmentInventoryItem.dispose();
         }
         if(titan)
         {
            titan.signal_updateExp.remove(handler_experienceUpdate);
            titan.signal_updateBattleStats.remove(handler_titanUpdateBattleStats);
            titan = null;
         }
         if(watch)
         {
            watch.signal_updateEvolvableStatus.remove(updateEvolveWatch);
         }
         if(player)
         {
            player.signal_spendCost.remove(handler_playerSpendCost);
            player.signal_takeReward.remove(handler_playerTakeReward);
            player.titans.signal_newTitanObtained.remove(handler_newTitanObtained);
            player.titans.signal_titanArtifactEvolveStar.remove(handler_tianArtifactEvolve);
            player.titans.signal_titanArtifactLevelUp.remove(handler_tianArtifactLevelUp);
         }
         _loc1_ = 0;
         while(_loc1_ < _miniTitanListDataProvider.length)
         {
            _loc2_ = _miniTitanListDataProvider.getItemAt(_loc1_) as PlayerTitanListValueObject;
            _loc2_ && _loc2_.dispose();
            _loc1_++;
         }
         _miniTitanListDataProvider = null;
         if(current == this)
         {
            current = null;
         }
         super.dispose();
      }
      
      public function get titan() : PlayerTitanEntry
      {
         return _titan;
      }
      
      public function set titan(param1:PlayerTitanEntry) : void
      {
         if(_titan == param1)
         {
            return;
         }
         if(_titan)
         {
            if(fragmentInventoryItem)
            {
               fragmentInventoryItem.signal_update.remove(handler_fragmentCountUpdate);
            }
            titan.signal_updateExp.remove(handler_experienceUpdate);
            titan.signal_updateBattleStats.remove(handler_titanUpdateBattleStats);
            watch.signal_updateEvolvableStatus.remove(updateEvolveWatch);
         }
         _titan = param1;
         if(!_titan)
         {
            return;
         }
         fragmentInventoryItem = player.inventory.getItemCounterProxy(titan.titan,true);
         fragmentInventoryItem.signal_update.add(handler_fragmentCountUpdate);
         titan.signal_updateExp.add(handler_experienceUpdate);
         titan.signal_updateBattleStats.add(handler_titanUpdateBattleStats);
         watch = player.titans.watcher.getTitanWatch(titan.titan);
         watch.signal_updateEvolvableStatus.add(updateEvolveWatch);
         updateLevelUpParams();
         statListData_reset();
         _signal_titanChanged.dispatch();
      }
      
      public function get signl_fragmentCountUpdate() : Signal
      {
         return _signl_fragmentCountUpdate;
      }
      
      public function get signal_experienceUpdate() : Signal
      {
         return _signal_experienceUpdate;
      }
      
      public function get signal_evolvableStatusUpdate() : Signal
      {
         return _signal_evolvableStatusUpdate;
      }
      
      public function get signal_titanEvolve() : Signal
      {
         return _signal_titanEvolve;
      }
      
      public function get signal_titanChanged() : Signal
      {
         return _signal_titanChanged;
      }
      
      public function get signal_powerUpdate() : Signal
      {
         return _signal_powerUpdate;
      }
      
      public function get signal_titanSparkUpdate() : Signal
      {
         return _signal_titanSparkUpdate;
      }
      
      public function get signal_statsUpdate() : Signal
      {
         return _signal_statsUpdate;
      }
      
      public function get signal_titanArtifactUpgrade() : Signal
      {
         return _signal_titanArtifactUpgrade;
      }
      
      public function get expComsumableCost() : InventoryItem
      {
         return _expComsumableCost;
      }
      
      public function set expComsumableCost(param1:InventoryItem) : void
      {
         _expComsumableCost = param1;
      }
      
      public function get levelUpCost() : InventoryItem
      {
         return _levelUpCost;
      }
      
      public function set levelUpCost(param1:InventoryItem) : void
      {
         _levelUpCost = param1;
      }
      
      public function get titanName() : String
      {
         return titan.titan.name;
      }
      
      public function get titanRole() : String
      {
         return titan.titan.details.type;
      }
      
      public function get titanDesc() : String
      {
         return titan.titan.descText;
      }
      
      public function get titanElement() : String
      {
         return titan.titan.details.element;
      }
      
      public function get power() : int
      {
         return titan.getPower();
      }
      
      public function get powerNextLevel() : int
      {
         return titan.getPowerNext(true);
      }
      
      public function get powerNextStar() : int
      {
         return titan.getPowerNext(false,true);
      }
      
      public function get soulstoneCount() : int
      {
         return !!fragmentInventoryItem?fragmentInventoryItem.amount:0;
      }
      
      public function get soulstoneMaxCount() : int
      {
         return !!titan.star.next?titan.star.next.star.evolveFragmentCost:0;
      }
      
      public function get soulstoneMax() : Boolean
      {
         return titan.star.next == null;
      }
      
      public function get star() : TitanEvolutionStar
      {
         return titan.star.star;
      }
      
      public function get starCount() : int
      {
         return star.id;
      }
      
      public function get level() : int
      {
         return titan.level.level;
      }
      
      public function get levelMax() : int
      {
         var _loc1_:PlayerTeamLevel = player.levelData.level;
         while(_loc1_.nextLevel)
         {
            _loc1_ = _loc1_.nextLevel as PlayerTeamLevel;
         }
         if(_loc1_)
         {
            return Math.min(titan.levelMax.level,_loc1_.maxTitanLevel);
         }
         return titan.levelMax.level;
      }
      
      public function get levelMaxByTeam() : int
      {
         return player.levelData.level.maxTitanLevel;
      }
      
      public function get xpCurrent() : int
      {
         return titan.experience;
      }
      
      public function get xpNextLevel() : int
      {
         return !!titan.level.nextLevel?titan.level.nextLevel.exp:0;
      }
      
      public function get xpCurrentLevel() : int
      {
         return !!titan.level?titan.level.exp:0;
      }
      
      public function get actionAvailable_evolve() : Boolean
      {
         return watch.evolvable;
      }
      
      public function get statList() : ListCollection
      {
         return _statList;
      }
      
      public function get playerTitanSpark() : InventoryItem
      {
         var _loc1_:InventoryItem = new InventoryItem(DataStorage.consumable.getTitanSparkDesc(),0);
         _loc1_.amount = GameModel.instance.player.inventory.getItemCount(_loc1_.item);
         return _loc1_;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney(true);
         _loc1_.requre_consumable(DataStorage.consumable.getTitanSparkDesc());
         _loc1_.requre_consumable(_potionDesc);
         return _loc1_;
      }
      
      public function get miniTitanListDataProvider() : ListCollection
      {
         return _miniTitanListDataProvider;
      }
      
      public function get miniTitanListSelectedItem() : PlayerTitanEntryValueObject
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc1_:int = _miniTitanListDataProvider.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = _miniTitanListDataProvider.getItemAt(_loc2_) as PlayerTitanEntryValueObject;
            if(_loc3_.titan == titan.titan)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function get potionDesc() : ConsumableDescription
      {
         var _loc1_:* = undefined;
         if(!_potionDesc)
         {
            _loc1_ = DataStorage.consumable.getItemsByType("titanExperience");
            _potionDesc = _loc1_[0];
         }
         return _potionDesc;
      }
      
      public function get titanArtifactsList() : Vector.<PlayerTitanArtifactVO>
      {
         var _loc2_:int = 0;
         var _loc1_:Vector.<PlayerTitanArtifactVO> = new Vector.<PlayerTitanArtifactVO>();
         if(titan)
         {
            _loc2_ = 0;
            while(_loc2_ < titan.artifacts.list.length)
            {
               _loc1_.push(new PlayerTitanArtifactVO(player,titan.artifacts.list[_loc2_],titan));
               _loc2_++;
            }
         }
         return _loc1_;
      }
      
      public function get titanSpiritArtifactVO() : PlayerTitanArtifactVO
      {
         return new PlayerTitanArtifactVO(player,titan.artifacts.spirit,titan);
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TitanPopup(this);
         return _popup;
      }
      
      public function action_miniListSelectionUpdate(param1:PlayerTitanEntryValueObject) : void
      {
         if(param1)
         {
            titan = param1.playerEntry;
         }
         else
         {
            titan = null;
         }
      }
      
      public function action_evolveTitan() : void
      {
         var _loc1_:* = null;
         if(!titan.star.next)
         {
            PopupList.instance.message(Translate.translate("UI_DIALOG_TITAN_EVOLVE_MAX"));
            return;
         }
         if(soulstoneCount >= soulstoneMaxCount)
         {
            _loc1_ = PopupList.instance.popup_titan_evolve_cost(titan.titan);
            _loc1_.signal_complete.addOnce(onAction_titanEvolve);
         }
         else
         {
            PopupList.instance.message(Translate.translateArgs("UI_DIALOG_TITAN_EVOLVE_REQUIREMENT",soulstoneMaxCount - soulstoneCount));
         }
      }
      
      public function action_levelUpByConsumable() : void
      {
         var _loc1_:* = null;
         var _loc2_:InventoryItem = player.inventory.getItemCollection().getItem(expComsumableCost.item);
         if(_loc2_ && _loc2_.amount >= expComsumableCost.amount)
         {
            GameModel.instance.actionManager.titan.titanConsumableUseXP(titan,expComsumableCost.item as ConsumableDescription,expComsumableCost.amount);
         }
         else
         {
            _loc1_ = PopupList.instance.dialog_not_enough_titan_consumable(Translate.translateArgs("UI_DIALOG_TITAN_NOT_ENOUGH_CONSUMABLE"),Translate.translateArgs("UI_DIALOG_TITAN_NOT_ENOUGH_CONSUMABLE_TITLE"),Translate.translateArgs("LIB_MECHANIC_NAVIGATE_GUILD_DUNGEON"));
            _loc1_.signal_okClose.add(navigateToDungeon);
         }
      }
      
      public function action_levelUpByStarMoney() : void
      {
         GameModel.instance.actionManager.titan.titanLevelUp(titan,levelUpCost);
      }
      
      public function action_navigateToSummoningCircle() : void
      {
         Game.instance.navigator.navigateToSummoningCircle(Stash.click("summoning_circle",_popup.stashParams));
      }
      
      public function action_navigateToForge() : void
      {
         var _loc1_:HeroRuneListPopupMediator = new HeroRuneListPopupMediator(player,"tab_elements");
         _loc1_.open(Stash.click("clan_forge",_popup.stashParams));
      }
      
      public function action_navigate_to_artifacts(param1:TitanArtifactDescription = null) : void
      {
         if(checkFor5Titans())
         {
            if(artifactsMechanicAvaliable)
            {
               PopupList.instance.dialog_titan_artifacts(titan.titan,param1,Stash.click("dialog_titan",_popup.stashParams));
            }
            else
            {
               PopupList.instance.message(Translate.translateArgs("UI_MECHANIC_NAVIGATOR_TEAM_LEVEL_REQUIRED",MechanicStorage.TITAN_ARTIFACT.teamLevel));
            }
         }
      }
      
      public function action_navigate_to_spirit_artifacts(param1:PlayerTitanArtifact) : void
      {
         if(checkFor5Titans())
         {
            if(artifactsMechanicAvaliable)
            {
               PopupList.instance.dialog_titan_spirit_artifacts(param1,Stash.click("dialog_titan",_popup.stashParams));
            }
            else
            {
               PopupList.instance.message(Translate.translateArgs("UI_MECHANIC_NAVIGATOR_TEAM_LEVEL_REQUIRED",MechanicStorage.TITAN_ARTIFACT.teamLevel));
            }
         }
      }
      
      private function checkFor5Titans() : Boolean
      {
         if(player.titans.getAmount() < 5)
         {
            PopupList.instance.message(Translate.translate("UI_TITAN_ARENA_NEGATIVE_TEXT_VALLEY"));
            return false;
         }
         return true;
      }
      
      private function handler_newTitanObtained(param1:PlayerTitanEntry) : void
      {
         createMiniList();
      }
      
      private function createMiniList() : void
      {
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc7_:* = null;
         var _loc1_:Vector.<PlayerTitanListValueObject> = new Vector.<PlayerTitanListValueObject>();
         var _loc5_:Vector.<TitanDescription> = DataStorage.titan.getPlayableTitans();
         var _loc2_:int = _loc5_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc3_ = _loc5_[_loc6_];
            if(_loc3_.isPlayable)
            {
               _loc4_ = player.titans.getById(_loc3_.id);
               if(_loc4_)
               {
                  _loc7_ = new PlayerTitanListValueObject(_loc3_,player);
                  _loc1_.push(_loc7_);
               }
            }
            _loc6_++;
         }
         _loc1_.sort(PlayerTitanListValueObject.sort);
         _miniTitanListDataProvider.data = _loc1_;
      }
      
      private function statListData_reset() : void
      {
         var _loc1_:Vector.<BattleStatValueObject> = BattleStatValueObjectProvider.fromBattleStats(titan.battleStats);
         _statList = new ListCollection(_loc1_);
      }
      
      private function statListData_update() : void
      {
         var _loc1_:* = undefined;
         var _loc3_:Vector.<BattleStatValueObject> = BattleStatValueObjectProvider.fromBattleStats(titan.battleStats);
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
      
      private function updateLevelUpParams() : void
      {
         expComsumableCost = new InventoryItem(potionDesc,Math.ceil((xpNextLevel - xpCurrent) / potionDesc.rewardAmount));
         levelUpCost = new InventoryItem(DataStorage.pseudo.STARMONEY,DataStorage.rule.titanExperienceStarMoneyCost * (xpNextLevel - xpCurrent));
      }
      
      private function handler_fragmentCountUpdate(param1:InventoryItemCountProxy) : void
      {
         _signl_fragmentCountUpdate.dispatch();
      }
      
      private function handler_experienceUpdate(param1:PlayerTitanEntry) : void
      {
         updateLevelUpParams();
         _signal_experienceUpdate.dispatch();
      }
      
      private function updateEvolveWatch(param1:PlayerTitanWatcherEntry) : void
      {
         _signal_evolvableStatusUpdate.dispatch();
      }
      
      private function onAction_titanEvolve() : void
      {
         _signal_titanEvolve.dispatch();
      }
      
      private function handler_titanUpdateBattleStats(param1:PlayerTitanEntry, param2:BattleStats) : void
      {
         statListData_update();
      }
      
      private function navigateToDungeon() : void
      {
         GamePopupManager.closeAll();
         Game.instance.navigator.navigateToMechanic(MechanicStorage.CLAN_DUNGEON,_popup.stashParams);
      }
      
      private function handler_playerTakeReward(param1:RewardData) : void
      {
         signal_titanSparkUpdate.dispatch();
      }
      
      private function handler_playerSpendCost(param1:CostData) : void
      {
         signal_titanSparkUpdate.dispatch();
      }
      
      private function handler_tianArtifactLevelUp(param1:PlayerTitanEntry, param2:PlayerTitanArtifact) : void
      {
         signal_titanArtifactUpgrade.dispatch();
      }
      
      private function handler_tianArtifactEvolve(param1:PlayerTitanEntry, param2:PlayerTitanArtifact) : void
      {
         signal_titanArtifactUpgrade.dispatch();
      }
   }
}
