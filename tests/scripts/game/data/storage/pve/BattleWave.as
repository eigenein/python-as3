package game.data.storage.pve
{
   import game.assets.battle.SoundtrackAsset;
   import game.data.reward.RewardData;
   import game.model.user.hero.HeroEntrySourceData;
   
   public class BattleWave
   {
       
      
      private var _soundtrackAsset:SoundtrackAsset;
      
      private var _potentialDrop:RewardData;
      
      private var _enemyDisplayedList:Vector.<BattleEnemyValueObject>;
      
      public function BattleWave(param1:Object)
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         super();
         var _loc7_:Array = param1.enemies;
         var _loc2_:int = _loc7_.length;
         _enemyDisplayedList = new Vector.<BattleEnemyValueObject>();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = _loc7_[_loc4_];
            _enemyDisplayedList.push(new BattleEnemyValueObject(new HeroEntrySourceData(_loc5_)));
            if(_loc5_.drop && _loc5_.drop.length > 0)
            {
               if(!_potentialDrop)
               {
                  _potentialDrop = new RewardData();
               }
               _loc3_ = _loc5_.drop;
               _loc8_ = _loc3_.length;
               _loc6_ = 0;
               while(_loc6_ < _loc8_)
               {
                  if(_loc3_[_loc6_].chance != 0)
                  {
                     _potentialDrop.addRawData(_loc3_[_loc6_].reward);
                  }
                  _loc6_++;
               }
            }
            _loc4_++;
         }
         if(param1.soundtrack)
         {
            _soundtrackAsset = new SoundtrackAsset(param1.soundtrack.asset,param1.soundtrack.ident);
         }
      }
      
      public function get potentialDrop() : RewardData
      {
         return _potentialDrop;
      }
      
      public function get enemyDisplayedList() : Vector.<BattleEnemyValueObject>
      {
         return _enemyDisplayedList;
      }
      
      public function get soundtrackAsset() : SoundtrackAsset
      {
         return _soundtrackAsset;
      }
   }
}
