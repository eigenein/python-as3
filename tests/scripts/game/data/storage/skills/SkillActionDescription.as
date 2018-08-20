package game.data.storage.skills
{
   import battle.BattleStats;
   
   public class SkillActionDescription
   {
       
      
      public var type:String = null;
      
      public var base:String = null;
      
      public var K:Number = NaN;
      
      public var c:Number = NaN;
      
      public var scale:Number = NaN;
      
      public function SkillActionDescription()
      {
         super();
      }
      
      public static function create(param1:*) : SkillActionDescription
      {
         if(!param1)
         {
            return null;
         }
         var _loc2_:SkillActionDescription = new SkillActionDescription();
         _loc2_.type = param1.type;
         _loc2_.base = param1.base;
         _loc2_.K = Number(param1.K);
         _loc2_.c = Number(param1.c);
         _loc2_.scale = Number(param1.scale);
         return _loc2_;
      }
      
      public function getValue(param1:BattleStats, param2:int) : Number
      {
         var _loc5_:Number = !!this.K?this.K:1;
         var _loc3_:Number = !!this.c?this.c:0;
         var _loc4_:Number = !!this.scale?this.scale:0;
         if(param1 && base == "HP")
         {
            return param1.hp * _loc5_ + _loc3_ + _loc4_ * param2;
         }
         if(param1 && base == "MP")
         {
            return param1.magicPower * _loc5_ + _loc3_ + _loc4_ * param2;
         }
         if(param1 && base == "PA")
         {
            return param1.physicalAttack * _loc5_ + _loc3_ + _loc4_ * param2;
         }
         return _loc3_ + _loc4_ * param2;
      }
   }
}
