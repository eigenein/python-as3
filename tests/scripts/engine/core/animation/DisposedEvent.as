package engine.core.animation
{
   import starling.events.Event;
   
   public class DisposedEvent extends Event
   {
      
      public static const DISPOSED:String = "disposed";
       
      
      public function DisposedEvent(param1:String, param2:Boolean = false, param3:Object = null)
      {
         super(param1,param2,param3);
      }
   }
}
