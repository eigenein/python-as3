package game.model.user.specialoffer
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.property.ObjectProperty;
   import engine.core.utils.property.ObjectPropertyWriteable;
   import engine.core.utils.property.VectorProperty;
   import engine.core.utils.property.VectorPropertyWriteable;
   import game.command.rpc.billing.CommandBillingChooseHero;
   import game.command.social.BillingBuyCommandBase;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.level.PlayerTeamLevel;
   import game.mediator.gui.popup.AutoPopupQueueEntry;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.billing.BillingPopupValueObject;
   import game.mediator.gui.popup.billing.bundle.HeroBundleRewardPopupDescription;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.billing.PlayerBillingDescription;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.billing.bundle.HeroBundleRewardPopup;
   import game.view.specialoffer.herochoice.SpecialOfferHeroChoicePopupMediator;
   import game.view.specialoffer.herochoice.SpecialOfferHeroChoiceSelectorPopupMediator;
   import org.osflash.signals.Signal;
   
   public class PlayerSpecialOfferHeroChoice extends PlayerSpecialOfferWithTimer
   {
      
      public static const OFFER_TYPE:String = "heroChoice";
       
      
      private var _billing:BillingPopupValueObject;
      
      private var _heroesRequirements:Object;
      
      private var _heroes:VectorPropertyWriteable;
      
      private var _selectedHero:ObjectPropertyWriteable;
      
      private var autoPopupQueueEntry:AutoPopupQueueEntry;
      
      public const signal_paymentConfirm:Signal = new Signal();
      
      public function PlayerSpecialOfferHeroChoice(param1:Player, param2:*)
      {
         _heroes = new VectorPropertyWriteable(new Vector.<UnitDescription>() as Vector.<*>);
         _selectedHero = new ObjectPropertyWriteable(UnitDescription,null);
         autoPopupQueueEntry = new AutoPopupQueueEntry(4);
         super(param1,param2);
         autoPopupQueueEntry.signal_open.add(handler_autoPopupOpen);
      }
      
      public function get title() : String
      {
         return Translate.translate(clientData.locale.title);
      }
      
      public function get description() : String
      {
         return Translate.translate(clientData.locale.description);
      }
      
      public function get costString() : String
      {
         return _billing.costString;
      }
      
      public function get heroes() : VectorProperty
      {
         return _heroes;
      }
      
      public function get selectedHero() : ObjectProperty
      {
         return _selectedHero;
      }
      
      public function get defaultUnknownHero() : UnitDescription
      {
         return _heroes.value.length > 0?_heroes.value[_heroes.value.length - 1]:null;
      }
      
      public function get reward() : Vector.<InventoryItem>
      {
         return _billing.rewardList;
      }
      
      public function get heroFramgentsCount() : int
      {
         return offerData.heroFramgentsCount;
      }
      
      public function get discountPercent() : int
      {
         return clientData.discountPercent;
      }
      
      override public function start(param1:PlayerSpecialOfferData) : void
      {
         super.start(param1);
         param1.addAutoPopup(autoPopupQueueEntry);
         player.levelData.signal_levelUp.add(handler_teamLevelUp);
         if(_sideBarIcon)
         {
            _sideBarIcon.signal_click.add(handler_iconClick);
         }
      }
      
      override public function stop(param1:PlayerSpecialOfferData) : void
      {
         super.stop(param1);
         player.levelData.signal_levelUp.remove(handler_teamLevelUp);
      }
      
      public function action_select(param1:HeroDescription) : void
      {
         _selectedHero.value = param1;
      }
      
      public function action_buy() : void
      {
         var _loc1_:* = null;
         if(selectedHero.value != null)
         {
            _loc1_ = GameModel.instance.actionManager.billingChooseHero(_selectedHero.value as UnitDescription,_billing.desc);
            _loc1_.onClientExecute(handler_commandChooseHero);
         }
      }
      
      public function action_openSelectionPopup(param1:PopupStashEventParams) : void
      {
         var _loc2_:SpecialOfferHeroChoiceSelectorPopupMediator = new SpecialOfferHeroChoiceSelectorPopupMediator(player,this);
         _loc2_.signal_heroSelected.add(handler_heroSelected);
         _loc2_.open(param1);
      }
      
      override protected function update(param1:*) : void
      {
         var _loc2_:int = 0;
         var _loc4_:* = null;
         super.update(param1);
         var _loc6_:int = 0;
         var _loc5_:* = param1.billings;
         for each(var _loc3_ in param1.billings)
         {
            _loc2_ = _loc3_.id;
            _loc4_ = player.billingData.getById(_loc2_);
            if(_loc4_)
            {
               _billing = new BillingPopupValueObject(_loc4_,player);
            }
         }
         _heroesRequirements = param1.offerData.heroIds;
         updateHeroes();
      }
      
      protected function updateHeroes() : void
      {
         var _loc6_:* = null;
         var _loc5_:int = 0;
         var _loc1_:* = null;
         var _loc2_:int = player.levelData.level.level;
         var _loc3_:Vector.<UnitDescription> = new Vector.<UnitDescription>();
         var _loc8_:int = 0;
         var _loc7_:* = _heroesRequirements;
         for(var _loc4_ in _heroesRequirements)
         {
            _loc6_ = _heroesRequirements[_loc4_];
            _loc5_ = _loc6_.teamLevel;
            if(_loc5_ <= _loc2_)
            {
               _loc1_ = DataStorage.hero.getUnitById(_loc4_);
               if(_loc1_ != null)
               {
                  _loc3_.push(_loc1_);
               }
            }
         }
         _heroes.value = _loc3_ as Vector.<*>;
      }
      
      private function handler_autoPopupOpen(param1:PopupStashEventParams) : void
      {
         new SpecialOfferHeroChoicePopupMediator(player,this).open(param1);
      }
      
      private function handler_iconClick(param1:PopupStashEventParams) : void
      {
         new SpecialOfferHeroChoicePopupMediator(player,this).open(param1);
      }
      
      private function handler_teamLevelUp(param1:PlayerTeamLevel) : void
      {
         updateHeroes();
      }
      
      private function handler_heroSelected(param1:HeroDescription) : void
      {
         _selectedHero.value = param1;
      }
      
      private function handler_commandChooseHero(param1:CommandBillingChooseHero) : void
      {
         var _loc2_:BillingBuyCommandBase = GameModel.instance.actionManager.platform.billingBuy(_billing);
         _loc2_.signal_paymentBoxError.add(handler_paymentError);
         _loc2_.signal_paymentBoxConfirm.add(handler_paymentConfirm);
         _loc2_.signal_paymentSuccess.add(handler_paymentSuccess);
      }
      
      protected function handler_paymentError(param1:BillingBuyCommandBase) : void
      {
      }
      
      protected function handler_paymentConfirm(param1:BillingBuyCommandBase) : void
      {
         signal_paymentConfirm.dispatch();
      }
      
      protected function handler_paymentSuccess(param1:BillingBuyCommandBase) : void
      {
         var _loc4_:HeroBundleRewardPopupDescription = new HeroBundleRewardPopupDescription();
         _loc4_.title = Translate.translate(param1.billing.name);
         _loc4_.buttonLabel = Translate.translate("UI_DIALOG_REWARD_HERO_OK");
         _loc4_.description = Translate.translate("UI_POPUP_PURCHASE_SUCCESS_HEADER");
         var _loc3_:Vector.<InventoryItem> = param1.reward.outputDisplay;
         _loc4_.reward = _loc3_;
         var _loc2_:HeroBundleRewardPopup = new HeroBundleRewardPopup(_loc4_);
         _loc2_.open();
      }
   }
}
