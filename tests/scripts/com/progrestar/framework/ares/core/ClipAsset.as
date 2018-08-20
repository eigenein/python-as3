package com.progrestar.framework.ares.core
{
   import com.progrestar.common.util.assert;
   import com.progrestar.framework.ares.extension.DataExtensionBase;
   import com.progrestar.framework.ares.extension.DataExtensionType;
   import flash.utils.Dictionary;
   
   public class ClipAsset
   {
       
      
      public var date:Number = NaN;
      
      public var version:Number = NaN;
      
      public var invertedResolution:Number = NaN;
      
      public var images:Vector.<ClipImage>;
      
      public var clips:Vector.<Clip>;
      
      public var frames:Vector.<Frame>;
      
      public var nodes:Vector.<Node>;
      
      public const dataExtensions:Dictionary = new Dictionary();
      
      private var _name:String;
      
      private var classNameMap:Dictionary;
      
      public function ClipAsset(param1:String)
      {
         images = new Vector.<ClipImage>(0);
         clips = new Vector.<Clip>(0);
         frames = new Vector.<Frame>(0);
         nodes = new Vector.<Node>(0);
         super();
         assert(param1 != null);
         _name = param1;
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < images.length)
         {
            _loc1_ = images[_loc2_];
            _loc1_.dispose();
            _loc2_++;
         }
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function setName(param1:String) : void
      {
         _name = param1;
      }
      
      public function getClipByName(param1:String) : Clip
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function getClipById(param1:int) : Clip
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function requestData(param1:DataExtensionType) : DataExtensionBase
      {
         if(dataExtensions[param1])
         {
            §§push(dataExtensions[param1]);
         }
         else
         {
            var _loc2_:* = param1.createInstance(this);
            dataExtensions[param1] = _loc2_;
            §§push(_loc2_);
         }
         return §§pop();
      }
      
      public function getData(param1:DataExtensionType) : DataExtensionBase
      {
         return dataExtensions[param1];
      }
      
      public function setData(param1:DataExtensionBase) : void
      {
         assert(dataExtensions[param1.type] == null);
         dataExtensions[param1.type] = param1;
      }
   }
}
