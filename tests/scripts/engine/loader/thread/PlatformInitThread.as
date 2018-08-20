package engine.loader.thread
{
   import engine.core.utils.thread.Thread;
   
   public class PlatformInitThread extends Thread
   {
       
      
      protected var inited:Boolean;
      
      public function PlatformInitThread()
      {
         super();
      }
      
      override public function get progressCurrent() : uint
      {
         return 0;
      }
      
      override public function get progressTotal() : uint
      {
         return 1;
      }
   }
}
