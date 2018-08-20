package com.progrestar.common.util.collections.map
{
   import com.progrestar.common.util.assert;
   import com.progrestar.common.util.collections.ArrayIterator;
   import com.progrestar.common.util.collections.IIterator;
   import flash.utils.Dictionary;
   
   public class HashMap implements IMap
   {
      
      private static const DELIM:String = ", ";
       
      
      private var _keyType:Class;
      
      private var _itemType:Class;
      
      private var _toString:String = null;
      
      private var _map:Dictionary;
      
      private var _idsMap:Dictionary;
      
      private var _keys:Array;
      
      public function HashMap(param1:Class = null, param2:Class = null)
      {
         _map = new Dictionary();
         _idsMap = new Dictionary();
         _keys = [];
         super();
         _keyType = param1;
         _itemType = param2;
      }
      
      public function put(param1:*, param2:*) : *
      {
         var _loc3_:Boolean = (_keyType == null || param1 is _keyType) && (_itemType == null || param2 is _itemType);
         if(!_loc3_)
         {
            assert(false);
            return null;
         }
         if(!contains(param1))
         {
            _idsMap[param1] = _keys.length;
            _keys.push(param1);
         }
         _map[param1] = param2;
         return param2;
      }
      
      public function remove(param1:*) : Boolean
      {
         if(!contains(param1))
         {
            return false;
         }
         var _loc2_:int = _idsMap[param1];
         _keys[_loc2_] = _keys[_keys.length - 1];
         _keys.length = _keys.length - 1;
         _idsMap[_keys[_loc2_]] = _loc2_;
         delete _map[param1];
         delete _idsMap[param1];
         return true;
      }
      
      public function clean() : void
      {
         _map = new Dictionary();
         _idsMap = new Dictionary();
         _keys = [];
      }
      
      public function get(param1:*) : *
      {
         return _map[param1];
      }
      
      public function getOrDefault(param1:*, param2:*) : *
      {
         if(contains(param1))
         {
            return _map[param1];
         }
         return param2;
      }
      
      public function get keys() : IIterator
      {
         return new ArrayIterator(_keys);
      }
      
      public function get values() : IIterator
      {
         return new HashMapIterator(this);
      }
      
      public function get size() : int
      {
         return _keys.length;
      }
      
      public function contains(param1:*) : Boolean
      {
         return _idsMap[param1] !== undefined;
      }
      
      public function toString() : String
      {
         var _loc2_:* = null;
         if(_toString == null)
         {
            _toString = "Map{";
            _loc2_ = "";
            var _loc4_:int = 0;
            var _loc3_:* = _keys;
            for each(var _loc1_ in _keys)
            {
               _toString = _toString + (_loc2_ + _loc1_ + ":" + _map[_loc1_]);
               _loc2_ = ", ";
            }
            _toString = _toString + "}";
         }
         return _toString;
      }
   }
}
