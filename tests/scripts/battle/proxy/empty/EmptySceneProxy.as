package battle.proxy.empty
{
   import battle.Hero;
   import battle.Team;
   import battle.data.BattleSkillDescription;
   import battle.objects.BattleBody;
   import battle.objects.EffectHolder;
   import battle.objects.ProjectileEntity;
   import battle.proxy.IBattleBodyProxy;
   import battle.proxy.ISceneProxy;
   import battle.proxy.ViewTransformProvider;
   import battle.proxy.displayEvents.BattleDisplayEvent;
   import battle.proxy.idents.EffectAnimationIdent;
   import battle.proxy.idents.ProjectileMovementIdent;
   import battle.skills.Effect;
   import battle.skills.SkillCast;
   
   public class EmptySceneProxy implements ISceneProxy
   {
       
      
      public function EmptySceneProxy()
      {
      }
      
      public function shakeScreen(param1:Number, param2:Number = 1, param3:Number = 0) : void
      {
      }
      
      public function setSceneTimeOffset(param1:Number) : void
      {
      }
      
      public function setHeroCameraTracking(param1:Hero, param2:Boolean) : void
      {
      }
      
      public function getBodyProxy(param1:BattleBody) : IBattleBodyProxy
      {
         return null;
      }
      
      public function freezeScreen(param1:Number) : void
      {
      }
      
      public function displayEvent(param1:BattleDisplayEvent) : void
      {
      }
      
      public function area(param1:Number, param2:Number, param3:SkillCast) : void
      {
      }
      
      public function addTiledFx(param1:ViewTransformProvider, param2:BattleSkillDescription, param3:EffectAnimationIdent, param4:String) : void
      {
      }
      
      public function addSceneFx(param1:Number, param2:EffectAnimationIdent, param3:BattleSkillDescription, param4:Hero = undefined, param5:int = 0, param6:Number = 0) : void
      {
      }
      
      public function addProjectileHitFx(param1:ProjectileEntity, param2:Hero, param3:BattleSkillDescription) : void
      {
      }
      
      public function addProjectileFx(param1:ProjectileEntity, param2:EffectAnimationIdent, param3:BattleSkillDescription, param4:Number = 0) : void
      {
      }
      
      public function addProjectile(param1:ProjectileEntity, param2:BattleSkillDescription, param3:ProjectileMovementIdent = undefined, param4:EffectAnimationIdent = undefined) : void
      {
      }
      
      public function addHero(param1:Hero) : void
      {
      }
      
      public function addFx(param1:Hero, param2:EffectAnimationIdent, param3:SkillCast, param4:BattleSkillDescription = undefined) : void
      {
      }
      
      public function addEffect(param1:Effect, param2:EffectHolder, param3:EffectAnimationIdent = undefined) : void
      {
      }
      
      public function addComplexFx(param1:ViewTransformProvider, param2:BattleSkillDescription, param3:EffectAnimationIdent, param4:String) : void
      {
      }
      
      public function addBossHpBar(param1:Hero) : void
      {
      }
      
      public function addBody(param1:BattleBody, param2:Team) : IBattleBodyProxy
      {
         return null;
      }
   }
}
