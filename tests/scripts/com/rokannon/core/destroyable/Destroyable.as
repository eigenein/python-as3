package com.rokannon.core.destroyable
{
   public class Destroyable implements IDestroyable
   {
       
      
      private var _destroyed:Boolean = false;
      
      public function Destroyable()
      {
         super();
      }
      
      public final function get destroyed() : Boolean
      {
         return _destroyed;
      }
      
      public final function destroy() : void
      {
         if(_destroyed)
         {
            return;
         }
         _destroy();
         if(!_destroyed)
         {
            throw "Object was not completely destroyed.";
         }
      }
      
      protected function _destroy() : void
      {
         _destroyed = true;
      }
   }
}
