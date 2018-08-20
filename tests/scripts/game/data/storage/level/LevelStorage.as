package game.data.storage.level
{
   import game.data.cost.CostData;
   import game.data.storage.rewardmodifier.RewardModifierDescription;
   
   public class LevelStorage
   {
       
      
      private const hero:Array = [];
      
      private const titan:Array = [];
      
      private const team:Array = [];
      
      private const vip:Array = [];
      
      private const skillLevelCost:Array = [];
      
      private const alchemy:Array = [];
      
      private const clan:Array = [];
      
      public function LevelStorage()
      {
         super();
      }
      
      public function init(param1:Object) : void
      {
         parseVect(hero,param1["hero"],HeroLevel);
         parseVect(titan,param1["titan"],TitanLevel);
         parseVect(team,param1["teamDelta"],PlayerTeamLevel);
         parseVect(vip,param1["vip"],VIPLevel);
         parseVect(alchemy,param1["alchemy"],AlchemyLevel);
         parseVect(clan,param1["clan"],ClanLevel);
         parseVect(skillLevelCost,param1["skillLevelCost"],SkillLevelCost,false);
      }
      
      private function getLevel(param1:Array, param2:int) : LevelBase
      {
         var _loc4_:int = 0;
         var _loc3_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(param1[_loc4_].exp > param2)
            {
               if(_loc4_ > 0)
               {
                  return param1[_loc4_ - 1];
               }
               return null;
            }
            _loc4_++;
         }
         return param1[param1.length - 1];
      }
      
      private function parseVect(param1:Array, param2:Object, param3:Class, param4:Boolean = true) : void
      {
         var _loc5_:* = null;
         var _loc7_:int = 0;
         var _loc10_:int = 0;
         var _loc9_:* = param2;
         for(var _loc8_ in param2)
         {
            _loc5_ = new param3(param2[_loc8_]) as LevelBase;
            param1.push(_loc5_);
         }
         if(param4)
         {
            param1.sort(_sort);
         }
         var _loc6_:int = param1.length;
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            if(_loc7_ > 0)
            {
               (param1[_loc7_] as LevelBase).prevLevel = param1[_loc7_ - 1];
            }
            if(_loc7_ != _loc6_ - 1)
            {
               (param1[_loc7_] as LevelBase).nextLevel = param1[_loc7_ + 1];
            }
            _loc7_++;
         }
      }
      
      private function _sort(param1:LevelBase, param2:LevelBase) : int
      {
         return param1.exp - param2.exp;
      }
      
      public function getVipLevelByVipPoints(param1:int) : VIPLevel
      {
         return getLevel(vip,param1) as VIPLevel;
      }
      
      public function getVipLevelWithRewardMod(param1:RewardModifierDescription) : VIPLevel
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = vip.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = vip[_loc4_];
            if(_loc2_.rewardModifier && _loc2_.rewardModifier.indexOf(param1.id) != -1)
            {
               return _loc2_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function getVipLevel(param1:int) : VIPLevel
      {
         if(param1 >= vip.length || param1 < 0)
         {
            return null;
         }
         return vip[param1];
      }
      
      public function getTeamLevel(param1:int) : PlayerTeamLevel
      {
         return getLevel(team,param1) as PlayerTeamLevel;
      }
      
      public function getTeamLevelByLevel(param1:int) : PlayerTeamLevel
      {
         if(param1 > team.length || param1 < 1)
         {
            return null;
         }
         return team[param1 - 1];
      }
      
      public function getMaxTeamLevel() : int
      {
         return (team[team.length - 1] as PlayerTeamLevel).level;
      }
      
      public function getSkillLevelCost(param1:int, param2:int) : CostData
      {
         var _loc3_:SkillLevelCost = skillLevelCost[param1];
         if(_loc3_)
         {
            return _loc3_.getTierCost(param2);
         }
         return null;
      }
      
      public function getHeroLevelByExp(param1:int) : HeroLevel
      {
         return getLevel(hero,param1) as HeroLevel;
      }
      
      public function getHeroLevel(param1:int) : HeroLevel
      {
         if(param1 - 1 >= hero.length || param1 < 1)
         {
            return null;
         }
         return hero[param1 - 1];
      }
      
      public function getTitanLevelByExp(param1:int) : TitanLevel
      {
         return getLevel(titan,param1) as TitanLevel;
      }
      
      public function getTitanLevel(param1:int) : TitanLevel
      {
         if(param1 - 1 >= titan.length || param1 < 1)
         {
            return null;
         }
         return titan[param1 - 1];
      }
      
      public function getAlchemyLevel(param1:int) : AlchemyLevel
      {
         if(!alchemy[param1])
         {
            return alchemy[alchemy.length];
         }
         return alchemy[param1];
      }
      
      public function getClanLevel(param1:int) : ClanLevel
      {
         return clan[param1 - 1];
      }
   }
}
