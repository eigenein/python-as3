package game.data.storage.tower
{
   import flash.utils.Dictionary;
   import game.data.storage.DescriptionBase;
   
   public class TowerStorage
   {
       
      
      private var buff:Dictionary;
      
      private var floor:Vector.<TowerFloorDescription>;
      
      private var reward:Vector.<TowerRewardDescription>;
      
      private var _maxFloorNumber:int;
      
      public function TowerStorage()
      {
         buff = new Dictionary();
         floor = new Vector.<TowerFloorDescription>();
         reward = new Vector.<TowerRewardDescription>();
         super();
      }
      
      public function get maxFloorNumber() : int
      {
         return _maxFloorNumber;
      }
      
      public function init(param1:Object) : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = param1.buff;
         for each(_loc2_ in param1.buff)
         {
            buff[_loc2_.id] = new TowerBuffDescription(_loc2_);
         }
         var _loc6_:int = 0;
         var _loc5_:* = param1.floor;
         for each(_loc2_ in param1.floor)
         {
            floor.push(new TowerFloorDescription(_loc2_));
         }
         var _loc8_:int = 0;
         var _loc7_:* = param1.reward;
         for each(_loc2_ in param1.reward)
         {
            reward.push(new TowerRewardDescription(_loc2_));
         }
         reward.sort(_sortRewards);
         _maxFloorNumber = floor.length;
      }
      
      public function applyLocale() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = buff;
         for each(var _loc1_ in buff)
         {
            _loc1_.applyLocale();
         }
      }
      
      public function getBuffById(param1:int) : TowerBuffDescription
      {
         return buff[param1];
      }
      
      public function getBuffListByEffect(param1:String) : Vector.<TowerBuffDescription>
      {
         var _loc3_:Vector.<TowerBuffDescription> = new Vector.<TowerBuffDescription>();
         var _loc5_:int = 0;
         var _loc4_:* = buff;
         for each(var _loc2_ in buff)
         {
            if(_loc2_.effect.effect == param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         return _loc3_;
      }
      
      public function getFloor(param1:int) : TowerFloorDescription
      {
         var _loc3_:int = 0;
         var _loc2_:int = floor.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(floor[_loc3_].floor == param1)
            {
               return floor[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      public function countBattleFloorsTill(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = floor.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(floor[_loc3_].floor < param1)
            {
               if(floor[_loc3_].type == TowerFloorType.BATTLE)
               {
                  _loc4_++;
               }
               _loc3_++;
               continue;
            }
            break;
         }
         return _loc4_;
      }
      
      public function getFloorList() : Vector.<TowerFloorDescription>
      {
         return floor.concat();
      }
      
      public function getRewardList() : Vector.<TowerRewardDescription>
      {
         return reward;
      }
      
      private function _sortRewards(param1:TowerRewardDescription, param2:TowerRewardDescription) : int
      {
         return param2.pointsEarned - param1.pointsEarned;
      }
   }
}
