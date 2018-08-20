package game.data.storage.nygifts
{
   import com.progrestar.common.lang.Translate;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.loot.LootBoxDescription;
   import game.data.storage.resource.PseudoResourceDescription;
   import game.model.GameModel;
   
   public class NYGiftDescription extends PseudoResourceDescription
   {
       
      
      private var _asset:String;
      
      private var _sortIndex:uint;
      
      private var _cost:CostData;
      
      private var senderRewardRawData:Object;
      
      private var _recipientReward:RewardData;
      
      private var _recipientRewardSkins:Array;
      
      private var _recipientRewardLootBox:LootBoxDescription;
      
      public function NYGiftDescription(param1:Object)
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         super(param1);
         _id = param1.id;
         _asset = param1.asset;
         _sortIndex = param1.sortIndex;
         _cost = new CostData(param1.cost);
         if(param1.recipientReward)
         {
            _loc2_ = param1.recipientReward.randomSkin;
            _recipientRewardSkins = _loc2_ != null?_loc2_.split(","):null;
            _loc3_ = param1.recipientReward.reward;
            _recipientReward = _loc3_ != null?new RewardData(_loc3_):null;
            _recipientRewardLootBox = DataStorage.lootBox.getByIdent(param1.recipientReward.lootBox);
         }
         senderRewardRawData = param1.senderReward;
      }
      
      public function get asset() : String
      {
         return _asset;
      }
      
      public function get sortIndex() : uint
      {
         return _sortIndex;
      }
      
      public function get cost() : CostData
      {
         return _cost;
      }
      
      public function get senderReward() : RewardData
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc1_:RewardData = new RewardData();
         if(senderRewardRawData)
         {
            _loc1_ = new RewardData();
            _loc2_ = senderRewardRawData.dailyHero;
            if(_loc2_ && _loc2_.length)
            {
               _loc1_.addFragmentItem(DataStorage.hero.getHeroById(GameModel.instance.player.ny.dayHeroId),_loc2_[0].amount);
            }
            _loc3_ = senderRewardRawData.eventHero;
            if(_loc3_ && _loc3_.length)
            {
               _loc1_.addFragmentItem(DataStorage.hero.getHeroById(GameModel.instance.player.ny.eventHeroId),_loc3_[0].amount);
            }
         }
         return _loc1_;
      }
      
      public function get recipientReward() : RewardData
      {
         return _recipientReward;
      }
      
      public function get recipientRewardSkins() : Array
      {
         return _recipientRewardSkins;
      }
      
      public function get recipientRewardLootBox() : LootBoxDescription
      {
         return _recipientRewardLootBox;
      }
      
      override public function applyLocale() : void
      {
         _name = Translate.translate("LIB_EVENT_BOX_NAME_" + id);
      }
   }
}
