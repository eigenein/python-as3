package game.model.user.inventory
{
   import flash.utils.Dictionary;
   import game.data.storage.DescriptionBase;
   import game.data.storage.resource.InventoryItemDescription;
   import idv.cjcat.signals.Signal;
   
   public class InventoryCollection
   {
       
      
      private var _updateSignal:Signal;
      
      private var _updateCountSignal:Signal;
      
      protected var _arr:Array;
      
      protected var dict:Dictionary;
      
      public function InventoryCollection()
      {
         super();
         dict = new Dictionary();
         _arr = [];
      }
      
      public function get updateSignal() : Signal
      {
         if(!_updateSignal)
         {
            _updateSignal = new Signal(InventoryItem);
         }
         return _updateSignal;
      }
      
      public function get updateCountSignal() : Signal
      {
         if(!_updateCountSignal)
         {
            _updateCountSignal = new Signal(InventoryItem);
         }
         return _updateCountSignal;
      }
      
      public function set array(param1:Dictionary) : void
      {
         dict = param1;
         _arr = _getArray();
      }
      
      public function getArray() : Array
      {
         return _arr;
      }
      
      protected function _getArray() : Array
      {
         var _loc1_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = dict;
         for(var _loc2_ in dict)
         {
            _loc1_.push(dict[_loc2_]);
         }
         return _loc1_;
      }
      
      public function disposeItem(param1:DescriptionBase, param2:Number = -1) : Boolean
      {
         var _loc3_:* = null;
         if(dict[param1.id])
         {
            _loc3_ = dict[param1.id] as InventoryItem;
            if(_loc3_.amount < param2)
            {
               return false;
            }
            if(param2 == -1)
            {
               _loc3_.amount = 0;
            }
            else
            {
               _loc3_.amount = _loc3_.amount - param2;
            }
            if(_loc3_.amount == 0)
            {
               delete dict[param1.id];
               _arr.splice(_arr.indexOf(_loc3_),1);
               if(_updateSignal)
               {
                  updateSignal.dispatch(_loc3_);
               }
            }
            else
            {
               updateCountSignal.dispatch(_loc3_);
            }
            return true;
         }
         return false;
      }
      
      public function hasEnough(param1:DescriptionBase, param2:Number = 1) : Boolean
      {
         var _loc3_:* = null;
         if(param1)
         {
            _loc3_ = dict[param1.id] as InventoryItem;
         }
         return _loc3_ && _loc3_.amount >= param2;
      }
      
      protected function _addItem_createNewItem(param1:InventoryItemDescription, param2:Number) : InventoryItem
      {
         return new InventoryItem(param1,param2);
      }
      
      public function addItem(param1:InventoryItemDescription, param2:Number = 1) : Boolean
      {
         var _loc3_:* = null;
         if(param1)
         {
            _loc3_ = dict[param1.id] as InventoryItem;
            if(_loc3_)
            {
               _loc3_.amount = _loc3_.amount + param2;
               updateCountSignal.dispatch(_loc3_);
            }
            else
            {
               _loc3_ = _addItem_createNewItem(param1,param2);
               dict[param1.id] = _loc3_;
               _arr.push(dict[param1.id]);
               if(_updateSignal)
               {
                  updateSignal.dispatch(_loc3_);
               }
            }
            return true;
         }
         return false;
      }
      
      public function setItem(param1:InventoryItemDescription, param2:Number = 1) : void
      {
         var _loc3_:* = null;
         if(param1)
         {
            _loc3_ = dict[param1.id] as InventoryItem;
            if(_loc3_)
            {
               _loc3_.amount = param2;
            }
            else
            {
               dict[param1.id] = _addItem_createNewItem(param1,param2);
               _arr.push(dict[param1.id]);
            }
         }
      }
      
      public function getItem(param1:InventoryItemDescription) : InventoryItem
      {
         var _loc2_:InventoryItem = dict[param1.id];
         return _loc2_;
      }
      
      public function getItemById(param1:int) : InventoryItem
      {
         var _loc2_:InventoryItem = dict[param1];
         return _loc2_;
      }
      
      public function clear(param1:Boolean = false) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function isEmpty() : Boolean
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc1_:Array = getArray();
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_] as InventoryItem;
            if(_loc3_.amount > 0)
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      public function getItemCount(param1:DescriptionBase) : Number
      {
         if(!param1)
         {
            return 0;
         }
         var _loc2_:InventoryItem = dict[param1.id] as InventoryItem;
         return !!_loc2_?_loc2_.amount:0;
      }
      
      public function toString() : String
      {
         var _loc2_:* = null;
         var _loc1_:String = "";
         var _loc5_:int = 0;
         var _loc4_:* = dict;
         for(var _loc3_ in dict)
         {
            _loc2_ = dict[_loc3_];
            _loc1_ = _loc1_ + ("[" + _loc2_.item.id + ":" + _loc2_.amount + "] ");
         }
         return _loc1_;
      }
      
      public function addCollection(param1:InventoryCollection) : Boolean
      {
         var _loc5_:* = null;
         var _loc4_:int = 0;
         if(!param1)
         {
            return false;
         }
         var _loc2_:Boolean = false;
         var _loc3_:Array = param1.getArray();
         if(_loc3_)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _loc5_ = _loc3_[_loc4_] as InventoryItem;
               if(_loc5_ && _loc5_.amount)
               {
                  addItem(_loc5_.item,_loc5_.amount);
                  _loc2_ = true;
               }
               _loc4_++;
            }
         }
         return _loc2_;
      }
      
      public function setCollection(param1:InventoryCollection) : void
      {
         var _loc4_:* = null;
         var _loc3_:int = 0;
         if(!param1)
         {
            return;
         }
         clear(true);
         var _loc2_:Array = param1.getArray();
         if(_loc2_)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc4_ = _loc2_[_loc3_] as InventoryItem;
               if(_loc4_)
               {
                  setItem(_loc4_.item,_loc4_.amount);
               }
               _loc3_++;
            }
         }
      }
      
      public function subtractCollection(param1:InventoryCollection, param2:Boolean = false) : void
      {
         var _loc4_:* = null;
         var _loc7_:* = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         if(!param1)
         {
            return;
         }
         var _loc6_:Array = param1.getArray();
         if(_loc6_)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc6_.length)
            {
               _loc4_ = _loc6_[_loc3_] as InventoryItem;
               if(_loc4_)
               {
                  _loc7_ = int(_loc4_.amount);
                  if(param2)
                  {
                     _loc5_ = getItemCount(_loc4_.item);
                     if(_loc4_.amount > _loc5_)
                     {
                        _loc7_ = _loc5_;
                     }
                  }
                  disposeItem(_loc4_.item,_loc7_);
               }
               _loc3_++;
            }
         }
      }
      
      public function getInsufficientItems(param1:InventoryCollection) : void
      {
         var _loc4_:* = null;
         var _loc2_:int = 0;
         var _loc5_:* = null;
         var _loc3_:int = 0;
         if(!param1)
         {
            return;
         }
         var _loc6_:Array = getArray().slice();
         if(_loc6_)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc6_.length)
            {
               _loc4_ = _loc6_[_loc2_] as InventoryItem;
               _loc5_ = param1.getItem(_loc4_.item);
               if(_loc5_)
               {
                  _loc3_ = Math.min(_loc5_.amount,_loc4_.amount);
                  disposeItem(_loc5_.item,_loc3_);
               }
               _loc2_++;
            }
         }
      }
      
      public function getLength() : Number
      {
         var _loc3_:int = 0;
         var _loc2_:* = 0;
         var _loc1_:Array = getArray();
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = Number(_loc2_ + (_loc1_[_loc3_] as InventoryItem).amount);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getUniqueElementsAmount() : int
      {
         var _loc1_:int = 0;
         if(_arr)
         {
            _loc1_ = _arr.length;
         }
         return _loc1_;
      }
      
      public function isEqual(param1:InventoryCollection) : Boolean
      {
         var _loc7_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         if(!param1)
         {
            return false;
         }
         var _loc3_:int = getUniqueElementsAmount();
         var _loc4_:int = param1.getUniqueElementsAmount();
         if(_loc3_ > _loc4_)
         {
            _loc7_ = this;
            _loc5_ = param1;
         }
         else
         {
            _loc7_ = param1;
            _loc5_ = this;
         }
         if(_loc7_.dict && _loc5_.dict)
         {
            var _loc9_:int = 0;
            var _loc8_:* = _loc7_.dict;
            for each(var _loc2_ in _loc7_.dict)
            {
               _loc6_ = _loc5_.dict[_loc2_.id];
               if(!_loc6_ || _loc2_.amount != _loc6_.amount)
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      public function contains(param1:InventoryCollection) : Boolean
      {
         var _loc5_:* = null;
         var _loc2_:* = null;
         if(param1 == null)
         {
            return false;
         }
         var _loc3_:int = getUniqueElementsAmount();
         var _loc4_:int = param1.getUniqueElementsAmount();
         if(_loc3_ >= _loc4_)
         {
            var _loc7_:int = 0;
            var _loc6_:* = param1.dict;
            for each(_loc2_ in param1.dict)
            {
               _loc5_ = dict[_loc2_.id];
               if(_loc5_ == null || _loc2_.amount > _loc5_.amount)
               {
                  return false;
               }
            }
            return true;
         }
         return false;
      }
   }
}
