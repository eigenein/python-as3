package game.model.user.shop
{
   import game.command.rpc.RPCCommandBase;
   
   public class SpecialShopController
   {
       
      
      private var _model:SpecialShopModel;
      
      private var _specialShopManager:SpecialShopManager;
      
      public function SpecialShopController(param1:SpecialShopManager)
      {
         super();
         _specialShopManager = param1;
         _model = _specialShopManager.model;
      }
      
      public function init(param1:Object) : void
      {
         parse(param1);
      }
      
      private function parse(param1:Object) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:SpecialShopMerchant = new SpecialShopMerchant(param1);
         if(_model.addMerchant(_loc2_))
         {
            _loc2_.signal_dismiss.addOnce(onMerchantEnd);
            _model.signal_init.dispatch();
            _model.signal_update.dispatch();
         }
      }
      
      private function update(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:SpecialShopMerchant = _model.getAvailableMerchant();
         if(_loc2_)
         {
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               _loc2_.updateHero(param1[_loc3_]);
               _loc3_++;
            }
            _model.signal_update.dispatch();
         }
      }
      
      private function onMerchantEnd(param1:SpecialShopMerchant) : void
      {
         _model.removeMerchant(param1);
      }
      
      public function onRpc_checkUpdates(param1:RPCCommandBase) : void
      {
         var _loc2_:Object = param1.result.heroesMerchant;
         if(_loc2_ != null)
         {
            parse(_loc2_);
         }
         var _loc3_:Array = param1.result.heroesMerchantUpdate;
         if(_loc3_ && _loc3_.length)
         {
            update(_loc3_);
         }
      }
   }
}
