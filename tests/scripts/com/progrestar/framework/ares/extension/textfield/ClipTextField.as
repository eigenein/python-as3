package com.progrestar.framework.ares.extension.textfield
{
   import flash.geom.Rectangle;
   
   public class ClipTextField
   {
      
      public static const ALIGN_LEFT:int = 0;
      
      public static const ALIGN_RIGHT:int = 1;
      
      public static const ALIGN_CENTER:int = 2;
      
      public static const ALIGN_JUSTIFY:int = 3;
      
      public static const ALIGN_START:int = 4;
      
      public static const ALIGN_END:int = 5;
       
      
      public var clipId:int;
      
      public var name:String;
      
      public var bounds:Rectangle;
      
      public var multiline:Boolean;
      
      public var align:uint;
      
      public var fontClass:String;
      
      public var fontHeight:Number;
      
      public var textColor:uint;
      
      public function ClipTextField()
      {
         super();
      }
   }
}
