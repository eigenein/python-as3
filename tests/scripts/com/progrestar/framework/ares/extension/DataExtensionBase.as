package com.progrestar.framework.ares.extension
{
   import avmplus.getQualifiedClassName;
   import com.progrestar.common.util.assert;
   import com.progrestar.framework.ares.core.ClipAsset;
   import com.progrestar.framework.ares.io.IByteArrayReadOnly;
   import com.progrestar.framework.ares.utils.AbstractMethodError;
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   
   public class DataExtensionBase
   {
      
      public static const TYPE:DataExtensionType = new DataExtensionType(DataExtensionBase,"abstract");
       
      
      protected var asset:ClipAsset;
      
      public function DataExtensionBase(param1:ClipAsset)
      {
         super();
         var _loc2_:* = getDefinitionByName(getQualifiedClassName(this));
         assert(_loc2_.TYPE && _loc2_.TYPE is DataExtensionType);
         this.asset = param1;
      }
      
      public function get type() : DataExtensionType
      {
         return getDefinitionByName(getQualifiedClassName(this)).TYPE;
      }
      
      public function get isEmpty() : Boolean
      {
         return true;
      }
      
      public function write(param1:ByteArray) : void
      {
         throw new AbstractMethodError();
      }
      
      public function readChunk(param1:IByteArrayReadOnly) : void
      {
         throw new AbstractMethodError();
      }
   }
}
