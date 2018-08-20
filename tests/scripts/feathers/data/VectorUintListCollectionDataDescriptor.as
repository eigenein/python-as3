package feathers.data
{
   import flash.errors.IllegalOperationError;
   
   public class VectorUintListCollectionDataDescriptor implements IListCollectionDataDescriptor
   {
       
      
      public function VectorUintListCollectionDataDescriptor()
      {
         super();
      }
      
      public function getLength(param1:Object) : int
      {
         this.checkForCorrectDataType(param1);
         return (param1 as Vector.<uint>).length;
      }
      
      public function getItemAt(param1:Object, param2:int) : Object
      {
         this.checkForCorrectDataType(param1);
         return (param1 as Vector.<uint>)[param2];
      }
      
      public function setItemAt(param1:Object, param2:Object, param3:int) : void
      {
         this.checkForCorrectDataType(param1);
         (param1 as Vector.<uint>)[param3] = param2 as uint;
      }
      
      public function addItemAt(param1:Object, param2:Object, param3:int) : void
      {
         this.checkForCorrectDataType(param1);
         (param1 as Vector.<uint>).splice(param3,0,param2);
      }
      
      public function removeItemAt(param1:Object, param2:int) : Object
      {
         this.checkForCorrectDataType(param1);
         return (param1 as Vector.<uint>).splice(param2,1)[0];
      }
      
      public function removeAll(param1:Object) : void
      {
         this.checkForCorrectDataType(param1);
         (param1 as Vector.<uint>).length = 0;
      }
      
      public function getItemIndex(param1:Object, param2:Object) : int
      {
         this.checkForCorrectDataType(param1);
         return (param1 as Vector.<uint>).indexOf(param2 as uint);
      }
      
      protected function checkForCorrectDataType(param1:Object) : void
      {
         if(!(param1 is Vector.<uint>))
         {
            throw new IllegalOperationError("Expected Vector.<uint>. Received " + Object(param1).constructor + " instead.");
         }
      }
   }
}
