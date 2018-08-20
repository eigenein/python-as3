package haxe
{
   import haxe._List.ListIterator;
   
   public class List
   {
       
      
      public var h:Array;
      
      public function List()
      {
      }
      
      public function iterator() : ListIterator
      {
         return new ListIterator(h);
      }
   }
}
