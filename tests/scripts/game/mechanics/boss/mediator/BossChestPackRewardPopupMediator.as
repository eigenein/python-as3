package game.mechanics.boss.mediator
{
   import flash.utils.setTimeout;
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.data.storage.resource.CoinDescription;
   import game.mechanics.boss.model.PlayerBossEntry;
   import game.mechanics.boss.popup.BossChestPackRewardPopup;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.PopupBase;
   
   public class BossChestPackRewardPopupMediator extends PopupMediator
   {
       
      
      public var rewards:Vector.<InventoryItem>;
      
      public function BossChestPackRewardPopupMediator(param1:Player, param2:Vector.<InventoryItem>)
      {
         super(param1);
         this.rewards = param2;
      }
      
      public function get reopenCost() : CostData
      {
         return DataStorage.rule.bossRule.chestPackCost;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney();
         var _loc2_:CoinDescription = DataStorage.coin.getByIdent("boss");
         _loc1_.requre_coin(_loc2_).animateChanges = true;
         _loc1_.requre_coin(DataStorage.coin.getByIdent("skin_coin_int"));
         _loc1_.requre_coin(DataStorage.coin.getByIdent("skin_coin_str"));
         _loc1_.requre_coin(DataStorage.coin.getByIdent("skin_coin_agi"));
         return _loc1_;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new BossChestPackRewardPopup(this);
         return new BossChestPackRewardPopup(this);
      }
      
      public function action_reopen() : void
      {
         var m:BossChestPopupMediator = new BossChestPopupMediator(player,player.boss.currentBoss.value as PlayerBossEntry);
         m.open();
         setTimeout(function():void
         {
            m.action_open(DataStorage.rule.bossRule.chestPackAmount);
         },500);
         super.close();
      }
      
      override public function close() : void
      {
         var _loc1_:BossChestPopupMediator = new BossChestPopupMediator(player,player.boss.currentBoss.value as PlayerBossEntry);
         _loc1_.open();
         super.close();
      }
   }
}
