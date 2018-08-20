package game.mediator.gui.popup.settings
{
   import com.progrestar.common.lang.Translate;
   import game.model.user.settings.PlayerSettingsParameter;
   import idv.cjcat.signals.Signal;
   
   public class SettingSliderMediator
   {
       
      
      protected var parameter:PlayerSettingsParameter;
      
      protected var _currentValue:Number;
      
      private var _label:String;
      
      private var _minValue:Number;
      
      private var _maxValue:Number;
      
      private var _step:Number;
      
      public const signal_changed:Signal = new Signal(Number);
      
      public function SettingSliderMediator(param1:PlayerSettingsParameter, param2:String, param3:Number, param4:Number, param5:Number)
      {
         super();
         this.parameter = param1;
         this._currentValue = Math.max(param3,Math.min(param4,param1.getValue()));
         this._label = param2;
         this._minValue = param3;
         this._maxValue = param4;
         this._step = param5;
      }
      
      public function saveAndDispose() : void
      {
         parameter.onChanged.remove(handler_parameterChanged);
         signal_changed.clear();
         parameter.setValue(_currentValue);
      }
      
      public function get value() : Number
      {
         return _currentValue;
      }
      
      public function set value(param1:Number) : void
      {
         if(_currentValue == param1)
         {
            return;
         }
         _currentValue = param1;
         signal_changed.dispatch(param1);
      }
      
      public function get label() : String
      {
         return _label;
      }
      
      public function get minValue() : Number
      {
         return _minValue;
      }
      
      public function get maxValue() : Number
      {
         return _maxValue;
      }
      
      public function get step() : Number
      {
         return _step;
      }
      
      public function get valueString() : String
      {
         if(_currentValue > 0)
         {
            return int((_currentValue - _minValue) / (_maxValue - _minValue) * 100) + "%";
         }
         return Translate.translate("UI_POPUP_SETTINGS_VOLUME_OFF");
      }
      
      public function testValue() : void
      {
      }
      
      protected function handler_parameterChanged(param1:Number) : void
      {
         this.value = param1;
      }
   }
}
