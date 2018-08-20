package haxe.ds
{
   import flash.Boot;
   import flash.utils.Dictionary;
   import haxe.IMap;
   
   public class UnsafeStringMap implements IMap
   {
       
      
      public var h:Dictionary;
      
      public function UnsafeStringMap()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         h = new Dictionary();
      }
   }
}
