package game.command.rpc
{
   public class CommandResult
   {
       
      
      private var _data:Object;
      
      private var _questUpdates:CommandResultQuestUpdateData;
      
      private var _specialOfferUpdates:CommandResultSpecialOfferUpdateData;
      
      private var _bundleUpdate:CommandResultBundleData;
      
      private var _heroesMerchant:Object;
      
      private var _heroesMerchantUpdate:Array;
      
      public function CommandResult(param1:Object)
      {
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         super();
         var _loc6_:Array = null;
         var _loc8_:int = 0;
         var _loc7_:* = param1;
         for(var _loc2_ in param1)
         {
            _loc4_ = param1[_loc2_];
            if(_loc4_.quests || _loc4_.newQuests)
            {
               if(!_questUpdates)
               {
                  _questUpdates = new CommandResultQuestUpdateData();
               }
               _questUpdates.addNewQuests(_loc4_.newQuests);
               _questUpdates.addQuestUpdate(_loc4_.quests);
            }
            if(_loc4_.specialOffers || _loc4_.endSpecialOffers)
            {
               if(!_specialOfferUpdates)
               {
                  _specialOfferUpdates = new CommandResultSpecialOfferUpdateData();
               }
               _specialOfferUpdates.addUpdateSpecialOffers(_loc4_.specialOffers);
               _specialOfferUpdates.addEndSpecialOffers(_loc4_.endSpecialOffers);
            }
            if(_loc4_.bundleUpdate)
            {
               _loc6_ = _loc6_ || [];
               _loc6_ = _loc6_.concat(_loc4_.bundleUpdate);
            }
            _heroesMerchant = _loc4_.heroesMerchant;
            _heroesMerchantUpdate = _loc4_.heroesMerchantUpdate;
            param1[_loc2_] = _loc4_.response;
         }
         if(_loc6_)
         {
            _bundleUpdate = new CommandResultBundleData();
            _loc3_ = _loc6_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _bundleUpdate.billings = _bundleUpdate.billings.concat(_loc6_[_loc5_].billings);
               _bundleUpdate.bundle = _bundleUpdate.bundle.concat(_loc6_[_loc5_].bundle);
               _loc5_++;
            }
         }
         _data = param1;
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function get questUpdateData() : CommandResultQuestUpdateData
      {
         return _questUpdates;
      }
      
      public function get specialOfferUpdates() : CommandResultSpecialOfferUpdateData
      {
         return _specialOfferUpdates;
      }
      
      public function get bundleUpdate() : CommandResultBundleData
      {
         return _bundleUpdate;
      }
      
      public function get heroesMerchant() : Object
      {
         return _heroesMerchant;
      }
      
      public function get heroesMerchantUpdate() : Array
      {
         return _heroesMerchantUpdate;
      }
      
      public function get body() : Object
      {
         return data.body;
      }
   }
}
