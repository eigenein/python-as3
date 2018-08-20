package game.screen
{
   import feathers.core.PopUpManager;
   import game.battle.controller.thread.BattleThread;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.Tutorial;
   import starling.animation.IAnimatable;
   import starling.core.Starling;
   import starling.display.DisplayObjectContainer;
   
   public class GameScreenManager implements IAnimatable
   {
       
      
      private var mainScreen:MainScreen;
      
      private var dialogScreen:DialogScreen;
      
      private var battleScreen:BattleScreen;
      
      private var container:DisplayObjectContainer;
      
      private var currentScreen:GameScreen;
      
      private var lastPermanent:GameScreen;
      
      private var presentedScreens:Vector.<GameScreen>;
      
      public const size:GameScreenSize = new GameScreenSize();
      
      public function GameScreenManager()
      {
         presentedScreens = new Vector.<GameScreen>();
         super();
      }
      
      public function get isOnDialogs() : Boolean
      {
         return currentScreen == dialogScreen;
      }
      
      public function get isOnBattle() : Boolean
      {
         return currentScreen == battleScreen && battleScreen != null;
      }
      
      public function advanceTime(param1:Number) : void
      {
         if(currentScreen)
         {
            currentScreen.juggler.advanceTime(param1);
         }
      }
      
      public function initialize(param1:DisplayObjectContainer) : void
      {
         this.container = param1;
         size.initialize(Starling.current.stage.stageWidth,Starling.current.stage.stageHeight);
         mainScreen = new MainScreen();
         dialogScreen = new DialogScreen();
         battleScreen = new BattleScreen();
         PopUpManager.root && PopUpManager.root.removeFromParent();
         PopUpManager.root = dialogScreen.graphics;
         addScreen(mainScreen);
         Starling.juggler.add(this);
      }
      
      public function showBattle(param1:BattleThread) : BattleScreen
      {
         addScreen(battleScreen);
         battleScreen.start(param1);
         return battleScreen;
      }
      
      public function hideBattle() : void
      {
         battleScreen.clear();
         removeScreen(battleScreen);
      }
      
      public function showNotDisposedBattle() : void
      {
         if(battleScreen.scene)
         {
            addScreen(battleScreen);
         }
      }
      
      public function hideNotDisposedBattle() : void
      {
         if(battleScreen.scene)
         {
            removeScreen(battleScreen);
         }
      }
      
      public function getBattleScreen() : BattleScreen
      {
         return battleScreen;
      }
      
      public function getMainScreen() : MainScreen
      {
         return mainScreen;
      }
      
      public function showDialogs() : void
      {
         addScreen(dialogScreen);
      }
      
      public function hideDialogs() : void
      {
         removeScreen(dialogScreen);
      }
      
      protected function addScreen(param1:GameScreen) : void
      {
         if(presentedScreens.indexOf(param1) == -1)
         {
            presentedScreens.push(param1);
            presentedScreens.sort(GameScreen.sortByPriority);
            if(presentedScreens[0] != currentScreen)
            {
               changeScreen(presentedScreens[0]);
            }
         }
      }
      
      protected function removeScreen(param1:GameScreen) : void
      {
         var _loc2_:int = presentedScreens.indexOf(param1);
         if(_loc2_ != -1)
         {
            presentedScreens.splice(_loc2_,1);
            if(presentedScreens[0] != currentScreen)
            {
               changeScreen(presentedScreens[0]);
            }
         }
      }
      
      protected function changeScreen(param1:GameScreen) : void
      {
         if(currentScreen == param1)
         {
            return;
         }
         if(currentScreen)
         {
            currentScreen.hide();
         }
         if(param1.isPermanent() && lastPermanent != param1)
         {
            lastPermanent = param1;
         }
         currentScreen = param1;
         param1.show(container);
         if(currentScreen == param1 && currentScreen is ITutorialNodePresenter)
         {
            Tutorial.registerNode(currentScreen as ITutorialNodePresenter);
         }
      }
   }
}
