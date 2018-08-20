package game.model.user.shop
{
   import flash.utils.Dictionary;
   import idv.cjcat.signals.Signal;
   
   public class SpecialShopModel
   {
       
      
      private var _merchants:Dictionary;
      
      var _signal_update:Signal;
      
      var _signal_init:Signal;
      
      public function SpecialShopModel()
      {
         _merchants = new Dictionary();
         _signal_update = new Signal();
         _signal_init = new Signal();
         super();
      }
      
      public function getAvailableMerchant() : SpecialShopMerchant
      {
         var _loc3_:int = 0;
         var _loc2_:* = _merchants;
         for each(var _loc1_ in _merchants)
         {
            if(_loc1_.timeLeft > 0 && _loc1_.canBuy())
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      function removeMerchant(param1:SpecialShopMerchant) : void
      {
         if(_merchants[param1.id])
         {
            delete _merchants[param1.id];
            _signal_update.dispatch();
         }
      }
      
      function addMerchant(param1:SpecialShopMerchant) : Boolean
      {
         if(_merchants[param1.id] || param1.timeLeft <= 0)
         {
            return false;
         }
         _merchants[param1.id] = param1;
         return true;
      }
      
      public function get signal_update() : Signal
      {
         return _signal_update;
      }
      
      public function get signal_init() : Signal
      {
         return _signal_init;
      }
   }
}
