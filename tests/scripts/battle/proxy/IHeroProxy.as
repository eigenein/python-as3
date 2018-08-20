package battle.proxy
{
   import battle.DamageValue;
   import battle.proxy.idents.HeroAnimationIdent;
   import battle.proxy.idents.SwitchHeroAssetIdent;
   import battle.skills.SkillCast;
   
   public interface IHeroProxy
   {
       
      
      function ultAnimation(param1:SkillCast) : void;
      
      function stopAnimation(param1:HeroAnimationIdent, param2:Boolean) : void;
      
      function setYPosition(param1:Number) : void;
      
      function setWeaponRotation(param1:Number, param2:Number, param3:int, param4:Number) : void;
      
      function setAsset(param1:SwitchHeroAssetIdent, param2:Boolean = undefined) : void;
      
      function setAnimation(param1:HeroAnimationIdent, param2:String) : void;
      
      function onTakeHeal(param1:Number) : void;
      
      function onTakeDamage(param1:DamageValue) : void;
      
      function onHpModify(param1:Number) : void;
      
      function onEnergyModify(param1:Number) : void;
      
      function onDie() : void;
      
      function getAnchors() : HeroViewAnchors;
      
      function energyGenerated(param1:int) : void;
      
      function energyBurned(param1:int) : void;
      
      function energyBlocked(param1:int) : void;
      
      function disableAndStopWhenCompleted() : void;
   }
}
