package game.command.rpc.shop
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.shop.ShopDescription;
   import game.data.storage.shop.StaticSlotsShopDescription;
   import game.mediator.gui.popup.shop.ShopSlotValueObject;
   import game.model.user.Player;
   
   public class CommandShopBuy extends CostCommand
   {
       
      
      private var _shop:ShopDescription;
      
      private var _slot:ShopSlotValueObject;
      
      private var _staticShopData:Vector.<ShopSlotValueObject>;
      
      public function CommandShopBuy(param1:ShopDescription, param2:ShopSlotValueObject, param3:uint = 1)
      {
         var _loc4_:* = null;
         super();
         this._shop = param1;
         this._slot = param2;
         rpcRequest = new RpcRequest("shopBuy");
         rpcRequest.writeParam("shopId",param1.id);
         rpcRequest.writeParam("slot",param2.id);
         _cost = new CostData();
         _cost.add(param2.cost);
         _reward = new RewardData();
         _reward.add(param2.reward);
         if(param2.staticShopMultiplePurchase)
         {
            rpcRequest.writeParam("amount",param3);
            _cost.multiply(param3);
            _reward.multiply(param3);
            isImmediate = false;
         }
         if(param1 is StaticSlotsShopDescription)
         {
            _loc4_ = new RpcRequest("shopGet");
            _loc4_.writeParam("shopId",param1.id);
            rpcRequest.writeRequest(_loc4_);
         }
      }
      
      override public function clientExecute(param1:Player) : void
      {
         if(shop is StaticSlotsShopDescription == false)
         {
            slot.bought = true;
         }
         super.clientExecute(param1);
      }
      
      public function get shop() : ShopDescription
      {
         return _shop;
      }
      
      public function get slot() : ShopSlotValueObject
      {
         return _slot;
      }
      
      public function get staticShopData() : Vector.<ShopSlotValueObject>
      {
         return _staticShopData;
      }
      
      override protected function successHandler() : void
      {
         var _loc1_:* = null;
         if(result.data["shopGet"])
         {
            _staticShopData = new Vector.<ShopSlotValueObject>();
            _loc1_ = result.data["shopGet"].slots;
            var _loc4_:int = 0;
            var _loc3_:* = _loc1_;
            for(var _loc2_ in _loc1_)
            {
               _staticShopData.push(new ShopSlotValueObject(_loc1_[_loc2_]));
            }
         }
         super.successHandler();
      }
   }
}
