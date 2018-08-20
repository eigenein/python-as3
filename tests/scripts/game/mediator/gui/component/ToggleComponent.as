package game.mediator.gui.component
{
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   
   public class ToggleComponent
   {
       
      
      private var _data:Object;
      
      private var group:ToggleGroupComponent;
      
      private const _selected:BooleanPropertyWriteable = new BooleanPropertyWriteable();
      
      public function ToggleComponent(param1:Object)
      {
         super();
         _data = param1;
      }
      
      public function get property_selected() : BooleanProperty
      {
         return _selected;
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function setToggleGroup(param1:ToggleGroupComponent) : void
      {
         this.group = param1;
      }
      
      public function select() : void
      {
         group.selectToggle(this);
      }
      
      function setSelectedInternal(param1:Boolean) : void
      {
         if(_selected.value != param1)
         {
            _selected.value = param1;
         }
      }
   }
}
