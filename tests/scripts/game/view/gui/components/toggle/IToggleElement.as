package game.view.gui.components.toggle
{
   import idv.cjcat.signals.Signal;
   
   public interface IToggleElement
   {
       
      
      function get isSelected() : Boolean;
      
      function set isSelected(param1:Boolean) : void;
      
      function get signal_updateToggleState() : Signal;
   }
}
