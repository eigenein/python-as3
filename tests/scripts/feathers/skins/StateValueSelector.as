package feathers.skins
{
   import flash.utils.Dictionary;
   
   public class StateValueSelector
   {
       
      
      protected var stateToValue:Dictionary;
      
      public var defaultValue:Object;
      
      public function StateValueSelector()
      {
         stateToValue = new Dictionary(true);
         super();
      }
      
      public function setValueForState(param1:Object, param2:Object) : void
      {
         this.stateToValue[param2] = param1;
      }
      
      public function clearValueForState(param1:Object) : Object
      {
         var _loc2_:Object = this.stateToValue[param1];
         delete this.stateToValue[param1];
         return _loc2_;
      }
      
      public function getValueForState(param1:Object) : Object
      {
         return this.stateToValue[param1];
      }
      
      public function updateValue(param1:Object, param2:Object, param3:Object = null) : Object
      {
         var _loc4_:Object = this.stateToValue[param2];
         if(!_loc4_)
         {
            _loc4_ = this.defaultValue;
         }
         return _loc4_;
      }
   }
}
