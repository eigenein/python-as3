package game.view.gui.tutorial
{
   import avmplus.getQualifiedClassName;
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.mechanic.MechanicDescription;
   import game.data.storage.resource.ConsumableDescription;
   import game.data.storage.titan.TitanDescription;
   import game.data.storage.tutorial.TutorialTaskDescription;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.hero.PlayerTitanEntry;
   import game.model.user.inventory.InventoryCollection;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.mission.PlayerMissionEntry;
   import game.model.user.quest.PlayerQuestEntry;
   import game.view.gui.tutorial.condition.TutorialCondition;
   import game.view.gui.tutorial.condition.TutorialLibCondition;
   import game.view.gui.tutorial.condition.TutorialStateCondition;
   import game.view.gui.tutorial.dialogs.TutorialMessageEntry;
   import game.view.gui.tutorial.tutorialtarget.ITutorialTargetKey;
   
   public class TutorialTaskFactory
   {
       
      
      private var states:TutorialStateMachineResolver;
      
      private var executor:TutorialTaskExecutor;
      
      private var finder:TutorialTaskFinder;
      
      private var player:Player;
      
      private var chain:TutorialTaskChain;
      
      private var desc:TutorialTaskDescription;
      
      public function TutorialTaskFactory(param1:TutorialStateMachineResolver, param2:TutorialTaskExecutor)
      {
         super();
         this.states = param1;
         this.executor = param2;
         this.player = GameModel.instance.player;
         this.finder = new TutorialTaskFinder(player);
      }
      
      public function createFromDescription(param1:TutorialTaskChain, param2:TutorialTaskDescription) : TutorialTask
      {
         this.chain = param1;
         this.desc = param2;
         param2.initParams(player.tutorial.params);
         var _loc3_:TutorialTask = create(param2.name,param2.params);
         if(_loc3_ && param2.startCondition)
         {
            _loc3_.startCondition = new TutorialLibCondition(param2.startCondition.event,param2.startCondition.param);
         }
         if(_loc3_ && param2.view)
         {
            _loc3_.message = new TutorialMessageEntry(param2.view);
            _loc3_.message.needButton = _loc3_.completeCondition && _loc3_.completeCondition.ident == "tutorialOk";
         }
         return _loc3_;
      }
      
      public function create(param1:String, param2:Array) : TutorialTask
      {
         if(this.hasOwnProperty(param1) && this[param1] is Function)
         {
            if(this[param1].length <= param2.length)
            {
               return this[param1].apply(this,param2);
            }
            trace(getQualifiedClassName(this),"invalid task ident params count, expected",this[param1].length,"got",param2.length);
         }
         else
         {
            if(param1 == "" || param1 == null)
            {
               return emptyTask();
            }
            trace(getQualifiedClassName(this),"invalid task ident",param1);
         }
         return null;
      }
      
      public function emptyTask() : TutorialTask
      {
         return new TutorialTask(desc,chain);
      }
      
      public function beInWindow(param1:String) : TutorialTask
      {
         var _loc2_:TutorialTask = createTask(TutorialNavigator.TUTORIAL_MESSAGE,"tutorialOk",TutorialNavigator.ACTION_OK);
         _loc2_.skipCondition = new TutorialStateCondition(check_beInWindow);
         return _loc2_;
      }
      
      protected function check_beInWindow(param1:TutorialTask) : Boolean
      {
         return Tutorial.currentNode.name != param1.description.params[0];
      }
      
      public function check() : TutorialTask
      {
         return new TutorialTask(desc,chain);
      }
      
      public function closeButton() : TutorialTask
      {
         return createTask(null,"navigationCompleteAny",TutorialNavigator.ACTION_CLOSE);
      }
      
      public function upgradeSkill(param1:int, param2:int) : TutorialTask
      {
         var _loc3_:TutorialTask = createTask(TutorialNavigator.ACTION_UPGRADE_SKILL,"skillUpgrade",TutorialNavigator.ACTION_UPGRADE_SKILL);
         _loc3_.skipCondition = new TutorialStateCondition(check_canNotUpgradeSkill);
         _loc3_.filterNavigationAndCompleteCondition(getSkill(param1,param2),getUnit(param1));
         return _loc3_;
      }
      
      protected function check_canNotUpgradeSkill(param1:TutorialTask) : Boolean
      {
         return !finder.heroToUpgradeSkill(param1);
      }
      
      public function equipHero(param1:int) : TutorialTask
      {
         var _loc2_:TutorialTask = createTask(TutorialNavigator.ACTION_EQUIP_HERO,"heroEquip",TutorialNavigator.ACTION_EQUIP_HERO);
         _loc2_.skipCondition = new TutorialStateCondition(check_canNotEquipHero);
         _loc2_.filterNavigationAndCompleteCondition(getUnit(param1));
         return _loc2_;
      }
      
      protected function check_canNotEquipHero(param1:TutorialTask) : Boolean
      {
         return !finder.heroToEquip(param1);
      }
      
      public function promoteHero(param1:int) : TutorialTask
      {
         var _loc2_:TutorialTask = createTask(TutorialNavigator.ACTION_PROMOTE_HERO,"heroPromote",TutorialNavigator.ACTION_PROMOTE_HERO);
         _loc2_.skipCondition = new TutorialStateCondition(check_canNotPromoteHero);
         _loc2_.filterNavigationAndCompleteCondition(getUnit(param1));
         return _loc2_;
      }
      
      protected function check_canNotPromoteHero(param1:TutorialTask) : Boolean
      {
         return !finder.heroToPromote(param1);
      }
      
      public function evolveTitanArtifact() : TutorialTask
      {
         var _loc1_:TutorialTask = createTask(TutorialNavigator.ACTION_TITAN_ARTIFACT_EVOLVE_BUTTON,"evolveTitanArtifact",TutorialNavigator.ACTION_TITAN_ARTIFACT_EVOLVE_BUTTON);
         _loc1_.skipCondition = new TutorialStateCondition(check_canNotEvolveTitanArtifact);
         _loc1_.setKeys(getUnit(4000));
         return _loc1_;
      }
      
      protected function check_canNotEvolveTitanArtifact(param1:TutorialTask) : Boolean
      {
         return !finder.titanForArtifactWeaponEvolve(param1);
      }
      
      public function levelUpTitanArtifact() : TutorialTask
      {
         var _loc1_:TutorialTask = createTask(TutorialNavigator.TITAN_ARTIFACT,"levelUpTitanArtifact",TutorialNavigator.ACTION_TITAN_ARTIFACT_LEVELUP_BUTTON);
         _loc1_.skipCondition = new TutorialStateCondition(check_canNotLevelUpTitanArtifact);
         _loc1_.setKeys(getUnit(4000));
         return _loc1_;
      }
      
      protected function check_canNotLevelUpTitanArtifact(param1:TutorialTask) : Boolean
      {
         return !finder.titanForArtifactWeaponLevelUp(param1);
      }
      
      public function evolveHero(param1:int) : TutorialTask
      {
         var _loc2_:TutorialTask = createTask(TutorialNavigator.ACTION_EVOLVE_HERO,"heroEvolve",TutorialNavigator.ACTION_EVOLVE_HERO);
         _loc2_.skipCondition = new TutorialStateCondition(check_canNotEvolveHero);
         _loc2_.filterNavigationAndCompleteCondition(getUnit(param1));
         return _loc2_;
      }
      
      protected function check_canNotEvolveHero(param1:TutorialTask) : Boolean
      {
         return !finder.heroToEvolve(param1);
      }
      
      public function evolveHeroStrict(param1:int) : TutorialTask
      {
         var _loc2_:TutorialTask = createTask(TutorialNavigator.ACTION_EVOLVE_HERO,"heroEvolve",TutorialNavigator.ACTION_EVOLVE_HERO);
         _loc2_.skipCondition = new TutorialStateCondition(check_canNotEvolveHeroStrict);
         _loc2_.filterNavigationAndCompleteCondition(getUnit(param1));
         return _loc2_;
      }
      
      protected function check_canNotEvolveHeroStrict(param1:TutorialTask) : Boolean
      {
         return !finder.heroToEvolveStrict(param1);
      }
      
      public function heroUseConsumable(param1:int) : TutorialTask
      {
         var _loc2_:TutorialTask = createTask(TutorialNavigator.HERO_USE_CONSUMABLE,"heroUseConsumable",TutorialNavigator.ACTION_HERO_USE_CONSUMABLE);
         _loc2_.skipCondition = new TutorialStateCondition(check_canNotUseConsumable);
         _loc2_.filterNavigationAndCompleteCondition(getUnit(param1));
         return _loc2_;
      }
      
      protected function check_canNotUseConsumable(param1:TutorialTask) : Boolean
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc7_:PlayerHeroEntry = player.heroes.getById(param1.target.unit.id);
         if(_loc7_ == null || _loc7_.experience >= player.heroes.getMaxHeroExp())
         {
            return true;
         }
         var _loc6_:InventoryCollection = player.inventory.getItemCollection().getCollectionByType(InventoryItemType.CONSUMABLE);
         var _loc2_:Array = _loc6_.getArray();
         var _loc4_:int = _loc2_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = _loc2_[_loc5_];
            if((_loc3_.item as ConsumableDescription).rewardType == "heroExperience")
            {
               if(_loc3_.amount > 0)
               {
                  return false;
               }
            }
            _loc5_++;
         }
         return true;
      }
      
      public function goQuest(param1:int) : TutorialTask
      {
         var _loc2_:TutorialTask = createTask(TutorialNavigator.QUESTS,"questGo",TutorialNavigator.ACTION_QUEST_GO);
         _loc2_.skipCondition = new TutorialStateCondition(check_questCanNotFarm);
         _loc2_.filterNavigationAndCompleteCondition(getQuest(param1));
         return _loc2_;
      }
      
      public function goDailyQuest(param1:int) : TutorialTask
      {
         var _loc2_:TutorialTask = createTask(TutorialNavigator.QUESTS,"questGo",TutorialNavigator.ACTION_QUEST_GO);
         _loc2_.skipCondition = new TutorialStateCondition(check_questCanNotFarm);
         _loc2_.filterNavigationAndCompleteCondition(getQuest(param1));
         return _loc2_;
      }
      
      public function farmQuest(param1:int) : TutorialTask
      {
         var _loc2_:TutorialTask = createTask(TutorialNavigator.QUESTS,"questFarm",TutorialNavigator.ACTION_QUEST_FARM);
         _loc2_.skipCondition = new TutorialStateCondition(check_questCanNotFarm);
         _loc2_.filterNavigationAndCompleteCondition(getQuest(param1));
         return _loc2_;
      }
      
      public function farmDailyQuest(param1:int) : TutorialTask
      {
         var _loc2_:TutorialTask = createTask(TutorialNavigator.DAILY_QUESTS,"questFarm",TutorialNavigator.ACTION_QUEST_FARM);
         _loc2_.skipCondition = new TutorialStateCondition(check_questCanNotFarm);
         _loc2_.filterNavigationAndCompleteCondition(getQuest(param1));
         return _loc2_;
      }
      
      protected function check_questCanNotFarm(param1:TutorialTask) : Boolean
      {
         var _loc2_:PlayerQuestEntry = player.questData.getQuest(param1.target.quest.id);
         if(!_loc2_)
         {
            return true;
         }
         return !_loc2_.canFarm;
      }
      
      public function obtainHeroSomeWay(param1:int) : TutorialTask
      {
         var _loc2_:TutorialTask = new TutorialTask(desc,chain);
         _loc2_.skipCondition = new TutorialStateCondition(check_heroObtained);
         _loc2_.completeCondition = new TutorialCondition("heroObtain");
         _loc2_.filterNavigationAndCompleteCondition(getUnit(param1));
         return _loc2_;
      }
      
      protected function check_heroObtained(param1:TutorialTask) : Boolean
      {
         var _loc2_:PlayerHeroEntry = player.heroes.getById(param1.target.unit.id);
         return _loc2_;
      }
      
      public function obtainTitanAmountSomeWay(param1:int) : TutorialTask
      {
         amount = param1;
         check_someTitanObtained = function(param1:TutorialTask):Boolean
         {
            return player.titans.getAmount() >= amount;
         };
         var task:TutorialTask = new TutorialTask(desc,chain);
         task.skipCondition = new TutorialStateCondition(check_someTitanObtained);
         task.completeCondition = new TutorialCondition("titanAmount",amount);
         return task;
      }
      
      public function action_claimReward() : TutorialTask
      {
         var _loc1_:TutorialTask = createActionTask(executor.claimClanJoinReward);
         return _loc1_;
      }
      
      public function action_claimArtifactIntroReward() : TutorialTask
      {
         return createActionTask(executor.claimArtifactIntroReward);
      }
      
      public function titanLevelUpPotion() : TutorialTask
      {
         check_canNotTitanLevelUpPotion = function(param1:TutorialTask):Boolean
         {
            if(param1.target == null)
            {
               return false;
            }
            if(param1.target.unit == null)
            {
               return false;
            }
            var _loc3_:PlayerTitanEntry = player.titans.getById(param1.target.unit.id);
            if(_loc3_ == null)
            {
               return false;
            }
            if(_loc3_.level.nextLevel == null)
            {
               return false;
            }
            var _loc2_:int = _loc3_.level.nextLevel.exp - _loc3_.level.exp;
            var _loc4_:int = player.inventory.getItemCount(player.titans.levelUpPotionDescription);
            return _loc4_ < _loc2_;
         };
         var task:TutorialTask = createTask(TutorialNavigator.TITAN,"titanLevelUp",TutorialNavigator.ACTION_TITAN_LEVEL_UP_POTION);
         task.filterNavigationAndCompleteCondition(getMaxLevelTitan());
         task.skipCondition = new TutorialStateCondition(check_canNotTitanLevelUpPotion);
         return task;
      }
      
      protected function getMaxLevelTitan() : TitanDescription
      {
         var _loc2_:int = 0;
         var _loc4_:Vector.<PlayerTitanEntry> = player.titans.getList();
         var _loc1_:int = 0;
         var _loc6_:* = null;
         var _loc3_:int = player.levelData.level.maxTitanLevel;
         var _loc8_:int = 0;
         var _loc7_:* = _loc4_;
         for each(var _loc5_ in _loc4_)
         {
            _loc2_ = _loc5_.level.level;
            if(_loc2_ > _loc1_ && _loc2_ < _loc5_.levelMax.level && _loc2_ < _loc3_)
            {
               _loc1_ = _loc5_.level.level;
               _loc6_ = _loc5_;
            }
         }
         if(_loc6_)
         {
            return _loc6_.titan;
         }
         return null;
      }
      
      public function titanArtifactChestOpenFree(param1:int) : TutorialTask
      {
         var _loc2_:TutorialTask = createTask(TutorialNavigator.TITAN_VALLEY_ALTAR,"titanArtifactChestOpenFree",TutorialNavigator.ACTION_TITAN_VALLEY_ALTAR_BUTTON);
         _loc2_.skipCondition = new TutorialStateCondition(check_canNotTitanArtifactChestOpenFree);
         return _loc2_;
      }
      
      protected function check_canNotTitanArtifactChestOpenFree(param1:TutorialTask) : Boolean
      {
         var _loc2_:CostData = DataStorage.rule.titanArtifactChestRule.openCostX1.clone() as CostData;
         _loc2_.multiply(param1.description.params[0]);
         return player.clan.clan == null || !player.canSpend(_loc2_);
      }
      
      public function summoningCircleOne() : TutorialTask
      {
         var _loc1_:TutorialTask = createTask(TutorialNavigator.CLAN_SUMMONING_CIRCLE,"summoningCircleOne",TutorialNavigator.ACTION_CLAN_SUMMONING_CIRCLE_ONE);
         _loc1_.skipCondition = new TutorialStateCondition(check_canNotSummoningCircleOne);
         return _loc1_;
      }
      
      protected function check_canNotSummoningCircleOne(param1:TutorialTask) : Boolean
      {
         return player.clan.clan == null || !player.canSpend(DataStorage.clanSummoningCircle.defaultCircle.cost_single);
      }
      
      public function craftHero(param1:int) : TutorialTask
      {
         var _loc2_:TutorialTask = createTask(TutorialNavigator.ACTION_OBTAIN_HERO,"heroObtain",TutorialNavigator.ACTION_EVOLVE_HERO);
         _loc2_.skipCondition = new TutorialStateCondition(check_heroCanNotBeCrafted);
         _loc2_.filterNavigationAndCompleteCondition(getUnit(param1));
         return _loc2_;
      }
      
      protected function check_heroCanNotBeCrafted(param1:TutorialTask) : Boolean
      {
         if(check_heroObtained(param1))
         {
            return true;
         }
         var _loc5_:HeroDescription = param1.target.unit as HeroDescription;
         var _loc3_:int = _loc5_.startingStar.star.summonFragmentCost;
         var _loc2_:int = player.inventory.getFragmentCount(_loc5_);
         var _loc4_:int = _loc5_.startingStar.star.summonGoldCost.gold;
         var _loc6_:int = player.gold;
         return _loc2_ < _loc3_ || _loc6_ < _loc4_;
      }
      
      public function startMission(param1:int) : TutorialTask
      {
         var _loc2_:TutorialTask = createTask(TutorialNavigator.MISSION,"missionStart",TutorialNavigator.TEAM_GATHER,TutorialNavigator.ACTION_START_BATTLE);
         _loc2_.filterNavigationAndCompleteCondition(getMission(param1));
         return _loc2_;
      }
      
      public function goMission(param1:int) : TutorialTask
      {
         var _loc2_:TutorialTask = new TutorialTask(desc,chain);
         _loc2_.setGuiTarget(TutorialNavigator.MISSION,TutorialNavigator.TEAM_GATHER);
         _loc2_.setKeys(getMission(param1));
         _loc2_.completeCondition = new TutorialCondition("navigationComplete",TutorialNavigator.MISSION);
         return _loc2_;
      }
      
      public function useAlchemy() : TutorialTask
      {
         return createTask(TutorialNavigator.ALCHEMY,"alchemyUse",TutorialNavigator.ACTION_ALCHEMY_USE);
      }
      
      public function openChestFree(param1:String) : TutorialTask
      {
         var _loc2_:TutorialTask = createTask(TutorialNavigator.CHESTS,"chestOpenFree",TutorialNavigator.ACTION_CHEST);
         _loc2_.filterNavigationAndCompleteCondition(getChest(param1));
         return _loc2_;
      }
      
      public function openChestSingleOrFree(param1:String) : TutorialTask
      {
         var _loc2_:TutorialTask = createTask(TutorialNavigator.CHESTS,"chestOpenSingleOrFree",TutorialNavigator.ACTION_CHEST);
         _loc2_.filterNavigationAndCompleteCondition(getChest(param1));
         return _loc2_;
      }
      
      public function openChestSingle(param1:String) : TutorialTask
      {
         var _loc2_:TutorialTask = createTask(TutorialNavigator.CHESTS,"chestOpenSingle",TutorialNavigator.ACTION_CHEST);
         _loc2_.filterNavigationAndCompleteCondition(getChest(param1));
         return _loc2_;
      }
      
      public function openChestPack(param1:String) : TutorialTask
      {
         var _loc2_:TutorialTask = createTask(TutorialNavigator.CHESTS,"chestOpenPack",TutorialNavigator.ACTION_CHEST);
         _loc2_.filterNavigationAndCompleteCondition(getChest(param1));
         return _loc2_;
      }
      
      public function text() : TutorialTask
      {
         return createTask(null,"navigationCompleteAny");
      }
      
      public function textWaitingForEvent(param1:String) : TutorialTask
      {
         return createTask(null,param1);
      }
      
      public function textLock() : TutorialTask
      {
         var _loc1_:TutorialTask = createTask(TutorialNavigator.TUTORIAL_MESSAGE,"tutorialOk",TutorialNavigator.ACTION_OK);
         _loc1_.signal_onStart.add(executor.pauseBattle);
         _loc1_.signal_onComplete.add(executor.startBattle);
         return _loc1_;
      }
      
      public function heroSay(param1:int) : TutorialTask
      {
         var _loc2_:TutorialTask = createActionTask(executor.heroSay);
         _loc2_.setKeys(getUnit(param1));
         return _loc2_;
      }
      
      public function enemySay(param1:int) : TutorialTask
      {
         var _loc2_:TutorialTask = createActionTask(executor.enemySay);
         _loc2_.setKeys(getUnit(param1));
         return _loc2_;
      }
      
      public function navigateTo(param1:String) : TutorialTask
      {
         var _loc3_:TutorialNode = states.getNodeByName(param1);
         var _loc2_:TutorialTask = createClickTask(_loc3_);
         _loc2_.completeCondition = new TutorialCondition("navigationComplete",_loc3_);
         return _loc2_;
      }
      
      public function toHomeScreen() : TutorialTask
      {
         var _loc1_:TutorialTask = createClickTask(TutorialNavigator.HOME_SCREEN);
         _loc1_.completeCondition = new TutorialCondition("navigationComplete",TutorialNavigator.HOME_SCREEN);
         return _loc1_;
      }
      
      public function toArena() : TutorialTask
      {
         var _loc1_:TutorialTask = createClickTask(TutorialNavigator.ARENA);
         _loc1_.completeCondition = new TutorialCondition("navigationComplete",TutorialNavigator.ARENA);
         return _loc1_;
      }
      
      public function textIfDialog(param1:String) : TutorialTask
      {
         var _loc2_:TutorialTask = new TutorialTask(desc,chain);
         var _loc3_:TutorialNode = states.getNodeByName(param1);
         if(!Tutorial.isCurrentNode(_loc3_))
         {
            _loc2_.startCondition = new TutorialCondition("navigationComplete",_loc3_);
         }
         _loc2_.completeCondition = new TutorialCondition("navigationCompleteAny",null);
         return _loc2_;
      }
      
      public function selectFullTeam() : TutorialTask
      {
         var _loc1_:TutorialTask = createTask(TutorialNavigator.TEAM_GATHER,"fullTeamSelected",TutorialNavigator.ACTION_GATHER_TEAM);
         return _loc1_;
      }
      
      public function onCompleteMissionOnce(param1:int) : TutorialTask
      {
         var _loc2_:TutorialTask = new TutorialTask(desc,chain);
         _loc2_.skipCondition = new TutorialStateCondition(check_missionCompleted);
         _loc2_.setKeys(getMission(param1));
         _loc2_.startCondition = new TutorialCondition("missionStart",param1);
         _loc2_.completeCondition = new TutorialCondition("missionComplete",param1);
         return _loc2_;
      }
      
      public function completeMissionOnce(param1:int) : TutorialTask
      {
         var _loc2_:TutorialTask = new TutorialTask(desc,chain);
         _loc2_.setGuiTarget(TutorialNavigator.MISSION,TutorialNavigator.TEAM_GATHER,TutorialNavigator.ACTION_START_BATTLE);
         _loc2_.doNotLockButtonsOn(TutorialNavigator.MISSION);
         _loc2_.skipCondition = new TutorialStateCondition(check_missionCompleted);
         _loc2_.setKeys(getMission(param1));
         _loc2_.completeCondition = new TutorialCondition("missionComplete",param1);
         return _loc2_;
      }
      
      protected function check_missionCompleted(param1:TutorialTask) : Boolean
      {
         var _loc2_:PlayerMissionEntry = player.missions.getByDesc(param1.target.mission);
         return _loc2_ && _loc2_.stars > 0;
      }
      
      public function startBattle() : TutorialTask
      {
         return createTask(null,"teamSelectionCompleted",TutorialNavigator.ACTION_START_BATTLE);
      }
      
      public function startArenaBattle() : TutorialTask
      {
         return createTask(null,"teamSelectionCompleted",TutorialNavigator.ACTION_START_ARENA_BATTLE);
      }
      
      public function arenaAttack(param1:int) : TutorialTask
      {
         var _loc2_:TutorialNodeAction = null;
         if(param1 == 1)
         {
            _loc2_ = TutorialNavigator.ACTION_ARENA_ATTACK_1;
         }
         if(param1 == 2)
         {
            _loc2_ = TutorialNavigator.ACTION_ARENA_ATTACK_2;
         }
         if(param1 == 3)
         {
            _loc2_ = TutorialNavigator.ACTION_ARENA_ATTACK_3;
         }
         return createTask(TutorialNavigator.ARENA,"arenaStart",_loc2_,TutorialNavigator.TEAM_GATHER_ARENA,TutorialNavigator.ACTION_START_ARENA_BATTLE);
      }
      
      public function action_closeAll() : TutorialTask
      {
         return createActionTask(executor.closeAll);
      }
      
      public function action_dropChestTimer() : TutorialTask
      {
         var _loc1_:TutorialTask = createActionTask(executor.dropChestTimer);
         _loc1_.skipCondition = new TutorialStateCondition(check_freeBronzeChestAvailable);
         return _loc1_;
      }
      
      protected function check_freeBronzeChestAvailable(param1:TutorialTask) : Boolean
      {
         return player.refillable.hasFreeChests;
      }
      
      public function action_battleUnlink() : TutorialTask
      {
         var _loc1_:TutorialTask = createActionTask(executor.battleUnlink);
         executor.toggleOnTutorialBattle();
         _loc1_.signal_onComplete.add(executor.toggleOffTutorialBattle);
         return _loc1_;
      }
      
      public function action_tutorialMissionComplete() : TutorialTask
      {
         var _loc1_:TutorialTask = createActionTask(executor.tutorialMissionComplete);
         executor.toggleOnTutorialBattle();
         _loc1_.signal_onComplete.add(executor.toggleOffTutorialBattle);
         _loc1_.completeCondition = new TutorialCondition("dialogClose",TutorialNavigator.REWARD_MISSION);
         return _loc1_;
      }
      
      public function action_pauseBattle() : TutorialTask
      {
         return createActionTask(executor.pauseBattle);
      }
      
      public function action_jumpToMission(param1:int) : TutorialTask
      {
         return createActionTask(executor.jumpToMission,getMission(param1));
      }
      
      public function action_jumpToHeroes() : TutorialTask
      {
         return createActionTask(executor.jumpToHeroes);
      }
      
      public function action_jumpToHero(param1:int) : TutorialTask
      {
         return createActionTask(executor.jumpToHero,getUnit(param1));
      }
      
      public function action_nothing() : TutorialTask
      {
         return createActionTask(executor.nothing);
      }
      
      public function ultManual() : TutorialTask
      {
         var _loc1_:TutorialTask = new TutorialTask(desc,chain);
         _loc1_.setGuiTarget(null,TutorialNavigator.ACTION_BATTLE_HERO);
         _loc1_.completeCondition = new TutorialCondition("battleUserAction");
         _loc1_.signal_onStart.add(executor.pauseBattle);
         _loc1_.signal_onComplete.add(executor.startBattle);
         return _loc1_;
      }
      
      public function dialogClosed(param1:String) : TutorialTask
      {
         var _loc2_:TutorialTask = new TutorialTask(desc,chain);
         _loc2_.completeCondition = new TutorialCondition("dialogClose",param1);
         return _loc2_;
      }
      
      public function obtainHeroesForMechanics(param1:String) : TutorialTask
      {
         var _loc2_:TutorialTask = new TutorialTask(desc,chain);
         var _loc3_:MechanicDescription = DataStorage.mechanic.getByType(param1);
         _loc2_.completeCondition = new TutorialCondition("heroLevel",_loc3_.minHeroLevel);
         _loc2_.skipCondition = new TutorialStateCondition(check_heroesForMechanicsAvailable);
         return _loc2_;
      }
      
      protected function check_heroesForMechanicsAvailable(param1:TutorialTask) : Boolean
      {
         var _loc2_:int = param1.completeCondition.data;
         return player.heroes.teamGathering.countHeroesOfLevel(_loc2_) > 0;
      }
      
      public function unlockedMechanics(param1:String) : TutorialTask
      {
         var _loc2_:TutorialTask = new TutorialTask(desc,chain);
         _loc2_.completeCondition = new TutorialCondition("unlockedMechanics",param1);
         _loc2_.skipCondition = new TutorialStateCondition(check_mechanicsAvailable);
         return _loc2_;
      }
      
      protected function check_mechanicsAvailable(param1:TutorialTask) : Boolean
      {
         var _loc3_:String = param1.completeCondition.data;
         var _loc4_:MechanicDescription = DataStorage.mechanic.getByType(_loc3_);
         var _loc2_:* = player.levelData.level.level >= _loc4_.teamLevel;
         return _loc2_;
      }
      
      protected function getQuest(param1:int) : ITutorialTargetKey
      {
         return DataStorage.quest.getQuestById(param1);
      }
      
      protected function getMission(param1:int) : ITutorialTargetKey
      {
         return DataStorage.mission.getMissionById(param1);
      }
      
      protected function getUnit(param1:int) : ITutorialTargetKey
      {
         return DataStorage.hero.getUnitById(param1);
      }
      
      protected function getSkill(param1:int, param2:int) : ITutorialTargetKey
      {
         return DataStorage.skill.getByHeroAndTier(param1,param2);
      }
      
      protected function getChest(param1:String) : ITutorialTargetKey
      {
         return DataStorage.chest.getByIdent(param1);
      }
      
      private function createActionTask(param1:Function, param2:ITutorialTargetKey = null, param3:ITutorialTargetKey = null) : TutorialTask
      {
         var _loc4_:TutorialTask = new TutorialTask(desc,chain);
         _loc4_.signal_onStart.addOnce(param1);
         _loc4_.setKeys(param2,param3);
         return _loc4_;
      }
      
      private function createTask(param1:TutorialNode, param2:String, ... rest) : TutorialTask
      {
         var _loc4_:TutorialTask = new TutorialTask(desc,chain);
         _loc4_.completeCondition = new TutorialCondition(param2,null);
         _loc4_.setGuiTargetWithArray(param1,rest);
         return _loc4_;
      }
      
      private function createClickTask(param1:TutorialNode, ... rest) : TutorialTask
      {
         var _loc3_:TutorialTask = new TutorialTask(desc,chain);
         _loc3_.setGuiTargetWithArray(param1,rest);
         return _loc3_;
      }
   }
}
