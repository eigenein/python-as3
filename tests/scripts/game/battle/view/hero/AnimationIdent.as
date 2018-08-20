package game.battle.view.hero
{
   import battle.proxy.idents.HeroAnimationIdent;
   import flash.utils.Dictionary;
   
   public class AnimationIdent
   {
      
      public static const NONE:AnimationIdent = new AnimationIdent();
      
      public static const IDLE:AnimationIdent = new AnimationIdent();
      
      public static const RUN:AnimationIdent = new AnimationIdent();
      
      public static const STRAFE:AnimationIdent = new AnimationIdent();
      
      public static const HURT:AnimationIdent = new AnimationIdent();
      
      public static const DIE:AnimationIdent = new AnimationIdent();
      
      public static const ATTACK:AnimationIdent = new AnimationIdent();
      
      public static const SKILL1:AnimationIdent = new AnimationIdent();
      
      public static const SKILL2:AnimationIdent = new AnimationIdent();
      
      public static const SKILL3:AnimationIdent = new AnimationIdent();
      
      public static const ULT:AnimationIdent = new AnimationIdent();
      
      public static const WIN:AnimationIdent = new AnimationIdent();
      
      public static const POSE:AnimationIdent = new AnimationIdent();
      
      public static const RUN_END:AnimationIdent = new AnimationIdent();
      
      public static const attacks:Vector.<AnimationIdent> = new <AnimationIdent>[ATTACK,ULT,SKILL1,SKILL2,SKILL3];
      
      private static var mapping:Dictionary;
       
      
      public function AnimationIdent()
      {
         super();
      }
      
      public static function fromBattleAnimationIdent(param1:HeroAnimationIdent) : AnimationIdent
      {
         if(!mapping)
         {
            createMapping();
         }
         return mapping[param1];
      }
      
      private static function createMapping() : void
      {
         mapping = new Dictionary();
         mapping[HeroAnimationIdent.ATTACK] = ATTACK;
         mapping[HeroAnimationIdent.NONE] = IDLE;
         mapping[HeroAnimationIdent.IDLE] = IDLE;
         mapping[HeroAnimationIdent.RUN] = RUN;
         mapping[HeroAnimationIdent.HURT] = HURT;
         mapping[HeroAnimationIdent.DIE] = DIE;
         mapping[HeroAnimationIdent.ATTACK] = ATTACK;
         mapping[HeroAnimationIdent.SKILL1] = SKILL1;
         mapping[HeroAnimationIdent.SKILL2] = SKILL2;
         mapping[HeroAnimationIdent.SKILL3] = SKILL3;
         mapping[HeroAnimationIdent.ULT] = ULT;
         mapping[HeroAnimationIdent.WIN] = WIN;
         mapping[HeroAnimationIdent.POSE] = POSE;
      }
   }
}
