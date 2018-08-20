package com.progrestar.framework.ares.io
{
   import flash.utils.ByteArray;
   
   public interface IByteArrayReadOnly
   {
       
      
      function get position() : uint;
      
      function get length() : uint;
      
      function get bytesAvailable() : uint;
      
      function readBoolean() : Boolean;
      
      function readByte() : int;
      
      function readBytes(param1:ByteArray, param2:uint = 0, param3:uint = 0) : void;
      
      function readDouble() : Number;
      
      function readFloat() : Number;
      
      function readInt() : int;
      
      function readMultiByte(param1:uint, param2:String) : String;
      
      function readObject() : *;
      
      function readShort() : int;
      
      function readUnsignedByte() : uint;
      
      function readUnsignedInt() : uint;
      
      function readUnsignedShort() : uint;
      
      function readUTF() : String;
      
      function readUTFBytes(param1:uint) : String;
   }
}
