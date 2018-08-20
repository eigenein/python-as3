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
   import game.view.specialoffer.halloween2k17.Halloween2k17SecretObjectView;
   
   public class PlayerSpecialOfferHalloween2k17secretReward extends PlayerSpecialOfferWithTimer
   {
      
      public static const OFFER_TYPE:String = "halloween2k17secretReward";
       
      
      private var _commandFarm:CommandOfferFarmReward;
      
      private var _isOpen:BooleanPropertyWriteable;
      
      private var _instance:PlayerSpecialOfferHalloween2k17secretReward;
      
      private var _objectsFound:int;
      
      private var _objectsTotal:int;
      
      private var dict:Dictionary;
      
      public function PlayerSpecialOfferHalloween2k17secretReward(param1:Player, param2:*)
      {
         _isOpen = new BooleanPropertyWriteable(false);
         dict = new Dictionary();
         super(param1,param2);
         _instance = this;
      }
      
      public function get instance() : PlayerSpecialOfferHalloween2k17secretReward
      {
         return _instance;
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
         dict["artifactChest"] = 0;
         dict["tower50"] = 0;
         dict["worldmap"] = 0;
         dict["zeppelin"] = 0;
         dict["moon"] = 0;
         dict["worldmap6"] = 0;
         super.start(param1);
         param1.hooks.halloweenSecretSpecialOffer.add(handler_bundlePopupSpecialOffer);
      }
      
      override public function stop(param1:PlayerSpecialOfferData) : void
      {
         super.stop(param1);
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
      
      protected function handler_bundlePopupSpecialOffer(param1:Halloween2k17SpecialOfferViewOwner) : void
      {
         var _loc2_:* = null;
         if(dict[param1.ident] == 0)
         {
            _loc2_ = new Halloween2k17SecretObjectView(this,param1);
            _loc2_.displayStyle.apply(param1.graphics,param1.graphics,param1.graphics);
            _loc2_.signal_click.add(handler_click);
         }
      }
      
      private function handler_click(param1:Halloween2k17SecretObjectView) : void
      {
         dict[param1.owner.ident] = 1;
         param1.hide(objectsFound,objectsTotal);
         if(objectsFound == objectsTotal)
         {
            action_open();
         }
      }
   }
}
