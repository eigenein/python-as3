package com.progrestar.framework.ares.extension.sounds
{
   import flash.media.Sound;
   import flash.utils.ByteArray;
   
   public class ClipSoundEncoder
   {
      
      public static const FORMAT_16BIT:String = "short";
      
      public static const FORMAT_32BIT:String = "float";
      
      public static const SAMPLE_RATE_5512HZ:uint = 0;
      
      public static const SAMPLE_RATE_11025HZ:uint = 1;
      
      public static const SAMPLE_RATE_22050HZ:uint = 2;
      
      public static const SAMPLE_RATE_44100HZ:uint = 3;
      
      public static const SAMPLE_RATE_44100HZ_VALUE:uint = 44100;
      
      private static const compressionMask:uint = 240;
      
      private static const compressionOffset:uint = 4;
      
      private static const sampleRateMask:uint = 12;
      
      private static const sampleRateOffset:uint = 2;
      
      private static const bitDepthMask:uint = 2;
      
      private static const bitDepthOffset:uint = 1;
      
      private static const stereoMask:uint = 1;
      
      private static const stereoOffset:uint = 0;
      
      private static const wavBuffer:ByteArray = new ByteArray();
       
      
      public function ClipSoundEncoder()
      {
         super();
      }
      
      public static function sampleRateFromCode(param1:uint) : int
      {
         return 44100 >>> 3 - param1;
      }
      
      public static function readSound(param1:ByteArray) : Sound
      {
         var _loc2_:uint = param1.readUnsignedByte();
         var _loc3_:uint = param1.readUnsignedInt();
         return createSound(param1,_loc2_,_loc3_);
      }
      
      public static function writeSound(param1:ByteArray, param2:ByteArray, param3:uint, param4:uint) : void
      {
         param1.writeByte(param3);
         param1.writeUnsignedInt(param4);
         param1.writeBytes(param2);
      }
      
      public static function createSound(param1:ByteArray, param2:uint, param3:uint) : Sound
      {
         var _loc8_:int = 0;
         var _loc7_:Boolean = false;
         var _loc4_:* = null;
         var _loc6_:Sound = new Sound();
         var _loc5_:uint = (param2 & 240) >> 4;
         if(_loc5_ != 3)
         {
            _loc6_.loadCompressedDataFromByteArray(param1,param3);
         }
         else
         {
            _loc8_ = 44100 / parseSampleRateValue(param2);
            _loc7_ = (param2 & 1) >> 0;
            if(_loc8_ != 1)
            {
               if(_loc7_)
               {
                  param1 = extendWavBytesStereo(param1,param3,_loc8_);
               }
               else
               {
                  param1 = extendWavBytes(param1,param3,_loc8_);
               }
            }
            _loc4_ = param1.endian;
            param1.endian = "littleEndian";
            _loc6_.loadPCMFromByteArray(param1,param3,"short",_loc7_,44100);
            param1.endian = _loc4_;
         }
         return _loc6_;
      }
      
      public static function getSamplesCount(param1:uint, param2:uint, param3:Boolean, param4:uint) : uint
      {
         if(param1 == 3 || param1 == 3)
         {
            if(param3)
            {
               return param4 / 4 * (int(44100 / sampleRateFromCode(param2)));
            }
            return param4 / 2 * (int(44100 / sampleRateFromCode(param2)));
         }
         return param4;
      }
      
      public static function getSoundDescription(param1:uint, param2:int, param3:Boolean, param4:uint) : uint
      {
         return param1 << 4 & 240 | param2 << 2 & 12 | param4 << 1 & 2 | int(param3) << 0 & 1;
      }
      
      public static function parseCompressionFormat(param1:int) : uint
      {
         return (param1 & 240) >> 4;
      }
      
      public static function parseSampleRate(param1:int) : uint
      {
         return (param1 & 12) >> 2;
      }
      
      public static function parseSampleRateValue(param1:int) : uint
      {
         return 44100 >>> 3 - ((param1 & 12) >> 2);
      }
      
      public static function parseBitDepth(param1:int) : uint
      {
         return (param1 & 2) >> 1;
      }
      
      public static function parseStereo(param1:int) : Boolean
      {
         return (param1 & 1) >> 0;
      }
      
      public static function testReadSoundFormatByte(param1:uint) : Object
      {
         return {
            "copmressionFormat":parseCompressionFormat(param1),
            "sampleRate":parseSampleRate(param1),
            "bitDepth":parseBitDepth(param1),
            "stereo":parseStereo(param1)
         };
      }
      
      protected static function extendWavBytes(param1:ByteArray, param2:uint, param3:int) : ByteArray
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected static function extendWavBytesStereo(param1:ByteArray, param2:uint, param3:int) : ByteArray
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
