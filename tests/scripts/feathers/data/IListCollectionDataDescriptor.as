package feathers.data
{
   public interface IListCollectionDataDescriptor
   {
       
      
      function getLength(param1:Object) : int;
      
      function getItemAt(param1:Object, param2:int) : Object;
      
      function setItemAt(param1:Object, param2:Object, param3:int) : void;
      
      function addItemAt(param1:Object, param2:Object, param3:int) : void;
      
      function removeItemAt(param1:Object, param2:int) : Object;
      
      function getItemIndex(param1:Object, param2:Object) : int;
      
      function removeAll(param1:Object) : void;
   }
}
