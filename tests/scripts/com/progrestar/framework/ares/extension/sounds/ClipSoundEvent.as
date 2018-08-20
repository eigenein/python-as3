package com.progrestar.framework.ares.extension.sounds
{
   import com.progrestar.framework.ares.events.IClipEvent;
   
   public class ClipSoundEvent implements IClipEvent
   {
       
      
      private var _frame:uint;
      
      private var _sound:ClipSound;
      
      public function ClipSoundEvent(param1:uint, param2:ClipSound)
      {
         super();
         _frame = param1;
         _sound = param2;
      }
      
      public function get frame() : uint
      {
         return _frame;
      }
      
      public function get type() : Class
      {
         return ClipSoundEvent;
      }
      
      public function get sound() : ClipSound
      {
         return _sound;
      }
   }
}
