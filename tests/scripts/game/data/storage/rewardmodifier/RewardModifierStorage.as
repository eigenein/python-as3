package game.data.storage.rewardmodifier
{
   import game.data.storage.DescriptionStorage;
   import game.data.storage.level.VIPLevel;
   
   public class RewardModifierStorage extends DescriptionStorage
   {
       
      
      public function RewardModifierStorage()
      {
         super();
      }
      
      public function getRewardModifierById(param1:uint) : RewardModifierDescription
      {
         return _items[param1];
      }
      
      public function getByVipLevel(param1:VIPLevel) : Vector.<RewardModifierDescription>
      {
         var _loc4_:int = 0;
         if(!param1.rewardModifier)
         {
            return null;
         }
         var _loc3_:int = param1.rewardModifier.length;
         var _loc2_:Vector.<RewardModifierDescription> = new Vector.<RewardModifierDescription>(_loc3_);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_[_loc4_] = _items[param1.rewardModifier[_loc4_]];
            _loc4_++;
         }
         return _loc2_;
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc2_:RewardModifierDescription = new RewardModifierDescription(param1);
         _items[_loc2_.id] = _loc2_;
      }
   }
}
