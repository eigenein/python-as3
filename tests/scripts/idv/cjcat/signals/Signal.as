package idv.cjcat.signals
{
   import flash.utils.Dictionary;
   
   public class Signal implements ISignal
   {
      
      private static const DEFAULT_ARRAY_SIZE:int = 4;
       
      
      private var _listenerArray:Array;
      
      private var _clearAfterDispatch:Boolean;
      
      private var _listenerDictionary:Dictionary;
      
      private var _index:int;
      
      private var _valueClasses:Array;
      
      private var _arrayDirty:Boolean;
      
      private var _isDispatching:Boolean;
      
      private var _listenerArrayNeedsCloning:Boolean;
      
      private var _diff:Number;
      
      private var _currentListenerArray:Array;
      
      private var _currentIndex:int;
      
      public function Signal(... rest)
      {
         super();
         this._valueClasses = rest;
         this._currentListenerArray = this._listenerArray = new Array(DEFAULT_ARRAY_SIZE);
         this._index = 0;
         this._listenerDictionary = new Dictionary();
         this._isDispatching = false;
         this._listenerArrayNeedsCloning = false;
         this._clearAfterDispatch = false;
      }
      
      public final function addOnce(param1:Function, param2:int = 0) : Function
      {
         this.add(param1,param2);
         ListenerData(this._listenerDictionary[param1]).once = true;
         return param1;
      }
      
      public final function remove(param1:Function) : Function
      {
         var _loc2_:ListenerData = this._listenerDictionary[param1];
         if(this._listenerArrayNeedsCloning)
         {
            this._listenerArray = this._listenerArray.concat();
            this._listenerArrayNeedsCloning = false;
         }
         if(_loc2_)
         {
            this._listenerArray[ListenerData(this._listenerDictionary[param1]).index] = this._listenerArray[--this._index];
            this._listenerArray[this._index] = null;
            delete this._listenerDictionary[param1];
            this._arrayDirty = true;
         }
         return param1;
      }
      
      public function get listeners() : Array
      {
         if(this._listenerArrayNeedsCloning)
         {
            this._listenerArray = this._listenerArray.concat();
            this._listenerArrayNeedsCloning = false;
         }
         if(this._arrayDirty)
         {
            this.sortListeners();
         }
         var _loc1_:Array = !!this._isDispatching?this._currentListenerArray.slice(0,this._currentIndex):this._listenerArray.slice(0,this._index);
         var _loc2_:int = 0;
         var _loc3_:int = _loc1_.length;
         while(_loc2_ < _loc3_)
         {
            _loc1_[_loc2_] = ListenerData(_loc1_[_loc2_]).listener;
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function sortListeners() : void
      {
         this._listenerArray.sort(this.prioritySorter);
         var _loc1_:int = 0;
         while(_loc1_ < this._index)
         {
            ListenerData(this._listenerArray[_loc1_]).index = _loc1_;
            _loc1_++;
         }
         this._arrayDirty = false;
      }
      
      public function getPriority(param1:Function) : Number
      {
         if(this._listenerDictionary[param1])
         {
            return ListenerData(this._listenerDictionary[param1]).priority;
         }
         return NaN;
      }
      
      public final function clear() : void
      {
         var _loc1_:* = undefined;
         if(this._listenerArrayNeedsCloning)
         {
            this._clearAfterDispatch = true;
         }
         else
         {
            this._currentListenerArray = this._listenerArray = new Array(DEFAULT_ARRAY_SIZE);
            this._index = 0;
            for(_loc1_ in this._listenerDictionary)
            {
               delete this._listenerDictionary[_loc1_];
            }
         }
      }
      
      private function prioritySorter(param1:ListenerData, param2:ListenerData) : Number
      {
         if(param2)
         {
            if(param1)
            {
               return !!(this._diff = param2.priority - param1.priority)?Number(this._diff):Number(param1.index - param2.index);
            }
            return 1;
         }
         if(param1)
         {
            return -1;
         }
         return 0;
      }
      
      public final function add(param1:Function, param2:int = 0) : Function
      {
         if(param1.length < this._valueClasses.length)
         {
            throw new ArgumentError("Listener has " + param1.length + " " + (param1.length == 1?"argument":"arguments") + " but it needs at least " + this._valueClasses.length + ".");
         }
         if(this._listenerArrayNeedsCloning)
         {
            this._listenerArray = this._listenerArray.concat();
            this._listenerArrayNeedsCloning = false;
         }
         var _loc3_:ListenerData = this._listenerDictionary[param1];
         if(_loc3_)
         {
            _loc3_.priority = param2;
            _loc3_.once = false;
         }
         else
         {
            _loc3_ = new ListenerData(param1,param2,false);
            this._listenerDictionary[param1] = _loc3_;
         }
         this._listenerArray[this._index] = _loc3_;
         _loc3_.index = this._index;
         if(++this._index == this._listenerArray.length)
         {
            this._listenerArray.length = this._listenerArray.length * 2;
         }
         this._arrayDirty = true;
         return param1;
      }
      
      public final function dispatch(... rest) : Signal
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ListenerData = null;
         if(rest.length != this._valueClasses.length)
         {
            throw new ArgumentError("Incorrect number of arguments. Expected " + this._valueClasses.length + " but was " + rest.length);
         }
         _loc2_ = 0;
         _loc3_ = rest.length;
         while(_loc2_ < _loc3_)
         {
            if(!(rest[_loc2_] is this._valueClasses[_loc2_]))
            {
               throw new ArgumentError("Incorrect argument type. Expected " + this._valueClasses[_loc2_] + " but was " + rest[_loc2_]);
            }
            _loc2_++;
         }
         if(this._arrayDirty)
         {
            this.sortListeners();
         }
         this._isDispatching = true;
         this._listenerArrayNeedsCloning = true;
         this._currentListenerArray = this._listenerArray;
         this._currentIndex = this._index;
         _loc2_ = 0;
         while(_loc2_ < this._currentIndex)
         {
            _loc4_ = this._currentListenerArray[_loc2_];
            _loc4_.listener.apply(null,rest);
            if(_loc4_.once)
            {
               this.remove(_loc4_.listener);
            }
            _loc2_++;
         }
         this._isDispatching = false;
         this._listenerArrayNeedsCloning = false;
         this._currentListenerArray = this._listenerArray;
         this._currentIndex = this._index;
         if(this._clearAfterDispatch)
         {
            this.clear();
            this._clearAfterDispatch = false;
         }
         return this;
      }
      
      public function get valueClasses() : Array
      {
         return this._valueClasses.concat();
      }
   }
}
