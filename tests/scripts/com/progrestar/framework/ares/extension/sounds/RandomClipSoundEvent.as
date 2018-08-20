package com.progrestar.framework.ares.extension.sounds
{
   public class RandomClipSoundEvent extends ClipSoundEvent
   {
      
      public static const FLA_SOUND_ALIAS_DIVIDER:String = "$";
       
      
      private var sounds:Vector.<ClipSound>;
      
      public function RandomClipSoundEvent(param1:uint, param2:Vector.<ClipSound>)
      {
         super(param1,null);
         this.sounds = param2;
      }
      
      public static function create(param1:int, param2:Vector.<ClipSound>, param3:int) : ClipSoundEvent
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      override public function get sound() : ClipSound
      {
         return sounds[int(Math.random() * sounds.length)];
      }
   }
}
