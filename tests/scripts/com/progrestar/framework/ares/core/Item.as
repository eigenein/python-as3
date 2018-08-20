package com.progrestar.framework.ares.core
{
   public class Item
   {
       
      
      private var _id:uint;
      
      public function Item(param1:uint)
      {
         super();
         _id = param1;
      }
      
      public function get id() : uint
      {
         return _id;
      }
      
      public function set id(param1:uint) : void
      {
         _id = param1;
      }
   }
}
