package game.mediator.gui.popup.mission
{
   import game.command.rpc.mission.MissionBattleResultValueObject;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.pve.mission.MissionDescription;
   import game.mediator.gui.component.RewardHeroExpDisplayValueObject;
   import game.mediator.gui.component.RewardHeroExpValueObject;
   import game.mediator.gui.component.RewardPopupStarAnimator;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.social.GMRUserAgreementCheck;
   import game.stat.Stash;
   import game.view.gui.tutorial.Tutorial;
   import game.view.popup.PopupBase;
   import game.view.popup.fightresult.pve.MissionRewardPopup;
   import game.view.popup.hero.TimerQueueDispenser;
   import idv.cjcat.signals.Signal;
   
   public class MissionRewardPopupMediator extends PopupMediator
   {
       
      
      private var reward:RewardData;
      
      private var xpTimer:TimerQueueDispenser;
      
      private var starTimer:RewardPopupStarAnimator;
      
      private var _missionResult:MissionBattleResultValueObject;
      
      private var _currentMission:MissionDescription;
      
      protected var _heroExperience:Vector.<RewardHeroExpValueObject>;
      
      private var _heroExpReward:Vector.<RewardHeroExpDisplayValueObject>;
      
      private var _stars:int;
      
      private var _itemRewardList:Vector.<InventoryItem>;
      
      public function MissionRewardPopupMediator(param1:Player, param2:MissionBattleResultValueObject, param3:MissionDescription)
      {
         var _loc12_:int = 0;
         var _loc6_:int = 0;
         var _loc14_:* = null;
         _loc12_ = 0;
         var _loc9_:int = 0;
         var _loc7_:* = null;
         var _loc13_:int = 0;
         var _loc10_:int = 0;
         _loc6_ = 0;
         var _loc11_:* = null;
         var _loc4_:* = null;
         var _loc8_:int = 0;
         super(param1);
         this._missionResult = param2;
         this._currentMission = param3;
         reward = param2.reward;
         _heroExpReward = new Vector.<RewardHeroExpDisplayValueObject>();
         _heroExperience = new Vector.<RewardHeroExpValueObject>();
         if(reward.heroExperience)
         {
            _loc12_ = reward.heroExperience.length;
            _loc6_ = 0;
            while(_loc6_ < _loc12_)
            {
               _loc14_ = DataStorage.hero.getHeroById(reward.heroExperience[_loc6_].id);
               _heroExperience[_loc6_] = new RewardHeroExpValueObject(_loc14_,reward.heroExperience[_loc6_].exp);
               _loc6_++;
            }
         }
         _loc12_ = param2.result.attackers.length;
         _loc9_ = 0;
         while(_loc9_ < _loc12_)
         {
            _loc7_ = param2.result.attackers[_loc9_].unit as HeroDescription;
            _loc13_ = 0;
            if(_heroExperience)
            {
               _loc10_ = _heroExperience.length;
               _loc6_ = 0;
               while(_loc6_ < _loc10_)
               {
                  if(_heroExperience[_loc6_].hero == _loc7_)
                  {
                     _loc13_ = _heroExperience[_loc6_].xp;
                     break;
                  }
                  _loc6_++;
               }
            }
            _loc11_ = param1.heroes.getById(_loc7_.id);
            _loc4_ = new RewardHeroExpDisplayValueObject(_loc7_,_loc11_,_loc13_);
            _heroExpReward[_loc9_] = _loc4_;
            _loc9_++;
         }
         var _loc5_:Vector.<InventoryItem> = param2.reward.outputDisplay;
         _itemRewardList = new Vector.<InventoryItem>();
         if(_loc5_)
         {
            _loc12_ = _loc5_.length;
            _loc8_ = 0;
            while(_loc8_ < _loc12_)
            {
               if(_loc5_[_loc8_].item.type != InventoryItemType.PSEUDO || _loc5_[_loc8_].item.id == DataStorage.pseudo.CLAN_ACTIVITY.id)
               {
                  _itemRewardList.push(_loc5_[_loc8_]);
               }
               _loc8_++;
            }
         }
         _stars = param2.stars;
         xpTimer = new TimerQueueDispenser(RewardHeroExpDisplayValueObject,500);
         xpTimer.signal_onElement.add(handler_onExpElement);
         starTimer = new RewardPopupStarAnimator(400,stars);
         starTimer.signal_complete.add(action_animateExperience);
      }
      
      override protected function dispose() : void
      {
         super.dispose();
         xpTimer.dispose();
         starTimer.dispose();
      }
      
      public function get signal_starAnimation() : Signal
      {
         return starTimer.signal_onElement;
      }
      
      public function get missionResult() : MissionBattleResultValueObject
      {
         return _missionResult;
      }
      
      public function get currentMission() : MissionDescription
      {
         return _currentMission;
      }
      
      public function get heroExperience() : Vector.<RewardHeroExpValueObject>
      {
         return _heroExperience;
      }
      
      public function get heroExpReward() : Vector.<RewardHeroExpDisplayValueObject>
      {
         return _heroExpReward;
      }
      
      public function get stars() : int
      {
         return _stars;
      }
      
      public function get gold() : int
      {
         return reward.gold;
      }
      
      public function get teamXp() : int
      {
         return reward.experience;
      }
      
      public function get teamLevel() : int
      {
         return player.levelData.level.level;
      }
      
      public function get itemRewardList() : Vector.<InventoryItem>
      {
         return _itemRewardList;
      }
      
      public function get mainTutorialCompleted() : Boolean
      {
         return Tutorial.flags.mainTutorialCompleted;
      }
      
      override public function close() : void
      {
         if(GMRUserAgreementCheck.instance)
         {
            if(currentMission.world == 1 && currentMission.index == 5)
            {
               GMRUserAgreementCheck.instance.action_userAgreementShow();
            }
         }
         super.close();
      }
      
      public function action_animateExperience() : void
      {
         var _loc1_:Vector.<RewardHeroExpDisplayValueObject> = _heroExpReward.slice();
         _loc1_.unshift(null);
         xpTimer.add(_heroExpReward);
      }
      
      public function action_animateStars() : void
      {
         starTimer.start();
      }
      
      public function action_navigateTown() : void
      {
         close();
      }
      
      public function action_navigateCampaign() : void
      {
         if(currentMission.id == player.missions.getCurrentMissionDesc().id)
         {
            Game.instance.navigator.navigateToMission(player.missions.getNextPlayableMission(),Stash.click("mission_reward_to_campaign",_popup.stashParams));
         }
         else
         {
            Game.instance.navigator.navigateToMission(currentMission,Stash.click("mission_reward_to_campaign",_popup.stashParams));
         }
         close();
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new MissionRewardPopup(this);
         return _popup;
      }
      
      private function handler_onExpElement(param1:RewardHeroExpDisplayValueObject) : void
      {
         if(param1)
         {
            param1.startXPTween();
         }
      }
   }
}
