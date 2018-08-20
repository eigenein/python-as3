package game.mediator.gui.popup.arena
{
   import flash.utils.Dictionary;
   import game.battle.controller.MultiBattleResult;
   import game.battle.controller.statistic.BattleDamageStatisticEntry;
   import game.battle.controller.statistic.BattleDamageStatisticTeamEntry;
   import game.battle.controller.statistic.BattleDamageStatisticsValueObject;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   
   public class BattleResultValueObject
   {
       
      
      public var source:Object;
      
      protected var _result:MultiBattleResult;
      
      public var stars:int;
      
      public var win:Boolean;
      
      public var startTime:int;
      
      public var endTime:int;
      
      public function BattleResultValueObject()
      {
         super();
      }
      
      public function get result() : MultiBattleResult
      {
         return _result;
      }
      
      public function set result(param1:MultiBattleResult) : void
      {
         _result = param1;
      }
      
      public function get defenderTeamStats() : Vector.<BattleDamageStatisticsValueObject>
      {
         return getTeamStats(result.defenders,result.battleStatistics.defenders);
      }
      
      public function get attackerTeamStats() : Vector.<BattleDamageStatisticsValueObject>
      {
         return getTeamStats(result.attackers,result.battleStatistics.attackers);
      }
      
      public function get timeIsUp() : Boolean
      {
         return _result.timesUp;
      }
      
      private function getTeamStats(param1:Vector.<UnitEntryValueObject>, param2:BattleDamageStatisticTeamEntry) : Vector.<BattleDamageStatisticsValueObject>
      {
         var _loc8_:int = 0;
         var _loc3_:* = null;
         var _loc7_:* = null;
         var _loc6_:Vector.<BattleDamageStatisticsValueObject> = new Vector.<BattleDamageStatisticsValueObject>();
         var _loc4_:int = param1.length;
         var _loc5_:int = getMaxDamage();
         var _loc9_:Dictionary = new Dictionary();
         _loc8_ = 0;
         while(_loc8_ < _loc4_)
         {
            if(!_loc9_[param1[_loc8_].id])
            {
               _loc3_ = param2.getStat(param1[_loc8_].id);
               _loc7_ = new BattleDamageStatisticsValueObject(param1[_loc8_],_loc3_);
               _loc7_.maxDamage = _loc5_;
               _loc6_.push(_loc7_);
               _loc9_[param1[_loc8_].id] = 1;
            }
            _loc8_++;
         }
         _loc6_.sort(_sort);
         return _loc6_;
      }
      
      private function getMaxDamage() : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:int = result.battleStatistics.attackers.team.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = Math.max(_loc2_,result.battleStatistics.attackers.team[_loc3_].damageDealt);
            _loc3_++;
         }
         _loc1_ = result.battleStatistics.defenders.team.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = Math.max(_loc2_,result.battleStatistics.defenders.team[_loc3_].damageDealt);
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function _sort(param1:BattleDamageStatisticsValueObject, param2:BattleDamageStatisticsValueObject) : int
      {
         return param2.damage - param1.damage;
      }
   }
}
