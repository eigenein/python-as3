package game.screen.navigator
{
   import game.data.storage.mechanic.MechanicDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.pve.mission.MissionDescription;
   import game.data.storage.refillable.RefillableDescription;
   import game.data.storage.resource.ObtainNavigatorType;
   import game.data.storage.shop.ShopDescription;
   import game.mediator.gui.popup.GamePopupManager;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.billing.bundle.BundleListPopupMediator;
   import game.mediator.gui.popup.titan.TitanListPopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.billing.PlayerBillingBundleEntry;
   import game.model.user.mission.PlayerEliteMissionEntry;
   import game.model.user.specialoffer.PlayerSpecialOfferEntry;
   import game.stat.Stash;
   import game.view.popup.activity.SpecialQuestEventPopupMediator;
   import game.view.popup.summoningcircle.SummoningCirclePopUpMediator;
   
   public class GameNavigator
   {
       
      
      private var player:Player;
      
      private var _refillableHelper:RefillableNavigator;
      
      private var _mechanicHelper:MechanicNavigator;
      
      private var _questHelper:QuestMechanicNavigator;
      
      private var _heroObtainTypeHelper:InventoryObtainTypeNavigator;
      
      private var _shopHelper:ShopNavigator;
      
      private var _coinHelper:CoinObtainTypeNavigator;
      
      public function GameNavigator(param1:Player)
      {
         super();
         this.player = param1;
         _questHelper = new QuestMechanicNavigator(this,param1);
         _mechanicHelper = new MechanicNavigator(this,param1);
         _refillableHelper = new RefillableNavigator(this,param1);
         _shopHelper = new ShopNavigator(this,param1);
         _heroObtainTypeHelper = new InventoryObtainTypeNavigator(this,param1);
         _coinHelper = new CoinObtainTypeNavigator(this,param1);
      }
      
      function get mechanicHelper() : MechanicNavigator
      {
         return _mechanicHelper;
      }
      
      public function get questHelper() : QuestMechanicNavigator
      {
         return _questHelper;
      }
      
      public function get heroObtainTypeHelper() : InventoryObtainTypeNavigator
      {
         return _heroObtainTypeHelper;
      }
      
      public function get shopHelper() : ShopNavigator
      {
         return _shopHelper;
      }
      
      public function get coinHelper() : CoinObtainTypeNavigator
      {
         return _coinHelper;
      }
      
      public function navigateToEvents(param1:PopupStashEventParams, param2:int = -1) : void
      {
         var _loc3_:SpecialQuestEventPopupMediator = new SpecialQuestEventPopupMediator(player,param2);
         _loc3_.open(Stash.click("events",param1));
      }
      
      public function navigateToBundle(param1:PopupStashEventParams, param2:Boolean = false, param3:int = 1000) : void
      {
         var _loc4_:* = null;
         var _loc5_:PlayerBillingBundleEntry = player.billingData.bundleData.activeBundle;
         if(!_loc5_)
         {
            return;
         }
         if(player.billingData.bundleData.hasOnlyOneActiveBundle)
         {
            _loc4_ = BundleListPopupMediator.createBundlePopupMediator(player,_loc5_);
         }
         else
         {
            _loc4_ = new BundleListPopupMediator(player);
         }
         var _loc6_:PopupStashEventParams = Stash.click("bundle:" + _loc5_.id,param1);
         if(_loc4_)
         {
            !!param2?_loc4_.openDelayed(_loc6_,param3):_loc4_.open(_loc6_);
         }
      }
      
      public function navigateToMechanic(param1:MechanicDescription, param2:PopupStashEventParams) : void
      {
         _mechanicHelper.navigate(param1,param2);
      }
      
      public function navigateToRefillable(param1:RefillableDescription, param2:PopupStashEventParams) : IRefillableNavigatorResult
      {
         return _refillableHelper.navigate(param1,param2);
      }
      
      public function navigateToRefillableMission(param1:PlayerEliteMissionEntry, param2:PopupStashEventParams) : void
      {
         _refillableHelper.mission_tries(param1,param2);
      }
      
      public function navigateToShop(param1:ShopDescription, param2:PopupStashEventParams) : void
      {
         _shopHelper.navigate(param1,param2);
      }
      
      public function navigateToMission(param1:MissionDescription, param2:PopupStashEventParams) : void
      {
         _mechanicHelper.mission_by_desc(param1,param2);
      }
      
      public function isMechanicEnabled(param1:MechanicDescription) : Boolean
      {
         return param1 && param1.enabled;
      }
      
      public function navigateToClan(param1:PopupStashEventParams) : void
      {
         _mechanicHelper.clan(param1);
      }
      
      public function navigateToClanById(param1:int = -1) : void
      {
         _mechanicHelper.clanById(param1);
      }
      
      public function navigateToTitans(param1:PopupStashEventParams) : void
      {
         if(!_mechanicHelper.checkIfInClanAndSearchForClanIfNot(param1))
         {
            return;
         }
         var _loc2_:TitanListPopupMediator = new TitanListPopupMediator(player);
         _loc2_.open(param1);
      }
      
      public function navigateToSummoningCircle(param1:PopupStashEventParams) : void
      {
         var _loc2_:* = null;
         if(!_mechanicHelper.checkIfInClanAndSearchForClanIfNot(param1))
         {
            return;
         }
         if(SummoningCirclePopUpMediator.current)
         {
            GamePopupManager.instance.removePopUp(SummoningCirclePopUpMediator.current.popup);
            GamePopupManager.instance.addPopUp(SummoningCirclePopUpMediator.current.popup);
         }
         else
         {
            _loc2_ = new SummoningCirclePopUpMediator(GameModel.instance.player);
            _loc2_.open(param1);
         }
      }
      
      public function navigateToCoinObtainType(param1:ObtainNavigatorType, param2:PopupStashEventParams) : Boolean
      {
         _coinHelper.navigate(param1,param2);
         return _coinHelper.canNavigate(param1);
      }
      
      public function navigateToSpecialOffer(param1:int, param2:PopupStashEventParams) : void
      {
         var _loc3_:PlayerSpecialOfferEntry = player.specialOffer.getSpecialOfferById(param1);
         if(_loc3_)
         {
            if(_loc3_.type == "newYear2018")
            {
               Game.instance.navigator.navigateToMechanic(MechanicStorage.NY2018_WELCOME,Stash.click("special_offer",param2));
            }
            else if(_loc3_.type == "newYear2018gifts")
            {
               Game.instance.navigator.navigateToMechanic(MechanicStorage.NY2018_GIFTS,Stash.click("special_offer",param2));
            }
         }
      }
      
      public function canNavigateToCoinObtainType(param1:ObtainNavigatorType) : Boolean
      {
         return _coinHelper.canNavigate(param1);
      }
   }
}
