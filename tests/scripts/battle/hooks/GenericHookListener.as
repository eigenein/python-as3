package battle.hooks
{
   import flash.Boot;
   
   public class GenericHookListener
   {
       
      
      public var next:GenericHookListener;
      
      public var callback:Function;
      
      public function GenericHookListener(param1:Function = undefined, param2:GenericHookListener = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         callback = param1;
         next = param2;
      }
   }
}
