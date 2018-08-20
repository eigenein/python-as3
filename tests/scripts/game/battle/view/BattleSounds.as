package game.battle.view
{
   import flash.media.Sound;
   import flash.media.SoundTransform;
   import game.assets.storage.AssetStorage;
   import game.battle.controller.BattleSoundConfig;
   import game.sound.SoundSource;
   import starling.display.DisplayObject;
   import starling.events.Event;
   
   public class BattleSounds
   {
       
      
      private var musicSource:SoundSource;
      
      private var defaultMusicSource:SoundSource;
      
      private var soundConfig:BattleSoundConfig;
      
      private var soundTransform:SoundTransform;
      
      public function BattleSounds()
      {
         soundTransform = new SoundTransform();
         super();
      }
      
      public function dispose() : void
      {
         if(soundConfig && soundConfig.musicEnabled)
         {
            soundConfig.musicEnabled.unsubscribe(handler_musicEnabled);
         }
         stopMusic();
      }
      
      function setSoundConfig(param1:BattleSoundConfig = null) : void
      {
         this.soundConfig = !!param1?param1:new BattleSoundConfig();
         if(this.soundConfig.musicEnabled != null)
         {
            param1.musicEnabled.signal_update.add(handler_musicEnabled);
         }
      }
      
      function listenForSoundsFromGraphics(param1:DisplayObject) : void
      {
         param1.addEventListener("SOUND",handler_soundEvent);
      }
      
      function musicFadeAway() : void
      {
         if(musicSource)
         {
            musicSource.volume.tweenTo(0,2.5);
         }
      }
      
      function updateSoundtrack(param1:SoundSource) : void
      {
         if(param1 == null)
         {
            if(defaultMusicSource == null)
            {
               defaultMusicSource = AssetStorage.sound.battleMusic;
            }
            param1 = defaultMusicSource;
         }
         if(musicSource && musicSource.isPlaying)
         {
            if(musicSource != param1)
            {
               musicSource.volume.tweenTo(0,1);
               musicSource.stopWhenVolumeZero();
               musicSource = param1;
               musicSource.volume.setValue(0);
               musicSource.volume.tweenTo(1,1);
               musicSource.play();
            }
         }
         else
         {
            musicSource = param1;
            musicSource.volume.setValue(1);
            musicSource.play();
         }
      }
      
      private function stopMusic() : void
      {
         if(musicSource)
         {
            musicSource.stopWhenVolumeZero();
            musicSource.volume.tweenTo(0,0.5);
         }
      }
      
      private function handler_soundEvent(param1:Event) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         param1.stopPropagation();
         if(soundConfig.enabled)
         {
            _loc2_ = param1.data as BattleSoundStarlingEventData;
            if(!_loc2_)
            {
               return;
            }
            _loc3_ = _loc2_.event.sound.sound;
            if(soundConfig.volume != 1)
            {
               soundTransform.volume = soundConfig.volume;
               _loc3_.play(0,0,soundTransform);
            }
            else
            {
               _loc3_.play();
            }
         }
      }
      
      private function handler_musicEnabled(param1:Boolean) : void
      {
         if(musicSource && param1)
         {
            musicSource.play();
         }
      }
   }
}
