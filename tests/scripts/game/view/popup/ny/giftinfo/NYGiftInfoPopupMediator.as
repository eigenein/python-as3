package game.view.popup.ny.giftinfo
{
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.nygifts.NYGiftDescription;
   import game.data.storage.resource.CoinDescription;
   import game.data.storage.skin.SkinDescription;
   import game.mediator.gui.popup.PopupList;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.PopupBase;
   import game.view.popup.ny.NYPopupMediatorBase;
   
   public class NYGiftInfoPopupMediator extends NYPopupMediatorBase
   {
       
      
      private var gift:NYGiftDescription;
      
      public function NYGiftInfoPopupMediator(param1:Player, param2:NYGiftDescription)
      {
         super(param1);
         this.gift = param2;
      }
      
      public function get giftTitle() : String
      {
         return gift.name;
      }
      
      public function get skins() : Vector.<SkinDescription>
      {
         var _loc2_:int = 0;
         var _loc1_:Vector.<SkinDescription> = new Vector.<SkinDescription>();
         _loc2_ = 0;
         while(_loc2_ < gift.recipientRewardSkins.length)
         {
            _loc1_.push(DataStorage.skin.getSkinById(gift.recipientRewardSkins[_loc2_]));
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get lootBoxItems() : Vector.<InventoryItem>
      {
         var _loc3_:int = 0;
         var _loc1_:RewardData = new RewardData();
         _loc3_ = 0;
         while(_loc3_ < gift.recipientRewardLootBox.drop.length)
         {
            _loc1_.add(gift.recipientRewardLootBox.drop[_loc3_].reward);
            _loc3_++;
         }
         var _loc2_:Vector.<InventoryItem> = _loc1_.outputDisplay;
         _loc2_.sort(sortItems);
         return _loc2_;
      }
      
      public function get rewardItems() : Vector.<InventoryItem>
      {
         return gift.recipientReward.outputDisplay;
      }
      
      override public function createPopup() : PopupBase
      {
         if(gift.recipientRewardSkins)
         {
            _popup = new NYGiftWithSkinInfoPopup(this);
         }
         else
         {
            _popup = new NYGiftInfoPopup(this);
         }
         return _popup;
      }
      
      public function action_showSkinInfo(param1:SkinDescription) : void
      {
         PopupList.instance.dialog_skin_info(param1.id);
      }
      
      private function sortItems(param1:InventoryItem, param2:InventoryItem) : int
      {
         if(param1.item is CoinDescription)
         {
            return -1;
         }
         if(param2.item is CoinDescription)
         {
            return 1;
         }
         if(param2.item.color.id < param1.item.color.id)
         {
            return -1;
         }
         if(param2.item.color.id > param1.item.color.id)
         {
            return 1;
         }
         return param2.item.id - param1.item.id;
      }
   }
}
