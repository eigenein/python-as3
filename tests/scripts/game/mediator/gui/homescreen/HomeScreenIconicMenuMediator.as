package game.mediator.gui.homescreen
{
   import game.data.storage.DataStorage;
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.shop.ShopDescription;
   import game.mechanics.grand.mediator.GrandPopupMediator;
   import game.mediator.gui.GUILayerMediator;
   import game.mediator.gui.RedMarkerGlobalMediator;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.inventory.PlayerInventoryPopupMediator;
   import game.mediator.gui.popup.quest.QuestListPopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.stat.Stash;
   import game.view.gui.homescreen.HomeScreenIconicMenu;
   import idv.cjcat.signals.Signal;
   
   public class HomeScreenIconicMenuMediator
   {
       
      
      private var player:Player;
      
      private var guiLayer:GUILayerMediator;
      
      public var stashParams:PopupStashEventParams;
      
      private var _redMarkerMediator:RedMarkerGlobalMediator;
      
      private var _panel:HomeScreenIconicMenu;
      
      private var _dotStateUpdateHero:Boolean;
      
      private var _signal_dotStateUpdateHero:Signal;
      
      private var _dotStateFriends:Boolean;
      
      private var _signal_dotStateUpdateFriends:Signal;
      
      public function HomeScreenIconicMenuMediator(param1:Player, param2:GUILayerMediator)
      {
         super();
         this.guiLayer = param2;
         this.player = param1;
         _redMarkerMediator = RedMarkerGlobalMediator.instance;
         _signal_dotStateUpdateHero = new Signal();
         _signal_dotStateUpdateFriends = new Signal();
         _panel = new HomeScreenIconicMenu(this);
         param1.signal_update.initSignal.add(onPlayerInit);
         stashParams = new PopupStashEventParams();
         stashParams.windowName = "global";
      }
      
      public function get redMarkerMediator() : RedMarkerGlobalMediator
      {
         return _redMarkerMediator;
      }
      
      public function get panel() : HomeScreenIconicMenu
      {
         return _panel;
      }
      
      public function get dotStateUpdateHero() : Boolean
      {
         return _dotStateUpdateHero;
      }
      
      public function get signal_dotStateUpdateHero() : Signal
      {
         return _signal_dotStateUpdateHero;
      }
      
      public function get dotStateFriends() : Boolean
      {
         return _dotStateFriends;
      }
      
      public function get signal_dotStateUpdateFriends() : Signal
      {
         return _signal_dotStateUpdateFriends;
      }
      
      public function action_clickHeroes() : void
      {
         PopupList.instance.dialog_hero_list(Stash.click("heroes",stashParams));
      }
      
      public function action_clickInventory() : void
      {
         var _loc1_:PlayerInventoryPopupMediator = new PlayerInventoryPopupMediator(GameModel.instance.player);
         _loc1_.open(Stash.click("inventory",stashParams));
      }
      
      public function action_clickShop() : void
      {
         var _loc1_:ShopDescription = DataStorage.shop.getShopById(1);
         Game.instance.navigator.navigateToShop(_loc1_,Stash.click("store:" + _loc1_.id,stashParams));
      }
      
      public function action_clickFriends() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.SOCIAL_GIFT,Stash.click("friends",stashParams));
      }
      
      public function action_clickGrand() : void
      {
         var _loc1_:GrandPopupMediator = new GrandPopupMediator(GameModel.instance.player);
         _loc1_.open();
      }
      
      public function action_clickTrials() : void
      {
      }
      
      public function action_clickQuests() : void
      {
         var _loc1_:QuestListPopupMediator = new QuestListPopupMediator(GameModel.instance.player,0);
         _loc1_.open(Stash.click("quests",stashParams));
      }
      
      public function action_clickRating() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.RATING,stashParams);
      }
      
      private function onPlayerInit() : void
      {
      }
   }
}
