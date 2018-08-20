package haxe.ds
{
   import flash.Boot;
   import flash.utils.Dictionary;
   import haxe.IMap;
   
   public dynamic class ObjectMap extends Dictionary implements IMap
   {
       
      
      public function ObjectMap()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(false);
      }
   }
}
