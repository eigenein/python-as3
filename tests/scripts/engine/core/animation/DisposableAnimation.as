package engine.core.animation
{
   import starling.errors.AbstractMethodError;
   
   public class DisposableAnimation
   {
       
      
      private var containers:Vector.<IDisposableAnimationContainer>;
      
      public function DisposableAnimation()
      {
         super();
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         if(containers != null)
         {
            _loc2_ = containers.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               containers[_loc1_].handleRemovedChild(this);
               _loc1_++;
            }
            containers = null;
         }
      }
      
      public function get completed() : Boolean
      {
         return false;
      }
      
      public final function addOnDispose(param1:IDisposableAnimationContainer) : void
      {
         if(containers == null)
         {
            containers = new Vector.<IDisposableAnimationContainer>();
         }
         containers.push(param1);
      }
      
      public function advanceTime(param1:Number) : void
      {
         throw new AbstractMethodError();
      }
   }
}
