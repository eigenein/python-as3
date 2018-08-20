package game.command.rpc.threebox
{
   import game.command.requirement.CommandRequirement;
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.model.user.Player;
   import game.model.user.refillable.PlayerRefillableEntry;
   import game.model.user.specialoffer.PlayerSpecialOfferLootBox;
   
   public class CommandLootBoxBuy extends CostCommand
   {
       
      
      public var stashClick:PopupStashEventParams;
      
      public var rewardList:Vector.<RewardData>;
      
      public var box:PlayerSpecialOfferLootBox;
      
      public var free:Boolean;
      
      public var pack:Boolean;
      
      public function CommandLootBoxBuy(param1:PlayerSpecialOfferLootBox, param2:int, param3:Boolean, param4:Boolean, param5:CostData)
      {
         super();
         this.free = param3;
         this.pack = param4;
         this.box = param1;
         rpcRequest = new RpcRequest("lootBoxBuy");
         rpcRequest.writeParam("box",param1.id);
         rpcRequest.writeParam("offerId",param2);
         rpcRequest.writeParam("free",param3);
         rpcRequest.writeParam("x10",param4);
         _cost = param5;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         if(free)
         {
            param1.refillable.freeLootBoxOpen(box.refillable);
         }
         super.clientExecute(param1);
      }
      
      override public function prerequisiteCheck(param1:Player) : CommandRequirement
      {
         var _loc2_:* = null;
         var _loc3_:CommandRequirement = super.prerequisiteCheck(param1);
         if(free)
         {
            _loc2_ = param1.refillable.getById(box.refillable);
            _loc3_.invalid = !(_loc2_ && _loc2_.value > 0 && _loc2_.canRefill);
         }
         return _loc3_;
      }
      
      override protected function successHandler() : void
      {
         var _loc3_:int = 0;
         _reward = new RewardData(null);
         var _loc1_:Array = this.result.body as Array;
         var _loc2_:int = _loc1_.length;
         rewardList = new Vector.<RewardData>();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            rewardList[_loc3_] = new RewardData(_loc1_[_loc3_]);
            reward.addRawData(_loc1_[_loc3_]);
            _loc3_++;
         }
         super.successHandler();
      }
   }
}
