package game.view.gui.clanscreen
{
   import com.progrestar.common.lang.Translate;
   import engine.core.assets.AssetProgressProvider;
   import engine.core.clipgui.GuiAnimation;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.model.user.clan.ClanPrivateInfoValueObject;
   import game.model.user.specialoffer.SpecialOfferViewSlot;
   import game.screen.MainScreen;
   import game.view.gui.ClanScreenSceneMediator;
   import game.view.gui.clanscreen.heroes.ClanScreenHeroes;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import starling.animation.IAnimatable;
   import starling.display.Sprite;
   
   public class ClanScreenScene implements IAnimatable, ITutorialActionProvider, ITutorialNodePresenter
   {
       
      
      private var mediator:ClanScreenSceneMediator;
      
      private var city:ClanCityClip;
      
      private var heroes:ClanScreenHeroes;
      
      private var sky:GuiAnimation;
      
      private var front_sky:GuiAnimation;
      
      private var slotSummoningCircle:SpecialOfferViewSlot;
      
      public const graphics:Sprite = new Sprite();
      
      public function ClanScreenScene(param1:ClanScreenSceneMediator)
      {
         super();
         this.mediator = param1;
         heroes = new ClanScreenHeroes();
         heroes.start(param1.player);
         param1.signal_clanUpdate.add(handler_clanUpdate);
         param1.signal_spiritsUpdate.add(handler_spiritsUpdate);
         graphics.addEventListener("addedToStage",handler_addedToStage);
      }
      
      public static function getAsset() : RsxGuiAsset
      {
         return AssetStorage.rsx.getByName("clan_screen") as RsxGuiAsset;
      }
      
      public function dispose() : void
      {
         AssetStorage.instance.globalLoader.cancelCallback(handler_assetLoaded);
         mediator.titanSoulShopIsAvailable.unsubscribe(handler_titanSoulShopIsAvailable);
         graphics.removeEventListener("addedToStage",handler_addedToStage);
         if(slotSummoningCircle)
         {
            slotSummoningCircle.dispose();
         }
         if(city)
         {
            city.button_titanSoulShop.dispose();
         }
      }
      
      public function get initialized() : Boolean
      {
         return city != null;
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.CLAN_SCREEN;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:* = null;
         if(city == null)
         {
            return TutorialActionsHolder.create(graphics);
         }
         _loc2_ = TutorialActionsHolder.create(city.graphics);
         _loc2_.addButton(TutorialNavigator.TITAN_LIST,city.button_titanhall);
         _loc2_.addButton(TutorialNavigator.CLAN_DUNGEON,city.button_dungeon);
         _loc2_.addButton(TutorialNavigator.CLAN_SUMMONING_CIRCLE,city.button_summoncircle);
         _loc2_.addButton(TutorialNavigator.TITAN_GIFT_HEROES,city.button_blacksmith);
         _loc2_.addButton(TutorialNavigator.TITAN_SOUL_SHOP,city.button_titanSoulShop);
         _loc2_.addButton(TutorialNavigator.TITAN_VALLEY,city.button_titanArena);
         return _loc2_;
      }
      
      public function requestAsset() : AssetProgressProvider
      {
         AssetStorage.instance.globalLoader.cancelCallback(handler_assetLoaded);
         var _loc2_:RsxGuiAsset = getAsset();
         AssetStorage.instance.globalLoader.requestAssetWithCallback(_loc2_,handler_assetLoaded);
         _loc2_.addUsage();
         var _loc1_:AssetProgressProvider = AssetStorage.instance.globalLoader.getAssetProgress(_loc2_);
         return _loc1_;
      }
      
      public function advanceTime(param1:Number) : void
      {
         if(heroes)
         {
            heroes.advanceTime(param1);
         }
      }
      
      public function addedToStage() : void
      {
         mediator.action_addedToStage();
      }
      
      private function updateSpiritTotems() : void
      {
         city.button_titanArena.island_animation.totem_earth.setStar(mediator.totemStar_earth);
         city.button_titanArena.island_animation.totem_fire.setStar(mediator.totemStar_fire);
         city.button_titanArena.island_animation.totem_water.setStar(mediator.totemStar_water);
      }
      
      private function handler_assetLoaded(param1:RsxGuiAsset) : void
      {
         front_sky = param1.create(GuiAnimation,"front_sky");
         city = param1.create(ClanCityClip,"clan_city");
         sky = param1.create(GuiAnimation,"clan_city_sky");
         front_sky.graphics.touchable = false;
         front_sky.playbackSpeed = 0.3;
         sky.playbackSpeed = 0.1;
         graphics.y = -ClanScreenTransition.yOffset;
         graphics.addChild(sky.graphics);
         graphics.addChild(city.graphics);
         graphics.addChild(front_sky.graphics);
         city.container_heroes.container.addChild(heroes.graphics);
         city.container_titanhall_titan.container.addChild(heroes.mightyTitanGraphics);
         city.button_war.label = Translate.translate("UI_CLANMENU_WAR");
         city.button_war.redMarkerState = mediator.redMarkerMediator.clanWar;
         city.button_war.signal_click.add(mediator.action_navigate_war);
         city.button_titanhall.label = Translate.translate("UI_CLANMENU_TITANHALL");
         city.button_titanhall.redMarkerState = mediator.redMarkerMediator.titan;
         city.button_titanhall.signal_click.add(mediator.action_navigate_titanList);
         city.button_titanSoulShop.label = Translate.translate("UI_CLANMENU_TITANSOULSHOP");
         city.button_titanSoulShop.red_dot.graphics.visible = false;
         city.button_titanSoulShop.signal_click.add(mediator.action_navigate_titanSoulShop);
         mediator.titanSoulShopIsAvailable.onValue(handler_titanSoulShopIsAvailable);
         city.button_blacksmith.label = Translate.translate("UI_CLANMENU_ALTAR");
         city.button_blacksmith.signal_click.add(mediator.action_navigate_forge);
         city.button_dungeon.label = Translate.translate("UI_CLANMENU_DUNGEON");
         city.button_dungeon.signal_click.add(mediator.action_navigate_dungeon);
         city.button_titanArena.label = Translate.translate("UI_CLANMENU_TITAN_VALLEY");
         city.button_titanArena.redMarkerState = mediator.redMarkerMediator.titanValley;
         city.button_titanArena.signal_click.add(mediator.action_navigate_titanValley);
         city.button_summoncircle.label = Translate.translate("UI_CLANMENU_SUMMONING_CIRCLE");
         city.button_summoncircle.redMarkerState = mediator.redMarkerMediator.summnonKeys;
         city.button_summoncircle.signal_click.add(mediator.action_navigate_summoningCircle);
         city.block_clan_info.button_activity.initialize(Translate.translate("UI_DIALOG_CLAN_INFO_REWARD"),mediator.action_navigate_clanActivity);
         city.block_clan_info.button_members.initialize(Translate.translate("UI_DIALOG_CLAN_MEMBERS"),mediator.action_navigate_clanRoster);
         city.block_clan_info.button_settings.initialize(Translate.translate("UI_DIALOG_CLAN_INFO_SETTINGS"),mediator.action_navigate_clanSettings);
         slotSummoningCircle = new SpecialOfferViewSlot(city.button_summoncircle.labelBackground.graphics,mediator.player.specialOffer.hooks.clanScreenSummoningCircle,city.container);
         updateSpiritTotems();
         handler_clanUpdate();
         Tutorial.updateActionsFrom(this);
      }
      
      private function handler_clanUpdate() : void
      {
         var _loc2_:ClanPrivateInfoValueObject = mediator.clan;
         if(city)
         {
            city.block_clan_info.setData(_loc2_,mediator.player);
         }
         var _loc1_:MainScreen = Game.instance.screen.getMainScreen();
         if(_loc2_ == null && _loc1_.isOnClanScreen)
         {
            _loc1_.toHomeScreen();
         }
         var _loc3_:* = mediator.canEditClanSettings;
         city.block_clan_info.button_settings.isEnabled = _loc3_;
         city.block_clan_info.button_settings.graphics.visible = _loc3_;
      }
      
      private function handler_addedToStage() : void
      {
         mediator.action_addedToStage();
      }
      
      private function handler_titanSoulShopIsAvailable(param1:Boolean) : void
      {
         city.button_titanSoulShop.graphics.visible = param1;
      }
      
      private function handler_spiritsUpdate() : void
      {
         updateSpiritTotems();
      }
   }
}
