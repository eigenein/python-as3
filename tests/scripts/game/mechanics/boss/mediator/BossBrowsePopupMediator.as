package game.mechanics.boss.mediator
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.DataStorage;
   import game.mechanics.boss.model.CommandBossAttack;
   import game.mechanics.boss.model.CommandBossRaid;
   import game.mechanics.boss.model.PlayerBossEntry;
   import game.mechanics.boss.popup.BossBrowsePopup;
   import game.mechanics.boss.storage.BossLevelDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.team.TeamGatherPopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.specialoffer.InventoryItemSortOrder;
   import game.view.popup.PopupBase;
   import game.view.popup.reward.RewardPopup;
   
   public class BossBrowsePopupMediator extends PopupMediator
   {
       
      
      private var _attackBossLevel:BossLevelDescription;
      
      private var _teamGatherPopupMediator:TeamGatherPopupMediator;
      
      public var boss:PlayerBossEntry;
      
      public function BossBrowsePopupMediator(param1:Player, param2:PlayerBossEntry, param3:Boolean)
      {
         super(param1);
         this.boss = param2;
         _attackBossLevel = this.boss.level != null?this.boss.level:param2.type.getLevelByBossLevel(1);
         if(param3 && this.boss.level && _attackBossLevel.nextLevel)
         {
            _attackBossLevel = _attackBossLevel.nextLevel;
         }
      }
      
      public function get attackBossLevel() : BossLevelDescription
      {
         return _attackBossLevel;
      }
      
      public function get firstWinRewardList() : Vector.<InventoryItem>
      {
         return new InventoryItemSortOrder(["coin4","coin","starmoney"]).sortReward(attackBossLevel.firstWinReward);
      }
      
      public function get bossChestInventoryItem() : InventoryItem
      {
         return new InventoryItem(DataStorage.pseudo.BOSS_CHEST_PSEUDO,1);
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new BossBrowsePopup(this);
         return new BossBrowsePopup(this);
      }
      
      public function getPlayer() : Player
      {
         return this.player;
      }
      
      public function action_attack() : void
      {
         var _loc1_:BossTeamGatherPopupMediator = new BossTeamGatherPopupMediator(player,boss.type);
         _teamGatherPopupMediator = _loc1_;
         _loc1_.signal_teamGatherComplete.addOnce(handler_teamGatherComplete);
         _loc1_.open();
      }
      
      public function action_raid() : void
      {
         var _loc1_:CommandBossRaid = GameModel.instance.actionManager.boss.bossRaid(boss);
         _loc1_.onClientExecute(handler_bossRaidClientExecute);
      }
      
      private function handler_teamGatherComplete(param1:TeamGatherPopupMediator) : void
      {
         var _loc2_:CommandBossAttack = GameModel.instance.actionManager.boss.bossAttack(boss,param1.playerEntryTeamList);
         _loc2_.onClientExecute(handler_bossAttackClientExecute);
      }
      
      private function handler_bossAttackClientExecute(param1:CommandBossAttack) : void
      {
         if(_teamGatherPopupMediator)
         {
            _teamGatherPopupMediator.close();
         }
         close();
      }
      
      private function handler_bossRaidClientExecute(param1:CommandBossRaid) : void
      {
         var _loc2_:RewardPopup = new RewardPopup(param1.reward.outputDisplay,"bossBrowsePopup");
         _loc2_.header = Translate.translate("UI_DIALOG_BOSS_RAID_TITLE");
         _loc2_.label = "";
         _loc2_.open();
         close();
      }
   }
}
