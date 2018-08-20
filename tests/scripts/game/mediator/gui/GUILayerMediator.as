package game.mediator.gui
{
   import com.progrestar.common.Logger;
   import com.progrestar.common.social.GMRSocialAdapter;
   import com.progrestar.common.social.SocialAdapter;
   import flash.events.FullScreenEvent;
   import flash.utils.Dictionary;
   import game.assets.storage.AssetStorage;
   import game.data.storage.level.PlayerTeamLevel;
   import game.mediator.gui.debug.DebugGuiClan;
   import game.mediator.gui.debug.DebugGuiHero;
   import game.mediator.gui.debug.DebugGuiPush;
   import game.mediator.gui.homescreen.HomeScreenClanMenuMediator;
   import game.mediator.gui.homescreen.HomeScreenIconicMenuMediator;
   import game.mediator.gui.homescreen.PlayerStatsPanelMediator;
   import game.mediator.gui.homescreen.SpecialOfferSideBarMediator;
   import game.mediator.gui.popup.AutoPopupMediator;
   import game.mediator.gui.popup.HeroRewardPopupHandler;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.VipLevelUpPopupHandler;
   import game.mediator.gui.popup.settings.SettingsPopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.screen.FullScreenController;
   import game.view.gui.tutorial.Tutorial;
   import game.view.layer.GUILayer;
   import game.view.popup.messagetimeout.MessageTimeoutPopup;
   import idv.cjcat.signals.Signal;
   import starling.core.Starling;
   import starling.events.Event;
   
   public class GUILayerMediator
   {
      
      private static const logger:Logger = Logger.getLogger(GUILayerMediator);
       
      
      private var player:Player;
      
      private var hasUnreadMailToDingDong:Boolean;
      
      private var socialPaymantBoxMessage:MessageTimeoutPopup;
      
      private var _autoPopupMediator:AutoPopupMediator;
      
      private var _heroRewardHandler:HeroRewardPopupHandler;
      
      private var _vipLevelUpPopupHandler:VipLevelUpPopupHandler;
      
      private var _playerStatsPanelMediator:PlayerStatsPanelMediator;
      
      private var _iconicMenuMediator:HomeScreenIconicMenuMediator;
      
      private var _specialOfferSideBar:SpecialOfferSideBarMediator;
      
      private var _clanMenuMediator:HomeScreenClanMenuMediator;
      
      private var _mainMenu:Dictionary;
      
      public var guiLayer:GUILayer;
      
      private var _signal_playerInit:Signal;
      
      private var _signal_fullScreenStateChange:Signal;
      
      public function GUILayerMediator(param1:Player)
      {
         _signal_fullScreenStateChange = new Signal();
         super();
         this.player = param1;
         param1.levelData.signal_levelUp.add(onPlayerLevelUp);
         _mainMenu = new Dictionary();
         _mainMenu["hero"] = new DebugGuiHero().actions;
         _mainMenu["i have no friends"] = new DebugGuiClan().actions;
         _mainMenu["push"] = new DebugGuiPush().actions;
         _playerStatsPanelMediator = new PlayerStatsPanelMediator(GameModel.instance.player);
         _iconicMenuMediator = new HomeScreenIconicMenuMediator(param1,this);
         _clanMenuMediator = new HomeScreenClanMenuMediator(param1);
         _specialOfferSideBar = new SpecialOfferSideBarMediator(param1);
         _signal_playerInit = param1.signal_update.initSignal;
         guiLayer = new GUILayer(this);
         guiLayer.buttonSignal.add(buttonListener);
         _heroRewardHandler = new HeroRewardPopupHandler(param1);
         _vipLevelUpPopupHandler = new VipLevelUpPopupHandler(param1);
         _autoPopupMediator = new AutoPopupMediator(param1);
         if(param1.isInited)
         {
            handler_playerInit();
         }
         else
         {
            param1.signal_update.initSignal.add(handler_playerInit);
         }
         if(SocialAdapter.instance is GMRSocialAdapter)
         {
            SocialAdapter.instance.addEventListener("openSocialPaymentBox",handler_socialPaymentBoxOpen);
            SocialAdapter.instance.addEventListener("closeSocialPaymentBox",handler_socialPaymentBoxClose);
            SocialAdapter.instance.addEventListener("closeSocialBox",handler_socialBoxClose);
         }
         Starling.current.nativeStage.addEventListener("fullScreen",handler_fullScreenStateChange);
      }
      
      public function get autoPopupMediator() : AutoPopupMediator
      {
         return _autoPopupMediator;
      }
      
      public function get heroRewardHandler() : HeroRewardPopupHandler
      {
         return _heroRewardHandler;
      }
      
      public function get vipLevelUpPopupHandler() : VipLevelUpPopupHandler
      {
         return _vipLevelUpPopupHandler;
      }
      
      public function get playerStatsPanelMediator() : PlayerStatsPanelMediator
      {
         return _playerStatsPanelMediator;
      }
      
      public function get iconicMenuMediator() : HomeScreenIconicMenuMediator
      {
         return _iconicMenuMediator;
      }
      
      public function get specialOfferSideBar() : SpecialOfferSideBarMediator
      {
         return _specialOfferSideBar;
      }
      
      public function get clanMenuMediator() : HomeScreenClanMenuMediator
      {
         return _clanMenuMediator;
      }
      
      public function get mainMenu() : Dictionary
      {
         return _mainMenu;
      }
      
      public function get signal_playerInit() : Signal
      {
         return _signal_playerInit;
      }
      
      public function get signal_fullScreenStateChange() : Signal
      {
         return _signal_fullScreenStateChange;
      }
      
      public function get playerIdString() : String
      {
         return "id" + GameModel.instance.player.id;
      }
      
      public function get fullScreenMode() : Boolean
      {
         return Starling.current.nativeStage.displayState != "normal";
      }
      
      public function action_settings() : void
      {
         var _loc1_:SettingsPopupMediator = new SettingsPopupMediator(GameModel.instance.player);
         _loc1_.open();
      }
      
      public function addedToStage() : void
      {
         if(hasUnreadMailToDingDong && !Tutorial.inputIsBlocked)
         {
            playUnreadMailDingDong();
         }
      }
      
      public function changeFullScreenMode() : void
      {
         if(fullScreenMode)
         {
            FullScreenController.instance.fullScreenOff();
         }
         else
         {
            FullScreenController.instance.fullScreenOn();
         }
      }
      
      private function playUnreadMailDingDong() : void
      {
         AssetStorage.sound.incomeMessage.play();
         hasUnreadMailToDingDong = false;
      }
      
      private function buttonListener(param1:String, param2:String) : void
      {
      }
      
      private function onPlayerLevelUp(param1:PlayerTeamLevel) : void
      {
         PopupList.instance.dialog_level_up(player.levelData.level,param1);
      }
      
      private function handler_playerInit() : void
      {
         _clanMenuMediator.initialize();
         player.mail.signal_newMail.add(handler_hasUnreadMailUpdated);
         handler_hasUnreadMailUpdated();
         if(guiLayer.stage)
         {
            _autoPopupMediator.initialize();
         }
         else
         {
            guiLayer.addEventListener("addedToStage",handler_addedToStageAfterInit);
         }
      }
      
      private function handler_addedToStageAfterInit(param1:starling.events.Event) : void
      {
         guiLayer.removeEventListener("addedToStage",handler_addedToStageAfterInit);
         _autoPopupMediator.initialize();
      }
      
      private function handler_hasUnreadMailUpdated() : void
      {
         hasUnreadMailToDingDong = player.mail.hasUnreadMail;
         if(guiLayer.stage && hasUnreadMailToDingDong && !Tutorial.inputIsBlocked)
         {
            playUnreadMailDingDong();
         }
      }
      
      private function handler_fullScreenStateChange(param1:FullScreenEvent) : void
      {
         _signal_fullScreenStateChange.dispatch();
      }
      
      protected function handler_socialPaymentBoxOpen(param1:flash.events.Event) : void
      {
         if(!socialPaymantBoxMessage)
         {
            socialPaymantBoxMessage = new MessageTimeoutPopup("UI_PAYMENT_BOX_GRM_TEXT",10,true);
            socialPaymantBoxMessage.open();
         }
      }
      
      protected function handler_socialPaymentBoxClose(param1:flash.events.Event) : void
      {
         if(socialPaymantBoxMessage)
         {
            socialPaymantBoxMessage.timerStart();
         }
      }
      
      protected function handler_socialBoxClose(param1:flash.events.Event) : void
      {
         if(socialPaymantBoxMessage)
         {
            socialPaymantBoxMessage.forceClose();
            socialPaymantBoxMessage = null;
         }
      }
   }
}
