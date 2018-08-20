package battle.proxy.idents
{
   import battle.data.BattleSkillDescription;
   import flash.Boot;
   
   public class HeroAnimationIdent
   {
      
      public static var NONE:HeroAnimationIdent = new HeroAnimationIdent("NONE");
      
      public static var IDLE:HeroAnimationIdent = new HeroAnimationIdent("IDLE");
      
      public static var RUN:HeroAnimationIdent = new HeroAnimationIdent("RUN");
      
      public static var DIE:HeroAnimationIdent = new HeroAnimationIdent("DEATH");
      
      public static var WIN:HeroAnimationIdent = new HeroAnimationIdent("WIN");
      
      public static var POSE:HeroAnimationIdent = new HeroAnimationIdent("POSE");
      
      public static var HURT:HeroAnimationIdent = new HeroAnimationIdent("HURT");
      
      public static var ATTACK:HeroAnimationIdent = new HeroAnimationIdent("ATTACK");
      
      public static var ULT:HeroAnimationIdent = new HeroAnimationIdent("ULT");
      
      public static var SKILL1:HeroAnimationIdent = new HeroAnimationIdent("SKILL1");
      
      public static var SKILL2:HeroAnimationIdent = new HeroAnimationIdent("SKILL2");
      
      public static var SKILL3:HeroAnimationIdent = new HeroAnimationIdent("SKILL3");
      
      public static var DEFAULT:HeroAnimationIdent = new HeroAnimationIdent("DEFAULT");
      
      public static var _END:HeroAnimationIdent = new HeroAnimationIdent("_END");
      
      public static var skillByTier:Vector.<HeroAnimationIdent> = Vector.<HeroAnimationIdent>([HeroAnimationIdent.ATTACK,HeroAnimationIdent.ULT,HeroAnimationIdent.SKILL1,HeroAnimationIdent.SKILL2,HeroAnimationIdent.SKILL3]);
      
      public static var ANIMATED_TIER:int = 4;
       
      
      public var name:String;
      
      public function HeroAnimationIdent(param1:String = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         name = param1;
      }
      
      public static function bySkill(param1:BattleSkillDescription) : HeroAnimationIdent
      {
         return HeroAnimationIdent.skillByTier[param1.tier];
      }
      
      public function toString() : String
      {
         return "HeroAnimationIdent." + name;
      }
   }
}
