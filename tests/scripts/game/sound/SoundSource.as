package game.sound
{
   import com.progrestar.framework.ares.extension.sounds.ClipSound;
   import flash.media.Sound;
   
   public class SoundSource
   {
       
      
      protected var _sound:Sound;
      
      protected var _soundVolume:Number = 1;
      
      protected var _looping:Boolean = false;
      
      private var _isPlaying:Boolean = false;
      
      private var _stopWhenVolumeZero:Boolean;
      
      public const volume:TweenableProperty = new TweenableProperty(1,handler_updateVolume);
      
      public function SoundSource(param1:ClipSound = null, param2:Boolean = false, param3:Number = -1)
      {
         super();
         if(param3 == -1)
         {
            param3 = NaN;
         }
         if(param1)
         {
            _sound = param1.sound;
         }
         if(param3 == param3)
         {
            _soundVolume = param3;
         }
         _looping = param2;
      }
      
      public function get soundVolume() : Number
      {
         return _soundVolume;
      }
      
      public function get sound() : Sound
      {
         return _sound;
      }
      
      public function get isPlaying() : Boolean
      {
         return Game.instance.soundPlayer.music.getIsPlaying(this);
      }
      
      public function set looping(param1:Boolean) : void
      {
         _looping = param1;
      }
      
      public function get looping() : Boolean
      {
         return _looping;
      }
      
      public function play(param1:ClipSound = null) : void
      {
         if(param1)
         {
            _sound = param1.sound;
         }
         if(_sound)
         {
            Game.instance.soundPlayer.music.play(this);
            _isPlaying = true;
         }
      }
      
      public function setMusic(param1:ClipSound) : void
      {
         if(param1)
         {
            _sound = param1.sound;
         }
      }
      
      public function stopWhenVolumeZero() : void
      {
         _stopWhenVolumeZero = true;
         if(_sound && volume.value == 0)
         {
            Game.instance.soundPlayer.music.stop(this);
            _isPlaying = false;
         }
      }
      
      public function stop() : void
      {
         Game.instance.soundPlayer.music.stop(this);
         _isPlaying = false;
      }
      
      private function handler_updateVolume(param1:Number) : void
      {
         if(_sound)
         {
            if(param1 == 0 && _stopWhenVolumeZero)
            {
               Game.instance.soundPlayer.music.stop(this);
               _isPlaying = false;
            }
            else
            {
               Game.instance.soundPlayer.music.setVolume(this,param1);
            }
         }
      }
   }
}
