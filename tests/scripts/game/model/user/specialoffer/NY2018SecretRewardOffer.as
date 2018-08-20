package game.model.user.specialoffer
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import flash.utils.Dictionary;
   import game.command.rpc.player.CommandOfferFarmReward;
   import game.mediator.gui.popup.billing.bundle.HeroBundleRewardPopupDescription;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.billing.bundle.HeroBundleRewardPopup;
   import game.view.popup.ny.NY2018SecretRewardOfferView;
   
   public class NY2018SecretRewardOffer extends PlayerSpecialOfferEntry
   {
      
      public static const OFFER_TYPE:String = "ny2k18secretReward";
       
      
      private var _commandFarm:CommandOfferFarmReward;
      
      private var endTime:PlayerDeferredEvent;
      
      private var _isOpen:BooleanPropertyWriteable;
      
      private var dict:Dictionary;
      
      private var dictmap:Array;
      
      private var _objectsFound:int;
      
      private var _objectsTotal:int;
      
      public function NY2018SecretRewardOffer(param1:Player, param2:*)
      {
         endTime = new PlayerDeferredEvent();
         _isOpen = new BooleanPropertyWriteable(false);
         dict = new Dictionary();
         dictmap = [];
         super(param1,param2);
      }
      
      public function get objectsFound() : int
      {
         _objectsFound = 0;
         var _loc3_:int = 0;
         var _loc2_:* = dict;
         for(var _loc1_ in dict)
         {
            if(dict[_loc1_] == 1)
            {
               _objectsFound = Number(_objectsFound) + 1;
            }
         }
         return _objectsFound;
      }
      
      public function getKeyList() : Array
      {
         var _loc3_:int = 0;
         var _loc1_:Array = [];
         var _loc2_:int = dictmap.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_[_loc3_] = dict[dictmap[_loc3_]];
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function get objectsTotal() : int
      {
         _objectsTotal = 0;
         var _loc3_:int = 0;
         var _loc2_:* = dict;
         for(var _loc1_ in dict)
         {
            _objectsTotal = Number(_objectsTotal) + 1;
         }
         return _objectsTotal;
      }
      
      override public function start(param1:PlayerSpecialOfferData) : void
      {
         dict["zero"] = 1;
         dict["moon"] = 0;
         dict["fireworks"] = 0;
         dict["tree"] = 0;
         dict["key_1"] = 0;
         dict["key_2"] = 0;
         dict["key_3"] = 0;
         dictmap = ["moon","fireworks","key_2","zero","key_1","key_3"];
         super.start(param1);
         endTime.signal_complete.add(handler_endTimeComplete);
         param1.hooks.ny2018SecretSpecialOffer.add(handler_bundlePopupSpecialOffer);
      }
      
      override public function stop(param1:PlayerSpecialOfferData) : void
      {
         super.stop(param1);
         endTime.signal_complete.remove(handler_endTimeComplete);
      }
      
      public function action_open() : void
      {
         if(!_commandFarm)
         {
            _commandFarm = GameModel.instance.actionManager.playerCommands.specialOfferFarmReward(id);
            _commandFarm.onClientExecute(handler_commandReward);
         }
      }
      
      public function action_collect() : void
      {
         var _loc3_:* = null;
         var _loc2_:* = undefined;
         var _loc1_:* = null;
         if(_commandFarm)
         {
            _commandFarm.farmReward(player);
            _loc3_ = new HeroBundleRewardPopupDescription();
            _loc3_.title = Translate.translate("UI_POPUP_QUEST_REWARD_HEADER");
            _loc3_.buttonLabel = Translate.translate("UI_DIALOG_REWARD_HERO_OK");
            _loc3_.description = "";
            _loc2_ = _commandFarm.reward.outputDisplay;
            _loc3_.reward = _loc2_;
            _loc3_.skinCoinSortWeight = 500;
            _loc1_ = new HeroBundleRewardPopup(_loc3_);
            _loc1_.open();
         }
         player.specialOffer.specialOfferEnded(this);
      }
      
      override protected function update(param1:*) : void
      {
         super.update(param1);
         endTime.setEndTime(param1.endTime);
      }
      
      private function getPointFarmed(param1:int = 0) : Boolean
      {
         return false;
      }
      
      private function handler_commandReward(param1:CommandOfferFarmReward) : void
      {
         _isOpen.value = true;
         _commandFarm = param1;
         action_collect();
      }
      
      private function handler_endTimeComplete() : void
      {
         player.specialOffer.specialOfferEnded(this);
      }
      
      protected function handler_bundlePopupSpecialOffer(param1:NY2018SecretRewardOfferViewOwner) : void
      {
         var _loc2_:* = null;
         if(dict[param1.ident] == 0)
         {
            _loc2_ = new NY2018SecretRewardOfferView(this,param1);
            _loc2_.displayStyle.apply(param1.graphics,param1.graphics,param1.graphics);
            _loc2_.signal_click.add(handler_click);
         }
      }
      
      private function handler_click(param1:NY2018SecretRewardOfferView) : void
      {
         dict[param1.owner.ident] = 1;
         param1.hide(objectsFound,objectsTotal);
         if(objectsFound == objectsTotal)
         {
            action_open();
         }
      }
      
      public function getKeyIndex(param1:String) : String
      {
         var _loc2_:int = dictmap.indexOf(param1);
         if(_loc2_ != -1)
         {
            return "secret_letter_" + (_loc2_ + 1);
         }
         return "secret_letter_x";
      }
   }
}
