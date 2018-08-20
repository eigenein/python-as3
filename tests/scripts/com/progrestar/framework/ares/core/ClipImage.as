package com.progrestar.framework.ares.core
{
   import flash.display.BitmapData;
   import flash.utils.ByteArray;
   
   public class ClipImage extends Item
   {
       
      
      public var bitmapData:BitmapData;
      
      public var frames:Vector.<Frame>;
      
      public var name:String;
      
      public var quality:Number = 0;
      
      public var atfData:ByteArray;
      
      public var resource:ClipAsset;
      
      public var packSize:uint;
      
      public function ClipImage(param1:uint)
      {
         frames = new Vector.<Frame>(0);
         super(param1);
      }
      
      function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         if(bitmapData != null)
         {
            bitmapData.dispose();
         }
         _loc1_ = 0;
         while(_loc1_ < frames.length)
         {
            _loc2_ = frames[_loc1_];
            _loc2_.image = null;
            _loc1_++;
         }
         if(atfData != null)
         {
            atfData.clear();
         }
      }
   }
}
