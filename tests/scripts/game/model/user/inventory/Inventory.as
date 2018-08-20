package game.model.user.inventory
{
   import flash.utils.Dictionary;
   import game.data.storage.DataStorage;
   import game.data.storage.enum.lib.InventoryItemType;
   import game.data.storage.loot.LootBoxRewardDescription;
   import game.data.storage.loot.LootBoxRewardGroupDescription;
   import game.data.storage.resource.InventoryItemDescription;
   import idv.cjcat.signals.Signal;
   
   public class Inventory
   {
       
      
      protected var collections:Dictionary;
      
      private var _updateSignal:Signal;
      
      public function Inventory()
      {
         super();
      }
      
      protected function get TYPE_LIST() : Vector.<InventoryItemType>
      {
         return InventoryItemType.TYPE_LIST;
      }
      
      private function collectionUpdateHandler(param1:InventoryItem) : void
      {
         if(_updateSignal)
         {
            _updateSignal.dispatch(param1);
         }
      }
      
      public function get updateSignal() : Signal
      {
         if(!_updateSignal)
         {
            _updateSignal = new Signal(InventoryItem);
            var _loc3_:int = 0;
            var _loc2_:* = collections;
            for each(var _loc1_ in collections)
            {
               _loc1_.updateSignal.add(collectionUpdateHandler);
            }
         }
         return _updateSignal;
      }
      
      public function serialize() : Object
      {
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc8_:* = null;
         var _loc1_:* = null;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:* = null;
         var _loc5_:Object = {};
         var _loc3_:int = TYPE_LIST.length;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc4_ = TYPE_LIST[_loc6_];
            _loc8_ = getCollectionByType(_loc4_);
            _loc1_ = _loc8_.getArray();
            _loc9_ = _loc1_.length;
            if(_loc9_)
            {
               _loc5_[_loc4_.type] = {};
               _loc7_ = 0;
               while(_loc7_ < _loc9_)
               {
                  _loc2_ = _loc1_[_loc7_] as InventoryItem;
                  _loc5_[_loc4_.type][_loc2_.id] = _loc2_.amount;
                  _loc7_++;
               }
            }
            _loc6_++;
         }
         return _loc5_;
      }
      
      public function getCollectionByType(param1:InventoryItemType) : InventoryCollection
      {
         if(collections == null)
         {
            collections = new Dictionary();
         }
         if(collections[param1] == null)
         {
            if(TYPE_LIST.indexOf(param1) == -1)
            {
               trace("Invalid InventoryItemType " + param1.type + " in Inventory.getCollectionByType");
            }
            collections[param1] = new InventoryCollection();
         }
         return collections[param1];
      }
      
      public function getInventoryItemType(param1:String) : InventoryItemType
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < TYPE_LIST.length)
         {
            if(TYPE_LIST[_loc2_].type == param1)
            {
               return TYPE_LIST[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function addItem(param1:InventoryItemDescription, param2:int) : void
      {
         getCollectionByType(param1.type).addItem(param1,param2);
      }
      
      public function removeItem(param1:InventoryItemDescription, param2:int) : void
      {
         getCollectionByType(param1.type).disposeItem(param1,param2);
      }
      
      public function hasItem(param1:InventoryItemDescription, param2:int = 1) : Boolean
      {
         var _loc3_:InventoryCollection = getCollectionByType(param1.type);
         return _loc3_ && _loc3_.getItemCount(param1) >= param2;
      }
      
      public function getItemCount(param1:InventoryItemDescription) : int
      {
         return getCollectionByType(param1.type).getItemCount(param1);
      }
      
      public function getItem(param1:InventoryItemDescription) : InventoryItem
      {
         return getCollectionByType(param1.type).getItem(param1);
      }
      
      public function addRawData(param1:Object) : void
      {
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc9_:int = 0;
         var _loc8_:* = TYPE_LIST;
         for each(var _loc4_ in TYPE_LIST)
         {
            _loc5_ = param1[_loc4_.type];
            if(_loc5_)
            {
               var _loc7_:int = 0;
               var _loc6_:* = _loc5_;
               for(var _loc3_ in _loc5_)
               {
                  _loc2_ = _loc4_.storage.getById(_loc3_) as InventoryItemDescription;
                  if(_loc2_ == null)
                  {
                     throw new ArgumentError("Undefined inventory item: " + (this is FragmentInventory?"fragment ":" ") + _loc4_.type + ":" + _loc3_);
                  }
                  addItem(_loc2_,_loc5_[_loc3_]);
               }
               continue;
            }
         }
         if(param1.lootBoxRewardGroup)
         {
            addLootBoxGroupRawData(param1.lootBoxRewardGroup);
         }
      }
      
      private function addLootBoxGroupRawData(param1:Object) : void
      {
         var _loc7_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = 0;
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc11_:int = 0;
         var _loc10_:* = param1;
         for(var _loc9_ in param1)
         {
            _loc7_ = DataStorage.lootBoxRewardGroup.getByIdent(_loc9_);
            if(_loc7_)
            {
               _loc4_ = uint(param1[_loc9_]);
               _loc8_ = 0;
               while(_loc8_ < _loc4_)
               {
                  _loc5_ = 0;
                  while(_loc5_ < _loc7_.reward.length)
                  {
                     _loc3_ = _loc7_.reward[_loc5_];
                     if(_loc3_)
                     {
                        _loc6_ = 0;
                        while(_loc6_ < _loc3_.ids.length)
                        {
                           _loc2_ = getInventoryItemType(_loc3_.type);
                           if(_loc2_)
                           {
                              addItem(_loc2_.storage.getById(_loc3_.ids[_loc6_]) as InventoryItemDescription,_loc3_.amount);
                           }
                           _loc6_++;
                        }
                     }
                     _loc5_++;
                  }
                  _loc8_++;
               }
               continue;
            }
         }
      }
      
      public function getInsufficient(param1:Inventory) : Inventory
      {
         var _loc2_:Inventory = clone();
         var _loc5_:int = 0;
         var _loc4_:* = TYPE_LIST;
         for each(var _loc3_ in TYPE_LIST)
         {
            _loc2_.getCollectionByType(_loc3_).getInsufficientItems(param1.getCollectionByType(_loc3_));
         }
         return _loc2_;
      }
      
      public function contains(param1:Inventory) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:* = TYPE_LIST;
         for each(var _loc2_ in TYPE_LIST)
         {
            if(!getCollectionByType(_loc2_).contains(param1.getCollectionByType(_loc2_)))
            {
               return false;
            }
         }
         return true;
      }
      
      public function subtract(param1:Inventory) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = TYPE_LIST;
         for each(var _loc2_ in TYPE_LIST)
         {
            getCollectionByType(_loc2_).subtractCollection(param1.getCollectionByType(_loc2_));
         }
      }
      
      public function add(param1:Inventory) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc5_:int = 0;
         var _loc4_:* = TYPE_LIST;
         for each(var _loc3_ in TYPE_LIST)
         {
            if(collections != null && collections[_loc3_] != null || param1.collections != null && param1.collections[_loc3_] != null)
            {
               if(getCollectionByType(_loc3_).addCollection(param1.getCollectionByType(_loc3_)))
               {
                  _loc2_ = true;
               }
            }
         }
         return _loc2_;
      }
      
      public function clone() : Inventory
      {
         var _loc1_:Inventory = new Inventory();
         var _loc4_:int = 0;
         var _loc3_:* = TYPE_LIST;
         for each(var _loc2_ in TYPE_LIST)
         {
            if(collections != null && collections[_loc2_] != null)
            {
               _loc1_.getCollectionByType(_loc2_).addCollection(getCollectionByType(_loc2_));
            }
         }
         return _loc1_;
      }
      
      public function get isEmpty() : Boolean
      {
         if(collections == null)
         {
            return true;
         }
         var _loc3_:int = 0;
         var _loc2_:* = TYPE_LIST;
         for each(var _loc1_ in TYPE_LIST)
         {
            if(!getCollectionByType(_loc1_).isEmpty())
            {
               return false;
            }
         }
         return true;
      }
      
      public function toArray() : Array
      {
         var _loc1_:Array = [];
         if(collections == null)
         {
            return _loc1_;
         }
         var _loc4_:int = 0;
         var _loc3_:* = TYPE_LIST;
         for each(var _loc2_ in TYPE_LIST)
         {
            _loc1_ = _loc1_.concat(getCollectionByType(_loc2_).getArray());
         }
         return _loc1_;
      }
      
      public function toString() : String
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc7_:* = null;
         var _loc1_:* = null;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:String = "";
         var _loc3_:int = TYPE_LIST.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = TYPE_LIST[_loc5_];
            _loc7_ = getCollectionByType(_loc4_);
            _loc1_ = _loc7_.getArray();
            _loc8_ = _loc1_.length;
            if(_loc8_)
            {
               _loc2_ = _loc2_ + (_loc4_.type + "\n");
               _loc6_ = 0;
               while(_loc6_ < _loc8_)
               {
                  _loc2_ = _loc2_ + ("\t" + (_loc1_[_loc6_] as InventoryItem).toString() + "\n");
                  _loc6_++;
               }
               _loc2_ = _loc2_ + "--\n";
            }
            _loc5_++;
         }
         return _loc2_;
      }
   }
}
