package battle.proxy
{
   import battle.Hero;
   import battle.Team;
   import battle.data.BattleSkillDescription;
   import battle.objects.BattleBody;
   import battle.objects.EffectHolder;
   import battle.objects.ProjectileEntity;
   import battle.proxy.displayEvents.BattleDisplayEvent;
   import battle.proxy.idents.EffectAnimationIdent;
   import battle.proxy.idents.ProjectileMovementIdent;
   import battle.skills.Effect;
   import battle.skills.SkillCast;
   
   public interface ISceneProxy
   {
       
      
      function shakeScreen(param1:Number, param2:Number = undefined, param3:Number = undefined) : void;
      
      function setSceneTimeOffset(param1:Number) : void;
      
      function setHeroCameraTracking(param1:Hero, param2:Boolean) : void;
      
      function getBodyProxy(param1:BattleBody) : IBattleBodyProxy;
      
      function freezeScreen(param1:Number) : void;
      
      function displayEvent(param1:BattleDisplayEvent) : void;
      
      function area(param1:Number, param2:Number, param3:SkillCast) : void;
      
      function addTiledFx(param1:ViewTransformProvider, param2:BattleSkillDescription, param3:EffectAnimationIdent, param4:String) : void;
      
      function addSceneFx(param1:Number, param2:EffectAnimationIdent, param3:BattleSkillDescription, param4:Hero = undefined, param5:int = undefined, param6:Number = undefined) : void;
      
      function addProjectileHitFx(param1:ProjectileEntity, param2:Hero, param3:BattleSkillDescription) : void;
      
      function addProjectileFx(param1:ProjectileEntity, param2:EffectAnimationIdent, param3:BattleSkillDescription, param4:Number = undefined) : void;
      
      function addProjectile(param1:ProjectileEntity, param2:BattleSkillDescription, param3:ProjectileMovementIdent = undefined, param4:EffectAnimationIdent = undefined) : void;
      
      function addHero(param1:Hero) : void;
      
      function addFx(param1:Hero, param2:EffectAnimationIdent, param3:SkillCast, param4:BattleSkillDescription = undefined) : void;
      
      function addEffect(param1:Effect, param2:EffectHolder, param3:EffectAnimationIdent = undefined) : void;
      
      function addComplexFx(param1:ViewTransformProvider, param2:BattleSkillDescription, param3:EffectAnimationIdent, param4:String) : void;
      
      function addBossHpBar(param1:Hero) : void;
      
      function addBody(param1:BattleBody, param2:Team) : IBattleBodyProxy;
   }
}
