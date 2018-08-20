package battle.proxy
{
   import battle.proxy.idents.EffectAnimationIdent;
   
   public interface IProjectileProxy
   {
       
      
      function switchAsset(param1:EffectAnimationIdent) : void;
      
      function projectileHit() : void;
      
      function getViewPosition() : ViewPosition;
   }
}
