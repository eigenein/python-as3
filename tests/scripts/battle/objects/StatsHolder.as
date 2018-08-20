package battle.objects
{
   import battle.BattleEngine;
   import battle.HeroStats;
   import battle.data.HeroState;
   import battle.data.MainStat;
   import battle.effects.IStatsInvalidator;
   import battle.logic.MovingBody;
   import flash.Boot;
   
   public class StatsHolder extends BattleBody implements IStatsInvalidator
   {
       
      
      public var statsInvalidated:Boolean;
      
      public var stats:HeroStats;
      
      public var state:HeroState;
      
      public function StatsHolder(param1:BattleEngine = undefined, param2:Number = 0.0)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1,new MovingBody(param2));
         stats = new HeroStats();
         statsInvalidated = true;
      }
      
      public function updatedStats() : HeroStats
      {
         if(statsInvalidated)
         {
            updateStats();
         }
         return stats;
      }
      
      public function updateStats() : void
      {
         stats.copyFromHeroStats(getPrimaryStats());
         var _loc1_:HeroStats = stats;
         var _loc2_:MainStat = _loc1_.mainStat;
         _loc1_.physicalAttack = Number(_loc1_.physicalAttack + (Number((_loc2_ == MainStat.intelligence?_loc1_.intelligence:_loc2_ == MainStat.agility?_loc1_.agility:_loc1_.strength) + _loc1_.agility * 2)));
         _loc1_.hp = int(Number(_loc1_.hp + 40 * _loc1_.strength));
         _loc1_.armor = Number(_loc1_.armor + _loc1_.agility);
         _loc1_.magicPower = Number(_loc1_.magicPower + _loc1_.intelligence * 3);
         _loc1_.magicResist = Number(_loc1_.magicResist + _loc1_.intelligence);
         _loc2_ = _loc1_.mainStat;
         if(_loc2_ == MainStat.intelligence)
         {
            _loc1_.antidodge = Number(_loc1_.antidodge + _loc1_.intelligence);
         }
         else if(_loc2_ == MainStat.agility)
         {
            _loc1_.antidodge = Number(_loc1_.antidodge + _loc1_.agility);
         }
         else
         {
            _loc1_.antidodge = Number(_loc1_.antidodge + _loc1_.strength);
         }
         _loc2_ = _loc1_.mainStat;
         if(_loc2_ == MainStat.intelligence)
         {
            _loc1_.anticrit = Number(_loc1_.anticrit + _loc1_.intelligence);
         }
         else if(_loc2_ == MainStat.agility)
         {
            _loc1_.anticrit = Number(_loc1_.anticrit + _loc1_.agility);
         }
         else
         {
            _loc1_.anticrit = Number(_loc1_.anticrit + _loc1_.strength);
         }
         statsInvalidated = false;
      }
      
      public function invalidateStats() : void
      {
         statsInvalidated = true;
      }
      
      public function get_isDead() : Boolean
      {
         return state.isDead;
      }
      
      public function getPrimaryStats() : HeroStats
      {
         return null;
      }
      
      public function getMaxHp() : int
      {
         if(statsInvalidated)
         {
            updateStats();
         }
         return stats.hp;
      }
      
      public function getIsDead() : Boolean
      {
         return Boolean(get_isDead());
      }
   }
}
