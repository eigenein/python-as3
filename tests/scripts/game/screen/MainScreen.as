package game.screen
{
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.GUILayerMediator;
   import game.mediator.gui.component.PopupOverlay;
   import game.model.GameModel;
   import game.view.gui.ClanScreenSceneMediator;
   import game.view.gui.HomeScreenSceneMediator;
   import game.view.gui.clanscreen.ClanScreenScene;
   import game.view.gui.clanscreen.ClanScreenTransition;
   import game.view.gui.homescreen.HomeScreenScene;
   import game.view.gui.tutorial.Tutorial;
   import game.view.layer.GUILayer;
   import starling.display.DisplayObjectContainer;
   import starling.events.Event;
   
   public class MainScreen extends GameScreen
   {
       
      
      private var homeScreen:HomeScreenScene;
      
      private var clanScreen:ClanScreenScene;
      
      private var transition:ClanScreenTransition;
      
      private var homeScreenMediator:HomeScreenSceneMediator;
      
      private var guiLayer:GUILayer;
      
      private var guiLayerMediator:GUILayerMediator;
      
      var clip_overlay:PopupOverlay;
      
      private var _isOnClanScreen:BooleanPropertyWriteable;
      
      private var _displayIsOnClanScreen:BooleanPropertyWriteable;
      
      private var _transitionInProgress:BooleanPropertyWriteable;
      
      public function MainScreen()
      {
         _isOnClanScreen = new BooleanPropertyWriteable(false);
         _displayIsOnClanScreen = new BooleanPropertyWriteable(false);
         _transitionInProgress = new BooleanPropertyWriteable(false);
         super(3);
         homeScreenMediator = new HomeScreenSceneMediator(GameModel.instance.player,juggler);
         homeScreen = new HomeScreenScene(homeScreenMediator);
         graphics.addChild(homeScreen);
         guiLayerMediator = new GUILayerMediator(GameModel.instance.player);
         guiLayer = guiLayerMediator.guiLayer;
         graphics.addChild(guiLayer);
         clip_overlay = AssetStorage.rsx.popup_theme.create(PopupOverlay,"popup_overlay");
         graphics.addEventListener("removedFromStage",handler_removedFromStage);
      }
      
      public function get isOnClanScreen() : BooleanProperty
      {
         return _isOnClanScreen;
      }
      
      public function get transitionInProgress() : BooleanProperty
      {
         return _transitionInProgress;
      }
      
      public function toggleHomeAndClan() : void
      {
         if(transition == null || transition.transitionInProgress.value == false)
         {
            if(transition == null || !transition.clanScreenState)
            {
               toClanScreen();
            }
            else
            {
               toHomeScreen();
            }
         }
      }
      
      public function toClanScreen() : void
      {
         if(transition != null && (transition.transitionInProgress.value || transition.clanScreenState))
         {
            return;
         }
         if(!clanScreen)
         {
            createClanScreen();
         }
         graphics.addChildAt(clanScreen.graphics,1);
         transition.toClanScreen(null);
         juggler.add(clanScreen);
         _isOnClanScreen.value = true;
         Tutorial.events.triggerEvent_anyNavigation();
      }
      
      public function toHomeScreen() : void
      {
         if(transition.transitionInProgress.value || !transition.clanScreenState)
         {
            return;
         }
         if(!clanScreen)
         {
            createClanScreen();
         }
         graphics.addChildAt(homeScreen,0);
         graphics.addChildAt(clanScreen.graphics,1);
         transition.toHomeScreen(null);
         juggler.remove(clanScreen);
         _isOnClanScreen.value = false;
      }
      
      override public function show(param1:DisplayObjectContainer) : void
      {
         super.show(param1);
         guiLayerMediator.addedToStage();
         homeScreenMediator.action_show();
         _displayIsOnClanScreen.onValue(handler_displayIsOnClanScreen);
      }
      
      override public function hide() : void
      {
         super.hide();
         homeScreenMediator.action_hide();
         _displayIsOnClanScreen.unsubscribe(handler_displayIsOnClanScreen);
         if(_displayIsOnClanScreen.value)
         {
            if(clanScreen)
            {
               Tutorial.unregister(clanScreen);
               Tutorial.removeActionsFrom(clanScreen);
            }
         }
         else
         {
            Tutorial.unregister(homeScreen);
            Tutorial.removeActionsFrom(homeScreen);
         }
      }
      
      private function createClanScreen() : void
      {
         clanScreen = new ClanScreenSceneMediator(GameModel.instance.player).createClanScreen();
         transition = new ClanScreenTransition(clanScreen,homeScreen,guiLayerMediator);
         transition.transitionInProgress.onValue(handler_transitionInProgress);
         transition.signal_transitionMiddlePointReached.add(handler_transitionMiddlePointReached);
      }
      
      private function handler_transitionInProgress(param1:Boolean) : void
      {
         _transitionInProgress.value = param1;
      }
      
      private function handler_displayIsOnClanScreen(param1:Boolean) : void
      {
         if(param1)
         {
            if(clanScreen)
            {
               Tutorial.registerNode(clanScreen);
               Tutorial.addActionsFrom(clanScreen);
            }
            Tutorial.unregister(homeScreen);
         }
         else
         {
            Tutorial.registerNode(homeScreen);
            Tutorial.addActionsFrom(homeScreen);
            if(clanScreen)
            {
               Tutorial.removeActionsFrom(clanScreen);
               Tutorial.unregister(clanScreen);
            }
         }
      }
      
      private function handler_transitionMiddlePointReached() : void
      {
         _displayIsOnClanScreen.value = isOnClanScreen.value;
      }
      
      private function handler_removedFromStage(param1:Event) : void
      {
         graphics.removeEventListener("removedFromStage",handler_removedFromStage);
         graphics.addEventListener("addedToStage",handler_addedToStage);
         clip_overlay.hide();
      }
      
      private function handler_addedToStage(param1:Event) : void
      {
         clip_overlay.tweenHide(graphics.stage);
         graphics.addEventListener("removedFromStage",handler_removedFromStage);
         graphics.removeEventListener("addedToStage",handler_addedToStage);
      }
   }
}
