package game.view.gui.tutorial
{
   import flash.utils.Dictionary;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import idv.cjcat.signals.Signal;
   import starling.animation.IAnimatable;
   import starling.core.Starling;
   
   public class TutorialNavigator implements IAnimatable
   {
      
      public static const HOME_SCREEN:TutorialNode = new TutorialNode("homeScreen");
      
      public static const CLAN_SCREEN:TutorialNode = new TutorialNode("clanScreen");
      
      public static const BATTLE_SCREEN:TutorialNode = new TutorialNode("battleScreen");
      
      public static const WORLD_MAP:TutorialNode = new TutorialNode("worldMap");
      
      public static const CHESTS:TutorialNode = new TutorialNode("chests");
      
      public static const SHOP:TutorialNode = new TutorialNode("shop");
      
      public static const ARENA:TutorialNode = new TutorialNode("arena");
      
      public static const GUILD:TutorialNode = new TutorialNode("guild");
      
      public static const INVENTORY:TutorialNode = new TutorialNode("inventory");
      
      public static const QUESTS:TutorialNode = new TutorialNode("quests");
      
      public static const HEROES:TutorialNode = new TutorialNode("heroes");
      
      public static const CHART:TutorialNode = new TutorialNode("chart");
      
      public static const FRIENDS:TutorialNode = new TutorialNode("friends");
      
      public static const RUNE_HEROES:TutorialNode = new TutorialNode("runeHeroes");
      
      public static const DAILY_BONUSES:TutorialNode = new TutorialNode("dailyBonuses");
      
      public static const DAILY_QUESTS:TutorialNode = new TutorialNode("dailyQuests");
      
      public static const MAIL:TutorialNode = new TutorialNode("mail");
      
      public static const PROFILE:TutorialNode = new TutorialNode("profile");
      
      public static const VIP:TutorialNode = new TutorialNode("vip");
      
      public static const BILLING:TutorialNode = new TutorialNode("billing");
      
      public static const ALCHEMY:TutorialNode = new TutorialNode("alchemy");
      
      public static const REFILL_ENERGY:TutorialNode = new TutorialNode("refillEnergy");
      
      public static const HERO:TutorialNode = new TutorialNode("hero");
      
      public static const HERO_SLOT:TutorialNode = new TutorialNode("heroSlot");
      
      public static const ACTION_UPGRADE_SKILL:TutorialNodeAction = new TutorialNodeAction("actionUpgradeSkill");
      
      public static const ACTION_EQUIP_HERO:TutorialNodeAction = new TutorialNodeAction("actionEquipHero");
      
      public static const ACTION_PROMOTE_HERO:TutorialNodeAction = new TutorialNodeAction("actionPromoteHero");
      
      public static const ACTION_EVOLVE_HERO:TutorialNodeAction = new TutorialNodeAction("actionEvolveHero");
      
      public static const ACTION_OBTAIN_HERO:TutorialNodeAction = new TutorialNodeAction("actionObtainHero");
      
      public static const ACTION_INSERT_ITEM:TutorialNodeAction = new TutorialNodeAction("actionInsertItem");
      
      public static const ACTION_HERO_USE_CONSUMABLE:TutorialNodeAction = new TutorialNodeAction("actionUseHeroExpConsumable");
      
      public static const EVOLVE_HERO_CONFIRM:TutorialNodeAction = new TutorialNodeAction("obtainHeroConfirm");
      
      public static const HERO_USE_CONSUMABLE:TutorialNode = new TutorialNode("heroUseConsumable");
      
      public static const HERO_COLOR_UP:TutorialNode = new TutorialNode("heroColorUp");
      
      public static const HERO_STAR_UP:TutorialNode = new TutorialNode("heroStarUp");
      
      public static const MISSION:TutorialNode = new TutorialNode("mission");
      
      public static const TEAM_GATHER:TutorialNode = new TutorialNode("teamGather");
      
      public static const TEAM_GATHER_ARENA:TutorialNode = new TutorialNode("teamGatherArena");
      
      public static const REWARD_CHEST:TutorialNode = new TutorialNode("rewardChest");
      
      public static const REWARD_HERO:TutorialNode = new TutorialNode("rewardHero");
      
      public static const REWARD_MISSION:TutorialNode = new TutorialNode("rewardMission");
      
      public static const REWARD_QUEST:TutorialNode = new TutorialNode("rewardQuest");
      
      public static const REWARD_TUTORIAL:TutorialNode = new TutorialNode("rewardTutorial");
      
      public static const REWARD_CLAN_SUMMONING_CIRCLE:TutorialNode = new TutorialNode("rewardClanSummoningCircle");
      
      public static const TEAM_LEVEL_UP:TutorialNode = new TutorialNode("teamLevelUp");
      
      public static const TUTORIAL_MESSAGE:TutorialNode = new TutorialNode("tutorialMessage");
      
      public static const IN_GAME_PRELOADER:TutorialNode = new TutorialNode("inGamePreloader");
      
      public static const ACTION_START_BATTLE:TutorialNodeAction = new TutorialNodeAction("actionStartBattle");
      
      public static const ACTION_START_ARENA_BATTLE:TutorialNodeAction = new TutorialNodeAction("actionStartArenaBattle");
      
      public static const ACTION_GATHER_TEAM:TutorialNodeAction = new TutorialNodeAction("actionGatherTeam");
      
      public static const ACTION_ALCHEMY_USE:TutorialNodeAction = new TutorialNodeAction("actionAlchemyUse");
      
      public static const ACTION_QUEST_FARM:TutorialNodeAction = new TutorialNodeAction("actionQuestFarm");
      
      public static const ACTION_QUEST_GO:TutorialNodeAction = new TutorialNodeAction("actionQuestGo");
      
      public static const ACTION_CHEST:TutorialNodeAction = new TutorialNodeAction("actionChest");
      
      public static const ACTION_CHEST_MORE:TutorialNodeAction = new TutorialNodeAction("actionChestMore");
      
      public static const ACTION_ARENA_ATTACK_1:TutorialNodeAction = new TutorialNodeAction("actionArenaAttack1");
      
      public static const ACTION_ARENA_ATTACK_2:TutorialNodeAction = new TutorialNodeAction("actionArenaAttack2");
      
      public static const ACTION_ARENA_ATTACK_3:TutorialNodeAction = new TutorialNodeAction("actionArenaAttack3");
      
      public static const ACTION_ARENA_CHANGE_DEFENDERS:TutorialNodeAction = new TutorialNodeAction("actionArenaChangeDefeners");
      
      public static const ACTION_BATTLE_HERO:TutorialNodeAction = new TutorialNodeAction("actionBattleHero");
      
      public static const ACTION_CLOSE:TutorialNode = new TutorialNode("actionClose");
      
      public static const ACTION_OK:TutorialNode = new TutorialNode("actionOk");
      
      public static const RUNE_HERO:TutorialNode = new TutorialNode("runeHero");
      
      public static const CLAN_SUMMONING_CIRCLE:TutorialNode = new TutorialNode("clanSummoningCircle");
      
      public static const ACTION_CLAN_SUMMONING_CIRCLE_ONE:TutorialNode = new TutorialNode("actionClanSummoningCircleOne");
      
      public static const ACTION_CLAN_SUMMONING_CIRCLE_PACK:TutorialNode = new TutorialNode("actionClanSummoningCirclePack");
      
      public static const CLAN_DUNGEON:TutorialNode = new TutorialNode("clanDungeon");
      
      public static const CLAN_DUNGEON_SELECT_ENEMY_HERO:TutorialNode = new TutorialNode("clanDungeonSelectEnemyHero");
      
      public static const CLAN_DUNGEON_SELECT_ENEMY_TITAN:TutorialNode = new TutorialNode("clanDungeonSelectEnemyTitan");
      
      public static const TITAN_LIST:TutorialNode = new TutorialNode("titanList");
      
      public static const TITAN:TutorialNode = new TutorialNode("titan");
      
      public static const ACTION_TITAN_LEVEL_UP_POTION:TutorialNode = new TutorialNode("actionTitanLevelUpPotion");
      
      public static const ACTION_TITAN_LEVEL_UP_GEM:TutorialNode = new TutorialNode("actionTitanLevelUpGem");
      
      public static const ACTION_TITAN_EVOLVE:TutorialNode = new TutorialNode("actionTitanEvolve");
      
      public static const ACTION_TITAN_OBTAIN:TutorialNode = new TutorialNode("actionTitanObtain");
      
      public static const TITAN_GIFT_HEROES:TutorialNode = new TutorialNode("titanGiftHeroes");
      
      public static const TITAN_GIFT_HERO:TutorialNode = new TutorialNode("titanGiftHero");
      
      public static const ACTION_TITAN_GIFT_UPGRADE:TutorialNode = new TutorialNode("actionTitanGiftUpgrade");
      
      public static const ACTION_TITAN_GIFT_DROP:TutorialNode = new TutorialNode("actionTitanGiftDrop");
      
      public static const TITAN_SOUL_SHOP:TutorialNode = new TutorialNode("titanSoulShop");
      
      public static const ZEPPELIN:TutorialNode = new TutorialNode("zeppelin");
      
      public static const ARTIFACT_CHEST:TutorialNode = new TutorialNode("artifactChest");
      
      public static const TITAN_VALLEY:TutorialNode = new TutorialNode("titanValley");
      
      public static const TITAN_VALLEY_ALTAR:TutorialNode = new TutorialNode("titanValleyAltar");
      
      public static const TITAN_VALLEY_ARTIFACTS:TutorialNode = new TutorialNode("titanValleyArtifacts");
      
      public static const TITAN_VALLEY_ARENA:TutorialNode = new TutorialNode("titanValleyArena");
      
      public static const TITAN_VALLEY_ARENA_RULES:TutorialNode = new TutorialNode("titanValleyArenaRules");
      
      public static const TITAN_VALLEY_MERCHANT:TutorialNode = new TutorialNode("titanValleyMerchant");
      
      public static const TITAN_VALLEY_ALTAR_REWARD:TutorialNode = new TutorialNode("titanValleyAltarReward");
      
      public static const ACTION_TITAN_VALLEY_ALTAR_BUTTON:TutorialNode = new TutorialNode("actionTitanValleyAltarButton");
      
      public static const ACTION_TITAN_ARTIFACT_EVOLVE_BUTTON:TutorialNode = new TutorialNode("titanArtifactEvolveButton");
      
      public static const ACTION_TITAN_ARTIFACT_LEVELUP_BUTTON:TutorialNode = new TutorialNode("actionTitanValleyAltarButton");
      
      public static const TITAN_ARTIFACT:TutorialNode = new TutorialNode("titanArtifact");
       
      
      private var overlay:TutorialOverlay;
      
      private var actionsByProvider:Dictionary;
      
      private var passiveProviders:Dictionary;
      
      var currentNode:TutorialNode;
      
      private var task:TutorialTask;
      
      private var target:TutorialTarget;
      
      private var nextNode:TutorialNode;
      
      private var hasActiveAction:Boolean = false;
      
      private var invalidated:Boolean = false;
      
      private var activeButtons:Vector.<ITutorialButton>;
      
      private var closedDialogs:Vector.<TutorialNode>;
      
      private var tutorialShouldWaitNodes:Vector.<TutorialNode>;
      
      private var presentedDialogs:Vector.<TutorialNode>;
      
      private var exitTutorialBlockingState:Boolean;
      
      public const states:TutorialStateMachineResolver = new TutorialStateMachineResolver();
      
      public const tutorialCanGo:Signal = new Signal();
      
      public function TutorialNavigator()
      {
         actionsByProvider = new Dictionary();
         passiveProviders = new Dictionary();
         activeButtons = new Vector.<ITutorialButton>();
         closedDialogs = new Vector.<TutorialNode>();
         tutorialShouldWaitNodes = new <TutorialNode>[REWARD_HERO,REWARD_MISSION,REWARD_CHEST,TEAM_LEVEL_UP,HERO_COLOR_UP,HERO_STAR_UP,REWARD_QUEST,REWARD_TUTORIAL,REWARD_CLAN_SUMMONING_CIRCLE];
         presentedDialogs = new Vector.<TutorialNode>();
         super();
      }
      
      public function get tutorialShouldWait() : Boolean
      {
         return tutorialShouldWaitNodes.indexOf(currentNode) != -1;
      }
      
      public function initialize(param1:TutorialOverlay) : void
      {
         this.overlay = param1;
         states.addLinks(HOME_SCREEN,WORLD_MAP,CHESTS,SHOP,ARENA,CLAN_SCREEN);
         states.addLinks(HOME_SCREEN,INVENTORY,QUESTS,HEROES,CHART,FRIENDS);
         states.addLinks(HOME_SCREEN,DAILY_BONUSES,DAILY_QUESTS,MAIL,PROFILE,VIP);
         states.addLinks(HOME_SCREEN,BILLING,ALCHEMY,REFILL_ENERGY);
         states.addLinks(WORLD_MAP,MISSION);
         states.addLinks(MISSION,TEAM_GATHER);
         states.addLinks(TEAM_GATHER,ACTION_START_BATTLE,ACTION_GATHER_TEAM);
         states.addLinks(TEAM_GATHER_ARENA,ACTION_GATHER_TEAM,ACTION_START_ARENA_BATTLE);
         states.addLinks(HEROES,HERO,ACTION_OBTAIN_HERO);
         states.addLinks(HERO,EVOLVE_HERO_CONFIRM);
         states.addLinks(HERO,ACTION_UPGRADE_SKILL,ACTION_INSERT_ITEM,ACTION_EQUIP_HERO,ACTION_PROMOTE_HERO,HERO_USE_CONSUMABLE);
         states.addLinks(HERO_USE_CONSUMABLE,ACTION_HERO_USE_CONSUMABLE);
         states.addLinks(EVOLVE_HERO_CONFIRM,ACTION_EVOLVE_HERO);
         states.addLinks(QUESTS,ACTION_QUEST_FARM,ACTION_QUEST_GO);
         states.addLinks(CHESTS,ACTION_CHEST,REWARD_CHEST);
         states.addLinks(ARENA,ACTION_ARENA_CHANGE_DEFENDERS,ACTION_ARENA_ATTACK_1,ACTION_ARENA_ATTACK_2,ACTION_ARENA_ATTACK_3);
         states.addLinks(CLAN_SCREEN,CLAN_DUNGEON,TITAN_LIST,CLAN_DUNGEON,RUNE_HEROES,CLAN_SUMMONING_CIRCLE,TITAN_SOUL_SHOP);
         states.addLinks(CLAN_SCREEN,TITAN_VALLEY);
         states.addLinks(CLAN_SUMMONING_CIRCLE,ACTION_CLAN_SUMMONING_CIRCLE_ONE,ACTION_CLAN_SUMMONING_CIRCLE_PACK);
         states.addLinks(TITAN_VALLEY,TITAN_VALLEY_ALTAR,TITAN_VALLEY_ARTIFACTS,TITAN_VALLEY_ARENA,TITAN_VALLEY_MERCHANT);
         states.addLinks(TITAN_VALLEY_ALTAR,ACTION_TITAN_VALLEY_ALTAR_BUTTON);
         states.addLinks(TITAN_VALLEY_ARTIFACTS,TITAN_ARTIFACT);
         states.addLinks(TITAN_ARTIFACT,ACTION_TITAN_ARTIFACT_EVOLVE_BUTTON,ACTION_TITAN_ARTIFACT_LEVELUP_BUTTON);
         states.addLinks(TITAN_VALLEY_ARENA,TITAN_VALLEY_ARENA_RULES);
         states.addLinks(TITAN_LIST,TITAN);
         states.addLinks(TITAN,ACTION_TITAN_EVOLVE,ACTION_TITAN_LEVEL_UP_POTION,ACTION_TITAN_LEVEL_UP_GEM);
         states.addLinks(RUNE_HEROES,TITAN_GIFT_HEROES,RUNE_HERO);
         states.addLinks(TITAN_GIFT_HEROES,RUNE_HEROES,TITAN_GIFT_HERO);
         states.addLinks(TITAN_GIFT_HERO,ACTION_TITAN_GIFT_DROP,ACTION_TITAN_GIFT_UPGRADE);
         states.addLinks(CLAN_DUNGEON,CLAN_DUNGEON_SELECT_ENEMY_HERO,CLAN_DUNGEON_SELECT_ENEMY_TITAN);
         states.addLinks(REWARD_MISSION,HOME_SCREEN);
         states.init();
         Starling.juggler.add(this);
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         while(closedDialogs.length > 0)
         {
            _loc3_ = closedDialogs.pop();
            _loc2_ = presentedDialogs.indexOf(_loc3_);
            if(_loc2_ != -1)
            {
               presentedDialogs.splice(_loc2_,1);
               Tutorial.events.triggerEvent_dialogClosed(_loc3_);
            }
         }
         if(exitTutorialBlockingState)
         {
            if(currentNode == null || tutorialShouldWaitNodes.indexOf(currentNode) == -1)
            {
               tutorialCanGo.dispatch();
            }
         }
         if(invalidated)
         {
            invalidated = false;
            updateAllActions();
         }
      }
      
      public function deprecateTask(param1:TutorialTask) : void
      {
         if(this.task == param1)
         {
            param1 = null;
            target = null;
            nextNode = null;
            invalidated = true;
         }
      }
      
      public function setTask(param1:TutorialTask) : void
      {
         this.task = param1;
         var _loc2_:TutorialTarget = param1.target;
         var _loc3_:TutorialTarget = target;
         target = _loc2_;
         nextNode = null;
         if(_loc3_ == null)
         {
            activatePassiveProviders();
         }
         renavigate();
      }
      
      public function register(param1:ITutorialNodePresenter) : void
      {
         var _loc2_:TutorialNode = currentNode;
         currentNode = param1.tutorialNode;
         Tutorial.events.triggerEvent_dialogNodeReached(currentNode);
         renavigate();
         presentedDialogs.push(currentNode);
         if(_loc2_ && tutorialShouldWaitNodes.indexOf(_loc2_) != -1)
         {
            exitTutorialBlockingState = true;
         }
      }
      
      public function unregister(param1:ITutorialNodePresenter) : void
      {
         closedDialogs.push(param1.tutorialNode);
      }
      
      public function addActionsFrom(param1:ITutorialActionProvider) : void
      {
         var _loc2_:* = null;
         if(actionsByProvider[param1])
         {
            actionsByProvider[param1].dispose();
         }
         if(target)
         {
            _loc2_ = param1.registerTutorial(target);
            actionsByProvider[param1] = _loc2_;
            invalidated = true;
         }
         else
         {
            passiveProviders[param1] = true;
         }
      }
      
      public function removeActionsFrom(param1:ITutorialActionProvider) : void
      {
         if(actionsByProvider[param1])
         {
            actionsByProvider[param1].dispose();
            delete actionsByProvider[param1];
            invalidated = true;
         }
         else if(passiveProviders[param1])
         {
            delete passiveProviders[param1];
         }
      }
      
      public function updateActionsFrom(param1:ITutorialActionProvider) : void
      {
         var _loc2_:* = null;
         if(actionsByProvider[param1])
         {
            actionsByProvider[param1].dispose();
            if(target)
            {
               _loc2_ = param1.registerTutorial(target);
               actionsByProvider[param1] = _loc2_;
               invalidated = true;
            }
            else
            {
               delete actionsByProvider[param1];
               passiveProviders[param1] = true;
            }
            return;
         }
      }
      
      public function updateActions() : void
      {
         updateAllActions();
      }
      
      protected function renavigate() : void
      {
         if(task == null || task.targetScreenNode == null)
         {
            invalidated = true;
            return;
         }
         if(currentNode == null)
         {
            return;
         }
         if(currentNode != task.targetScreenNode)
         {
            nextNode = states.findNextNode(currentNode,task.targetScreenNode);
         }
         else
         {
            nextNode = null;
         }
         invalidated = true;
      }
      
      protected function updateAllActions() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function activateCloseButtons(param1:int) : int
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function activatePassiveProviders() : void
      {
         if(!target)
         {
            return;
         }
         var _loc3_:int = 0;
         var _loc2_:* = passiveProviders;
         for(var _loc1_ in passiveProviders)
         {
            delete passiveProviders[_loc1_];
            addActionsFrom(_loc1_);
         }
      }
   }
}
