package engine.core.utils.thread
{
   import avmplus.getQualifiedClassName;
   import idv.cjcat.signals.Signal;
   
   public class Thread
   {
      
      private static var uidCounter:uint = 0;
       
      
      private var uid:uint = 0;
      
      public const eventComplete:Signal = new Signal(Thread);
      
      public const eventProgress:Signal = new Signal(Thread);
      
      public const eventError:Signal = new Signal(Thread);
      
      public function Thread()
      {
         super();
         uidCounter = Number(uidCounter) + 1;
         uid = Number(uidCounter);
      }
      
      public function get progressCurrent() : uint
      {
         return 0;
      }
      
      public function get progressTotal() : uint
      {
         return 0;
      }
      
      public final function get id() : uint
      {
         return uid;
      }
      
      public function toString() : String
      {
         var _loc1_:String = getQualifiedClassName(this);
         var _loc2_:int = _loc1_.indexOf("::");
         return (_loc2_ == -1?_loc1_:_loc1_.slice(_loc2_ + 2)) + "[" + uid + "]";
      }
      
      public function run() : void
      {
      }
      
      public function dispose() : void
      {
         eventComplete.clear();
         eventProgress.clear();
         eventError.clear();
      }
   }
}
