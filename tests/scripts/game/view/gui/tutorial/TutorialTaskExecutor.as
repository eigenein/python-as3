package game.view.gui.tutorial
{
   import com.progrestar.common.lang.Translate;
   import feathers.core.PopUpManager;
   import game.battle.controller.entities.BattleHero;
   import game.battle.controller.thread.TutorialMissionBattleThread;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.mediator.gui.popup.GamePopupManager;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.model.GameModel;
   import game.model.user.hero.PlayerHeroEntry;
   import game.screen.IBattleScreen;
   import game.view.gui.tutorial.reward.TutorialRewardExtendedPopup;
   import game.view.gui.tutorial.reward.TutorialRewardExtendedPopupValueObject;
   import game.view.gui.tutorial.reward.TutorialRewardPopup;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Quad;
   
   public class TutorialTaskExecutor
   {
       
      
      private var navigator:TutorialNavigator;
      
      private var stashSource:PopupStashEventParams;
      
      public function TutorialTaskExecutor(param1:TutorialNavigator)
      {
         super();
         this.navigator = param1;
         stashSource = new PopupStashEventParams();
         stashSource.windowName = "tutorialAction";
      }
      
      public function execute(param1:TutorialTask) : void
      {
         navigator.setTask(param1);
      }
      
      public function deprecate(param1:TutorialTask) : void
      {
         navigator.deprecateTask(param1);
      }
      
      function jumpToMission(param1:TutorialTask) : void
      {
         GamePopupManager.closeAll();
         Game.instance.navigator.navigateToMission(param1.target.mission,stashSource);
      }
      
      function jumpToHeroes(param1:TutorialTask) : void
      {
         GamePopupManager.closeAll();
         PopupList.instance.dialog_hero_list(stashSource);
      }
      
      function jumpToHero(param1:TutorialTask) : void
      {
         GamePopupManager.closeAll();
         var _loc2_:PlayerHeroEntry = GameModel.instance.player.heroes.getById(param1.target.unit.id);
         if(_loc2_ == null)
         {
            return;
         }
         PopupList.instance.dialog_hero(param1.target.unit as HeroDescription);
      }
      
      function closeAll(param1:TutorialTask) : void
      {
         GamePopupManager.closeAll();
      }
      
      function claimClanJoinReward(param1:TutorialTask) : void
      {
         param1.signal_onReward.addOnce(handler_clanJoinRewardPopup);
      }
      
      function claimArtifactIntroReward(param1:TutorialTask) : void
      {
         param1.signal_onReward.addOnce(handler_artifactChestIntroReward);
      }
      
      function toggleOnTutorialBattle() : void
      {
         Tutorial.flags.toggle_tutorialBattle(true);
      }
      
      function toggleOffTutorialBattle(param1:TutorialTask) : void
      {
         Tutorial.flags.toggle_tutorialBattle(false);
      }
      
      function heroSay(param1:TutorialTask) : void
      {
         var _loc4_:* = null;
         var _loc3_:int = param1.target.unit.id;
         var _loc2_:IBattleScreen = Game.instance.screen.getBattleScreen();
         if(_loc2_ && _loc2_.objects)
         {
            _loc4_ = _loc2_.objects.getPlayerHeroById(_loc3_);
            if(_loc4_)
            {
               _loc4_.view.say(param1.message.text);
            }
         }
      }
      
      function enemySay(param1:TutorialTask) : void
      {
         var _loc4_:* = null;
         var _loc3_:int = param1.target.unit.id;
         var _loc2_:IBattleScreen = Game.instance.screen.getBattleScreen();
         if(_loc2_ && _loc2_.objects)
         {
            _loc4_ = _loc2_.objects.getEnemyHeroById(_loc3_);
            if(_loc4_)
            {
               _loc4_.view.say(param1.message.text);
            }
         }
      }
      
      function nothing(param1:TutorialTask) : void
      {
      }
      
      function dropChestTimer(param1:TutorialTask) : void
      {
         GameModel.instance.player.refillable.tutorialDropChestTimer(DataStorage.chest.CHEST_TOWN);
      }
      
      function battleUnlink(param1:TutorialTask) : void
      {
         var _loc2_:IBattleScreen = Game.instance.screen.getBattleScreen();
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:TutorialMissionBattleThread = _loc2_.thread as TutorialMissionBattleThread;
         if(!_loc3_)
         {
            return;
         }
         _loc3_.unlink();
      }
      
      function tutorialMissionComplete(param1:TutorialTask) : void
      {
         var _loc2_:IBattleScreen = Game.instance.screen.getBattleScreen();
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:TutorialMissionBattleThread = _loc2_.thread as TutorialMissionBattleThread;
         if(!_loc3_)
         {
            return;
         }
         _loc3_.fastCompleteBattle();
      }
      
      function pauseBattle(param1:TutorialTask) : void
      {
         var _loc2_:IBattleScreen = Game.instance.screen.getBattleScreen();
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:TutorialMissionBattleThread = _loc2_.thread as TutorialMissionBattleThread;
         if(!_loc3_)
         {
            return;
         }
         _loc3_.controller.pause();
      }
      
      function startBattle(param1:TutorialTask) : void
      {
         var _loc2_:IBattleScreen = Game.instance.screen.getBattleScreen();
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:TutorialMissionBattleThread = _loc2_.thread as TutorialMissionBattleThread;
         if(!_loc3_)
         {
            return;
         }
         _loc3_.controller.play();
      }
      
      private function handler_clanJoinRewardPopup(param1:TutorialTask) : void
      {
         var _loc2_:* = null;
         if(param1.reward != null)
         {
            _loc2_ = new TutorialRewardPopup(param1.reward,Translate.translate("LIB_TUTORIAL_CLAN_REWARD_TITLE"),Translate.translate("UI_POPUP_QUEST_REWARD_LABEL"),Translate.translate("UI_DIALOG_MAIL_ENTRY_FARM"));
            _loc2_.open();
         }
      }
      
      private function _transparentOverlayFactory() : DisplayObject
      {
         var _loc1_:Quad = new Quad(Starling.current.stage.stageWidth,Starling.current.stage.stageHeight,0);
         _loc1_.alpha = 0.75;
         return _loc1_;
      }
      
      private function handler_artifactChestIntroReward(param1:TutorialTask) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(param1.reward != null)
         {
            if(Translate.has("UI_POPUP_SUBSCRIPTION_REWARD_1_TF_DESC_INTRO"))
            {
               _loc4_ = Translate.translate("UI_POPUP_SUBSCRIPTION_REWARD_1_TF_DESC_INTRO");
            }
            else
            {
               _loc4_ = Translate.translate("LIB_CONSUMABLE_DESC_ARTIFACT_KEY");
            }
            _loc3_ = new TutorialRewardExtendedPopupValueObject(param1.reward.outputDisplayFirst,_loc4_,true);
            _loc2_ = new TutorialRewardExtendedPopup(new <TutorialRewardExtendedPopupValueObject>[_loc3_],Translate.translate("LIB_MAIL_TYPE_FREEBIE_GROUP_TEXT"),Translate.translate("UI_POPUP_QUEST_REWARD_BUTTON_LABEL"));
            PopUpManager.addPopUp(_loc2_,true,true,_transparentOverlayFactory);
         }
      }
   }
}
