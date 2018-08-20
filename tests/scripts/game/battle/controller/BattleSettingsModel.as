package game.battle.controller
{
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.IntPropertyWriteable;
   import engine.core.utils.property.NumberProperty;
   import engine.core.utils.property.NumberPropertyWriteable;
   
   public class BattleSettingsModel
   {
       
      
      const _onPause:BooleanPropertyWriteable = new BooleanPropertyWriteable();
      
      const _speedToggleIndex:IntPropertyWriteable = new IntPropertyWriteable(1);
      
      const _isFast:BooleanPropertyWriteable = new BooleanPropertyWriteable();
      
      const _auto:BooleanPropertyWriteable = new BooleanPropertyWriteable();
      
      const _musicEnabled:BooleanPropertyWriteable = new BooleanPropertyWriteable();
      
      const _soundEnabled:BooleanPropertyWriteable = new BooleanPropertyWriteable();
      
      const _soundsVolume:NumberPropertyWriteable = new NumberPropertyWriteable();
      
      const _musicVolume:NumberPropertyWriteable = new NumberPropertyWriteable();
      
      const _battleIsInteractive:BooleanPropertyWriteable = new BooleanPropertyWriteable(false);
      
      public const onPause:BooleanProperty = _onPause;
      
      public const speedToggleIndex:IntProperty = _speedToggleIndex;
      
      public const isFast:BooleanProperty = _isFast;
      
      public const auto:BooleanProperty = _auto;
      
      public const musicEnabled:BooleanProperty = _musicEnabled;
      
      public const soundEnabled:BooleanProperty = _soundEnabled;
      
      public const soundsVolume:NumberProperty = _soundsVolume;
      
      public const musicVolume:NumberProperty = _musicVolume;
      
      public const battleIsInteractive:BooleanProperty = _battleIsInteractive;
      
      public function BattleSettingsModel()
      {
         super();
      }
   }
}
