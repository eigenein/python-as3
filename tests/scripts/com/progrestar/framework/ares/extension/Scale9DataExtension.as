package com.progrestar.framework.ares.extension
{
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.ClipAsset;
   import com.progrestar.framework.ares.extension.scale9.ClipScale9;
   import com.progrestar.framework.ares.io.IByteArrayReadOnly;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   
   public class Scale9DataExtension extends DataExtensionBase
   {
      
      public static const TYPE:DataExtensionType = new DataExtensionType(Scale9DataExtension,"scale9");
       
      
      public var scale9s:Vector.<ClipScale9>;
      
      public function Scale9DataExtension(param1:ClipAsset)
      {
         scale9s = new Vector.<ClipScale9>();
         super(param1);
      }
      
      public static function fromAsset(param1:ClipAsset) : Scale9DataExtension
      {
         return param1.getData(TYPE) as Scale9DataExtension;
      }
      
      public static function implement(param1:ClipAsset) : Scale9DataExtension
      {
         return param1.requestData(TYPE) as Scale9DataExtension;
      }
      
      override public function get type() : DataExtensionType
      {
         return TYPE;
      }
      
      override public function get isEmpty() : Boolean
      {
         return scale9s.length == 0;
      }
      
      public function addMovieClip(param1:MovieClip, param2:Clip) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function getGridByClip(param1:Clip) : Rectangle
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function getScale9ByClip(param1:Clip) : ClipScale9
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      override public function write(param1:ByteArray) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = scale9s.length;
         param1.writeShort(_loc3_);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = scale9s[_loc4_];
            param1.writeShort(_loc2_.clipId);
            param1.writeShort(int(_loc2_.grid.x));
            param1.writeShort(int(_loc2_.grid.y));
            param1.writeShort(int(_loc2_.grid.width));
            param1.writeShort(int(_loc2_.grid.height));
            _loc4_++;
         }
      }
      
      override public function readChunk(param1:IByteArrayReadOnly) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc5_:* = param1.readUnsignedShort();
         scale9s.length = _loc5_;
         var _loc3_:int = _loc5_;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = new ClipScale9();
            _loc2_.clipId = param1.readUnsignedShort();
            _loc2_.grid = new Rectangle();
            _loc2_.grid.x = param1.readUnsignedShort();
            _loc2_.grid.y = param1.readUnsignedShort();
            _loc2_.grid.width = param1.readUnsignedShort();
            _loc2_.grid.height = param1.readUnsignedShort();
            scale9s[_loc4_] = _loc2_;
            _loc4_++;
         }
      }
   }
}
