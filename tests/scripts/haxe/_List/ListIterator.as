package haxe._List
{
   import flash.Boot;
   
   public class ListIterator
   {
       
      
      public var val;
      
      public var head:Array;
      
      public function ListIterator(param1:Array = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         head = param1;
         val = null;
      }
      
      public function next() : Object
      {
         val = head[0];
         head = head[1];
         return val;
      }
      
      public function hasNext() : Boolean
      {
         return head != null;
      }
   }
}
