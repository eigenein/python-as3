package game.command.rpc.shop
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.data.storage.shop.ShopDescription;
   import game.mediator.gui.popup.shop.ShopSlotValueObject;
   
   public class CommandShopGet extends RPCCommandBase
   {
       
      
      private var _shopData:Vector.<ShopSlotValueObject>;
      
      private var _refreshTime:int;
      
      private var _shop:ShopDescription;
      
      public function CommandShopGet(param1:ShopDescription)
      {
         super();
         this._shop = param1;
         rpcRequest = new RpcRequest("shopGet");
         rpcRequest.writeParam("shopId",param1.id);
      }
      
      public function get shopData() : Vector.<ShopSlotValueObject>
      {
         return _shopData;
      }
      
      public function get refreshTime() : int
      {
         return _refreshTime;
      }
      
      public function get shop() : ShopDescription
      {
         return _shop;
      }
      
      override protected function successHandler() : void
      {
         _refreshTime = result.body.refreshTime;
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
