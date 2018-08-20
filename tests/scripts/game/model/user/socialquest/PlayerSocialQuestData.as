package game.model.user.socialquest
{
   import engine.context.platform.social.socialQuest.SocialQuestHelper;
   import game.data.storage.DataStorage;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.quest.PlayerQuestEntry;
   import idv.cjcat.signals.Signal;
   
   public class PlayerSocialQuestData
   {
       
      
      private var player:Player;
      
      private var _questAvailable:Boolean;
      
      private var _farmed:Boolean;
      
      private var _signal_stepUpdated_groupJoin:Signal;
      
      private var _stepCompleted_groupJoin:Boolean;
      
      private var _signal_stepUpdated_bookmark:Signal;
      
      private var _stepCompleted_bookmark:Boolean;
      
      private var _stepRequired_friendCount:int;
      
      private var _stepRequired_post:Boolean;
      
      private var _stepProgress_friendCount:int;
      
      private var _signal_stepUpdated_referrerSet:Signal;
      
      private var _signal_questUpdate:Signal;
      
      private var _stepCompleted_referrerSet:Boolean;
      
      public function PlayerSocialQuestData()
      {
         super();
         _signal_stepUpdated_groupJoin = new Signal();
         _signal_stepUpdated_bookmark = new Signal();
         _signal_stepUpdated_referrerSet = new Signal();
         _signal_questUpdate = new Signal();
      }
      
      public function get questAvailable() : Boolean
      {
         return _questAvailable;
      }
      
      public function get hasReferrer() : Boolean
      {
         return player.flags.getFlag(1);
      }
      
      public function set hasReferrer(param1:Boolean) : void
      {
         player.flags.setFlag(1,param1);
      }
      
      public function get farmed() : Boolean
      {
         return _farmed;
      }
      
      public function get canFarm() : Boolean
      {
         return !_farmed && stepCompleted_groupJoin && (!stepRequired_post || stepCompleted_post) && stepCompleted_friendCount && stepCompleted_referrerSet;
      }
      
      public function get signal_stepUpdated_groupJoin() : Signal
      {
         return _signal_stepUpdated_groupJoin;
      }
      
      public function get stepCompleted_groupJoin() : Boolean
      {
         return _stepCompleted_groupJoin;
      }
      
      public function get signal_stepUpdated_bookmark() : Signal
      {
         return _signal_stepUpdated_bookmark;
      }
      
      public function get stepCompleted_post() : Boolean
      {
         return _stepCompleted_bookmark;
      }
      
      public function get stepRequired_friendCount() : int
      {
         return _stepRequired_friendCount;
      }
      
      public function get stepRequired_post() : Boolean
      {
         return _stepRequired_post;
      }
      
      public function get stepProgress_friendCount() : int
      {
         return _stepProgress_friendCount;
      }
      
      public function get stepCompleted_friendCount() : Boolean
      {
         return _stepProgress_friendCount >= _stepRequired_friendCount;
      }
      
      public function get signal_stepUpdated_referrerSet() : Signal
      {
         return _signal_stepUpdated_referrerSet;
      }
      
      public function get signal_questUpdate() : Signal
      {
         return _signal_questUpdate;
      }
      
      public function get stepCompleted_referrerSet() : Boolean
      {
         return _stepCompleted_referrerSet;
      }
      
      public function init(param1:Object, param2:Player) : void
      {
         var _loc5_:Boolean = false;
         var _loc4_:Boolean = false;
         if(SocialQuestHelper.instance == null)
         {
            return;
         }
         this.player = param2;
         var _loc3_:Object = DataStorage.rule.socialQuest;
         _stepRequired_friendCount = _loc3_.invite;
         _stepRequired_post = _loc3_.post;
         _stepCompleted_referrerSet = param2.flags.getFlag(1);
         _stepCompleted_groupJoin = param1.group;
         _stepCompleted_bookmark = param1.post;
         _stepProgress_friendCount = param1.invited;
         _farmed = param1.farmed;
         if(SocialQuestHelper.instance.canCheck_groupStatus)
         {
            _loc5_ = SocialQuestHelper.instance.actionComplete_groupJoin;
         }
         else
         {
            _loc5_ = _stepCompleted_groupJoin;
         }
         if(SocialQuestHelper.instance.canCheck_bookmarkStatus)
         {
            _loc4_ = SocialQuestHelper.instance.actionComplete_bookmark;
         }
         else
         {
            _loc4_ = _stepCompleted_bookmark;
         }
         if(param1.group != _loc5_ || param1.post != _loc4_)
         {
            GameModel.instance.actionManager.friends.socialQuestUpdate(_loc4_,_loc5_);
            _stepCompleted_groupJoin = _loc5_;
            _stepCompleted_bookmark = _loc4_;
         }
         SocialQuestHelper.instance.signal_action_bookmark.add(handler_helperBookmarkUpdate);
         SocialQuestHelper.instance.signal_action_groupJoin.add(handler_helperGroupUpdate);
         param2.questData.signal_questAdded.add(handler_questAdded);
         param2.questData.signal_questRemoved.add(handler_questRemoved);
         _questAvailable = param2.questData.getQuest(_loc3_.id);
      }
      
      private function handler_questRemoved(param1:PlayerQuestEntry) : void
      {
         var _loc2_:Object = DataStorage.rule.socialQuest;
         if(_loc2_ && param1.desc.id == _loc2_.id)
         {
            _questAvailable = false;
            _signal_questUpdate.dispatch();
         }
      }
      
      private function handler_questAdded(param1:PlayerQuestEntry) : void
      {
         var _loc2_:Object = DataStorage.rule.socialQuest;
         if(_loc2_ && param1.desc.id == _loc2_.id)
         {
            _questAvailable = true;
            _signal_questUpdate.dispatch();
         }
      }
      
      public function completeStep_setReferrer(param1:Player) : void
      {
         if(param1)
         {
            param1.flags.setFlag(1,true);
         }
         _stepCompleted_referrerSet = true;
         _signal_stepUpdated_referrerSet.dispatch();
      }
      
      public function updateStep_bookmark(param1:Boolean) : void
      {
         if(_stepCompleted_bookmark != param1)
         {
            _stepCompleted_bookmark = param1;
            GameModel.instance.actionManager.friends.socialQuestUpdate(_stepCompleted_bookmark,_stepCompleted_groupJoin);
            _signal_stepUpdated_bookmark.dispatch();
         }
      }
      
      public function updateStep_groupJoined(param1:Boolean) : void
      {
         if(_stepCompleted_groupJoin != param1)
         {
            _stepCompleted_groupJoin = param1;
            GameModel.instance.actionManager.friends.socialQuestUpdate(_stepCompleted_bookmark,_stepCompleted_groupJoin);
            _signal_stepUpdated_groupJoin.dispatch();
         }
      }
      
      private function handler_helperBookmarkUpdate() : void
      {
         updateStep_bookmark(SocialQuestHelper.instance.actionComplete_bookmark);
      }
      
      private function handler_helperGroupUpdate() : void
      {
         updateStep_groupJoined(SocialQuestHelper.instance.actionComplete_groupJoin);
      }
   }
}
