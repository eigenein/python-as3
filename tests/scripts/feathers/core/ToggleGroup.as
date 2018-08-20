package feathers.core
{
   import flash.errors.IllegalOperationError;
   import starling.events.Event;
   import starling.events.EventDispatcher;
   
   [Event(name="change",type="starling.events.Event")]
   public class ToggleGroup extends EventDispatcher
   {
       
      
      protected var _items:Vector.<IToggle>;
      
      protected var _ignoreChanges:Boolean = false;
      
      protected var _isSelectionRequired:Boolean = true;
      
      protected var _selectedIndex:int = -1;
      
      public function ToggleGroup()
      {
         _items = new Vector.<IToggle>();
         super();
      }
      
      public function get isSelectionRequired() : Boolean
      {
         return this._isSelectionRequired;
      }
      
      public function set isSelectionRequired(param1:Boolean) : void
      {
         if(this._isSelectionRequired == param1)
         {
            return;
         }
         this._isSelectionRequired = param1;
         if(this._isSelectionRequired && this._selectedIndex < 0 && this._items.length > 0)
         {
            this.selectedIndex = 0;
         }
      }
      
      public function get selectedItem() : IToggle
      {
         if(this._selectedIndex < 0)
         {
            return null;
         }
         return this._items[this._selectedIndex];
      }
      
      public function set selectedItem(param1:IToggle) : void
      {
         this.selectedIndex = this._items.indexOf(param1);
      }
      
      public function get selectedIndex() : int
      {
         return this._selectedIndex;
      }
      
      public function set selectedIndex(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc5_:int = this._items.length;
         if(param1 < -1 || param1 >= _loc5_)
         {
            throw new RangeError("Index " + param1 + " is out of range " + _loc5_ + " for ToggleGroup.");
         }
         var _loc3_:* = this._selectedIndex != param1;
         this._selectedIndex = param1;
         this._ignoreChanges = true;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc2_ = this._items[_loc4_];
            _loc2_.isSelected = _loc4_ == param1;
            _loc4_++;
         }
         this._ignoreChanges = false;
         if(_loc3_)
         {
            this.dispatchEventWith("change");
         }
      }
      
      public function addItem(param1:IToggle) : void
      {
         if(!param1)
         {
            throw new ArgumentError("IToggle passed to ToggleGroup addItem() must not be null.");
         }
         var _loc2_:int = this._items.indexOf(param1);
         if(_loc2_ >= 0)
         {
            throw new IllegalOperationError("Cannot add an item to a ToggleGroup more than once.");
         }
         this._items.push(param1);
         if(this._selectedIndex < 0 && this._isSelectionRequired)
         {
            this.selectedItem = param1;
         }
         else
         {
            param1.isSelected = false;
         }
         param1.addEventListener("change",item_changeHandler);
         if(param1 is IGroupedToggle)
         {
            IGroupedToggle(param1).toggleGroup = this;
         }
      }
      
      public function removeItem(param1:IToggle) : void
      {
         var _loc2_:int = this._items.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         this._items.splice(_loc2_,1);
         param1.removeEventListener("change",item_changeHandler);
         if(param1 is IGroupedToggle)
         {
            IGroupedToggle(param1).toggleGroup = null;
         }
         if(this._selectedIndex >= this._items.length)
         {
            if(this._isSelectionRequired)
            {
               this.selectedIndex = this._items.length - 1;
            }
            else
            {
               this.selectedIndex = -1;
            }
         }
      }
      
      public function removeAllItems() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         var _loc3_:int = this._items.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc1_ = this._items.shift();
            _loc1_.removeEventListener("change",item_changeHandler);
            if(_loc1_ is IGroupedToggle)
            {
               IGroupedToggle(_loc1_).toggleGroup = null;
            }
            _loc2_++;
         }
         this.selectedIndex = -1;
      }
      
      public function hasItem(param1:IToggle) : Boolean
      {
         var _loc2_:int = this._items.indexOf(param1);
         return _loc2_ >= 0;
      }
      
      public function getItemIndex(param1:IToggle) : int
      {
         return this._items.indexOf(param1);
      }
      
      public function setItemIndex(param1:IToggle, param2:int) : void
      {
         var _loc3_:int = this._items.indexOf(param1);
         if(_loc3_ < 0)
         {
            throw new ArgumentError("Attempting to set index of an item that has not been added to this ToggleGroup.");
         }
         if(_loc3_ == param2)
         {
            return;
         }
         this._items.splice(_loc3_,1);
         this._items.splice(param2,0,param1);
         if(this._selectedIndex >= 0)
         {
            if(this._selectedIndex == _loc3_)
            {
               this.selectedIndex = param2;
            }
            else if(_loc3_ < this._selectedIndex && param2 > this._selectedIndex)
            {
               this.selectedIndex--;
            }
            else if(_loc3_ > this._selectedIndex && param2 < this._selectedIndex)
            {
               this.selectedIndex++;
            }
         }
      }
      
      protected function item_changeHandler(param1:Event) : void
      {
         if(this._ignoreChanges)
         {
            return;
         }
         var _loc2_:IToggle = IToggle(param1.currentTarget);
         var _loc3_:int = this._items.indexOf(_loc2_);
         if(_loc2_.isSelected || this._isSelectionRequired && this._selectedIndex == _loc3_)
         {
            this.selectedIndex = _loc3_;
         }
         else if(!_loc2_.isSelected)
         {
            this.selectedIndex = -1;
         }
      }
   }
}
