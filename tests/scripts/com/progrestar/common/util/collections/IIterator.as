package com.progrestar.common.util.collections
{
   public interface IIterator
   {
       
      
      function reset() : void;
      
      function getNext() : *;
      
      function hasNext() : Boolean;
   }
}
