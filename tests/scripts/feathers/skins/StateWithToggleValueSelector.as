package feathers.skins
{
   import feathers.core.IToggle;
   import flash.utils.Dictionary;
   
   public class StateWithToggleValueSelector
   {
       
      
      protected var stateToValue:Dictionary;
      
      protected var stateToSelectedValue:Dictionary;
      
      public var defaultValue:Object;
      
      public var defaultSelectedValue:Object;
      
      public function StateWithToggleValueSelector()
      {
         stateToValue = new Dictionary(true);
         stateToSelectedValue = new Dictionary(true);
         super();
      }
      
      public function setValueForState(param1:Object, param2:Object, param3:Boolean = false) : void
      {
         if(param3)
         {
            this.stateToSelectedValue[param2] = param1;
         }
         else
         {
            this.stateToValue[param2] = param1;
         }
      }
      
      public function clearValueForState(param1:Object, param2:Boolean = false) : Object
      {
         var _loc3_:* = null;
         if(param2)
         {
            _loc3_ = this.stateToSelectedValue[param1];
            delete this.stateToSelectedValue[param1];
         }
         else
         {
            _loc3_ = this.stateToValue[param1];
            delete this.stateToValue[param1];
         }
         return _loc3_;
      }
      
      public function getValueForState(param1:Object, param2:Boolean = false) : Object
      {
         if(param2)
         {
            return this.stateToSelectedValue[param1];
         }
         return this.stateToValue[param1];
      }
      
      public function updateValue(param1:Object, param2:Object, param3:Object = null) : Object
      {
         var _loc4_:* = null;
         if(param1 is IToggle && IToggle(param1).isSelected)
         {
            _loc4_ = this.stateToSelectedValue[param2];
            if(_loc4_ === null)
            {
               _loc4_ = this.defaultSelectedValue;
            }
         }
         else
         {
            _loc4_ = this.stateToValue[param2];
         }
         if(_loc4_ === null)
         {
            _loc4_ = this.defaultValue;
         }
         return _loc4_;
      }
   }
}
