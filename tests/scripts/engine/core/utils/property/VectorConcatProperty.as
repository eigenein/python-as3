package engine.core.utils.property
{
   import avmplus.getQualifiedClassName;
   import flash.utils.getDefinitionByName;
   
   public class VectorConcatProperty extends VectorProperty
   {
       
      
      private var vectors:Vector.<VectorProperty>;
      
      public function VectorConcatProperty(param1:VectorProperty = null, ... rest)
      {
         vectors = new Vector.<VectorProperty>();
         super();
         if(param1)
         {
            addVectorProperty(param1);
         }
         if(rest && rest.length > 0)
         {
            var _loc5_:int = 0;
            var _loc4_:* = rest;
            for each(var _loc3_ in rest)
            {
               addVectorProperty(_loc3_);
            }
         }
         if(_value)
         {
            updateValue();
         }
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = vectors;
         for each(var _loc1_ in vectors)
         {
            _loc1_.unsubscribe(handler_someDataUpdated);
         }
         vectors.length = 0;
      }
      
      public function addVectors(param1:VectorProperty, ... rest) : void
      {
         addVectorProperty(param1);
         var _loc5_:int = 0;
         var _loc4_:* = rest;
         for each(var _loc3_ in rest)
         {
            addVectorProperty(_loc3_);
         }
         if(_value)
         {
            updateValue();
         }
      }
      
      protected function addVectorProperty(param1:VectorProperty) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = undefined;
         if(!param1)
         {
            return;
         }
         if(!_value)
         {
            _loc2_ = getQualifiedClassName(param1.value);
            _loc3_ = _loc2_.substring(_loc2_.indexOf("<") + 1,_loc2_.lastIndexOf(">"));
            _loc4_ = getDefinitionByName(_loc3_);
            _value = new Vector.<_loc4_>();
         }
         vectors.push(param1);
         param1.signal_update.add(handler_someDataUpdated);
      }
      
      protected function updateValue() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = undefined;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         _value.length = 0;
         var _loc3_:int = 0;
         var _loc2_:int = vectors.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc1_ = vectors[_loc4_].value;
            _loc6_ = _loc1_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               _value[_loc3_ + _loc5_] = _loc1_[_loc5_];
               _loc5_++;
            }
            _loc3_ = _loc3_ + _loc6_;
            _loc4_++;
         }
         if(_signal)
         {
            _signal.dispatch(_value);
         }
      }
      
      private function handler_someDataUpdated(param1:Vector.<*>) : void
      {
         updateValue();
      }
   }
}
