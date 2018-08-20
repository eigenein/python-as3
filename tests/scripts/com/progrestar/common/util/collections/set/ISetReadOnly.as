package com.progrestar.common.util.collections.set
{
   import com.progrestar.common.util.collections.IIterator;
   
   public interface ISetReadOnly
   {
       
      
      function getIterator() : IIterator;
      
      function contains(param1:*) : Boolean;
      
      function get size() : int;
      
      function clone() : ISet;
      
      function join(param1:ISetReadOnly) : ISet;
   }
}
