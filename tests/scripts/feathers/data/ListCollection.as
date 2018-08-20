package feathers.data
{
   import starling.events.EventDispatcher;
   
   [Event(name="change",type="starling.events.Event")]
   [Event(name="reset",type="starling.events.Event")]
   [Event(name="addItem",type="starling.events.Event")]
   [Event(name="removeItem",type="starling.events.Event")]
   [Event(name="replaceItem",type="starling.events.Event")]
   [Event(name="updateItem",type="starling.events.Event")]
   public class ListCollection extends EventDispatcher
   {
       
      
      protected var _data:Object;
      
      protected var _dataDescriptor:IListCollectionDataDescriptor;
      
      public function ListCollection(param1:Object = null)
      {
         super();
         if(!param1)
         {
            param1 = [];
         }
         this.data = param1;
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function set data(param1:Object) : void
      {
         if(this._data == param1)
         {
            return;
         }
         if(!param1)
         {
            this.removeAll();
            return;
         }
         this._data = param1;
         if(this._data is Array)
         {
            if(!(this._dataDescriptor is ArrayListCollectionDataDescriptor))
            {
               this.dataDescriptor = new ArrayListCollectionDataDescriptor();
            }
         }
         else if(this._data is Vector.<*>)
         {
            if(!(this._dataDescriptor is VectorListCollectionDataDescriptor))
            {
               this.dataDescriptor = new VectorListCollectionDataDescriptor();
            }
         }
         else if(this._data is Vector.<Number>)
         {
            if(!(this._dataDescriptor is VectorNumberListCollectionDataDescriptor))
            {
               this.dataDescriptor = new VectorNumberListCollectionDataDescriptor();
            }
         }
         else if(this._data is Vector.<int>)
         {
            if(!(this._dataDescriptor is VectorIntListCollectionDataDescriptor))
            {
               this.dataDescriptor = new VectorIntListCollectionDataDescriptor();
            }
         }
         else if(this._data is Vector.<uint>)
         {
            if(!(this._dataDescriptor is VectorUintListCollectionDataDescriptor))
            {
               this.dataDescriptor = new VectorUintListCollectionDataDescriptor();
            }
         }
         else if(this._data is XMLList)
         {
            if(!(this._dataDescriptor is XMLListListCollectionDataDescriptor))
            {
               this.dataDescriptor = new XMLListListCollectionDataDescriptor();
            }
         }
         this.dispatchEventWith("reset");
         this.dispatchEventWith("change");
      }
      
      public function get dataDescriptor() : IListCollectionDataDescriptor
      {
         return this._dataDescriptor;
      }
      
      public function set dataDescriptor(param1:IListCollectionDataDescriptor) : void
      {
         if(this._dataDescriptor == param1)
         {
            return;
         }
         this._dataDescriptor = param1;
         this.dispatchEventWith("reset");
         this.dispatchEventWith("change");
      }
      
      public function get length() : int
      {
         return this._dataDescriptor.getLength(this._data);
      }
      
      public function updateItemAt(param1:int) : void
      {
         this.dispatchEventWith("updateItem",false,param1);
      }
      
      public function getItemAt(param1:int) : Object
      {
         return this._dataDescriptor.getItemAt(this._data,param1);
      }
      
      public function getItemIndex(param1:Object) : int
      {
         return this._dataDescriptor.getItemIndex(this._data,param1);
      }
      
      public function addItemAt(param1:Object, param2:int) : void
      {
         this._dataDescriptor.addItemAt(this._data,param1,param2);
         this.dispatchEventWith("change");
         this.dispatchEventWith("addItem",false,param2);
      }
      
      public function removeItemAt(param1:int) : Object
      {
         var _loc2_:Object = this._dataDescriptor.removeItemAt(this._data,param1);
         this.dispatchEventWith("change");
         this.dispatchEventWith("removeItem",false,param1);
         return _loc2_;
      }
      
      public function removeItem(param1:Object) : void
      {
         var _loc2_:int = this.getItemIndex(param1);
         if(_loc2_ >= 0)
         {
            this.removeItemAt(_loc2_);
         }
      }
      
      public function removeAll() : void
      {
         if(this.length == 0)
         {
            return;
         }
         this._dataDescriptor.removeAll(this._data);
         this.dispatchEventWith("change");
         this.dispatchEventWith("reset",false);
      }
      
      public function setItemAt(param1:Object, param2:int) : void
      {
         this._dataDescriptor.setItemAt(this._data,param1,param2);
         this.dispatchEventWith("change");
         this.dispatchEventWith("replaceItem",false,param2);
      }
      
      public function addItem(param1:Object) : void
      {
         this.addItemAt(param1,this.length);
      }
      
      public function push(param1:Object) : void
      {
         this.addItemAt(param1,this.length);
      }
      
      public function addAll(param1:ListCollection) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = param1.getItemAt(_loc4_);
            this.addItem(_loc2_);
            _loc4_++;
         }
      }
      
      public function addAllAt(param1:ListCollection, param2:int) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:int = param1.length;
         var _loc6_:* = param2;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = param1.getItemAt(_loc5_);
            this.addItemAt(_loc3_,_loc6_);
            _loc6_++;
            _loc5_++;
         }
      }
      
      public function pop() : Object
      {
         return this.removeItemAt(this.length - 1);
      }
      
      public function unshift(param1:Object) : void
      {
         this.addItemAt(param1,0);
      }
      
      public function shift() : Object
      {
         return this.removeItemAt(0);
      }
      
      public function contains(param1:Object) : Boolean
      {
         return this.getItemIndex(param1) >= 0;
      }
      
      public function dispose(param1:Function) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc4_:int = this.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = this.getItemAt(_loc3_);
            param1(_loc2_);
            _loc3_++;
         }
      }
   }
}
