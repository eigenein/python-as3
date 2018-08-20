package battle.proxy
{
   import flash.Boot;
   
   public class ComplexAnimationProxy
   {
       
      
      public var p:ComplexAnimationParams;
      
      public function ComplexAnimationProxy(param1:* = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         p = new ComplexAnimationParams();
         if(param1.hasOwnProperty("getTransform"))
         {
            p.getTransform = param1.getTransform;
         }
      }
      
      public function remove() : ViewTransform
      {
         p.remove(this);
         return null;
      }
      
      public function getTransform() : ViewTransform
      {
         return p.getTransform(this);
      }
      
      public function getTimeRelativeTransform() : ViewTransform
      {
         return p.getTimeRelativeTransform(this,0);
      }
   }
}
