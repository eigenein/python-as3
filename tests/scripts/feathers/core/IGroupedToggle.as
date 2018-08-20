package feathers.core
{
   public interface IGroupedToggle extends IToggle
   {
       
      
      function get toggleGroup() : ToggleGroup;
      
      function set toggleGroup(param1:ToggleGroup) : void;
   }
}
