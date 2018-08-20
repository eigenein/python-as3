package game.battle.controller
{
   import engine.context.GameContext;
   import game.battle.controller.thread.BattlePresets;
   import game.model.GameModel;
   import game.model.user.settings.PlayerSettingsData;
   import org.osflash.signals.Signal;
   
   public class BattleController
   {
      
      public static const DEBUG_FAST_TIME_SCALE:Number = 5;
      
      public static var DEFAULT_AUTO_BATTLE:Boolean = false;
      
      public static var DEFAULT_TIME_SCALE:Number = 1;
       
      
      private var presets:BattlePresets;
      
      private var _playerSettings:PlayerSettingsData;
      
      private var _dynamicSpeedUpTimeLeft:Number = 0;
      
      private var _activeAutoState:Boolean;
      
      public const signal_auto:Signal = new Signal();
      
      public const signal_retreat:Signal = new Signal();
      
      public const signal_selectHero:Signal = new Signal(int);
      
      public const battleSettings:BattleSettingsModel = new BattleSettingsModel();
      
      public const soundConfig:BattleSoundConfig = new BattleSoundConfig(battleSettings.musicEnabled,battleSettings.musicVolume);
      
      public const progressInfo:BattleProgressInfo = new BattleProgressInfo();
      
      public function BattleController(param1:BattlePresets)
      {
         super();
         this.presets = param1;
         _playerSettings = GameModel.instance.player.settings;
         soundConfig.enabled = _playerSettings.playSounds.getValue();
         soundConfig.volume = _playerSettings.soundsVolume.getValue();
         if(param1.isReplay)
         {
            battleSettings._auto.setValueSilently(true);
            _activeAutoState = true;
         }
         else
         {
            battleSettings._auto.setValueSilently(param1.autoOnStart);
            _activeAutoState = param1.autoOnStart;
         }
         battleSettings._speedToggleIndex.setValueSilently(param1.speedToggleIndexOnStart);
         battleSettings._soundEnabled.setValueSilently(_playerSettings.playSounds.getValue());
         battleSettings._musicEnabled.setValueSilently(_playerSettings.playMusic.getValue());
         battleSettings._soundsVolume.setValueSilently(_playerSettings.soundsVolume.getValue());
         battleSettings._musicVolume.setValueSilently(_playerSettings.musicVolume.getValue());
         _playerSettings.playSounds.onChanged.add(handler_settingsPlaySoundsChanged);
         _playerSettings.playMusic.onChanged.add(handler_settingsPlayMusicChanged);
         _playerSettings.soundsVolume.onChanged.add(handler_settingsSoundsVolumeChanged);
         _playerSettings.musicVolume.onChanged.add(handler_settingsMusicVolumeChanged);
      }
      
      public function dispose() : void
      {
         _playerSettings.playSounds.onChanged.remove(handler_settingsPlaySoundsChanged);
         _playerSettings.playMusic.onChanged.remove(handler_settingsPlayMusicChanged);
         _playerSettings.soundsVolume.onChanged.remove(handler_settingsSoundsVolumeChanged);
         _playerSettings.musicVolume.onChanged.remove(handler_settingsMusicVolumeChanged);
      }
      
      public function get playerSettings() : PlayerSettingsData
      {
         return _playerSettings;
      }
      
      public function get auto() : Boolean
      {
         return battleSettings.auto.value;
      }
      
      public function get isReplay() : Boolean
      {
         return presets.isReplay;
      }
      
      public function get timeScale() : Number
      {
         var _loc1_:int = 0;
         if(battleSettings.onPause.value)
         {
            return 0;
         }
         if(battleSettings._isFast.value)
         {
            return 5 * getDynamicSpeedUp();
         }
         _loc1_ = battleSettings._speedToggleIndex.value;
         return presets.speedToggleOptions[_loc1_] * DEFAULT_TIME_SCALE * getDynamicSpeedUp();
      }
      
      public function action_retreat() : void
      {
         signal_retreat.dispatch();
      }
      
      public function action_pause() : void
      {
         battleSettings._onPause.toggle();
      }
      
      public function action_toggleAutoBattle() : void
      {
         if(presets.autoToggleable)
         {
            toggleAutoBattle();
         }
      }
      
      public function action_toggleSpeedUp() : void
      {
         battleSettings._isFast.toggle();
      }
      
      public function action_toggleSpeed() : void
      {
         var _loc1_:int = (battleSettings._speedToggleIndex.value + 1) % presets.speedToggleOptions.length;
         battleSettings._speedToggleIndex.value = _loc1_;
      }
      
      public function action_toggleAllSounds() : void
      {
         var _loc1_:* = !_playerSettings.playSounds.getValue();
         _playerSettings.playSounds.setValue(_loc1_);
         _playerSettings.playMusic.setValue(_loc1_);
      }
      
      public function action_toggleHero(param1:uint) : void
      {
         signal_selectHero.dispatch(param1);
      }
      
      public function start() : void
      {
         if(_activeAutoState != battleSettings._auto.value)
         {
            _activeAutoState = !_activeAutoState;
            signal_auto.dispatch();
         }
         battleSettings._battleIsInteractive.value = !presets.isReplay;
      }
      
      public function stop() : void
      {
         _activeAutoState = battleSettings._auto.value;
         signal_auto.removeAll();
         battleSettings._battleIsInteractive.value = false;
      }
      
      public function pause() : void
      {
         battleSettings._onPause.setValueSilently(true);
      }
      
      public function play() : void
      {
         battleSettings._onPause.setValueSilently(false);
      }
      
      public function lock() : void
      {
         battleSettings._battleIsInteractive.value = false;
      }
      
      public function unlock() : void
      {
         battleSettings._battleIsInteractive.value = !presets.isReplay;
      }
      
      public function action_clickScene() : void
      {
         if(!GameContext.instance.consoleEnabled || true)
         {
            return;
         }
         if(_dynamicSpeedUpTimeLeft < 0)
         {
            _dynamicSpeedUpTimeLeft = 0;
         }
         _dynamicSpeedUpTimeLeft = _dynamicSpeedUpTimeLeft + 0.7;
      }
      
      public function advanceTime(param1:Number) : void
      {
         _dynamicSpeedUpTimeLeft = _dynamicSpeedUpTimeLeft * 0.95 - param1;
      }
      
      public function commitAutoStateFromPause() : void
      {
         if(_activeAutoState != battleSettings._auto.value)
         {
            _activeAutoState = !_activeAutoState;
            signal_auto.dispatch();
         }
      }
      
      public function toggleAutoBattle() : void
      {
         battleSettings._auto.value = !battleSettings._auto.value;
         if(battleSettings._battleIsInteractive.value)
         {
            signal_auto.dispatch();
         }
      }
      
      private function getDynamicSpeedUp() : Number
      {
         var _loc3_:* = NaN;
         _loc3_ = 1;
         var _loc2_:* = NaN;
         _loc2_ = 3;
         var _loc1_:* = 1;
         if(_dynamicSpeedUpTimeLeft > 1)
         {
            _loc1_ = 3;
         }
         else if(_dynamicSpeedUpTimeLeft > 0)
         {
            _loc1_ = Number(1 + (3 - 1) * _dynamicSpeedUpTimeLeft / 1);
         }
         return _loc1_;
      }
      
      private function handler_settingsPlaySoundsChanged(param1:Boolean) : void
      {
         battleSettings._soundEnabled.value = param1;
         soundConfig.enabled = param1;
      }
      
      private function handler_settingsPlayMusicChanged(param1:Boolean) : void
      {
         battleSettings._musicEnabled.value = param1;
      }
      
      private function handler_settingsSoundsVolumeChanged(param1:Number) : void
      {
         battleSettings._soundsVolume.value = param1;
         soundConfig.volume = param1;
      }
      
      private function handler_settingsMusicVolumeChanged(param1:Number) : void
      {
         battleSettings._musicVolume.value = param1;
      }
   }
}
