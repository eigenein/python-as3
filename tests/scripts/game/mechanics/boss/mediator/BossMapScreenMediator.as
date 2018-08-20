package game.mechanics.boss.mediator
{
   import com.progrestar.common.lang.Translate;
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.data.storage.shop.ShopDescription;
   import game.mechanics.boss.model.CommandBossRaid;
   import game.mechanics.boss.model.PlayerBossEntry;
   import game.mechanics.boss.popup.BossDailyRewardPopup;
   import game.mechanics.boss.popup.BossFrameRendererMediator;
   import game.mechanics.boss.popup.BossMapScreen;
   import game.mechanics.boss.storage.BossTypeDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import idv.cjcat.signals.Signal;
   
   public class BossMapScreenMediator extends PopupMediator
   {
       
      
      private var currentBossIndex:uint = 1;
      
      public const mapProgress:BossMapProgressMediator = new BossMapProgressMediator();
      
      public var bossAllTypesList:Vector.<BossTypeDescription>;
      
      public const signal_bossDataReceived:Signal = new Signal();
      
      public function BossMapScreenMediator(param1:Player, param2:BossTypeDescription = null)
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         super(param1);
         bossAllTypesList = DataStorage.boss.getAllTypesList();
         var _loc5_:Vector.<PlayerBossEntry> = param1.boss.getBossesWithMarkerActions();
         _loc5_.sort(_sortById);
         var _loc6_:* = null;
         if(param2)
         {
            _loc6_ = param2;
         }
         else if(_loc5_.length)
         {
            _loc6_ = _loc5_[0].type;
         }
         else if(param1.boss.currentBoss.value != null)
         {
            _loc6_ = (param1.boss.currentBoss.value as PlayerBossEntry).type;
         }
         if(_loc6_)
         {
            _loc3_ = bossAllTypesList.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               if(bossAllTypesList[_loc4_] == _loc6_)
               {
                  currentBossIndex = _loc4_;
                  break;
               }
               _loc4_++;
            }
         }
         else
         {
            currentBossIndex = 0;
         }
         param1.boss.action_selectBoss(currentBoss);
         param1.boss.signal_updateAll.add(handler_updateBosses);
         param1.boss.signal_bossChestOpened.add(handler_bossChestOpened);
      }
      
      override protected function dispose() : void
      {
         player.boss.signal_updateAll.remove(handler_updateBosses);
         player.boss.signal_bossChestOpened.remove(handler_bossChestOpened);
         super.dispose();
      }
      
      public function get currentBoss() : BossTypeDescription
      {
         return bossAllTypesList[currentBossIndex];
      }
      
      public function get prevBoss() : BossTypeDescription
      {
         if(currentBossIndex > 0)
         {
            return bossAllTypesList[currentBossIndex - 1];
         }
         return bossAllTypesList[bossAllTypesList.length - 1];
      }
      
      public function get nextBoss() : BossTypeDescription
      {
         if(bossAllTypesList.length > currentBossIndex + 1)
         {
            return bossAllTypesList[currentBossIndex + 1];
         }
         return bossAllTypesList[0];
      }
      
      public function get prevBossMarker() : Boolean
      {
         var _loc1_:PlayerBossEntry = player.boss.getBossById(prevBoss.id);
         return !_loc1_.level || _loc1_.level && (_loc1_.mayRaid.value || (_loc1_.chestCost.value as CostData).isEmpty);
      }
      
      public function get nextBossMarker() : Boolean
      {
         var _loc1_:PlayerBossEntry = player.boss.getBossById(nextBoss.id);
         return !_loc1_.level || _loc1_.level && (_loc1_.mayRaid.value || (_loc1_.chestCost.value as CostData).isEmpty);
      }
      
      public function get locationName() : String
      {
         return Translate.translate("UI_DIALOG_BOSS_TITLE") + " - " + Translate.translate("LIB_BOSS_LOCATION_NAME_" + currentBoss.id);
      }
      
      public function get description() : String
      {
         var _loc1_:PlayerBossEntry = player.boss.getBossById(currentBoss.id);
         if(!_loc1_.level)
         {
            return Translate.translate("UI_DIALOG_BOSS_DESC1");
         }
         return Translate.translate("UI_DIALOG_BOSS_DESC2");
      }
      
      public function get bossChestInventoryItem() : InventoryItem
      {
         return new InventoryItem(DataStorage.pseudo.BOSS_CHEST_PSEUDO,1);
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new BossMapScreen(this);
         return new BossMapScreen(this);
      }
      
      public function getFrameRendererMediator(param1:BossTypeDescription) : BossFrameRendererMediator
      {
         return new BossFrameRendererMediator(player,param1);
      }
      
      public function action_getBossData() : void
      {
         player.boss.requestRpcInitialize();
      }
      
      public function action_setNextBoss() : void
      {
         if(bossAllTypesList.length > currentBossIndex + 1)
         {
            currentBossIndex = currentBossIndex + 1;
         }
         else
         {
            currentBossIndex = 0;
         }
         player.boss.action_selectBoss(currentBoss);
         mapProgress.setup(player.boss.currentBoss.value as PlayerBossEntry);
      }
      
      public function action_setPrevBoss() : void
      {
         if(currentBossIndex > 0)
         {
            currentBossIndex = currentBossIndex - 1;
         }
         else
         {
            currentBossIndex = bossAllTypesList.length - 1;
         }
         player.boss.action_selectBoss(currentBoss);
         mapProgress.setup(player.boss.currentBoss.value as PlayerBossEntry);
      }
      
      public function action_toShop() : void
      {
         var _loc2_:String = "boss";
         var _loc1_:ShopDescription = DataStorage.shop.getByIdent(_loc2_);
         if(_loc1_)
         {
            Game.instance.navigator.navigateToShop(_loc1_,Stash.click("store:" + _loc1_.id,_popup.stashParams));
         }
      }
      
      public function action_attack() : void
      {
         new BossBrowsePopupMediator(GameModel.instance.player,player.boss.currentBoss.value as PlayerBossEntry,true).open(_popup.stashParams);
      }
      
      public function action_raid() : void
      {
         var _loc1_:CommandBossRaid = GameModel.instance.actionManager.boss.bossRaid(player.boss.currentBoss.value as PlayerBossEntry);
         _loc1_.onClientExecute(handler_bossRaidClientExecute);
      }
      
      public function action_open() : void
      {
         new BossChestPopupMediator(player,player.boss.currentBoss.value as PlayerBossEntry).open(_popup.stashParams);
      }
      
      public function action_skipChests() : void
      {
         player.boss.action_skipChestsLocal();
      }
      
      private function _sortById(param1:PlayerBossEntry, param2:PlayerBossEntry) : int
      {
         return param2.type.id - param1.type.id;
      }
      
      private function handler_updateBosses() : void
      {
         signal_bossDataReceived.dispatch();
         mapProgress.setup(player.boss.currentBoss.value as PlayerBossEntry);
      }
      
      private function handler_bossChestOpened() : void
      {
         mapProgress.setup(player.boss.currentBoss.value as PlayerBossEntry);
      }
      
      private function handler_bossRaidClientExecute(param1:CommandBossRaid) : void
      {
         var _loc2_:Vector.<InventoryItem> = new Vector.<InventoryItem>();
         _loc2_.push(bossChestInventoryItem);
         var _loc3_:BossDailyRewardPopup = new BossDailyRewardPopup(_loc2_.concat(param1.reward.outputDisplay),"bossDailyRewardPopup");
         _loc3_.header = Translate.translate("UI_DIALOG_BOSS_DAILY_REWARD_TITLE");
         _loc3_.textOnButton = Translate.translate("UI_DIALOG_BOSS_OPEN");
         _loc3_.signal_buttonClick.add(action_open);
         _loc3_.label = "";
         _loc3_.open();
      }
   }
}
