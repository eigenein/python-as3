package game.mediator.gui.popup.settings
{
   import flash.media.SoundTransform;
   import game.assets.storage.AssetStorage;
   import game.model.user.settings.PlayerSettingsParameter;
   import game.sound.SoundSource;
   
   public class SettingVolumeSliderMediator extends SettingSliderMediator
   {
       
      
      private var isEnabledParameter:PlayerSettingsParameter;
      
      public function SettingVolumeSliderMediator(param1:PlayerSettingsParameter, param2:PlayerSettingsParameter, param3:String, param4:Number, param5:Number, param6:Number)
      {
         super(param1,param3,param4,param5,param6);
         this.isEnabledParameter = param2;
         if(!param2.getValue())
         {
            _currentValue = 0;
         }
      }
      
      override public function saveAndDispose() : void
      {
         parameter.onChanged.remove(handler_parameterChanged);
         signal_changed.clear();
         if(_currentValue > 0)
         {
            parameter.setValue(_currentValue);
            isEnabledParameter.setValue(true);
         }
         else
         {
            isEnabledParameter.setValue(false);
         }
      }
      
      override public function testValue() : void
      {
         var _loc2_:SoundSource = AssetStorage.sound.dailyBonus;
         var _loc1_:SoundTransform = new SoundTransform(_loc2_.soundVolume * _currentValue);
         _loc2_.sound.play(0,0,_loc1_);
      }
   }
}
