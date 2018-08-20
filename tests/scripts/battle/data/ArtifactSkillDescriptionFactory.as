package battle.data
{
   import battle.action.Action;
   
   public class ArtifactSkillDescriptionFactory
   {
      
      public static var ARTIFACT_TIER:int = 6;
       
      
      public function ArtifactSkillDescriptionFactory()
      {
      }
      
      public static function create(param1:BattleHeroDescription, param2:int, param3:Number, param4:String, param5:Number) : BattleSkillDescription
      {
         var _loc6_:BattleSkillDescription = new BattleSkillDescription(1,param1,ArtifactSkillDescriptionFactory.ARTIFACT_TIER,null);
         _loc6_.behavior = "ArtifactStat";
         _loc6_.range = 0;
         _loc6_.cooldown = 0;
         _loc6_.cooldownInitial = 0;
         _loc6_.animationDelay = 0;
         _loc6_.prime = Action.createConst(param5);
         _loc6_.secondary = Action.createConst(param2);
         _loc6_.projectile = null;
         _loc6_.effect = param4;
         _loc6_.hitrate = -1;
         _loc6_.duration = param3;
         _loc6_.hits = 0;
         _loc6_.area = 0;
         _loc6_.delay = 0;
         return _loc6_;
      }
      
      public static function createTitan(param1:BattleHeroDescription, param2:String, param3:Number, param4:int) : BattleSkillDescription
      {
         var _loc5_:BattleSkillDescription = new BattleSkillDescription(1,param1,ArtifactSkillDescriptionFactory.ARTIFACT_TIER,null);
         _loc5_.behavior = "TitanArtifactElement";
         _loc5_.range = 0;
         _loc5_.cooldown = 0;
         _loc5_.cooldownInitial = 0;
         _loc5_.animationDelay = 0;
         _loc5_.prime = Action.createConst(param3,DamageType.PHYSICAL);
         _loc5_.projectile = null;
         _loc5_.level = param4;
         _loc5_.effect = param2;
         _loc5_.hitrate = -1;
         _loc5_.hits = 0;
         _loc5_.area = 0;
         _loc5_.delay = 0;
         return _loc5_;
      }
   }
}
