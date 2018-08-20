package battle.timeline
{
   import flash.Boot;
   
   public class CallbackNode
   {
       
      
      public var time:Number;
      
      public var callback:Function;
      
      public function CallbackNode()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         time = 0;
      }
      
      public function toString() : String
      {
         return "(" + time + ")";
      }
   }
}
