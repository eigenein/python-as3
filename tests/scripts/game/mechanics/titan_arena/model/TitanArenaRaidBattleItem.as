package game.mechanics.titan_arena.model
{
   import game.data.reward.RewardData;
   import game.mechanics.titan_arena.mediator.TitanArenaRoundResultValueObject;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.hero.UnitUtils;
   import game.model.user.inventory.InventoryItem;
   
   public class TitanArenaRaidBattleItem
   {
       
      
      private var _rewardInventoryItem:InventoryItem;
      
      private var _enemy:PlayerTitanArenaEnemy;
      
      private var _rawResult:Object;
      
      private var _reward:RewardData;
      
      private var _resultAttack:TitanArenaRoundResultValueObject;
      
      private var _resultDefence:TitanArenaRoundResultValueObject;
      
      public function TitanArenaRaidBattleItem(param1:PlayerTitanArenaEnemy, param2:Object)
      {
         super();
         this._enemy = param1;
         this._rawResult = param2;
         if(!invalidBattle)
         {
            this._resultAttack = _createResultVO(param2.battle,param2.rivalTeam,false);
            this._resultDefence = _createResultVO(param2.defBattle,param2.defenceTeam,true);
         }
         if(param2.reward)
         {
            this._reward = new RewardData(param2.reward);
            _rewardInventoryItem = this._reward.outputDisplayFirst;
         }
      }
      
      public static function sort_enemyPowerAndReward(param1:TitanArenaRaidBattleItem, param2:TitanArenaRaidBattleItem) : int
      {
         var _loc5_:Number = param1._enemy.power;
         var _loc6_:Number = param2._enemy.power;
         var _loc4_:int = !!param1._rewardInventoryItem?param1._rewardInventoryItem.amount:0;
         var _loc3_:int = !!param2._rewardInventoryItem?param2._rewardInventoryItem.amount:0;
         if(_loc4_ != 0 && _loc3_ != 0)
         {
            if(_loc4_ > _loc3_)
            {
               return 1;
            }
            if(_loc4_ < _loc3_)
            {
               return -1;
            }
         }
         if(_loc5_ > _loc6_)
         {
            return 1;
         }
         if(_loc5_ < _loc6_)
         {
            return -1;
         }
         return 0;
      }
      
      public function get enemy() : PlayerTitanArenaEnemy
      {
         return _enemy;
      }
      
      public function get rawResult() : Object
      {
         return _rawResult;
      }
      
      public function get rewardInventoryItem() : InventoryItem
      {
         return _rewardInventoryItem;
      }
      
      public function get fullVictory() : Boolean
      {
         return _enemy.points_attack == _enemy.points_attackMax && _enemy.points_defense == _enemy.points_defenseMax;
      }
      
      public function get invalidBattle() : Boolean
      {
         return _rawResult.error != null;
      }
      
      public function get scoreEarned() : int
      {
         return attackScoreEarned + defenceScoreEarned;
      }
      
      public function get attackScoreEarned() : int
      {
         return _rawResult.attackScoreEarned;
      }
      
      public function get defenceScoreEarned() : int
      {
         return _rawResult.defenceScoreEarned;
      }
      
      public function get resultAttack() : TitanArenaRoundResultValueObject
      {
         return _resultAttack;
      }
      
      public function get resultDefence() : TitanArenaRoundResultValueObject
      {
         return _resultDefence;
      }
      
      public function get rawAttackBattle() : Object
      {
         return _rawResult.battle;
      }
      
      public function get rawDefenceBattle() : Object
      {
         return _rawResult.defBattle;
      }
      
      private function _createResultVO(param1:Object, param2:Object, param3:Boolean) : TitanArenaRoundResultValueObject
      {
         var _loc5_:Vector.<UnitEntryValueObject> = UnitUtils.createUnitEntryVectorFromRawData(param1.attackers);
         var _loc4_:Vector.<UnitEntryValueObject> = UnitUtils.createUnitEntryVectorFromRawData(param1.defenders[0]);
         return new TitanArenaRoundResultValueObject(_loc5_,_loc4_,param2,param3);
      }
   }
}
