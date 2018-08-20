package game.mediator.gui.popup.settings
{
   import game.model.user.settings.PlayerSettingsParameter;
   import idv.cjcat.signals.Signal;
   
   public class SettingToggleButtonMediator
   {
       
      
      private var parameter:PlayerSettingsParameter;
      
      private var labelOn:String;
      
      private var labelOff:String;
      
      public function SettingToggleButtonMediator(param1:PlayerSettingsParameter, param2:String = null, param3:String = null)
      {
         super();
         this.parameter = param1;
         this.labelOn = param2;
         this.labelOff = param3;
      }
      
      public function get signal_changed() : Signal
      {
         return parameter.onChanged;
      }
      
      public function get isEnabled() : Boolean
      {
         return parameter.getValue();
      }
      
      public function set isEnabled(param1:Boolean) : void
      {
         parameter.setValue(param1);
      }
      
      public function get label() : String
      {
         if(parameter.getValue() == true)
         {
            return labelOn;
         }
         return !!labelOff?labelOff:labelOn;
      }
   }
}
