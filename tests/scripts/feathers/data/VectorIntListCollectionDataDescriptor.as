package feathers.data
{
   import flash.errors.IllegalOperationError;
   
   public class VectorIntListCollectionDataDescriptor implements IListCollectionDataDescriptor
   {
       
      
      public function VectorIntListCollectionDataDescriptor()
      {
         super();
      }
      
      public function getLength(param1:Object) : int
      {
         this.checkForCorrectDataType(param1);
         return (param1 as Vector.<int>).length;
      }
      
      public function getItemAt(param1:Object, param2:int) : Object
      {
         this.checkForCorrectDataType(param1);
         return (param1 as Vector.<int>)[param2];
      }
      
      public function setItemAt(param1:Object, param2:Object, param3:int) : void
      {
         this.checkForCorrectDataType(param1);
         (param1 as Vector.<int>)[param3] = param2 as int;
      }
      
      public function addItemAt(param1:Object, param2:Object, param3:int) : void
      {
         this.checkForCorrectDataType(param1);
         (param1 as Vector.<int>).splice(param3,0,param2);
      }
      
      public function removeItemAt(param1:Object, param2:int) : Object
      {
         this.checkForCorrectDataType(param1);
         return (param1 as Vector.<int>).splice(param2,1)[0];
      }
      
      public function removeAll(param1:Object) : void
      {
         this.checkForCorrectDataType(param1);
         (param1 as Vector.<int>).length = 0;
      }
      
      public function getItemIndex(param1:Object, param2:Object) : int
      {
         this.checkForCorrectDataType(param1);
         return (param1 as Vector.<int>).indexOf(param2 as int);
      }
      
      protected function checkForCorrectDataType(param1:Object) : void
      {
         if(!(param1 is Vector.<int>))
         {
            throw new IllegalOperationError("Expected Vector.<int>. Received " + Object(param1).constructor + " instead.");
         }
      }
   }
}
