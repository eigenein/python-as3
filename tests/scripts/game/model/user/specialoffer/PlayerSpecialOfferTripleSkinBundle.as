package game.model.user.specialoffer
{
   import game.assets.battle.AssetClipLink;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.billing.BillingPopupValueObject;
   import game.mediator.gui.popup.billing.specialoffer.TripleSkinBundleValueObject;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.billing.PlayerBillingDescription;
   import game.view.popup.activity.SpecialQuestEventPopupMediator;
   
   public class PlayerSpecialOfferTripleSkinBundle extends PlayerSpecialOfferWithSideBarIcon
   {
      
      public static const OFFER_TYPE:String = "sideBarIcon_tripleSkinBundle";
       
      
      private var _dataList:Vector.<TripleSkinBundleValueObject>;
      
      private var _titleLocale:String;
      
      private var _iconAsset:String;
      
      private var _popupAsset:AssetClipLink;
      
      public function PlayerSpecialOfferTripleSkinBundle(param1:Player, param2:*)
      {
         super(param1,param2);
      }
      
      public function get dataList() : Vector.<TripleSkinBundleValueObject>
      {
         return _dataList;
      }
      
      public function get titleLocale() : String
      {
         return _titleLocale;
      }
      
      public function get iconAsset() : String
      {
         return _iconAsset;
      }
      
      public function get popupAsset() : AssetClipLink
      {
         return _popupAsset;
      }
      
      public function action_popupOpen() : PopupMediator
      {
         updateDataList();
         var _loc1_:SpecialQuestEventPopupMediator = new SpecialQuestEventPopupMediator(GameModel.instance.player,1);
         return _loc1_;
      }
      
      override public function start(param1:PlayerSpecialOfferData) : void
      {
         var _loc4_:int = 0;
         var _loc6_:* = null;
         var _loc5_:* = null;
         super.start(param1);
         if(clientData.popup)
         {
            _popupAsset = new AssetClipLink(AssetStorage.rsx.getByName(clientData.popup.asset),clientData.popup.clip);
         }
         var _loc3_:Array = offerData.addBillingIds;
         var _loc2_:int = _loc3_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc6_ = player.billingData.getById(_loc3_[_loc4_]);
            if(_loc6_)
            {
               _loc5_ = getVOById(_loc3_[_loc4_]);
               if(_loc5_)
               {
                  _loc5_.updateBillingVO(new BillingPopupValueObject(_loc6_,player));
               }
            }
            _loc4_++;
         }
         _titleLocale = clientData.popupHeaderLocaleId;
         _iconAsset = clientData.iconAsset;
      }
      
      public function updateDataList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = _dataList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _dataList[_loc2_].updatePlayerData(player);
            _loc2_++;
         }
      }
      
      override protected function update(param1:*) : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         super.update(param1);
         if(!_dataList)
         {
            _dataList = new Vector.<TripleSkinBundleValueObject>();
         }
         var _loc3_:Array = param1.billings;
         var _loc2_:int = _loc3_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = getVOById(_loc3_[_loc4_].id);
            if(!_loc5_)
            {
               _loc5_ = new TripleSkinBundleValueObject(_loc3_[_loc4_]);
               _dataList.push(_loc5_);
            }
            _loc4_++;
         }
      }
      
      private function getVOById(param1:int) : TripleSkinBundleValueObject
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(_dataList)
         {
            _loc2_ = _dataList.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               if(_dataList[_loc3_].id == param1)
               {
                  return _dataList[_loc3_];
               }
               _loc3_++;
            }
         }
         return null;
      }
   }
}
