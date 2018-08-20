package game.battle.controller.hero
{
   import battle.data.BattleHeroDescription;
   import battle.log.BattleLogNameResolver;
   import flash.utils.Dictionary;
   import game.data.storage.DataStorage;
   import game.data.storage.skills.SkillDescription;
   
   public class GameBattleLogNameResolver extends BattleLogNameResolver
   {
       
      
      private var heroDescByHeroId:Dictionary;
      
      public function GameBattleLogNameResolver(param1:Dictionary)
      {
         super();
         this.heroDescByHeroId = param1;
      }
      
      override public function hero(param1:int) : String
      {
         var _loc2_:BattleHeroDescription = heroDescByHeroId[param1] as BattleHeroDescription;
         return !!_loc2_?_loc2_.name:"~";
      }
      
      override public function skill(param1:int, param2:int) : String
      {
         var _loc3_:* = null;
         var _loc4_:BattleHeroDescription = heroDescByHeroId[param2] as BattleHeroDescription;
         if(_loc4_)
         {
            _loc3_ = DataStorage.skill.getByHeroAndTier(_loc4_.heroId,param1);
            if(_loc3_)
            {
               return param1 + ". " + _loc3_.name;
            }
            return param1 + "";
         }
         return "?";
      }
   }
}
