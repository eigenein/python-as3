package battle.proxy.empty
{
   import battle.proxy.IEffectProxy;
   
   public class EmptyEffectProxy implements IEffectProxy
   {
      
      public static var instance:EmptyEffectProxy = new EmptyEffectProxy();
       
      
      public function EmptyEffectProxy()
      {
      }
      
      public function switchAsset(param1:String) : void
      {
      }
      
      public function setTime(param1:Number) : void
      {
      }
      
      public function playOnce(param1:String) : void
      {
      }
   }
}
