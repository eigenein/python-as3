package battle
{
   import battle.data.DamageType;
   import battle.logic.MovingBody;
   import battle.skills.SkillCast;
   
   public class DamageValue
   {
       
      
      public var type:DamageType;
      
      public var sourceValue:int;
      
      public var source:SkillCast;
      
      public var resultValue:int;
      
      public var redirected:Boolean;
      
      public var missed:Boolean;
      
      public var immune:Boolean;
      
      public var hitLevel:int;
      
      public var element:String;
      
      public var dodged:Boolean;
      
      public var dodgeRoll:int;
      
      public var currentTarget:Hero;
      
      public var crited:Boolean;
      
      public var critRoll:int;
      
      public var blocked:Boolean;
      
      public var applied:Boolean;
      
      public function DamageValue()
      {
      }
      
      public static function create(param1:Number, param2:SkillCast, param3:DamageType, param4:Hero, param5:Boolean = false) : DamageValue
      {
         var _loc6_:DamageValue = new DamageValue();
         var _loc7_:int = param1;
         _loc6_.sourceValue = _loc7_;
         _loc6_.resultValue = _loc7_;
         _loc6_.source = param2;
         _loc6_.type = param3;
         var _loc8_:Boolean = false;
         _loc6_.blocked = _loc8_;
         _loc8_ = _loc8_;
         _loc6_.immune = _loc8_;
         _loc8_ = _loc8_;
         _loc6_.crited = _loc8_;
         _loc8_ = _loc8_;
         _loc6_.dodged = _loc8_;
         _loc8_ = _loc8_;
         _loc6_.missed = _loc8_;
         _loc6_.applied = _loc8_;
         _loc6_.hitLevel = 0;
         _loc6_.element = null;
         _loc6_.redirected = param5;
         _loc7_ = -1;
         _loc6_.dodgeRoll = _loc7_;
         _loc6_.critRoll = _loc7_;
         _loc6_.currentTarget = param4;
         return _loc6_;
      }
      
      public function getSourcePosition() : Number
      {
         if(source != null && source.hero != null)
         {
            return source.hero.get_updatedBody().x;
         }
         return 0;
      }
      
      public function dispose() : void
      {
      }
   }
}
