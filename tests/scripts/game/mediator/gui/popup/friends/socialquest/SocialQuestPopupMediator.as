package game.mediator.gui.popup.friends.socialquest
{
   import com.progrestar.common.lang.Translate;
   import engine.context.platform.social.socialQuest.SocialQuestHelper;
   import feathers.core.PopUpManager;
   import game.command.rpc.quest.CommandQuestFarm;
   import game.command.social.CommandSocialInviteFriends;
   import game.data.storage.DataStorage;
   import game.data.storage.quest.QuestNormalDescription;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.friends.ReferrerPopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.quest.PlayerQuestEntry;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.friends.socialquest.SocialQuestPopup;
   import game.view.popup.quest.QuestRewardPopup;
   import idv.cjcat.signals.Signal;
   
   public class SocialQuestPopupMediator extends PopupMediator
   {
       
      
      private var quest:PlayerQuestEntry;
      
      private var vo1:SocialQuestTaskValueObject;
      
      private var vo2:SocialQuestTaskValueObject;
      
      private var vo3:SocialQuestTaskValueObject;
      
      private var vo4:SocialQuestTaskValueObject;
      
      private var _data:Vector.<SocialQuestTaskValueObject>;
      
      private var _questReward:Vector.<InventoryItem>;
      
      private var _signal_updateFarmAvailable:Signal;
      
      public function SocialQuestPopupMediator(param1:Player)
      {
         _signal_updateFarmAvailable = new Signal();
         super(param1);
         var _loc2_:Object = DataStorage.rule.socialQuest;
         quest = param1.questData.getQuest(_loc2_.id);
         _data = new Vector.<SocialQuestTaskValueObject>();
         vo1 = new SocialQuestTaskValueObject();
         vo1._title = Translate.translate("UI_DIALOG_SOCIAL_QUEST_TASK_1");
         vo1._desc = Translate.translate("UI_DIALOG_SOCIAL_QUEST_TASK_1_DESC");
         vo1._buttonLabel = Translate.translate("UI_DIALOG_SOCIAL_QUEST_TASK_1_BUTTON");
         vo1._progress = int(stepCompleted_groupJoin);
         vo1._progressMax = 1;
         vo1._signal_buttonAction.add(action_groupJoin);
         _data.push(vo1);
         if(param1.socialQuestData.stepRequired_post)
         {
            vo2 = new SocialQuestTaskValueObject();
            if(postIsActuallyABookmark)
            {
               vo2._title = Translate.translate("UI_DIALOG_SOCIAL_QUEST_TASK_2_BOOKMARK");
               vo2._desc = Translate.translate("UI_DIALOG_SOCIAL_QUEST_TASK_2_DESC_BOOKMARK");
               vo2._buttonLabel = Translate.translate("UI_DIALOG_SOCIAL_QUEST_TASK_2_BUTTON_BOOKMARK");
            }
            else
            {
               vo2._title = Translate.translate("UI_DIALOG_SOCIAL_QUEST_TASK_2");
               vo2._desc = Translate.translate("UI_DIALOG_SOCIAL_QUEST_TASK_2_DESC");
               vo2._buttonLabel = Translate.translate("UI_DIALOG_SOCIAL_QUEST_TASK_2_BUTTON");
            }
            vo2._progress = int(stepCompleted_post);
            vo2._progressMax = 1;
            vo2._signal_buttonAction.add(action_feedPost);
            _data.push(vo2);
         }
         vo3 = new SocialQuestTaskValueObject();
         vo3._title = Translate.translate("UI_DIALOG_SOCIAL_QUEST_TASK_3");
         vo3._desc = Translate.translate("UI_DIALOG_SOCIAL_QUEST_TASK_3_DESC");
         vo3._buttonLabel = Translate.translate("UI_DIALOG_SOCIAL_QUEST_TASK_3_BUTTON");
         vo3._progress = stepProgress_friendCount;
         vo3._progressMax = param1.socialQuestData.stepRequired_friendCount;
         vo3._signal_buttonAction.add(action_inviteFriends);
         _data.push(vo3);
         vo4 = new SocialQuestTaskValueObject();
         vo4._title = Translate.translate("UI_DIALOG_SOCIAL_QUEST_TASK_4");
         vo4._desc = Translate.translateArgs("UI_DIALOG_SOCIAL_QUEST_TASK_4_DESC",Translate.genderTriggerString(GameModel.instance.context.platformFacade.user.male));
         vo4._buttonLabel = Translate.translate("UI_DIALOG_SOCIAL_QUEST_TASK_4_BUTTON");
         vo4._progress = int(param1.socialQuestData.hasReferrer);
         vo4._signal_buttonAction.add(action_setReferrer);
         vo4._progressMax = 1;
         _data.push(vo4);
         param1.socialQuestData.signal_stepUpdated_groupJoin.add(handler_updateGroupJoin);
         param1.socialQuestData.signal_stepUpdated_bookmark.add(handler_updateBookmark);
         param1.socialQuestData.signal_stepUpdated_referrerSet.add(handler_updateReferrer);
         _questReward = quest.reward.outputDisplay;
      }
      
      override protected function dispose() : void
      {
         player.socialQuestData.signal_stepUpdated_groupJoin.remove(handler_updateGroupJoin);
         player.socialQuestData.signal_stepUpdated_bookmark.remove(handler_updateBookmark);
         player.socialQuestData.signal_stepUpdated_referrerSet.remove(handler_updateReferrer);
         super.dispose();
      }
      
      private function handler_updateGroupJoin() : void
      {
         vo1._progress = int(stepCompleted_groupJoin);
         vo1.dispatchUpdate();
         updateFarmAvailability();
      }
      
      private function handler_updateBookmark() : void
      {
         vo2._progress = int(stepCompleted_post);
         vo2.dispatchUpdate();
         updateFarmAvailability();
      }
      
      private function handler_updateFriendCount() : void
      {
         vo1._progress = stepProgress_friendCount;
         vo1.dispatchUpdate();
         updateFarmAvailability();
      }
      
      private function handler_updateReferrer() : void
      {
         vo4._progress = int(stepCompleted_referrerSet);
         vo4.dispatchUpdate();
         updateFarmAvailability();
      }
      
      private function updateFarmAvailability() : void
      {
         if(canFarm)
         {
            _signal_updateFarmAvailable.dispatch();
         }
      }
      
      public function get data() : Vector.<SocialQuestTaskValueObject>
      {
         return _data;
      }
      
      public function get questReward() : Vector.<InventoryItem>
      {
         return _questReward;
      }
      
      public function get canFarm() : Boolean
      {
         return player.socialQuestData.canFarm;
      }
      
      public function get stepCompleted_groupJoin() : Boolean
      {
         return player.socialQuestData.stepCompleted_groupJoin;
      }
      
      public function get stepCompleted_post() : Boolean
      {
         return player.socialQuestData.stepCompleted_post;
      }
      
      public function get stepCompleted_friendCount() : Boolean
      {
         return player.socialQuestData.stepCompleted_friendCount;
      }
      
      public function get stepCompleted_referrerSet() : Boolean
      {
         return player.socialQuestData.stepCompleted_referrerSet;
      }
      
      public function get stepProgress_friendCount() : int
      {
         return player.socialQuestData.stepProgress_friendCount;
      }
      
      public function get postIsActuallyABookmark() : Boolean
      {
         return GameModel.instance.context.platformFacade.network == "vkontakte";
      }
      
      public function get signal_updateFarmAvailable() : Signal
      {
         return _signal_updateFarmAvailable;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new SocialQuestPopup(this);
         return _popup;
      }
      
      public function action_farm() : void
      {
         var _loc1_:PopupStashEventParams = Stash.click("get_reward:" + quest.desc.id,_popup.stashParams);
         var _loc2_:CommandQuestFarm = GameModel.instance.actionManager.quest.questFarm(quest);
         _loc2_.stashClick = _loc1_;
         _loc2_.onClientExecute(onQuestFarmComplete);
         close();
      }
      
      public function action_groupJoin() : void
      {
         Stash.click("group",_popup.stashParams);
         SocialQuestHelper.instance.action_groupJoin();
      }
      
      public function action_feedPost() : void
      {
         SocialQuestHelper.instance.action_bookmark();
      }
      
      public function action_inviteFriends() : void
      {
         var _loc1_:CommandSocialInviteFriends = GameModel.instance.actionManager.platform.inviteFriends();
         _loc1_.onComplete.add(handler_inviteFriendsComplete);
      }
      
      public function action_setReferrer() : void
      {
         var _loc1_:ReferrerPopupMediator = new ReferrerPopupMediator(player);
         _loc1_.open(_popup.stashParams);
      }
      
      private function handler_inviteFriendsComplete(param1:CommandSocialInviteFriends) : void
      {
         PopupList.instance.message(Translate.translateArgs("UI_DIALOG_SOCIAL_QUEST_TASK_3_CONRIFM",(quest.desc as QuestNormalDescription).chain.startCondition.amount,quest.desc.localeTaskDescription));
      }
      
      private function onQuestFarmComplete(param1:CommandQuestFarm) : void
      {
         var _loc2_:QuestRewardPopup = new QuestRewardPopup(param1.reward.outputDisplay,param1.entry);
         _loc2_.stashSourceClick = param1.stashClick;
         PopUpManager.addPopUp(_loc2_);
      }
   }
}
