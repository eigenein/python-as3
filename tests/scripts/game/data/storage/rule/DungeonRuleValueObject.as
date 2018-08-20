package game.data.storage.rule
{
   public class DungeonRuleValueObject
   {
       
      
      private var _titanBattlegroundAsset:int;
      
      private var _heroBattlegroundAsset:int;
      
      private var _heroBattlePowerOverwhelmingPercent:int;
      
      public function DungeonRuleValueObject(param1:Object)
      {
         super();
         _titanBattlegroundAsset = param1.titanBattlegroundAsset;
         _heroBattlegroundAsset = param1.heroBattlegroundAsset;
         _heroBattlePowerOverwhelmingPercent = param1.heroBattlePowerOverwhelmingPercent;
      }
      
      public function get titanBattlegroundAsset() : int
      {
         return _titanBattlegroundAsset;
      }
      
      public function get heroBattlegroundAsset() : int
      {
         return _heroBattlegroundAsset;
      }
      
      public function get heroBattlePowerOverwhelmingPercent() : int
      {
         return _heroBattlePowerOverwhelmingPercent;
      }
   }
}
