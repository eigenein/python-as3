package com.progrestar.framework.ares.extension
{
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.ClipAsset;
   import com.progrestar.framework.ares.events.IClipEvent;
   import com.progrestar.framework.ares.extension.sounds.ClipSound;
   import com.progrestar.framework.ares.extension.sounds.ClipSoundEvent;
   import com.progrestar.framework.ares.extension.sounds.RandomClipSoundEvent;
   import com.progrestar.framework.ares.io.IByteArrayReadOnly;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class SoundDataExtension extends DataExtensionBase
   {
      
      public static const TYPE:DataExtensionType = new DataExtensionType(SoundDataExtension,"sound");
      
      public static var keepDataBytes:Boolean = false;
      
      private static const USE_RANDOM_SOUNDS:Boolean = true;
       
      
      private var sounds:Vector.<ClipSound>;
      
      private var soundInvocations:Dictionary;
      
      private var bytes:ByteArray;
      
      public function SoundDataExtension(param1:ClipAsset)
      {
         super(param1);
      }
      
      public static function fromAsset(param1:ClipAsset) : SoundDataExtension
      {
         return param1.getData(TYPE) as SoundDataExtension;
      }
      
      override public function get type() : DataExtensionType
      {
         return TYPE;
      }
      
      override public function get isEmpty() : Boolean
      {
         return sounds.length == 0;
      }
      
      public function define(param1:Vector.<ClipSound>, param2:Dictionary) : void
      {
         this.sounds = param1;
         this.soundInvocations = param2;
      }
      
      public function getAllSounds() : Vector.<ClipSound>
      {
         return sounds.concat();
      }
      
      public function getSoundByName(param1:String) : ClipSound
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function getClipSoundEvents(param1:Clip) : Vector.<IClipEvent>
      {
         return soundInvocations[param1.id];
      }
      
      override public function write(param1:ByteArray) : void
      {
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         var _loc7_:* = null;
         if(keepDataBytes && this.bytes)
         {
            param1.writeBytes(this.bytes,0,this.bytes.length);
            return;
         }
         var _loc3_:int = sounds.length;
         param1.writeUnsignedInt(_loc3_);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            sounds[_loc5_].write(param1);
            _loc5_++;
         }
         var _loc8_:int = 0;
         var _loc10_:int = 0;
         var _loc9_:* = soundInvocations;
         for(var _loc4_ in soundInvocations)
         {
            _loc8_++;
         }
         param1.writeShort(_loc8_);
         var _loc14_:int = 0;
         var _loc13_:* = soundInvocations;
         for(_loc4_ in soundInvocations)
         {
            _loc6_ = soundInvocations[_loc4_];
            param1.writeShort(_loc4_);
            param1.writeShort(_loc6_.length);
            var _loc12_:int = 0;
            var _loc11_:* = _loc6_;
            for each(var _loc2_ in _loc6_)
            {
               _loc7_ = _loc2_ as ClipSoundEvent;
               param1.writeShort(_loc7_.frame);
               param1.writeShort(_loc7_.sound.id);
            }
         }
      }
      
      override public function readChunk(param1:IByteArrayReadOnly) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
   }
}
