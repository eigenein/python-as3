package haxe.ds
{
   import flash.Boot;
   import haxe.IMap;
   
   public class StringMap implements IMap
   {
      
      public static var reserved:Object = {};
       
      
      public var rh;
      
      public var h;
      
      public function StringMap()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         h = {};
      }
      
      public function setReserved(param1:String, param2:Object) : void
      {
         if(rh == null)
         {
            rh = {};
         }
         rh["$" + param1] = param2;
      }
      
      public function getReserved(param1:String) : Object
      {
         if(rh == null)
         {
            return null;
         }
         return rh["$" + param1];
      }
      
      public function existsReserved(param1:String) : Boolean
      {
         if(rh == null)
         {
            return false;
         }
         return "$" + param1 in rh;
      }
   }
}
