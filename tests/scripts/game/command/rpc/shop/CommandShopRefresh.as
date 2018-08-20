package game.command.rpc.shop
{
   import game.command.requirement.CommandRequirement;
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.storage.shop.ShopDescription;
   import game.mediator.gui.popup.shop.ShopSlotValueObject;
   import game.model.user.Player;
   import game.model.user.refillable.PlayerRefillableEntry;
   
   public class CommandShopRefresh extends CostCommand
   {
       
      
      private var shop:ShopDescription;
      
      private var _shopData:Vector.<ShopSlotValueObject>;
      
      public function CommandShopRefresh(param1:ShopDescription)
      {
         super();
         this.shop = param1;
         rpcRequest = new RpcRequest("shopRefresh");
         rpcRequest.writeParam("shopId",param1.id);
      }
      
      override public function clientExecute(param1:Player) : void
      {
         var _loc2_:PlayerRefillableEntry = param1.refillable.getById(shop.resetRefillableId);
         param1.refillable.refill(_loc2_);
         super.clientExecute(param1);
      }
      
      public function get shopData() : Vector.<ShopSlotValueObject>
      {
         return _shopData;
      }
      
      override public function prerequisiteCheck(param1:Player) : CommandRequirement
      {
         var _loc3_:* = null;
         var _loc2_:PlayerRefillableEntry = param1.refillable.getById(shop.resetRefillableId);
         if(_loc2_.canRefill)
         {
            _cost = _loc2_.refillCost;
            _loc3_ = super.prerequisiteCheck(param1);
         }
         else
         {
            _loc3_ = super.prerequisiteCheck(param1);
            _loc3_.vipLevel = _loc2_.getVipLevelToRefill();
         }
         return super.prerequisiteCheck(param1);
      }
      
      override protected function successHandler() : void
      {
         _shopData = new Vector.<ShopSlotValueObject>();
         var _loc1_:Object = result.body.slots;
         var _loc4_:int = 0;
         var _loc3_:* = _loc1_;
         for(var _loc2_ in _loc1_)
         {
            _shopData.push(new ShopSlotValueObject(_loc1_[_loc2_]));
         }
         super.successHandler();
      }
   }
}
