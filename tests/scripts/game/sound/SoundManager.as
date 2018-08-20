package game.sound
{
   import flash.media.SoundTransform;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import game.model.GameModel;
   import game.model.user.settings.PlayerSettingsData;
   import starling.animation.IAnimatable;
   import starling.core.Starling;
   
   public class SoundManager implements IAnimatable
   {
      
      protected static const INFINITE_LOOP_LENGTH:Number = Infinity;
      
      protected static const INFINITE_LOOP_ITERATIONS:int = 2147483647;
       
      
      private var playSounds:Boolean;
      
      private var playMusic:Boolean;
      
      private var settingsSoundsVolume:Number;
      
      private var settingsMusicVolume:Number;
      
      private var soundTransform:SoundTransform;
      
      private var _currentTime:Number;
      
      private var playingSoundsMap:Dictionary;
      
      protected var playingSounds:Vector.<PlayingSound>;
      
      public function SoundManager()
      {
         soundTransform = new SoundTransform();
         playingSoundsMap = new Dictionary();
         playingSounds = new Vector.<PlayingSound>();
         super();
         _currentTime = getTimer() / 1000;
         Starling.juggler.add(this);
         var _loc1_:PlayerSettingsData = GameModel.instance.player.settings;
         handler_soundSettingChanged(_loc1_.playSounds.getValue());
         handler_musicSettingChanged(_loc1_.playMusic.getValue());
         handler_soundsVolumeSettingChanged(_loc1_.soundsVolume.getValue());
         handler_musicVolumeSettingChanged(_loc1_.musicVolume.getValue());
         _loc1_.playSounds.onChanged.add(handler_soundSettingChanged);
         _loc1_.playMusic.onChanged.add(handler_musicSettingChanged);
         _loc1_.soundsVolume.onChanged.add(handler_soundsVolumeSettingChanged);
         _loc1_.musicVolume.onChanged.add(handler_musicVolumeSettingChanged);
      }
      
      public function get currentTime() : Number
      {
         return _currentTime;
      }
      
      public function play(param1:SoundSource, param2:Function = null) : void
      {
         var _loc3_:Number = NaN;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         if(param1 is MusicSource)
         {
            if(!playMusic)
            {
               return;
            }
            _loc3_ = settingsMusicVolume;
         }
         else
         {
            if(!playSounds)
            {
               return;
            }
            _loc3_ = settingsSoundsVolume;
         }
         _loc5_ = 0;
         while(_loc5_ < playingSounds.length)
         {
            if(playingSounds[_loc5_].endTime >= _currentTime)
            {
               _loc5_++;
               continue;
            }
            break;
         }
         if(_loc5_ == playingSounds.length)
         {
            var _loc6_:* = new PlayingSound();
            playingSounds[_loc5_] = _loc6_;
            _loc4_ = _loc6_;
         }
         else
         {
            _loc4_ = playingSounds[_loc5_];
         }
         soundTransform.volume = param1.volume.value * param1.soundVolume * _loc3_;
         _loc4_.channel = param1.sound.play(0,int(param1.looping) * 2147483647,soundTransform);
         _loc4_.endTime = !!param1.looping?Infinity:Number(_currentTime + param1.sound.length / 1000);
         _loc4_.source = param1;
         if(param2)
         {
            _loc4_.channel.addEventListener("soundComplete",param2,false,0,true);
         }
         playingSoundsMap[param1] = _loc4_;
      }
      
      public function stop(param1:SoundSource) : void
      {
         var _loc2_:PlayingSound = playingSoundsMap[param1];
         if(_loc2_ && _loc2_.endTime > _currentTime && _loc2_.channel)
         {
            _loc2_.channel.stop();
            _loc2_.endTime = 0;
            delete playingSoundsMap[param1];
         }
      }
      
      public function getIsPlaying(param1:SoundSource) : Boolean
      {
         var _loc2_:PlayingSound = playingSoundsMap[param1];
         return _loc2_ && _loc2_.endTime > _currentTime && _loc2_.channel;
      }
      
      public function setVolume(param1:SoundSource, param2:Number) : void
      {
         var _loc3_:PlayingSound = playingSoundsMap[param1];
         if(_loc3_ && _loc3_.endTime > _currentTime && _loc3_.channel)
         {
            if(param1 is MusicSource)
            {
               soundTransform.volume = param2 * _loc3_.source.soundVolume * settingsMusicVolume;
            }
            else
            {
               soundTransform.volume = param2 * _loc3_.source.soundVolume * settingsSoundsVolume;
            }
            _loc3_.channel.soundTransform = soundTransform;
         }
      }
      
      public function stopAllSounds() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function stopAllMusic() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function alterAllSoundsVolume() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function alterAllMusicVolume() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function handler_soundSettingChanged(param1:Boolean) : void
      {
         playSounds = param1;
         if(!param1)
         {
            stopAllSounds();
         }
      }
      
      private function handler_musicSettingChanged(param1:Boolean) : void
      {
         playMusic = param1;
         if(!param1)
         {
            stopAllMusic();
         }
      }
      
      private function handler_soundsVolumeSettingChanged(param1:Number) : void
      {
         settingsSoundsVolume = param1;
         alterAllSoundsVolume();
      }
      
      private function handler_musicVolumeSettingChanged(param1:Number) : void
      {
         settingsMusicVolume = param1;
         alterAllMusicVolume();
      }
      
      public function advanceTime(param1:Number) : void
      {
         _currentTime = _currentTime + param1;
      }
   }
}
