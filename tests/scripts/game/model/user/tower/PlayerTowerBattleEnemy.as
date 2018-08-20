package game.model.user.tower
{
   import game.data.storage.DataStorage;
   import game.data.storage.tower.TowerBattleDifficulty;
   import game.mediator.gui.popup.hero.HeroEntryValueObject;
   import game.model.user.UserInfo;
   import game.model.user.hero.HeroEntry;
   import game.model.user.hero.HeroEntrySourceData;
   
   public class PlayerTowerBattleEnemy extends UserInfo
   {
       
      
      public const heroes:Vector.<HeroEntryValueObject> = new Vector.<HeroEntryValueObject>();
      
      protected var _difficulty:TowerBattleDifficulty;
      
      protected var _pointRewardString:String;
      
      protected var _power:int;
      
      private var _maxPointReward:int;
      
      private var _maxSkullReward:int;
      
      public function PlayerTowerBattleEnemy(param1:*, param2:*, param3:TowerBattleDifficulty, param4:int)
      {
         super();
         this._difficulty = param3;
         if(param1)
         {
            _id = param1.id;
            if(param1)
            {
               parse(param1);
            }
         }
         if(param2)
         {
            _power = param2.power;
            if(param2.heroes)
            {
               parseHeroes(param2.heroes);
            }
         }
         _pointRewardString = DataStorage.rule.towerRule.getPointReward(param4);
         _maxPointReward = DataStorage.rule.towerRule.getMaxPointReward(param4);
         _maxSkullReward = DataStorage.rule.towerRule.getMaxSkullReward(param3);
      }
      
      public function get maxPointReward() : int
      {
         return _maxPointReward;
      }
      
      public function get maxSkullReward() : int
      {
         return _maxSkullReward;
      }
      
      public function get difficulty() : TowerBattleDifficulty
      {
         return _difficulty;
      }
      
      public function get power() : int
      {
         return _power;
      }
      
      public function get rewardSkulls() : String
      {
         return DataStorage.rule.towerRule.getDifficultySkullReward(difficulty);
      }
      
      public function get rewardPoints() : String
      {
         return _pointRewardString;
      }
      
      protected function parseHeroes(param1:Object) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc2_ in param1)
         {
            _loc3_ = new HeroEntry(null,new HeroEntrySourceData(_loc2_));
            heroes.push(new HeroEntryValueObject(_loc3_.hero,_loc3_));
         }
      }
   }
}
