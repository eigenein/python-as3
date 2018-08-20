package com.progrestar.common.util.collections.map
{
   public interface IMap extends IMapReadOnly
   {
       
      
      function put(param1:*, param2:*) : *;
      
      function remove(param1:*) : Boolean;
      
      function clean() : void;
   }
}
