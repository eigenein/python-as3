package game.command.rpc.chest
{
   import game.command.requirement.CommandRequirement;
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.reward.RewardData;
   import game.data.storage.chest.ChestDescription;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.refillable.PlayerRefillableEntry;
   import game.view.gui.tutorial.Tutorial;
   
   public class CommandChestBuy extends CostCommand
   {
       
      
      private var free:Boolean;
      
      private var _rewardList:Vector.<RewardData>;
      
      public var stashClick:PopupStashEventParams;
      
      private var _chest:ChestDescription;
      
      private var _pack:Boolean;
      
      public function CommandChestBuy(param1:ChestDescription, param2:Boolean, param3:Boolean)
      {
         super();
         this._pack = param3;
         this.free = param2;
         this._chest = param1;
         rpcRequest = new RpcRequest("chestBuy");
         rpcRequest.writeParam("chest",param1.ident);
         rpcRequest.writeParam("free",param2);
         rpcRequest.writeParam("pack",param3);
         if(!param2)
         {
            if(param3)
            {
               _cost = GameModel.instance.player.specialOffer.costReplace.chestPack(param1);
            }
            else
            {
               _cost = GameModel.instance.player.specialOffer.costReplace.chestOne(param1);
            }
         }
      }
      
      public function get chest() : ChestDescription
      {
         return _chest;
      }
      
      public function get pack() : Boolean
      {
         return _pack;
      }
      
      public function get rewardList() : Vector.<RewardData>
      {
         return _rewardList;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         if(free)
         {
            param1.refillable.freeChestOpen(chest);
         }
         super.clientExecute(param1);
      }
      
      override public function prerequisiteCheck(param1:Player) : CommandRequirement
      {
         var _loc2_:* = null;
         var _loc3_:CommandRequirement = super.prerequisiteCheck(param1);
         if(free)
         {
            _loc2_ = param1.refillable.getById(chest.freeRefill);
            _loc3_.invalid = !(_loc2_ && _loc2_.value > 0 && _loc2_.canRefill);
         }
         return _loc3_;
      }
      
      override protected function successHandler() : void
      {
         var _loc3_:int = 0;
         _reward = new RewardData(null);
         var _loc2_:Array = this.result.body.rewards as Array;
         var _loc1_:int = _loc2_.length;
         _rewardList = new Vector.<RewardData>();
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _rewardList[_loc3_] = new RewardData(_loc2_[_loc3_]);
            reward.addRawData(_loc2_[_loc3_]);
            if(this.result.body.slots is Array)
            {
               trace(this.result.body.slots[_loc3_]);
            }
            _loc3_++;
         }
         super.successHandler();
         Tutorial.events.triggerEvent_chestBuy(_chest,free,_pack);
      }
   }
}
