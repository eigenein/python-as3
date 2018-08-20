package
{
   import engine.context.GameContext;
   import engine.debug.ClickLoger;
   import feathers.core.PopUpManager;
   import game.assets.storage.AssetStorage;
   import game.command.timer.GameTimer;
   import game.data.storage.DataStorage;
   import game.mediator.gui.RedMarkerGlobalMediator;
   import game.mediator.gui.popup.GamePopupManager;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.chat.ProcessingURLTextMediator;
   import game.mediator.gui.tooltip.TooltipLayerMediator;
   import game.model.GameModel;
   import game.model.user.sharedobject.RefreshMetadata;
   import game.screen.GameScreenManager;
   import game.screen.navigator.GameNavigator;
   import game.sound.GameSoundPlayer;
   import game.util.ConsoleCommandsJS;
   import game.view.gui.GlobalKeyboardController;
   import game.view.gui.debug.LogView;
   import game.view.gui.tutorial.Tutorial;
   import game.view.popup.test.BattleTestStatsPopupMediator;
   import game.view.theme.HeroesThemeDesktop;
   import game.view.theme.HeroesThemeMobile;
   import starling.core.Starling;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.filters.ColorMatrixFilter;
   
   public class Game extends Sprite
   {
      
      public static const data:Class = DataStorage;
      
      private static var _instance:Game;
       
      
      private var hue:Number = 0;
      
      private var tooltipLayer:TooltipLayerMediator;
      
      private var tutorialLayer:Sprite;
      
      private const keyboard:GlobalKeyboardController = new GlobalKeyboardController();
      
      public const screen:GameScreenManager = new GameScreenManager();
      
      private var _navigator:GameNavigator;
      
      private var _soundPlayer:GameSoundPlayer;
      
      public function Game()
      {
         _soundPlayer = new GameSoundPlayer();
         super();
         _instance = this;
         if(!AssetStorage.instance.inited)
         {
            AssetStorage.instance.init(GameContext.instance.assetIndex);
         }
         AssetStorage.instance.complete();
         var _loc1_:Sprite = new Sprite();
         Starling.current.stage.addChild(_loc1_);
         PopUpManager.popUpManagerFactory = popUpManagerFactory;
         PopUpManager.root = _loc1_;
         tooltipLayer = new TooltipLayerMediator();
         Starling.current.stage.addChild(tooltipLayer.tooltipLayer);
         tooltipLayer.init();
         if(GameModel.instance.player.isInited)
         {
            initialize();
         }
         else
         {
            GameModel.instance.player.signal_update.initSignal.addOnce(initialize);
         }
         if(GameContext.instance.consoleEnabled)
         {
            new LogView();
         }
         GameContext.instance.blockMessageSignal.add(handler_gameRunBlockMessage);
         GameContext.instance.selectAccountSignal.add(handler_selectAccount);
      }
      
      public static function get instance() : Game
      {
         return _instance;
      }
      
      private function handler_selectAccount(param1:Array) : void
      {
         if(GameModel.instance.player.specialOffer.mergebonusEndTime - GameTimer.instance.currentServerTime > 0)
         {
            PopupList.instance.dialog_merge_info(param1);
         }
         else
         {
            PopupList.instance.dialog_select_account(param1);
         }
      }
      
      private function handler_gameRunBlockMessage(param1:String) : void
      {
         PopupList.instance.message(param1,"",true);
      }
      
      private function handler_ef(param1:Event) : void
      {
         hue = hue + 0.03;
         hue = hue + 0.03;
         hue = hue + 0.03;
         if(hue > 1)
         {
            hue = -1;
         }
         var _loc3_:ColorMatrixFilter = new ColorMatrixFilter();
         var _loc2_:ColorMatrixFilter = _loc3_.adjustHue(hue);
         filter = _loc3_;
      }
      
      public function get navigator() : GameNavigator
      {
         return _navigator;
      }
      
      public function get soundPlayer() : GameSoundPlayer
      {
         return _soundPlayer;
      }
      
      private function initialize() : void
      {
         if(GameModel.instance.context.platformFacade.network == "ios")
         {
            new HeroesThemeMobile(this);
         }
         else
         {
            new HeroesThemeDesktop(this);
         }
         new RedMarkerGlobalMediator(GameModel.instance.player);
         _navigator = new GameNavigator(GameModel.instance.player);
         tutorialLayer = new Sprite();
         addChild(tutorialLayer);
         addChild(tooltipLayer.tooltipLayer);
         if(stage)
         {
            onAddedToStage(null);
         }
         else
         {
            addEventListener("addedToStage",onAddedToStage);
         }
         addEventListener("resize",onResize);
      }
      
      private function popUpManagerFactory() : GamePopupManager
      {
         return new GamePopupManager();
      }
      
      private function onResize(param1:Event) : void
      {
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         if(!GameModel.instance.player.isInited)
         {
            stage.touchable = false;
            GameModel.instance.player.signal_update.initSignal.addOnce(handler_playerInit);
         }
         Tutorial.initializeView(tutorialLayer);
         keyboard.init(stage);
         screen.initialize(this);
         new ClickLoger();
         new ConsoleCommandsJS().init();
         addEventListener("enterFrame",handler_enterFrame);
         var _loc2_:String = GameContext.instance.platformFacade.referrer.replay_id;
         var _loc3_:RefreshMetadata = GameModel.instance.player.sharedObjectStorage.refreshMeta;
         var _loc4_:String = GameContext.instance.platformFacade.referrer.test_battle_setup;
         if(_loc2_)
         {
            ProcessingURLTextMediator.signal_replayComplete.add(handler_replayComplete);
            ProcessingURLTextMediator.replay(_loc2_);
         }
         else if(_loc3_ && _loc3_.action == "arenaBattle")
         {
            ProcessingURLTextMediator.signal_replayComplete.add(handler_replayComplete);
            ProcessingURLTextMediator.replay(_loc3_.replayId);
         }
         else if(_loc3_ && _loc3_.action == "grandBattle")
         {
            ProcessingURLTextMediator.signal_replayComplete.add(handler_replayComplete);
            ProcessingURLTextMediator.replayGrand(_loc3_.replayId);
         }
         else if(_loc4_ && GameContext.instance.consoleEnabled)
         {
            new BattleTestStatsPopupMediator(GameModel.instance.player,_loc4_).open();
         }
         else
         {
            Tutorial.start();
         }
      }
      
      private function handler_replayComplete() : void
      {
         ProcessingURLTextMediator.signal_replayComplete.remove(handler_replayComplete);
         Tutorial.start();
      }
      
      private function handler_playerInit() : void
      {
         stage.touchable = true;
      }
      
      private function handler_enterFrame(param1:Event) : void
      {
         GameTimer.instance.nextFrame();
      }
   }
}
