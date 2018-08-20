package com.progrestar.common.util.collections.set
{
   public interface ISet extends ISetReadOnly
   {
       
      
      function add(param1:*) : Boolean;
      
      function remove(param1:*) : Boolean;
      
      function clean() : void;
   }
}
