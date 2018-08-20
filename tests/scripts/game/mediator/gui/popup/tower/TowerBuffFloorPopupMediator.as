package game.mediator.gui.popup.tower
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.property.IntProperty;
   import game.command.tower.CommandTowerBuyBuff;
   import game.command.tower.CommandTowerNextFloor;
   import game.data.storage.DataStorage;
   import game.data.storage.resource.InventoryItemDescription;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.tower.InventoryItemCountProperty;
   import game.model.user.tower.PlayerTowerBuffEntry;
   import game.model.user.tower.PlayerTowerBuffFloor;
   import game.model.user.tower.TowerHeroState;
   import game.view.popup.PopupBase;
   import game.view.popup.tower.TowerBuffFloorPopup;
   import starling.core.Starling;
   
   public class TowerBuffFloorPopupMediator extends PopupMediator
   {
       
      
      private var buffFloor:PlayerTowerBuffFloor;
      
      private var _buffs:Vector.<TowerBuffValueObject>;
      
      private var heroSelectPopupMediator:TowerBuffSelectHeroPopupMediator;
      
      public function TowerBuffFloorPopupMediator(param1:Player, param2:PlayerTowerBuffFloor)
      {
         var _loc4_:int = 0;
         super(param1);
         this.buffFloor = param2;
         _buffs = new Vector.<TowerBuffValueObject>();
         var _loc5_:Vector.<PlayerTowerBuffEntry> = param2.buffs;
         var _loc3_:uint = _loc5_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _buffs[_loc4_] = new TowerBuffValueObject(_loc5_[_loc4_]);
            _buffs[_loc4_].signal_selected.add(handler_buffSelected);
            _loc4_++;
         }
      }
      
      override protected function dispose() : void
      {
         var _loc2_:int = 0;
         super.dispose();
         var _loc1_:uint = _buffs.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _buffs[_loc2_].signal_selected.clear();
            _loc2_++;
         }
      }
      
      public function get buffs() : Vector.<TowerBuffValueObject>
      {
         return _buffs;
      }
      
      public function get floor() : IntProperty
      {
         return player.tower.floor;
      }
      
      public function get skulls() : InventoryItemCountProperty
      {
         return new InventoryItemCountProperty(skullDescription,false);
      }
      
      public function get points() : IntProperty
      {
         return player.tower.points;
      }
      
      private function get skullDescription() : InventoryItemDescription
      {
         return DataStorage.coin.getCoinById(DataStorage.rule.towerRule.buffCoinId);
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_coin(player.tower.skullCoin);
         return _loc1_;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TowerBuffFloorPopup(this);
         return new TowerBuffFloorPopup(this);
      }
      
      public function action_buyBuff(param1:PlayerTowerBuffEntry, param2:int = 0) : void
      {
         var _loc3_:CommandTowerBuyBuff = GameModel.instance.actionManager.tower.towerBuyBuff(param1,param2);
         _loc3_.onClientExecute(handler_commandBuyBuff);
      }
      
      public function action_nextFloor() : void
      {
         var _loc1_:CommandTowerNextFloor = GameModel.instance.actionManager.tower.towerNextFloor();
         _loc1_.onClientExecute(handler_nextFloor);
      }
      
      private function handler_nextFloor(param1:CommandTowerNextFloor) : void
      {
         close();
      }
      
      private function handler_buffSelected(param1:TowerBuffValueObject) : void
      {
         var _loc2_:* = null;
         if(param1.entry.needHeroSelection)
         {
            if(player.canSpend(param1.entry.buff.cost))
            {
               _loc2_ = new TowerBuffSelectHeroPopupMediator(player,param1);
               _loc2_.signal_selected.add(handler_buffTargetSelected);
               _loc2_.open(null);
            }
            else
            {
               PopupList.instance.message(player.tower.skullCoin.obtainNavigatorType.not_enough_message,Translate.translate("UI_POPUP_MESSAGE_NOTENOUGH_SKULL"));
            }
         }
         else
         {
            action_buyBuff(param1.entry);
         }
      }
      
      private function handler_buffTargetSelected(param1:TowerBuffSelectHeroPopupMediator) : void
      {
         heroSelectPopupMediator = param1;
         action_buyBuff(param1.buff.entry,param1.selectedHeroId);
      }
      
      private function handler_commandBuyBuff(param1:CommandTowerBuyBuff) : void
      {
         if(!heroSelectPopupMediator)
         {
            return;
         }
         var _loc2_:TowerHeroState = player.tower.heroes.getHeroState(heroSelectPopupMediator.selectedHeroId);
         heroSelectPopupMediator.applyBuffToHero();
         Starling.juggler.delayCall(heroSelectPopupMediator.close,1.8);
         heroSelectPopupMediator = null;
      }
   }
}
