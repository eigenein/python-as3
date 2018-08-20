package feathers.data
{
   import flash.errors.IllegalOperationError;
   
   public class ArrayListCollectionDataDescriptor implements IListCollectionDataDescriptor
   {
       
      
      public function ArrayListCollectionDataDescriptor()
      {
         super();
      }
      
      public function getLength(param1:Object) : int
      {
         this.checkForCorrectDataType(param1);
         return (param1 as Array).length;
      }
      
      public function getItemAt(param1:Object, param2:int) : Object
      {
         this.checkForCorrectDataType(param1);
         return (param1 as Array)[param2];
      }
      
      public function setItemAt(param1:Object, param2:Object, param3:int) : void
      {
         this.checkForCorrectDataType(param1);
         (param1 as Array)[param3] = param2;
      }
      
      public function addItemAt(param1:Object, param2:Object, param3:int) : void
      {
         this.checkForCorrectDataType(param1);
         (param1 as Array).splice(param3,0,param2);
      }
      
      public function removeItemAt(param1:Object, param2:int) : Object
      {
         this.checkForCorrectDataType(param1);
         return (param1 as Array).splice(param2,1)[0];
      }
      
      public function removeAll(param1:Object) : void
      {
         this.checkForCorrectDataType(param1);
         (param1 as Array).length = 0;
      }
      
      public function getItemIndex(param1:Object, param2:Object) : int
      {
         this.checkForCorrectDataType(param1);
         return (param1 as Array).indexOf(param2);
      }
      
      protected function checkForCorrectDataType(param1:Object) : void
      {
         if(!(param1 is Array))
         {
            throw new IllegalOperationError("Expected Array. Received " + Object(param1).constructor + " instead.");
         }
      }
   }
}
