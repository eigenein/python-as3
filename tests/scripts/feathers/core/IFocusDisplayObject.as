package feathers.core
{
   [Event(name="focusIn",type="starling.events.Event")]
   [Event(name="focusOut",type="starling.events.Event")]
   public interface IFocusDisplayObject extends IFeathersDisplayObject
   {
       
      
      function get focusManager() : IFocusManager;
      
      function set focusManager(param1:IFocusManager) : void;
      
      function get isFocusEnabled() : Boolean;
      
      function set isFocusEnabled(param1:Boolean) : void;
      
      function get nextTabFocus() : IFocusDisplayObject;
      
      function set nextTabFocus(param1:IFocusDisplayObject) : void;
      
      function get previousTabFocus() : IFocusDisplayObject;
      
      function set previousTabFocus(param1:IFocusDisplayObject) : void;
      
      function get focusOwner() : IFocusDisplayObject;
      
      function set focusOwner(param1:IFocusDisplayObject) : void;
      
      function showFocus() : void;
      
      function hideFocus() : void;
   }
}
