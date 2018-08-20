package game.data.storage.pve
{
   import game.data.reward.RewardData;
   import game.data.storage.DescriptionBase;
   
   public class PVEBattleDescription extends DescriptionBase
   {
       
      
      protected var _enemyList:Vector.<BattleEnemyValueObject>;
      
      protected var _consolidatedDrop:RewardData;
      
      protected var _waves:Vector.<BattleWave>;
      
      public function PVEBattleDescription()
      {
         super();
      }
      
      public function get enemyList() : Vector.<BattleEnemyValueObject>
      {
         return _enemyList;
      }
      
      public function get consolidatedDrop() : RewardData
      {
         return _consolidatedDrop;
      }
      
      public function get waves() : Vector.<BattleWave>
      {
         return _waves;
      }
      
      protected function parseWaves(param1:Array) : void
      {
         var _loc3_:int = 0;
         _consolidatedDrop = new RewardData();
         _enemyList = new Vector.<BattleEnemyValueObject>();
         _waves = new Vector.<BattleWave>();
         var _loc2_:int = param1.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _waves[_loc3_] = new BattleWave(param1[_loc3_]);
            if(_waves[_loc3_].potentialDrop)
            {
               _consolidatedDrop.add(_waves[_loc3_].potentialDrop);
            }
            _enemyList = _enemyList.concat(waves[_loc3_].enemyDisplayedList);
            _loc3_++;
         }
      }
   }
}
