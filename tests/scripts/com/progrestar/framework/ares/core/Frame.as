package com.progrestar.framework.ares.core
{
   import flash.geom.Rectangle;
   
   public class Frame extends Item implements IContent
   {
       
      
      public var image:ClipImage;
      
      public var area:Rectangle;
      
      public var doubleOffsetX:int;
      
      public var doubleOffsetY:int;
      
      public var frame:Rectangle;
      
      public function Frame(param1:uint)
      {
         super(param1);
      }
      
      public static function isEqual(param1:Frame, param2:Frame) : Boolean
      {
         if(param1 == param2)
         {
            return true;
         }
         if(param1.image != param2.image)
         {
            return false;
         }
         if(param1.area != param2.area)
         {
            return false;
         }
         if(param1.doubleOffsetX != param2.doubleOffsetX)
         {
            return false;
         }
         if(param1.doubleOffsetY != param2.doubleOffsetY)
         {
            return false;
         }
         if(param1.frame != param2.frame)
         {
            return false;
         }
         return true;
      }
      
      public function copyFrom(param1:Frame) : void
      {
         this.image = param1.image;
         this.area = param1.area;
         this.doubleOffsetX = param1.doubleOffsetX;
         this.doubleOffsetY = param1.doubleOffsetY;
         this.frame = param1.frame;
      }
   }
}
