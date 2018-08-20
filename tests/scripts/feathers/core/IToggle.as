package feathers.core
{
   [Event(name="change",type="starling.events.Event")]
   public interface IToggle extends IFeathersControl
   {
       
      
      function get isSelected() : Boolean;
      
      function set isSelected(param1:Boolean) : void;
   }
}
