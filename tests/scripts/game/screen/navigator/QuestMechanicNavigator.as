package game.screen.navigator
{
   import com.progrestar.common.lang.Translate;
   import flash.utils.Dictionary;
   import game.command.intern.skin.OpenSkinTabHeroPopUpCommand;
   import game.data.storage.DataStorage;
   import game.data.storage.mechanic.MechanicDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.pve.mission.MissionDescription;
   import game.data.storage.resource.CoinDescription;
   import game.data.storage.world.WorldMapDescription;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.clan.ClanActivityRewardPopupMediator;
   import game.mediator.gui.popup.friends.socialquest.SocialQuestPopupMediator;
   import game.model.user.Player;
   import game.model.user.quest.PlayerQuestEntry;
   import game.stat.Stash;
   
   public class QuestMechanicNavigator
   {
       
      
      private var stashSource:PopupStashEventParams;
      
      private var player:Player;
      
      private var navigator:GameNavigator;
      
      private var dictByHelper:Dictionary;
      
      private var dictByMechanic:Dictionary;
      
      public function QuestMechanicNavigator(param1:GameNavigator, param2:Player)
      {
         super();
         this.navigator = param1;
         this.player = param2;
         dictByMechanic = new Dictionary();
         dictByHelper = new Dictionary();
         dictByMechanic[MechanicStorage.MISSION.type] = mission;
         dictByMechanic[MechanicStorage.CLAN.type] = clan;
         dictByMechanic[MechanicStorage.ENCHANT.type] = enchant;
         dictByMechanic[MechanicStorage.ARENA.type] = arena;
         dictByHelper["alchemy"] = alchemy;
         dictByHelper["starmoneySubscription"] = starmoneySubscription;
         dictByHelper["socialQuest"] = socialQuest;
         dictByHelper["clanActivity"] = clan_activity;
         dictByHelper["expPotion"] = expPotion;
         dictByHelper["skin"] = skin;
         dictByHelper["titanList"] = titanList;
         dictByHelper["heroList"] = heroList;
         dictByHelper["bank"] = bank;
         dictByHelper["dailyQuest"] = dailyQuest;
         dictByHelper["bossById"] = bossById;
         dictByHelper["newYearResourceQuest"] = newYearResourceQuest;
         dictByHelper["toQuiz"] = quiz;
         stashSource = new PopupStashEventParams();
      }
      
      public function heroList(param1:PlayerQuestEntry, param2:PopupStashEventParams) : void
      {
         PopupList.instance.dialog_hero_list(Stash.click("goto_quest:" + param1.desc.id,param2));
      }
      
      public function titanList(param1:PlayerQuestEntry, param2:PopupStashEventParams) : void
      {
         if(!navigator.mechanicHelper.checkIfInClanAndSearchForClanIfNot(param2))
         {
            return;
         }
         PopupList.instance.dialog_titan_list(Stash.click("goto_quest:" + param1.desc.id,param2));
      }
      
      public function skin(param1:PlayerQuestEntry, param2:PopupStashEventParams) : void
      {
         new OpenSkinTabHeroPopUpCommand(player,Stash.click("goto_quest:" + param1.desc.id,param2)).execute();
      }
      
      public function alchemy(param1:PlayerQuestEntry, param2:PopupStashEventParams) : void
      {
         navigator.navigateToRefillable(DataStorage.refillable.getByIdent("alchemy"),param2);
      }
      
      public function starmoneySubscription(param1:PlayerQuestEntry, param2:PopupStashEventParams) : void
      {
         PopupList.instance.dialog_bank(stashSource);
      }
      
      public function socialQuest(param1:PlayerQuestEntry, param2:PopupStashEventParams) : void
      {
         var _loc3_:SocialQuestPopupMediator = new SocialQuestPopupMediator(player);
         _loc3_.open(param2);
      }
      
      public function clan(param1:PlayerQuestEntry, param2:PopupStashEventParams) : void
      {
         navigator.mechanicHelper.navigate(param1.desc.farmCondition.stateFunc.mechanic,param2);
      }
      
      public function clan_activity(param1:PlayerQuestEntry, param2:PopupStashEventParams) : void
      {
         if(!navigator.mechanicHelper.checkIfInClanAndSearchForClanIfNot(param2))
         {
            return;
         }
         var _loc3_:ClanActivityRewardPopupMediator = new ClanActivityRewardPopupMediator(player);
         _loc3_.open(Stash.click("clan_rewards",param2));
      }
      
      public function expPotion(param1:PlayerQuestEntry, param2:PopupStashEventParams) : void
      {
         PopupList.instance.dialog_hero_add_exp();
      }
      
      public function bank(param1:PlayerQuestEntry, param2:PopupStashEventParams) : void
      {
         PopupList.instance.dialog_bank(param2);
      }
      
      public function dailyQuest(param1:PlayerQuestEntry, param2:PopupStashEventParams) : void
      {
         PopupList.instance.dialog_dailyQuests(param2);
      }
      
      public function bossById(param1:PlayerQuestEntry, param2:PopupStashEventParams) : void
      {
         navigator.mechanicHelper.bossById(param1.desc.farmCondition.functionArgs.id,param2);
      }
      
      public function newYearResourceQuest(param1:PlayerQuestEntry, param2:PopupStashEventParams) : void
      {
         var _loc3_:* = null;
         if(param1.desc.farmCondition.functionArgs.type == "coin")
         {
            _loc3_ = DataStorage.coin.getById(param1.desc.farmCondition.functionArgs.id) as CoinDescription;
            if(_loc3_)
            {
               if(_loc3_.ident == "ny_gift_coin")
               {
                  navigator.mechanicHelper.navigate(MechanicStorage.NY2018_GIFTS,param2);
               }
               else if(_loc3_.ident == "ny_tree_coin")
               {
                  navigator.mechanicHelper.navigate(MechanicStorage.NY2018_TREE,param2);
               }
            }
         }
      }
      
      public function enchant(param1:PlayerQuestEntry, param2:PopupStashEventParams) : void
      {
         navigator.mechanicHelper.navigate(param1.desc.farmCondition.stateFunc.mechanic,param2);
      }
      
      public function arena(param1:PlayerQuestEntry, param2:PopupStashEventParams) : void
      {
         if(param1 && param1.desc && param1.desc.farmCondition && param1.desc.farmCondition.functionArgs && param1.desc.farmCondition.functionArgs.type == "grand")
         {
            navigator.mechanicHelper.grand(param2);
         }
         else
         {
            navigator.mechanicHelper.arena(param2);
         }
      }
      
      public function mission(param1:PlayerQuestEntry, param2:PopupStashEventParams) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         if(param1.desc.farmCondition.functionArgs)
         {
            _loc4_ = DataStorage.mission.getMissionById(param1.desc.farmCondition.functionArgs.id) as MissionDescription;
            if(_loc4_)
            {
               _loc3_ = DataStorage.world.getById(_loc4_.world) as WorldMapDescription;
               if(player.levelData.level.level < _loc3_.teamLevel)
               {
                  PopupList.instance.message(Translate.translateArgs("UI_MECHANIC_NAVIGATOR_TEAM_LEVEL_REQUIRED",_loc3_.teamLevel));
                  return;
               }
            }
         }
         navigator.mechanicHelper.mission_by_desc(_loc4_,param2);
      }
      
      public function helpWithQuest(param1:PlayerQuestEntry, param2:PopupStashEventParams) : void
      {
         var _loc3_:String = param1.desc.farmCondition.stateFunc.mechanicHelper;
         if(_loc3_)
         {
            if(dictByHelper[_loc3_])
            {
               return;
               §§push(dictByHelper[_loc3_](param1,Stash.click("goto_quest:" + param1.desc.id,param2)));
            }
         }
         var _loc4_:MechanicDescription = param1.desc.farmCondition.stateFunc.mechanic;
         if(_loc4_)
         {
            if(dictByMechanic[_loc4_.type])
            {
               return;
               §§push(dictByMechanic[_loc4_.type](param1,param2));
            }
            else if(navigator.mechanicHelper.hasNavigatorForMechanic(_loc4_))
            {
               navigator.mechanicHelper.navigate(_loc4_,Stash.click("goto_quest:" + param1.desc.id,param2));
               return;
            }
         }
      }
      
      public function hasNavigatorForQuestEntry(param1:PlayerQuestEntry) : Boolean
      {
         var _loc3_:MechanicDescription = param1.desc.farmCondition.stateFunc.mechanic;
         if(_loc3_)
         {
            if(dictByMechanic[_loc3_.type])
            {
               return true;
            }
            if(navigator.mechanicHelper.hasNavigatorForMechanic(_loc3_))
            {
               return true;
            }
         }
         var _loc2_:String = param1.desc.farmCondition.stateFunc.mechanicHelper;
         if(_loc2_)
         {
            if(dictByHelper[_loc2_])
            {
               return true;
            }
         }
         return false;
      }
      
      public function quiz(param1:PlayerQuestEntry, param2:PopupStashEventParams) : void
      {
         player.quizData.action_quizNavigateTo(param2);
      }
   }
}
