package battle.skills
{
   import battle.DamageValue;
   import battle.timeline.Timeline;
   
   public class EffectFactory
   {
       
      
      public function EffectFactory()
      {
      }
      
      public static function ministunEffect(param1:DamageValue, param2:Timeline) : Effect
      {
         var _loc3_:Effect = new Effect(param2,"stun");
         _loc3_.setSkillCast(param1.source);
         return _loc3_;
      }
      
      public static function disable(param1:SkillCast) : Effect
      {
         var _loc2_:Effect = new Effect(param1.timelineAccess(),param1.skill.effect);
         _loc2_.setSkillCast(param1);
         return _loc2_;
      }
      
      public static function normal(param1:SkillCast, param2:String, param3:Array = undefined, param4:Boolean = false) : Effect
      {
         var _loc5_:Effect = new Effect(param1.timelineAccess(),param2,param3,param4);
         _loc5_.setSkillCast(param1);
         return _loc5_;
      }
   }
}
