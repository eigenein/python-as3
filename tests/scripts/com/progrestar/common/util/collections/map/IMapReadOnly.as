package com.progrestar.common.util.collections.map
{
   import com.progrestar.common.util.collections.IIterator;
   
   public interface IMapReadOnly
   {
       
      
      function get(param1:*) : *;
      
      function getOrDefault(param1:*, param2:*) : *;
      
      function get keys() : IIterator;
      
      function get values() : IIterator;
      
      function get size() : int;
      
      function contains(param1:*) : Boolean;
   }
}
