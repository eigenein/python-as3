package feathers.data
{
   import flash.errors.IllegalOperationError;
   
   public class VectorNumberListCollectionDataDescriptor implements IListCollectionDataDescriptor
   {
       
      
      public function VectorNumberListCollectionDataDescriptor()
      {
         super();
      }
      
      public function getLength(param1:Object) : int
      {
         this.checkForCorrectDataType(param1);
         return (param1 as Vector.<Number>).length;
      }
      
      public function getItemAt(param1:Object, param2:int) : Object
      {
         this.checkForCorrectDataType(param1);
         return (param1 as Vector.<Number>)[param2];
      }
      
      public function setItemAt(param1:Object, param2:Object, param3:int) : void
      {
         this.checkForCorrectDataType(param1);
         (param1 as Vector.<Number>)[param3] = param2 as Number;
      }
      
      public function addItemAt(param1:Object, param2:Object, param3:int) : void
      {
         this.checkForCorrectDataType(param1);
         (param1 as Vector.<Number>).splice(param3,0,param2);
      }
      
      public function removeItemAt(param1:Object, param2:int) : Object
      {
         this.checkForCorrectDataType(param1);
         return (param1 as Vector.<Number>).splice(param2,1)[0];
      }
      
      public function removeAll(param1:Object) : void
      {
         this.checkForCorrectDataType(param1);
         (param1 as Vector.<Number>).length = 0;
      }
      
      public function getItemIndex(param1:Object, param2:Object) : int
      {
         this.checkForCorrectDataType(param1);
         return (param1 as Vector.<Number>).indexOf(param2 as Number);
      }
      
      protected function checkForCorrectDataType(param1:Object) : void
      {
         if(!(param1 is Vector.<Number>))
         {
            throw new IllegalOperationError("Expected Vector.<Number>. Received " + Object(param1).constructor + " instead.");
         }
      }
   }
}
