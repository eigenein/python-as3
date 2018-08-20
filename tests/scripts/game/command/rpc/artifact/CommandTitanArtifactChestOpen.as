package game.command.rpc.artifact
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.tutorial.Tutorial;
   
   public class CommandTitanArtifactChestOpen extends CostCommand
   {
       
      
      private var player:Player;
      
      private var _amount:uint;
      
      private var _free:Boolean;
      
      private var _rewardList:Vector.<InventoryItem>;
      
      public function CommandTitanArtifactChestOpen(param1:Player, param2:uint, param3:Boolean)
      {
         super();
         this.player = param1;
         _amount = param2;
         _free = param3;
         rpcRequest = new RpcRequest("titanArtifactChestOpen");
         rpcRequest.writeParam("amount",param2);
         rpcRequest.writeParam("free",param3);
         _cost = new CostData();
         if(param2 == 100)
         {
            _cost = DataStorage.rule.titanArtifactChestRule.openCostX100;
         }
         else if(param2 == 10)
         {
            if(_free)
            {
               _cost = DataStorage.rule.titanArtifactChestRule.openCostX10Free;
            }
            else
            {
               _cost = DataStorage.rule.titanArtifactChestRule.openCostX10;
            }
         }
         else
         {
            _cost = DataStorage.rule.titanArtifactChestRule.openCostX1;
         }
      }
      
      public function get amount() : uint
      {
         return _amount;
      }
      
      public function get free() : Boolean
      {
         return _free;
      }
      
      public function get rewardList() : Vector.<InventoryItem>
      {
         return _rewardList;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         if(_free)
         {
            Tutorial.events.triggerEvent_titanArtifactChestOpenFree();
         }
      }
      
      override protected function successHandler() : void
      {
         var _loc1_:* = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         player.titanArtifactChest.update(result.body);
         var _loc2_:Array = result.body.reward as Array;
         _rewardList = new Vector.<InventoryItem>();
         _reward = new RewardData(null);
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_ = new RewardData(_loc2_[_loc3_]);
            _loc4_ = 0;
            while(_loc4_ < _loc1_.outputDisplay.length)
            {
               _rewardList.push(_loc1_.outputDisplay[_loc4_]);
               _loc4_++;
            }
            _reward.add(_loc1_);
            _loc3_++;
         }
         super.successHandler();
      }
   }
}
