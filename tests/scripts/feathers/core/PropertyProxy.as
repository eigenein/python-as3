package feathers.core
{
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   
   public final dynamic class PropertyProxy extends Proxy
   {
       
      
      private var _subProxyName:String;
      
      private var _onChangeCallbacks:Vector.<Function>;
      
      private var _names:Array;
      
      private var _storage:Object;
      
      public function PropertyProxy(param1:Function = null)
      {
         _onChangeCallbacks = new Vector.<Function>(0);
         _names = [];
         _storage = {};
         super();
         if(param1 != null)
         {
            this._onChangeCallbacks[this._onChangeCallbacks.length] = param1;
         }
      }
      
      public static function fromObject(param1:Object, param2:Function = null) : PropertyProxy
      {
         var _loc3_:PropertyProxy = fromEmpty(param2);
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for(var _loc4_ in param1)
         {
            _loc3_[_loc4_] = param1[_loc4_];
         }
         return _loc3_;
      }
      
      public static function fromEmpty(param1:Function = null) : PropertyProxy
      {
         return new PropertyProxy(param1);
      }
      
      public static function isInstance(param1:Object) : Boolean
      {
         return param1 is PropertyProxy;
      }
      
      public static function asInstance(param1:Object) : PropertyProxy
      {
         return param1 as PropertyProxy;
      }
      
      override flash_proxy function hasProperty(param1:*) : Boolean
      {
         return this._storage.hasOwnProperty(param1);
      }
      
      override flash_proxy function getProperty(param1:*) : *
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(this.isAttribute(param1))
         {
            _loc3_ = param1 is QName?QName(param1).localName:param1.toString();
            if(!this._storage.hasOwnProperty(_loc3_))
            {
               _loc2_ = PropertyProxy.fromEmpty(subProxy_onChange);
               _loc2_._subProxyName = _loc3_;
               this._storage[_loc3_] = _loc2_;
               this._names[this._names.length] = _loc3_;
               this.fireOnChangeCallback(_loc3_);
            }
            return this._storage[_loc3_];
         }
         return this._storage[param1];
      }
      
      override flash_proxy function setProperty(param1:*, param2:*) : void
      {
         var _loc3_:String = param1 is QName?QName(param1).localName:param1.toString();
         this._storage[_loc3_] = param2;
         if(this._names.indexOf(_loc3_) < 0)
         {
            this._names[this._names.length] = _loc3_;
         }
         this.fireOnChangeCallback(_loc3_);
      }
      
      override flash_proxy function deleteProperty(param1:*) : Boolean
      {
         var _loc5_:int = 0;
         var _loc4_:String = param1 is QName?QName(param1).localName:param1.toString();
         var _loc3_:int = this._names.indexOf(_loc4_);
         if(_loc3_ == 0)
         {
            this._names.shift();
         }
         else
         {
            _loc5_ = this._names.length - 1;
            if(_loc3_ == _loc5_)
            {
               this._names.pop();
            }
            else
            {
               this._names.splice(_loc3_,1);
            }
         }
         var _loc2_:* = delete this._storage[_loc4_];
         if(_loc2_)
         {
            this.fireOnChangeCallback(_loc4_);
         }
         return _loc2_;
      }
      
      override flash_proxy function nextNameIndex(param1:int) : int
      {
         if(param1 < this._names.length)
         {
            return param1 + 1;
         }
         return 0;
      }
      
      override flash_proxy function nextName(param1:int) : String
      {
         return this._names[param1 - 1];
      }
      
      override flash_proxy function nextValue(param1:int) : *
      {
         var _loc2_:* = this._names[param1 - 1];
         return this._storage[_loc2_];
      }
      
      public function addOnChangeCallback(param1:Function) : void
      {
         this._onChangeCallbacks[this._onChangeCallbacks.length] = param1;
      }
      
      public function removeOnChangeCallback(param1:Function) : void
      {
         var _loc2_:int = this._onChangeCallbacks.indexOf(param1);
         if(_loc2_ < 0)
         {
            return;
         }
         if(_loc2_ == 0)
         {
            this._onChangeCallbacks.shift();
            return;
         }
         var _loc3_:int = this._onChangeCallbacks.length - 1;
         if(_loc2_ == _loc3_)
         {
            this._onChangeCallbacks.pop();
            return;
         }
         this._onChangeCallbacks.splice(_loc2_,1);
      }
      
      public function toString() : String
      {
         var _loc1_:String = "[object PropertyProxy";
         var _loc4_:int = 0;
         var _loc3_:* = this;
         for(var _loc2_ in this)
         {
            _loc1_ = _loc1_ + (" " + _loc2_);
         }
         return _loc1_ + "]";
      }
      
      private function fireOnChangeCallback(param1:String) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc2_:int = this._onChangeCallbacks.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this._onChangeCallbacks[_loc3_] as Function;
            _loc4_(this,param1);
            _loc3_++;
         }
      }
      
      private function subProxy_onChange(param1:PropertyProxy, param2:String) : void
      {
         this.fireOnChangeCallback(param1._subProxyName);
      }
   }
}
