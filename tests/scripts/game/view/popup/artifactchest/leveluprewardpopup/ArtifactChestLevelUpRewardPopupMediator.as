package game.view.popup.artifactchest.leveluprewardpopup
{
   import game.data.reward.RewardData;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   
   public class ArtifactChestLevelUpRewardPopupMediator extends PopupMediator
   {
       
      
      private var _newLevel:int;
      
      private var _levelUpReward:RewardData;
      
      public function ArtifactChestLevelUpRewardPopupMediator(param1:Player, param2:RewardData, param3:int)
      {
         super(param1);
         _levelUpReward = param2;
         _newLevel = param3;
      }
      
      public function get newLevel() : int
      {
         return _newLevel;
      }
      
      public function get levelUpReward() : RewardData
      {
         return _levelUpReward;
      }
      
      public function get playerInClan() : Boolean
      {
         return player.clan.clan != null;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ArtifactChestLevelUpRewardPopup(this);
         return _popup;
      }
   }
}
