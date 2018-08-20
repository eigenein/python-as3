package com.progrestar.common.util.collections.map
{
   import com.progrestar.common.util.collections.IIterator;
   
   class HashMapIterator implements IIterator
   {
       
      
      private var _target:HashMap;
      
      private var _keys:IIterator;
      
      function HashMapIterator(param1:HashMap)
      {
         super();
         _target = param1;
         _keys = _target.keys;
      }
      
      public function reset() : void
      {
         _keys.reset();
      }
      
      public function getNext() : *
      {
         if(!_keys.hasNext())
         {
            return null;
         }
         return _target.get(_keys.getNext());
      }
      
      public function hasNext() : Boolean
      {
         return _keys.hasNext();
      }
   }
}
