package battle.proxy.empty
{
   import battle.proxy.IProjectileProxy;
   import battle.proxy.ViewPosition;
   import battle.proxy.idents.EffectAnimationIdent;
   
   public class EmptyProjectileProxy implements IProjectileProxy
   {
      
      public static var instance:EmptyProjectileProxy = new EmptyProjectileProxy();
       
      
      public function EmptyProjectileProxy()
      {
      }
      
      public function switchAsset(param1:EffectAnimationIdent) : void
      {
      }
      
      public function projectileHit() : void
      {
      }
      
      public function getViewPosition() : ViewPosition
      {
         return null;
      }
   }
}
