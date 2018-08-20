package battle.proxy.empty
{
   import battle.DamageValue;
   import battle.proxy.HeroViewAnchors;
   import battle.proxy.IHeroProxy;
   import battle.proxy.idents.HeroAnimationIdent;
   import battle.proxy.idents.SwitchHeroAssetIdent;
   import battle.skills.SkillCast;
   import flash.Boot;
   
   public class EmptyHeroProxy implements IHeroProxy
   {
      
      public static var instance:EmptyHeroProxy = new EmptyHeroProxy();
       
      
      public var anchors:HeroViewAnchors;
      
      public function EmptyHeroProxy()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         anchors = new HeroViewAnchors();
      }
      
      public function ultAnimation(param1:SkillCast) : void
      {
      }
      
      public function stopAnimation(param1:HeroAnimationIdent, param2:Boolean) : void
      {
      }
      
      public function setYPosition(param1:Number) : void
      {
      }
      
      public function setWeaponRotation(param1:Number, param2:Number, param3:int, param4:Number) : void
      {
      }
      
      public function setAsset(param1:SwitchHeroAssetIdent, param2:Boolean = false) : void
      {
      }
      
      public function setAnimation(param1:HeroAnimationIdent, param2:String) : void
      {
      }
      
      public function onTakeHeal(param1:Number) : void
      {
      }
      
      public function onTakeDamage(param1:DamageValue) : void
      {
      }
      
      public function onHpModify(param1:Number) : void
      {
      }
      
      public function onEnergyModify(param1:Number) : void
      {
      }
      
      public function onDie() : void
      {
      }
      
      public function getAnchors() : HeroViewAnchors
      {
         return anchors;
      }
      
      public function energyGenerated(param1:int) : void
      {
      }
      
      public function energyBurned(param1:int) : void
      {
      }
      
      public function energyBlocked(param1:int) : void
      {
      }
      
      public function disableAndStopWhenCompleted() : void
      {
      }
   }
}
