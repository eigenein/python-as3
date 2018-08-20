package game.view.gui.tutorial
{
   import battle.BattleStats;
   import engine.debug.ClickLoger;
   import flash.utils.Dictionary;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.chest.ChestDescription;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.level.HeroLevel;
   import game.data.storage.level.PlayerTeamLevel;
   import game.data.storage.level.TitanLevel;
   import game.data.storage.mechanic.MechanicDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.pve.mission.MissionDescription;
   import game.data.storage.skills.SkillDescription;
   import game.mediator.gui.popup.shop.titansoul.TitanSoulShopUtils;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.hero.PlayerTitanArtifact;
   import game.model.user.hero.PlayerTitanEntry;
   import game.model.user.quest.PlayerQuestEntry;
   import game.model.user.refillable.PlayerAlchemyRefillableEntry;
   import game.view.gui.tutorial.condition.TutorialCondition;
   import game.view.gui.tutorial.condition.TutorialLibCondition;
   import idv.cjcat.signals.Signal;
   
   public class TutorialEvents
   {
      
      public static const DIALOG_ANY:String = "any";
      
      public static const DIALOG_CLOSE:String = "dialogClose";
      
      public static const DIALOG_OPEN:String = "dialogOpen";
      
      public static const DAILY_QUESTS_DIMMER_SECOND_START_CONDITION:String = "dailyQuestsDimmerSecondStartCondition";
      
      public static const CHECK_TUTORIAL_UNLOCKER:String = "checkTutorialUnlocker";
      
      public static const NAVIGATION_COMPLETE:String = "navigationComplete";
      
      public static const NAVIGATION_COMPLETE_ANY:String = "navigationCompleteAny";
      
      public static const QUEST_FARM:String = "questFarm";
      
      public static const QUEST_GO:String = "questGo";
      
      public static const ALCHEMY_USE:String = "alchemyUse";
      
      public static const SKILL_UPGRADE:String = "skillUpgrade";
      
      public static const HERO_EQUIP:String = "heroEquip";
      
      public static const HERO_PROMOTE:String = "heroPromote";
      
      public static const HERO_EVOLVE:String = "heroEvolve";
      
      public static const HERO_USE_CONSUMABLE:String = "heroUseConsumable";
      
      public static const HERO_LEVEL:String = "heroLevel";
      
      public static const MISSION_START:String = "missionStart";
      
      public static const MISSION_COMPLETE:String = "missionComplete";
      
      public static const HERO_OBTAIN:String = "heroObtain";
      
      public static const HERO_AMOUNT:String = "heroAmount";
      
      public static const FULL_TEAM_SELECTED:String = "fullTeamSelected";
      
      public static const HAS_TEAM_TO_SELECT:String = "hasTeamToSelect";
      
      public static const TEAM_SELECTION_COMPLETED:String = "teamSelectionCompleted";
      
      public static const ARENA_START:String = "arenaStart";
      
      public static const CHEST_OPEN_FREE:String = "chestOpenFree";
      
      public static const CHEST_OPEN_SINGLE:String = "chestOpenSingle";
      
      public static const CHEST_OPEN_PACK:String = "chestOpenPack";
      
      public static const CHEST_OPEN_SINGLE_OR_FREE:String = "chestOpenSingleOrFree";
      
      public static const TUTORIAL_OK:String = "tutorialOk";
      
      public static const BATTLE_USER_ACTION_AVAILABLE:String = "ultAvailable";
      
      public static const BATTLE_HERO_DEAD:String = "battleHeroDead";
      
      public static const BATTLE_USER_ACTION:String = "battleUserAction";
      
      public static const BATTLE_TIMING:String = "battleTiming";
      
      public static const BATTLE_PAUSE_REACHED:String = "battlePauseReached";
      
      public static const UNLOCKED_MECHANICS:String = "unlockedMechanics";
      
      public static const REWARD_DIALOG_CLOSED:String = "rewardDialogClosed";
      
      public static const REWARD_HERO_DIALOG_CLOSED:String = "rewardHeroDialogClosed";
      
      public static const TEAM_LEVEL_DIALOG_CLOSED:String = "teamLevelDialogClosed";
      
      public static const TUTORIAL_PROGRESS_SAVED:String = "tutorialProgressSaved";
      
      public static const TUTORIAL_REWARD_CLAIMED:String = "tutorialRewardClaimed";
      
      public static const TUTORIAL_MISS_CLICK:String = "tutorialMissClick";
      
      public static const HAS_ENOUGHT:String = "hasEnough";
      
      public static const HAS_TITAN_FRAGMENTS_TO_SELL:String = "hasTitanFragmentsToSell";
      
      public static const CLAN_SCREEN_TRANSITION:String = "clanScreenTransition";
      
      public static const TITAN_ARTIFACTS_AVAILABLE:String = "titanArtifactsAvailable";
      
      public static const HAS_DAILY_QUESTS_WITH_EXP_TO_FARM:String = "hasDailyQuestsWithExpToFarm";
      
      public static const TITAN_OBTAIN:String = "titanObtain";
      
      public static const TITAN_AMOUNT:String = "titanAmount";
      
      public static const TITAN_EVOLVE:String = "heroEvolve";
      
      public static const TITAN_LEVEL:String = "titanLevel";
      
      public static const TITAN_LEVEL_UP:String = "titanLevelUp";
      
      public static const SUMMONING_CIRCLE_ONE:String = "summoningCircleOne";
      
      public static const SUMMONING_CIRCLE_PACK:String = "summoningCirclePack";
      
      public static const TITAN_ARTIFACT_CHEST_OPEN_FREE:String = "titanArtifactChestOpenFree";
      
      public static const TITAN_ARTIFACT_CHEST_OPEN_COMPLETE:String = "titanArtifactChestOpenComplete";
      
      public static const TITAN_ARTIFACT_EVOLVE:String = "evolveTitanArtifact";
      
      public static const TITAN_ARTIFACT_LEVEL_UP:String = "levelUpTitanArtifact";
       
      
      private const registeredSignals:Dictionary = new Dictionary();
      
      private var player:Player;
      
      private var conditions:Vector.<TutorialCondition>;
      
      private var dispatching:Boolean = false;
      
      private var tempConditions:Vector.<TutorialCondition>;
      
      private var updatedConditions:Vector.<TutorialCondition>;
      
      public function TutorialEvents()
      {
         conditions = new Vector.<TutorialCondition>();
         tempConditions = new Vector.<TutorialCondition>();
         super();
      }
      
      public function addCondition(param1:TutorialCondition) : void
      {
         var _loc2_:int = conditions.indexOf(param1);
         if(_loc2_ == -1)
         {
            if(param1.ident == "battleTiming")
            {
               Tutorial.flags.toggle_tutorialBattle(true);
            }
            if(updatedConditions)
            {
               updatedConditions.push(param1);
            }
            else
            {
               conditions.push(param1);
            }
         }
      }
      
      public function removeCondition(param1:TutorialCondition) : void
      {
         var _loc2_:Vector.<TutorialCondition> = !!updatedConditions?updatedConditions:conditions;
         var _loc3_:int = _loc2_.indexOf(param1);
         if(_loc3_ != -1)
         {
            spliceListener(param1);
         }
      }
      
      public function hasCondition(param1:String) : Boolean
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function removeConditionByListener(param1:ITutorialConditionListener) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function subscribeAll() : void
      {
         player = GameModel.instance.player;
         subscribeSignal(player.questData.signal_questRemoved,playerQuestRemoved);
         subscribeSignal(player.questData.signal_questProgress,playerQuestProgress);
         subscribeSignal(player.heroes.signal_heroUpgradeSkill,playerSkillUpgrade);
         subscribeSignal(player.heroes.signal_newHeroObtained,playerHeroObtained);
         subscribeSignal(player.heroes.signal_heroEvolveStar,playerHeroEvolve);
         subscribeSignal(player.levelData.signal_levelUp,playerLevelUp);
         var _loc1_:PlayerAlchemyRefillableEntry = player.refillable.getById(DataStorage.refillable.ALCHEMY.id) as PlayerAlchemyRefillableEntry;
         subscribeSignal(_loc1_.signal_update,alchemyUse);
         subscribeSignalOrgOs(player.titans.signal_newTitanObtained,playerTitanObtained);
         subscribeSignalOrgOs(player.titans.signal_titanEvolveStar,playerTitanEvolve);
         subscribeSignal(player.signal_takeReward,playerTakeReward);
      }
      
      public function triggerEvent_chestBuy(param1:ChestDescription, param2:Boolean, param3:Boolean) : void
      {
         if(param2)
         {
            triggerEqualDataCondition("chestOpenFree",param1);
            triggerEqualDataCondition("chestOpenSingleOrFree",param1);
         }
         else if(param3)
         {
            triggerEqualDataCondition("chestOpenPack",param1);
         }
         else
         {
            triggerEqualDataCondition("chestOpenSingle",param1);
            triggerEqualDataCondition("chestOpenSingleOrFree",param1);
         }
      }
      
      public function triggerEvent_heroEquip(param1:HeroDescription) : void
      {
         triggerEqualDataCondition("heroEquip",param1);
      }
      
      public function triggerEvent_heroPromoteColor(param1:HeroDescription) : void
      {
         triggerEqualDataCondition("heroPromote",param1);
      }
      
      public function triggerEvent_heroUseConsumable() : void
      {
         triggerCondition("heroUseConsumable");
      }
      
      public function triggerEvent_heroLevelUp(param1:PlayerHeroEntry, param2:HeroLevel) : void
      {
         triggerMethodCondition("heroLevel",checkCondition_dataGreaterOrEqual,param2.level);
      }
      
      public function triggerEvent_titanLevelUp(param1:PlayerTitanEntry, param2:TitanLevel) : void
      {
         triggerMethodCondition("titanLevel",checkCondition_dataGreaterOrEqual,param2.level);
         triggerCondition("titanLevelUp");
      }
      
      public function triggerEvent_rewardDialogClosed() : void
      {
         triggerCondition("rewardDialogClosed");
      }
      
      public function triggerEvent_rewardHeroDialogClosed() : void
      {
         triggerCondition("rewardHeroDialogClosed");
      }
      
      public function triggerEvent_teamLevelDialogClosed() : void
      {
         triggerCondition("teamLevelDialogClosed");
      }
      
      public function triggerEvent_dialogClosed(param1:TutorialNode) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function triggerEvent_dialogNodeReached(param1:TutorialNode) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function triggerEvent_tutorialProgressSaved() : void
      {
         triggerCondition("tutorialProgressSaved");
      }
      
      public function triggerEvent_tutorialRewardClaimed() : void
      {
         triggerCondition("tutorialRewardClaimed");
      }
      
      public function triggerEvent_tutorialMissClick() : void
      {
         triggerCondition("tutorialMissClick");
      }
      
      public function triggerEvent_missionStart(param1:MissionDescription) : void
      {
         triggerEqualDataCondition("missionStart",param1.id);
      }
      
      public function triggerEvent_missionComplete(param1:MissionDescription) : void
      {
         triggerEqualDataCondition("missionComplete",param1.id);
      }
      
      public function triggerEvent_arenaStart() : void
      {
         triggerCondition("arenaStart");
      }
      
      public function triggerEvent_anyNavigation() : void
      {
         triggerCondition("navigationCompleteAny");
      }
      
      public function triggerEvent_fullTeamSelected() : void
      {
         triggerCondition("fullTeamSelected");
      }
      
      public function triggerEvent_hasTeamToSelect() : void
      {
         triggerCondition("hasTeamToSelect");
      }
      
      public function triggerEvent_teamSelectionCompleted() : void
      {
         triggerCondition("teamSelectionCompleted");
      }
      
      public function triggerEvent_battleTiming(param1:int, param2:Number) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function triggerEvent_battlePauseReached() : void
      {
         triggerCondition("battlePauseReached");
      }
      
      public function triggerEvent_battle_userActionAvailable(param1:Number) : void
      {
         triggerMethodCondition("ultAvailable",checkCondition_dataGreaterOrEqual,param1,true);
      }
      
      public function triggerEvent_battle_heroDead(param1:int) : void
      {
         triggerEqualDataCondition("battleHeroDead",param1);
      }
      
      public function triggerEvent_battle_userAction(param1:int) : void
      {
         triggerCondition("battleUserAction");
      }
      
      public function triggerEvent_tutorialOk() : void
      {
         triggerCondition("tutorialOk");
      }
      
      public function triggerEvent_farmQuest(param1:PlayerQuestEntry) : void
      {
         triggerEqualDataCondition("questFarm",param1.desc);
      }
      
      public function triggerEvent_titanArtifactEvolve(param1:PlayerTitanArtifact) : void
      {
         triggerEqualDataCondition("evolveTitanArtifact",param1);
      }
      
      public function triggerEvent_titanArtifactLevelUp(param1:PlayerTitanArtifact) : void
      {
         triggerEqualDataCondition("levelUpTitanArtifact",param1);
      }
      
      public function triggerEvent_titanArtifactChestOpenFree() : void
      {
         triggerCondition("titanArtifactChestOpenFree");
      }
      
      public function triggerEvent_titanArtifactChestOpenComplete() : void
      {
         triggerCondition("titanArtifactChestOpenComplete");
      }
      
      public function triggerEvent_summoningCircleOne() : void
      {
         triggerCondition("summoningCircleOne");
      }
      
      public function triggerEvent_summoningCirclePack() : void
      {
         triggerCondition("summoningCirclePack");
      }
      
      public function checkState(param1:TutorialCondition) : Boolean
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(param1.ident == "titanArtifactsAvailable")
         {
            if(player.levelData.level.level >= MechanicStorage.TITAN_VALLEY.teamLevel)
            {
               return true;
            }
         }
         if(param1.ident == "hasEnough")
         {
            _loc3_ = param1.data as CostData;
            return _loc3_ && player.unsafeCanSpendFast(_loc3_);
         }
         if(param1.ident == "hasTitanFragmentsToSell")
         {
            return TitanSoulShopUtils.hasFragmentsToSell(player);
         }
         if(param1.ident == "hasDailyQuestsWithExpToFarm")
         {
            return player.questData.hasDailyQuestsWithExpToFarm;
         }
         if(param1.ident == "navigationComplete" || param1.ident == "dialogOpen")
         {
            _loc2_ = Tutorial.currentNode;
            if(!_loc2_)
            {
               return false;
            }
            if(param1.data == _loc2_ || param1.data == _loc2_.name)
            {
               return true;
            }
            if(param1 is TutorialLibCondition && (param1 as TutorialLibCondition).hasParam(_loc2_.name))
            {
               return true;
            }
         }
         if(param1.ident == "checkTutorialUnlocker")
         {
            _loc2_ = Tutorial.currentNode;
            if(!_loc2_)
            {
               return false;
            }
            if(player.tutorial.getUnlockerState(param1.data))
            {
               return true;
            }
         }
         return false;
      }
      
      protected function playerTakeReward(param1:RewardData) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function playerQuestRemoved(param1:PlayerQuestEntry) : void
      {
      }
      
      protected function playerQuestProgress(param1:PlayerQuestEntry) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function playerSkillUpgrade(param1:PlayerHeroEntry, param2:SkillDescription) : void
      {
         triggerEqualDataCondition("skillUpgrade",param2);
      }
      
      protected function playerHeroObtained(param1:PlayerHeroEntry) : void
      {
         triggerEqualDataCondition("heroObtain",param1.hero);
         triggerMethodCondition("heroAmount",checkCondition_dataGreaterOrEqual,player.heroes.getAmount());
      }
      
      protected function playerHeroEvolve(param1:PlayerHeroEntry, param2:BattleStats, param3:int) : void
      {
         triggerEqualDataCondition("heroEvolve",param1.hero);
      }
      
      protected function playerLevelUp(param1:PlayerTeamLevel) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function alchemyUse() : void
      {
         triggerCondition("alchemyUse");
      }
      
      protected function playerTitanObtained(param1:PlayerTitanEntry) : void
      {
         triggerEqualDataCondition("titanObtain",param1.titan);
         triggerMethodCondition("titanAmount",checkCondition_dataGreaterOrEqual,player.titans.getAmount());
      }
      
      protected function playerTitanEvolve(param1:PlayerTitanEntry, param2:BattleStats, param3:int) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function checkCondition_dataLess(param1:TutorialCondition, param2:*) : Boolean
      {
         return param2 < param1.data;
      }
      
      private function checkCondition_dataLessOrEqual(param1:TutorialCondition, param2:*) : Boolean
      {
         return param2 <= param1.data;
      }
      
      private function checkCondition_dataGreater(param1:TutorialCondition, param2:*) : Boolean
      {
         return param2 > param1.data;
      }
      
      private function checkCondition_dataGreaterOrEqual(param1:TutorialCondition, param2:*) : Boolean
      {
         return param2 >= param1.data;
      }
      
      private function checkBattleTiming(param1:TutorialLibCondition, param2:int, param3:Number) : Boolean
      {
         var _loc5_:int = param1.params[0];
         var _loc4_:Number = param1.params[1];
         return param2 == _loc5_ && param3 > _loc4_;
      }
      
      private function subscribeSignal(param1:idv.cjcat.signals.Signal, param2:Function) : void
      {
         registeredSignals[param1] = param2;
         param1.add(param2);
      }
      
      private function subscribeSignalOrgOs(param1:org.osflash.signals.Signal, param2:Function) : void
      {
         registeredSignals[param1] = param2;
         param1.add(param2);
      }
      
      private function triggerMethodCondition(param1:String, param2:Function, param3:*, param4:Boolean = false) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function triggerEqualDataCondition(param1:String, param2:*) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function triggerCondition(param1:String) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function removeListeners() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = registeredSignals;
         for(var _loc1_ in registeredSignals)
         {
            _loc1_.remove(registeredSignals[_loc1_]);
         }
      }
      
      private function spliceListener(param1:TutorialCondition) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         if(param1.ident == "battleTiming")
         {
            Tutorial.flags.toggle_tutorialBattle(false);
         }
         var _loc2_:Vector.<TutorialCondition> = !!updatedConditions?updatedConditions:conditions;
         var _loc6_:int = 0;
         var _loc4_:int = _loc2_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = _loc2_[_loc5_];
            if(_loc3_ != param1)
            {
               _loc6_++;
               tempConditions[_loc6_] = _loc3_;
            }
            _loc5_++;
         }
         tempConditions.length = _loc6_;
         updatedConditions = tempConditions;
         if(!dispatching)
         {
            tempConditions = conditions;
            conditions = updatedConditions;
            updatedConditions = null;
         }
      }
      
      private function startDispatching() : void
      {
         dispatching = true;
      }
      
      private function stopDispatching() : void
      {
         dispatching = false;
         if(updatedConditions)
         {
            tempConditions = conditions;
            conditions = updatedConditions;
            updatedConditions = null;
         }
      }
   }
}
