package battle.hooks
{
   import flash.Boot;
   
   public class HeroHooks
   {
       
      
      public var setAnimation:GenericHook_battle_proxy_idents_HeroAnimationIdent;
      
      public var modifyHp:GenericHook_Int;
      
      public var increaseEnergy:GenericHook_Int;
      
      public var getVisualPosition:GenericHook_Float;
      
      public var energyChanged:GenericHook_Int;
      
      public var die:GenericHook_Bool;
      
      public var decreaseEnergy:GenericHook_Int;
      
      public var dealDamage:GenericHook_battle_DamageValue;
      
      public var castSkill:GenericHook_battle_skills_SkillCast;
      
      public var burnUltEnergy:GenericHook_Int;
      
      public function HeroHooks()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         die = new GenericHook_Bool();
         burnUltEnergy = new GenericHook_Int();
         castSkill = new GenericHook_battle_skills_SkillCast();
         dealDamage = new GenericHook_battle_DamageValue();
         energyChanged = new GenericHook_Int();
         decreaseEnergy = new GenericHook_Int();
         increaseEnergy = new GenericHook_Int();
         modifyHp = new GenericHook_Int();
         getVisualPosition = new GenericHook_Float();
         setAnimation = new GenericHook_battle_proxy_idents_HeroAnimationIdent();
      }
   }
}
