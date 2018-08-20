package game.view.gui
{
   import game.data.storage.DataStorage;
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.shop.ShopDescription;
   import game.data.storage.world.WorldMapDescription;
   import game.mediator.gui.RedMarkerGlobalMediator;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.arena.ArenaPopupMediator;
   import game.mediator.gui.popup.chest.ChestPopupMediator;
   import game.mediator.gui.worldmap.WorldMapViewMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.shop.SpecialShopMerchant;
   import game.model.user.specialoffer.PlayerSpecialOfferHooks;
   import game.stat.Stash;
   import game.view.gui.homescreen.HomeScreenHeroes;
   import game.view.popup.shop.special.SpecialShopPopupMediator;
   import starling.animation.Juggler;
   import starling.display.DisplayObjectContainer;
   
   public class HomeScreenSceneMediator
   {
       
      
      private var player:Player;
      
      private var heroes:HomeScreenHeroes;
      
      private var adviceController:HomeScreenSceneHeroAdviceController;
      
      protected var stashEventParams:PopupStashEventParams;
      
      private var _redMarkerMediator:RedMarkerGlobalMediator;
      
      public function HomeScreenSceneMediator(param1:Player, param2:Juggler)
      {
         super();
         this.player = param1;
         heroes = new HomeScreenHeroes(param1);
         heroes.controller.signal_heroesReady.addOnce(handler_heroesReady);
         param2.add(heroes);
         _redMarkerMediator = RedMarkerGlobalMediator.instance;
         stashEventParams = new PopupStashEventParams();
         stashEventParams.windowName = "global";
         adviceController = new HomeScreenSceneHeroAdviceController(param1,heroes);
      }
      
      public function get isEnabled_boss() : Boolean
      {
         return MechanicStorage.BOSS.enabled;
      }
      
      public function get redMarkerMediator() : RedMarkerGlobalMediator
      {
         return _redMarkerMediator;
      }
      
      public function get specialOfferHooks() : PlayerSpecialOfferHooks
      {
         return player.specialOffer.hooks;
      }
      
      public function get heroContainer() : DisplayObjectContainer
      {
         return heroes.container;
      }
      
      public function get hasSpcecialOfferNY() : Boolean
      {
         return GameModel.instance.player.specialOffer.hasSpecialOffer("newYear2016Tree");
      }
      
      public function get hasSpcecialOfferNY2018() : Boolean
      {
         return GameModel.instance.player.specialOffer.hasSpecialOffer("newYear2018");
      }
      
      public function get hasSpcecialOfferNY2018Gifts() : Boolean
      {
         return GameModel.instance.player.specialOffer.hasSpecialOffer("newYear2018gifts");
      }
      
      public function action_openBoss() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.BOSS,Stash.click("boss",stashEventParams));
      }
      
      public function action_openArena() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.ARENA,Stash.click("arena",stashEventParams));
      }
      
      public function action_openGrand() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.GRAND,Stash.click("grand",stashEventParams));
      }
      
      public function action_openGuild() : void
      {
      }
      
      public function action_openPortal() : void
      {
         var _loc2_:WorldMapDescription = DataStorage.world.getById(1) as WorldMapDescription;
         var _loc1_:WorldMapViewMediator = new WorldMapViewMediator(player,null);
         _loc1_.open(Stash.click("campaign",stashEventParams));
      }
      
      public function action_openShop() : void
      {
         var _loc1_:ShopDescription = DataStorage.shop.getShopById(1);
         Game.instance.navigator.navigateToShop(_loc1_,Stash.click("store:" + _loc1_.id,stashEventParams));
      }
      
      public function action_openChest() : void
      {
         var _loc1_:ChestPopupMediator = new ChestPopupMediator(GameModel.instance.player);
         _loc1_.open(Stash.click("chest",stashEventParams));
      }
      
      public function action_openZeppelin() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.ZEPPELIN,Stash.click("expeditions",stashEventParams));
      }
      
      public function action_openTower() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.TOWER,Stash.click("tower",stashEventParams));
      }
      
      public function action_openSpecialShop(param1:SpecialShopMerchant) : void
      {
         var _loc2_:SpecialShopPopupMediator = new SpecialShopPopupMediator(param1);
         _loc2_.open();
      }
      
      public function action_showNY2018Window() : void
      {
         if(GameModel.instance.player.specialOffer.hasSpecialOffer("newYear2018"))
         {
            Game.instance.navigator.navigateToMechanic(MechanicStorage.NY2018_WELCOME,Stash.click("ny_tree",stashEventParams));
         }
         else if(GameModel.instance.player.specialOffer.hasSpecialOffer("newYear2018gifts"))
         {
            Game.instance.navigator.navigateToMechanic(MechanicStorage.NY2018_GIFTS,Stash.click("ny_tree",stashEventParams));
         }
      }
      
      public function action_show() : void
      {
         adviceController.action_start();
      }
      
      public function action_hide() : void
      {
         adviceController.action_stop();
      }
      
      private function handler_heroesReady() : void
      {
         action_show();
      }
   }
}
