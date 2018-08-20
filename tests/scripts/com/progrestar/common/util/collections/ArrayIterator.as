package com.progrestar.common.util.collections
{
   public class ArrayIterator implements IIterator
   {
       
      
      private var _pos:int = 0;
      
      var _list:Array;
      
      public function ArrayIterator(param1:Array)
      {
         super();
         _list = param1;
      }
      
      public function reset() : void
      {
         _pos = 0;
      }
      
      public function getNext() : *
      {
         _pos = Number(_pos) + 1;
         return _list[Number(_pos)];
      }
      
      public function hasNext() : Boolean
      {
         return _list != null && _pos < _list.length;
      }
   }
}
