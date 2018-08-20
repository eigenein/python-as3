package com.progrestar.common.util
{
   public function assert(param1:Boolean) : void
   {
      if(!param1)
      {
         throw new Error("Assertion failed!");
      }
   }
}
