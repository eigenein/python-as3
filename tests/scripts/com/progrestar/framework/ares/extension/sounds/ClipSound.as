package com.progrestar.framework.ares.extension.sounds
{
   import com.progrestar.framework.ares.core.Item;
   import com.progrestar.framework.ares.io.IByteArrayReadOnly;
   import flash.media.Sound;
   import flash.utils.ByteArray;
   
   public class ClipSound extends Item
   {
       
      
      public var name:String;
      
      public var sound:Sound;
      
      public function ClipSound(param1:uint)
      {
         super(param1);
      }
      
      public function read(param1:IByteArrayReadOnly) : void
      {
         name = param1.readUTF();
         sound = ClipSoundEncoder.readSound(param1 as ByteArray);
      }
      
      public function write(param1:ByteArray) : void
      {
      }
   }
}
