package haxe.ds
{
   import flash.Boot;
   import flash.utils.Dictionary;
   import haxe.IMap;
   
   public class IntMap implements IMap
   {
       
      
      public var h:Dictionary;
      
      public function IntMap()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         h = new Dictionary();
      }
   }
}
