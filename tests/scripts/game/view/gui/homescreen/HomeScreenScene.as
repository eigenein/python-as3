package game.view.gui.homescreen
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipFactory;
   import feathers.controls.LayoutGroup;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import game.data.storage.DataStorage;
   import game.data.storage.mechanic.MechanicStorage;
   import game.model.user.specialoffer.Halloween2k17SpecialOfferViewOwner;
   import game.model.user.specialoffer.NY2018SecretRewardOfferViewOwner;
   import game.model.user.specialoffer.SpecialOfferViewSlot;
   import game.view.gui.HomeScreenSceneMediator;
   import game.view.gui.components.ClipProgressBar;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import starling.core.Starling;
   import starling.display.Sprite;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   public class HomeScreenScene extends LayoutGroup implements ITutorialActionProvider, ITutorialNodePresenter
   {
       
      
      var clip_ground:HomeScreenGuiClip;
      
      var clip_sky:HomeScreenZeppelinLayerGuiClip;
      
      private var parallax_layer_1:Sprite;
      
      private var parallax_layer_2:Sprite;
      
      private var parallax_layer_3:Sprite;
      
      private var mediator:HomeScreenSceneMediator;
      
      private var layoutGroup:LayoutGroup;
      
      private var btn_portal_slot:SpecialOfferViewSlot;
      
      private var _specialShop:SpecialShopButtonController;
      
      private var _newYearSpecialOfferController:NewYearSpecialOfferController;
      
      private var _newYear2018SpecialOfferController:NewYear2018SpecialOfferController;
      
      public function HomeScreenScene(param1:HomeScreenSceneMediator)
      {
         var _loc3_:* = null;
         clip_ground = new HomeScreenGuiClip();
         super();
         this.mediator = param1;
         layoutGroup = new LayoutGroup();
         HomeScreenStyle.initialize();
         parallax_layer_3 = new Sprite();
         addChild(parallax_layer_3);
         parallax_layer_2 = new Sprite();
         addChild(parallax_layer_2);
         parallax_layer_1 = new Sprite();
         addChild(parallax_layer_1);
         var _loc2_:GuiClipFactory = new GuiClipFactory();
         clip_sky = new HomeScreenZeppelinLayerGuiClip();
         _loc2_.create(clip_sky,HomeScreenStyle.asset.data.getClipByName("main_city_sky"));
         addChild(clip_sky.graphics);
         _loc2_.create(clip_ground,HomeScreenStyle.asset.data.getClipByName("main_city_ground"));
         addChild(clip_ground.graphics);
         clip_ground.playback.gotoAndStop(0);
         clip_ground.btn_arena.label = Translate.translate("UI_MAINMENU_ARENA");
         clip_ground.btn_arena.signal_click.add(mediator.action_openArena);
         clip_ground.btn_grand_arena.label = Translate.translate("UI_MAINMENU_GRAND_ARENA");
         clip_ground.btn_grand_arena.signal_click.add(mediator.action_openGrand);
         clip_ground.btn_expeditions.label = Translate.translate("UI_MAINMENU_ZEPPELIN");
         clip_ground.btn_expeditions.signal_click.add(mediator.action_openZeppelin);
         clip_ground.btn_expeditions.redMarkerState = mediator.redMarkerMediator.zeppelin;
         clip_ground.btn_portal.label = Translate.translate("UI_MAINMENU_PORTAL");
         clip_ground.btn_portal.signal_click.add(mediator.action_openPortal);
         clip_ground.btn_shop.label = Translate.translate("UI_MAINMENU_SHOP");
         clip_ground.btn_shop.signal_click.add(mediator.action_openShop);
         clip_ground.btn_tower.label = Translate.translate("UI_MAINMENU_TOWER");
         clip_ground.btn_tower.signal_click.add(mediator.action_openTower);
         clip_ground.btn_chest.redMarkerState = mediator.redMarkerMediator.chest;
         clip_ground.btn_chest.signal_click.add(mediator.action_openChest);
         clip_sky.button_boss.label = Translate.translate("UI_MAINMENU_BOSS");
         clip_sky.button_boss.signal_click.add(mediator.action_openBoss);
         clip_sky.button_boss.redMarkerState = mediator.redMarkerMediator.outland;
         clip_sky.button_boss.isEnabled = mediator.isEnabled_boss;
         if(clip_sky.layout_hidden_moon && clip_sky.layout_hidden_moon.parent)
         {
            param1.specialOfferHooks.registerHalloween2k17SpecialOffer(new Halloween2k17SpecialOfferViewOwner(clip_sky.layout_hidden_moon,this,"moon"));
         }
         if(clip_sky.layout_giftdrop && clip_sky.layout_giftdrop.parent)
         {
            _loc3_ = HomeScreenStyle.asset.create(GuiAnimation,"snow_layer_front");
            _loc3_.graphics.touchable = false;
            _loc3_.playbackSpeed = 0.4;
            addChild(_loc3_.graphics);
            param1.specialOfferHooks.registerNY2018SecretRewardOffer(new NY2018SecretRewardOfferViewOwner(clip_sky.layout_giftdrop,this,"moon"));
         }
         param1.specialOfferHooks.registerHomeScreenChest(clip_ground.btn_chest);
         btn_portal_slot = new SpecialOfferViewSlot(clip_ground.btn_portal.container,param1.specialOfferHooks.homeScreenCampaign);
         clip_ground.container.addChild(mediator.heroContainer);
         if(clip_ground.btn_vagon)
         {
            clip_ground.btn_vagon.graphics.visible = false;
         }
         if(clip_ground.btn_ny_vagon)
         {
            clip_ground.btn_ny_vagon.graphics.visible = false;
         }
         if((mediator.hasSpcecialOfferNY2018 || mediator.hasSpcecialOfferNY2018Gifts) && clip_ground.btn_ny_vagon)
         {
            _newYear2018SpecialOfferController = new NewYear2018SpecialOfferController(clip_ground.btn_ny_vagon);
            _newYear2018SpecialOfferController.clickSignal.add(mediator.action_showNY2018Window);
            new HomeScreenSceneNYFireworks(clip_sky,clip_ground);
         }
         else if(!DataStorage.rule.personalMerchantRule.useSidebarIcon && clip_ground.btn_vagon)
         {
            _specialShop = new SpecialShopButtonController(clip_ground.btn_vagon);
            _specialShop.clickSignal.add(mediator.action_openSpecialShop);
         }
         clip_ground.btn_tower.isEnabled = Game.instance.navigator.isMechanicEnabled(MechanicStorage.TOWER);
      }
      
      private function onTouch(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(this);
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_.phase == "began")
         {
            Starling.current.nativeStage.addEventListener("mouseUp",fullScreen);
         }
      }
      
      private function fullScreen(param1:MouseEvent) : void
      {
         var _loc2_:Stage = Starling.current.nativeStage;
         Starling.current.nativeStage.removeEventListener("mouseUp",fullScreen);
         if(_loc2_.displayState == "normal")
         {
            _loc2_.displayState = "fullScreen";
         }
         else
         {
            _loc2_.displayState = "normal";
         }
      }
      
      public function get specialShop() : SpecialShopButtonController
      {
         return _specialShop;
      }
      
      public function get newYearSpecialOfferController() : NewYearSpecialOfferController
      {
         return _newYearSpecialOfferController;
      }
      
      public function get newYear2018SpecialOfferController() : NewYear2018SpecialOfferController
      {
         return _newYear2018SpecialOfferController;
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.HOME_SCREEN;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         _loc2_.addButton(TutorialNavigator.WORLD_MAP,clip_ground.btn_portal);
         _loc2_.addButton(TutorialNavigator.SHOP,clip_ground.btn_shop);
         _loc2_.addButton(TutorialNavigator.CHESTS,clip_ground.btn_chest);
         _loc2_.addButton(TutorialNavigator.ARENA,clip_ground.btn_arena);
         return _loc2_;
      }
      
      public function animateUpMotion() : void
      {
         clip_ground.playback.gotoAndStop(0);
         clip_ground.playback.stopOnFrame(9);
      }
      
      public function stopOnMiddleFrame() : void
      {
         clip_ground.playback.gotoAndStop(9);
      }
      
      public function animateDownMotion() : void
      {
         clip_ground.playback.gotoAndStop(9);
         clip_ground.playback.stopOnFrame(0);
      }
      
      public function addClanScreenPreloaderBar(param1:ClipProgressBar) : void
      {
         clip_sky.container_progressbar.layout.addChild(param1.graphics);
      }
      
      private function handler_shopClick() : void
      {
         mediator.action_openShop();
      }
      
      private function handler_chestClick() : void
      {
         mediator.action_openChest();
      }
      
      private function handler_arenaClick() : void
      {
         mediator.action_openArena();
      }
      
      private function handler_guildClick() : void
      {
         mediator.action_openGuild();
      }
      
      private function handler_portalClick() : void
      {
         mediator.action_openPortal();
      }
   }
}
