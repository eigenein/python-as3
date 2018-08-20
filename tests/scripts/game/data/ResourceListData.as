package game.data
{
   import com.progrestar.common.util.PropertyMapManager;
   import game.data.storage.DataStorage;
   import game.data.storage.resource.InventoryItemDescription;
   import game.model.user.inventory.FragmentInventory;
   import game.model.user.inventory.Inventory;
   import game.model.user.inventory.InventoryFragmentItem;
   import game.model.user.inventory.InventoryItem;
   
   public class ResourceListData
   {
       
      
      public var inventoryCollection:Inventory;
      
      public var fragmentCollection:FragmentInventory;
      
      public var gold:int;
      
      public var starmoney:int;
      
      public var stamina:int;
      
      public function ResourceListData(param1:Object = null)
      {
         inventoryCollection = new Inventory();
         fragmentCollection = new FragmentInventory();
         super();
         if(param1)
         {
            addRawData(param1);
         }
      }
      
      public function get outputDisplayFirst() : InventoryItem
      {
         var _loc1_:Vector.<InventoryItem> = this.outputDisplay;
         if(_loc1_.length > 0)
         {
            return _loc1_[0];
         }
         return null;
      }
      
      public function get outputDisplay() : Vector.<InventoryItem>
      {
         var _loc4_:int = 0;
         var _loc3_:Vector.<InventoryItem> = new Vector.<InventoryItem>();
         var _loc1_:Array = inventoryCollection.toArray();
         var _loc2_:int = _loc1_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_.push(_loc1_[_loc4_]);
            _loc4_++;
         }
         _loc1_ = fragmentCollection.toArray();
         _loc2_ = _loc1_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_.push(_loc1_[_loc4_]);
            _loc4_++;
         }
         if(stamina)
         {
            _loc3_.push(new InventoryItem(DataStorage.pseudo.STAMINA,stamina));
         }
         if(gold)
         {
            _loc3_.push(new InventoryItem(DataStorage.pseudo.COIN,gold));
         }
         if(starmoney)
         {
            _loc3_.push(new InventoryItem(DataStorage.pseudo.STARMONEY,starmoney));
         }
         return _loc3_;
      }
      
      public function addRawData(param1:Object) : void
      {
         gold = gold + int(param1.gold);
         stamina = stamina + int(param1.stamina);
         starmoney = starmoney + int(param1.starmoney);
         inventoryCollection.addRawData(param1);
         fragmentCollection.addRawData(param1);
      }
      
      public function add(param1:ResourceListData) : void
      {
         gold = gold + param1.gold;
         stamina = stamina + param1.stamina;
         starmoney = starmoney + param1.starmoney;
         inventoryCollection.add(param1.inventoryCollection);
         fragmentCollection.add(param1.fragmentCollection);
      }
      
      public function addItem(param1:InventoryItem) : void
      {
         if(param1 is InventoryFragmentItem)
         {
            addFragmentItem(param1.item,param1.amount);
         }
         else
         {
            addInventoryItem(param1.item,param1.amount);
         }
      }
      
      public function addInventoryItem(param1:InventoryItemDescription, param2:int) : void
      {
         inventoryCollection.addItem(param1,param2);
      }
      
      public function removeInventoryItem(param1:InventoryItemDescription, param2:int) : void
      {
         inventoryCollection.removeItem(param1,param2);
      }
      
      public function addFragmentItem(param1:InventoryItemDescription, param2:int) : void
      {
         fragmentCollection.addItem(param1,param2);
      }
      
      public function removeFragmentItem(param1:InventoryItemDescription, param2:int) : void
      {
         fragmentCollection.removeItem(param1,param2);
      }
      
      public function multiply(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:ResourceListData = clone();
         _loc3_ = 1;
         while(_loc3_ < param1)
         {
            add(_loc2_);
            _loc3_++;
         }
      }
      
      public function split() : Vector.<ResourceListData>
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc6_:int = 0;
         var _loc5_:Vector.<ResourceListData> = new Vector.<ResourceListData>();
         var _loc1_:Array = inventoryCollection.toArray();
         var _loc4_:int = _loc1_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc3_ = _createSplitEntity();
            _loc2_ = _loc1_[_loc6_];
            _loc3_.addInventoryItem(_loc2_.item,_loc2_.amount);
            _loc5_.push(_loc3_);
            _loc6_++;
         }
         _loc1_ = fragmentCollection.toArray();
         _loc4_ = _loc1_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc3_ = _createSplitEntity();
            _loc2_ = _loc1_[_loc6_];
            _loc3_.addFragmentItem(_loc2_.item,_loc2_.amount);
            _loc5_.push(_loc3_);
            _loc6_++;
         }
         if(stamina)
         {
            _loc3_ = _createSplitEntity();
            _loc3_.stamina = stamina;
            _loc5_.push(_loc3_);
         }
         if(gold)
         {
            _loc3_ = _createSplitEntity();
            _loc3_.gold = gold;
            _loc5_.push(_loc3_);
         }
         if(starmoney)
         {
            _loc3_ = _createSplitEntity();
            _loc3_.starmoney = starmoney;
            _loc5_.push(_loc3_);
         }
         return _loc5_;
      }
      
      protected function _createSplitEntity() : ResourceListData
      {
         return new ResourceListData();
      }
      
      public function get isEmpty() : Boolean
      {
         return outputDisplay.length == 0;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "";
         if(gold)
         {
            _loc1_ = _loc1_ + ("gold " + gold + "\n");
         }
         if(stamina)
         {
            _loc1_ = _loc1_ + ("stamina " + stamina + "\n");
         }
         if(starmoney)
         {
            _loc1_ = _loc1_ + ("starmoney " + starmoney + "\n");
         }
         _loc1_ = _loc1_ + inventoryCollection.toString();
         _loc1_ = _loc1_ + fragmentCollection.toString();
         return _loc1_;
      }
      
      public function serialize() : Object
      {
         var _loc1_:Object = {};
         _loc1_ = PropertyMapManager.merge(_loc1_,inventoryCollection.serialize());
         _loc1_ = PropertyMapManager.merge(_loc1_,fragmentCollection.serialize());
         return _loc1_;
      }
      
      public function clone() : ResourceListData
      {
         var _loc1_:ResourceListData = _createSplitEntity();
         _loc1_.gold = _loc1_.gold + gold;
         _loc1_.starmoney = _loc1_.starmoney + starmoney;
         _loc1_.stamina = _loc1_.stamina + stamina;
         _loc1_.inventoryCollection = inventoryCollection.clone();
         _loc1_.fragmentCollection = fragmentCollection.clone() as FragmentInventory;
         return _loc1_;
      }
   }
}
