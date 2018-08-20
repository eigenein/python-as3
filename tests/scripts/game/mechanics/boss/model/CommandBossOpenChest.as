package game.mechanics.boss.model
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.mechanics.boss.storage.BossChestDescription;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import idv.cjcat.signals.Signal;
   
   public class CommandBossOpenChest extends CostCommand
   {
       
      
      private var _chestNum:int;
      
      private var _player:Player;
      
      private var boss:PlayerBossEntry;
      
      private var chest:BossChestDescription;
      
      private var _amount:int;
      
      private var _rewardToBeTaken:RewardData = null;
      
      private var _rewardItem:InventoryItem;
      
      public const signal_rewardTaken:Signal = new Signal(RewardData);
      
      private var _rewardList:Vector.<InventoryItem>;
      
      public function CommandBossOpenChest(param1:PlayerBossEntry, param2:BossChestDescription, param3:int)
      {
         super();
         this.boss = param1;
         this.chest = param2;
         _amount = param3;
         _chestNum = param1.chestsOpenedCount.value + 1;
         if(param3 == 1)
         {
            _cost = param2.cost;
         }
         else
         {
            _cost = DataStorage.rule.bossRule.chestPackCost;
         }
         rpcRequest = new RpcRequest("bossOpenChest");
         rpcRequest.writeParam("bossId",param1.type.id);
         rpcRequest.writeParam("amount",param3);
         rpcRequest.writeParam("starmoney",_cost.starmoney);
      }
      
      public function get chestNum() : int
      {
         return _chestNum;
      }
      
      public function get rewardItem() : InventoryItem
      {
         return _rewardItem;
      }
      
      public function get rewardToBeTaken() : RewardData
      {
         return _rewardToBeTaken;
      }
      
      public function get rewardList() : Vector.<InventoryItem>
      {
         return _rewardList;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _player = param1;
         if(result.data.body)
         {
            _rewardToBeTaken = new RewardData();
            _rewardList = new Vector.<InventoryItem>();
            _loc3_ = result.body.rewards.payed as Array;
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _loc2_ = new RewardData(_loc3_[_loc4_]);
               _loc5_ = 0;
               while(_loc5_ < _loc2_.outputDisplay.length)
               {
                  _rewardList.push(_loc2_.outputDisplay[_loc5_]);
                  _loc5_++;
               }
               _rewardToBeTaken.add(_loc2_);
               _loc4_++;
            }
            _loc3_ = result.body.rewards.free as Array;
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _loc2_ = new RewardData(_loc3_[_loc4_]);
               _loc5_ = 0;
               while(_loc5_ < _loc2_.outputDisplay.length)
               {
                  _rewardList.push(_loc2_.outputDisplay[_loc5_]);
                  _loc5_++;
               }
               _rewardToBeTaken.add(_loc2_);
               _loc4_++;
            }
            _rewardItem = _rewardToBeTaken.outputDisplayFirst;
            boss.update(result.data.body.boss);
            boss.handleOpenedChest(this);
         }
         super.clientExecute(param1);
      }
      
      public function applyReward() : void
      {
         if(_rewardToBeTaken != null && _player)
         {
            signal_rewardTaken.dispatch(_rewardToBeTaken);
            _player.takeReward(_rewardToBeTaken);
            _rewardToBeTaken = null;
         }
      }
   }
}
