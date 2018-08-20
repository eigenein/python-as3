package com.progrestar.framework.ares.core
{
   public class ColorMode
   {
      
      public static const DEFAULT:uint = 0;
      
      public static const ALPHA:uint = 1;
      
      public static const MULTIPLY:uint = 2;
      
      public static const MATRIX:uint = 3;
       
      
      public function ColorMode()
      {
         super();
      }
      
      public static function toString(param1:uint) : String
      {
         if(0 == param1)
         {
            return "default";
         }
         if(1 == param1)
         {
            return "alpha";
         }
         if(2 == param1)
         {
            return "multiply";
         }
         if(3 == param1)
         {
            return "matrix";
         }
         return "unknown";
      }
   }
}
