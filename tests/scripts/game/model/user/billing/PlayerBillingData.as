package game.model.user.billing
{
   import engine.context.platform.PlatformFacade;
   import flash.utils.Dictionary;
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.billing.CommandBillingGetLast;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryFragmentItem;
   import idv.cjcat.signals.Signal;
   
   public class PlayerBillingData
   {
       
      
      private var dict:Dictionary;
      
      private var platform:PlatformFacade;
      
      private var completeTransactions:Vector.<String>;
      
      public const signal_updated:Signal = new Signal(PlayerBillingData);
      
      private var _list:Vector.<PlayerBillingDescription>;
      
      private var _upToDate:Boolean = false;
      
      private var _bundleData:PlayerBillingBundleData;
      
      public function PlayerBillingData()
      {
         completeTransactions = new Vector.<String>(0);
         _bundleData = new PlayerBillingBundleData();
         super();
      }
      
      public function get list() : Vector.<PlayerBillingDescription>
      {
         return _list;
      }
      
      public function get upToDate() : Boolean
      {
         return _upToDate;
      }
      
      public function get bundleData() : PlayerBillingBundleData
      {
         return _bundleData;
      }
      
      public function onRpc_checkUpdates(param1:RPCCommandBase) : void
      {
         if(param1.result.bundleUpdate && _list != null)
         {
            add(param1.result.bundleUpdate);
            _bundleData.update(param1.result.bundleUpdate.bundle);
         }
      }
      
      public function getRaidPromoBilling() : PlayerBillingDescription
      {
         var _loc2_:int = 0;
         var _loc3_:Array = [];
         var _loc1_:int = _list.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(_list[_loc2_].type == "nonPayerOneTime")
            {
               _loc3_.push(_list[_loc2_]);
            }
            _loc2_++;
         }
         if(_loc3_.length)
         {
            return _loc3_[Math.round(Math.random() * (_loc3_.length - 1))];
         }
         return null;
      }
      
      public function whenReady(param1:Function) : void
      {
         if(dict != null && _upToDate)
         {
            param1(this);
         }
         else
         {
            signal_updated.addOnce(param1);
         }
      }
      
      public function initialize(param1:Object, param2:PlatformFacade) : void
      {
         this.platform = param2;
         _update(param1);
         _bundleData.initialize(param1.bundle);
      }
      
      public function initializeLastBilling(param1:Object) : void
      {
         if(param1 && param1.info && param1.info.transactionId)
         {
            completeTransactions.push(param1.info.transactionId);
         }
      }
      
      public function hasTransaction(param1:CommandBillingGetLast) : Boolean
      {
         var _loc2_:String = param1.transactionId;
         if(_loc2_ && completeTransactions.indexOf(_loc2_) != -1)
         {
            return true;
         }
         return false;
      }
      
      public function getTransferBilling() : PlayerBillingDescription
      {
         var _loc3_:int = 0;
         var _loc2_:* = dict;
         for each(var _loc1_ in dict)
         {
            if(_loc1_.type == "serverTransfer")
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function add(param1:Object) : void
      {
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc4_:Array = param1.billings;
         var _loc5_:Array = [];
         var _loc7_:Array = _loc4_ as Array;
         var _loc3_:int = _loc7_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            if(_loc7_[_loc6_])
            {
               _loc2_ = new PlayerBillingDescription(_loc7_[_loc6_]);
               _loc2_.applyLocale();
               if(!platform.isMobile || _loc2_.productId)
               {
                  dict[_loc2_.id] = _loc2_;
                  _list.push(_loc2_);
               }
               if(_loc2_.productId)
               {
                  _loc5_.push(_loc2_.productId);
               }
            }
            _loc6_++;
         }
         if(!platform.isMobile)
         {
            whenUpdated();
         }
      }
      
      public function reset(param1:Object) : void
      {
         _update(param1);
         _bundleData.reset(param1.bundle);
      }
      
      public function buy(param1:String) : void
      {
         completeTransactions.push(param1);
         _upToDate = false;
         GameModel.instance.actionManager.playerCommands.updateBilllingsOnTransaction();
      }
      
      public function getBillingBySlot(param1:int) : PlayerBillingDescription
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function getBasicBillingBySlot(param1:int) : PlayerBillingDescription
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function getByBundleId(param1:int) : PlayerBillingDescription
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function getBySkinId(param1:int) : PlayerBillingDescription
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function getByProductId(param1:String) : PlayerBillingDescription
      {
         var _loc4_:int = 0;
         var _loc3_:* = dict;
         for each(var _loc2_ in dict)
         {
            if(_loc2_.productId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getById(param1:int) : PlayerBillingDescription
      {
         var _loc4_:int = 0;
         var _loc3_:* = dict;
         for each(var _loc2_ in dict)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getBySubscriptionId(param1:int) : PlayerBillingDescription
      {
         var _loc4_:int = 0;
         var _loc3_:* = dict;
         for each(var _loc2_ in dict)
         {
            if(_loc2_.subscriptionId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getBillingsBySlots(param1:Player, param2:int) : Vector.<PlayerBillingDescription>
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:int = _list.length;
         var _loc7_:Vector.<PlayerBillingDescription> = new Vector.<PlayerBillingDescription>();
         var _loc6_:* = param2;
         _loc7_.length = 0;
         _loc7_.length = _loc6_;
         var _loc10_:int = 0;
         var _loc9_:* = _list;
         for each(var _loc8_ in _list)
         {
            _loc5_ = _loc8_.slot;
            if(_loc5_ != 0)
            {
               if(_loc5_ > _loc6_)
               {
                  _loc6_ = _loc5_;
                  _loc7_.length = _loc6_;
               }
               _loc3_ = _loc7_[_loc5_ - 1];
               if(_loc3_ == null || _loc3_.inSlotPriority > _loc8_.inSlotPriority)
               {
                  _loc7_[_loc5_ - 1] = _loc8_;
               }
            }
         }
         if(_loc7_.length > param2)
         {
            _loc7_.sort(sort_priority);
            _loc7_.length = param2;
         }
         if(param1.vipPoints > 0)
         {
            _loc7_.sort(sort_slot_reversed);
         }
         else
         {
            _loc7_.sort(sort_slot);
         }
         return _loc7_;
      }
      
      protected function whenUpdated() : void
      {
         _upToDate = true;
         signal_updated.dispatch(this);
      }
      
      private function _update(param1:Object) : void
      {
         _list = new Vector.<PlayerBillingDescription>();
         dict = new Dictionary();
         add(param1);
      }
      
      private function sort_priority(param1:PlayerBillingDescription, param2:PlayerBillingDescription) : int
      {
         if(param1 == null || param2 == null)
         {
            return !!param1?-1:1;
         }
         return param1.priority - param2.priority;
      }
      
      private function sort_slot(param1:PlayerBillingDescription, param2:PlayerBillingDescription) : int
      {
         if(param1 == null || param2 == null)
         {
            return !!param1?-1:1;
         }
         return param1.slot - param2.slot;
      }
      
      private function sort_slot_reversed(param1:PlayerBillingDescription, param2:PlayerBillingDescription) : int
      {
         if(param1 == null || param2 == null)
         {
            return !!param1?-1:1;
         }
         return param2.slot - param1.slot;
      }
   }
}
