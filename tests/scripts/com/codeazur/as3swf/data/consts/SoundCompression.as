package com.codeazur.as3swf.data.consts
{
   public class SoundCompression
   {
      
      public static const UNCOMPRESSED_NATIVE_ENDIAN:uint = 0;
      
      public static const ADPCM:uint = 1;
      
      public static const MP3:uint = 2;
      
      public static const UNCOMPRESSED_LITTLE_ENDIAN:uint = 3;
      
      public static const NELLYMOSER_16_KHZ:uint = 4;
      
      public static const NELLYMOSER_8_KHZ:uint = 5;
      
      public static const NELLYMOSER:uint = 6;
      
      public static const SPEEX:uint = 11;
       
      
      public function SoundCompression()
      {
         super();
      }
      
      public static function toString(param1:uint) : String
      {
         switch(int(param1))
         {
            case 0:
               return "Uncompressed Native Endian";
            case 1:
               return "ADPCM";
            case 2:
               return "MP3";
            case 3:
               return "Uncompressed Little Endian";
            case 4:
               return "Nellymoser 16kHz";
            case 5:
               return "Nellymoser 8kHz";
            case 6:
               return "Nellymoser";
            default:
            default:
            default:
            default:
               return "unknown";
            case 11:
               return "Speex";
         }
      }
   }
}
