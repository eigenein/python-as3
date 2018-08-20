package feathers.data
{
   import flash.errors.IllegalOperationError;
   
   public class XMLListListCollectionDataDescriptor implements IListCollectionDataDescriptor
   {
       
      
      public function XMLListListCollectionDataDescriptor()
      {
         super();
      }
      
      public function getLength(param1:Object) : int
      {
         this.checkForCorrectDataType(param1);
         return (param1 as XMLList).length();
      }
      
      public function getItemAt(param1:Object, param2:int) : Object
      {
         this.checkForCorrectDataType(param1);
         return param1[param2];
      }
      
      public function setItemAt(param1:Object, param2:Object, param3:int) : void
      {
         this.checkForCorrectDataType(param1);
         param1[param3] = XML(param2);
      }
      
      public function addItemAt(param1:Object, param2:Object, param3:int) : void
      {
         var _loc4_:* = 0;
         this.checkForCorrectDataType(param1);
         var _loc5_:XMLList = (param1 as XMLList).copy();
         param1[param3] = param2;
         var _loc6_:int = _loc5_.length();
         _loc4_ = param3;
         while(_loc4_ < _loc6_)
         {
            param1[_loc4_ + 1] = _loc5_[_loc4_];
            _loc4_++;
         }
      }
      
      public function removeItemAt(param1:Object, param2:int) : Object
      {
         this.checkForCorrectDataType(param1);
         var _loc3_:XML = param1[param2];
         delete param1[param2];
         return _loc3_;
      }
      
      public function removeAll(param1:Object) : void
      {
         var _loc2_:int = 0;
         this.checkForCorrectDataType(param1);
         var _loc3_:XMLList = param1 as XMLList;
         var _loc4_:int = _loc3_.length();
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            delete param1[0];
            _loc2_++;
         }
      }
      
      public function getItemIndex(param1:Object, param2:Object) : int
      {
         var _loc3_:int = 0;
         var _loc5_:* = null;
         this.checkForCorrectDataType(param1);
         var _loc4_:XMLList = param1 as XMLList;
         var _loc6_:int = _loc4_.length();
         _loc3_ = 0;
         while(_loc3_ < _loc6_)
         {
            _loc5_ = _loc4_[_loc3_];
            if(_loc5_ == param2)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      protected function checkForCorrectDataType(param1:Object) : void
      {
         if(!(param1 is XMLList))
         {
            throw new IllegalOperationError("Expected XMLList. Received " + Object(param1).constructor + " instead.");
         }
      }
   }
}
