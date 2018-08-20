package game.view.gui.clanscreen
{
   import engine.core.assets.AssetProgressProvider;
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.GUILayerMediator;
   import game.view.gui.components.ClipProgressBar;
   import game.view.gui.homescreen.HomeScreenScene;
   import org.osflash.signals.Signal;
   import starling.core.Starling;
   
   public class ClanScreenTransition
   {
      
      public static var preloaderDuration:Number = 0.85;
      
      public static var transitionFxHideDelayK:Number = 0.7;
      
      public static var transitionFxHideDurationK:Number = 0.2;
      
      public static var transitionDurationByNum:Vector.<Number> = new <Number>[1.6,1.6,1,0.6];
      
      public static var transitionType:String = "easeInOut";
      
      public static var yPreloaderOffset:Number = 750;
      
      public static var yOffset:Number = 2100.0;
       
      
      private var clanScreen:ClanScreenScene;
      
      private var homeScreen:HomeScreenScene;
      
      private var guiLayerMediator:GUILayerMediator;
      
      private var transitionFx:ClanScreenTransitionSpeedFx;
      
      private var _transitionInProgress:BooleanPropertyWriteable;
      
      private var needPreloading:Boolean = false;
      
      private var _toClanScreen:Boolean = false;
      
      private var progress:AssetProgressProvider;
      
      private var progressBar:ClipProgressBar;
      
      private var transitionNumInSession:int = -1;
      
      public const signal_transitionMiddlePointReached:Signal = new Signal();
      
      public function ClanScreenTransition(param1:ClanScreenScene, param2:HomeScreenScene, param3:GUILayerMediator)
      {
         _transitionInProgress = new BooleanPropertyWriteable(false);
         super();
         this.clanScreen = param1;
         this.homeScreen = param2;
         this.guiLayerMediator = param3;
         transitionFx = new ClanScreenTransitionSpeedFx(param2.parent);
      }
      
      public function get clanScreenState() : Boolean
      {
         return _toClanScreen;
      }
      
      public function get transitionInProgress() : BooleanProperty
      {
         return _transitionInProgress;
      }
      
      public function toClanScreen(param1:AssetProgressProvider) : void
      {
         _toClanScreen = true;
         Starling.juggler.delayCall(homeScreen.animateUpMotion,0.166666666666667);
         startTransition(param1);
      }
      
      public function toHomeScreen(param1:AssetProgressProvider) : void
      {
         _toClanScreen = false;
         homeScreen.stopOnMiddleFrame();
         startTransition(param1);
      }
      
      private function startTransition(param1:AssetProgressProvider) : void
      {
         _transitionInProgress.value = true;
         var _loc2_:Number = getNextTransitionDuration();
         guiLayerMediator.iconicMenuMediator.panel.visible = true;
         guiLayerMediator.playerStatsPanelMediator.portraitGroup.visible = true;
         needPreloading = !clanScreen.initialized;
         Starling.juggler.removeTweens(homeScreen);
         Starling.juggler.removeTweens(clanScreen);
         var _loc3_:Number = !!_toClanScreen?0:Number(-yOffset);
         if(needPreloading)
         {
            if(!progressBar)
            {
               createProgressBar();
            }
            Starling.juggler.tween(homeScreen,preloaderDuration,{
               "y":yPreloaderOffset,
               "transition":transitionType,
               "onComplete":toPreloader,
               "onUpdate":homeScreenTransitionUpdate
            });
            Starling.juggler.tween(guiLayerMediator.iconicMenuMediator.panel,_loc2_,{
               "pivotY":-yPreloaderOffset - yOffset,
               "transition":transitionType,
               "onComplete":hideIconicMenu
            });
         }
         else
         {
            Starling.juggler.tween(homeScreen,_loc2_,{
               "y":_loc3_ + yOffset,
               "transition":transitionType,
               "onComplete":transitionComplete,
               "onUpdate":homeScreenTransitionUpdate
            });
            Starling.juggler.delayCall(transitionMiddlePointReached,_loc2_ * 0.5);
            if(!_toClanScreen)
            {
               Starling.juggler.delayCall(homeScreen.animateDownMotion,_loc2_ - 0.583333333333333);
            }
            Starling.juggler.delayCall(transitionFx.hide,transitionFxHideDelayK * _loc2_,transitionFxHideDurationK * _loc2_);
            Starling.juggler.tween(guiLayerMediator.iconicMenuMediator.panel,_loc2_,{
               "pivotY":-_loc3_ - yOffset,
               "transition":transitionType,
               "onComplete":hideIconicMenu
            });
         }
         transitionFx.show(0.1 * _loc2_,0.4 * _loc2_,_toClanScreen);
         if(_toClanScreen)
         {
            Starling.juggler.tween(guiLayerMediator.playerStatsPanelMediator.portraitGroup,0.3,{
               "delay":0.2,
               "pivotY":100,
               "alpha":0,
               "rotation":-0.2,
               "transition":"easeIn",
               "onComplete":hidePlayerPortraitGroup
            });
         }
         else
         {
            Starling.juggler.tween(guiLayerMediator.playerStatsPanelMediator.portraitGroup,0.3,{
               "delay":_loc2_ - 0.4,
               "pivotY":0,
               "alpha":1,
               "rotation":0,
               "transition":"easeOut",
               "onComplete":hidePlayerPortraitGroup
            });
         }
      }
      
      private function createProgressBar() : void
      {
         progressBar = AssetStorage.rsx.popup_theme.create_component_progressbar();
         progressBar.maxValue = 1;
         progressBar.value = 0;
         homeScreen.addClanScreenPreloaderBar(progressBar);
      }
      
      private function hideIconicMenu() : void
      {
         guiLayerMediator.iconicMenuMediator.panel.visible = !_toClanScreen;
      }
      
      private function hidePlayerPortraitGroup() : void
      {
         guiLayerMediator.playerStatsPanelMediator.portraitGroup.visible = !_toClanScreen;
      }
      
      private function toPreloader() : void
      {
         var _loc1_:AssetProgressProvider = clanScreen.requestAsset();
         requestPreloader(_loc1_);
         if(_loc1_ && !_loc1_.completed)
         {
            progressBar.maxValue = _loc1_.progressTotal;
            progressBar.value = _loc1_.progressCurrent;
            _loc1_.signal_onProgress.add(handler_checkProgress);
         }
         else
         {
            completePreloading();
         }
      }
      
      private function transitionComplete() : void
      {
         if(_toClanScreen)
         {
            homeScreen.removeFromParent();
         }
         else
         {
            clanScreen.graphics.removeFromParent();
         }
         _transitionInProgress.value = false;
      }
      
      private function requestPreloader(param1:AssetProgressProvider) : void
      {
         if(this.progress != null)
         {
            this.progress.signal_onProgress.remove(handler_checkProgress);
         }
         if(param1 == null || param1.completed)
         {
            this.progress = null;
            needPreloading = false;
         }
         else
         {
            this.progress = param1;
            needPreloading = true;
         }
      }
      
      private function completePreloading() : void
      {
         var _loc1_:Number = getCurrentTransitionDuration();
         if(_toClanScreen)
         {
            Starling.juggler.tween(homeScreen,_loc1_,{
               "y":yOffset,
               "transition":transitionType,
               "onComplete":transitionComplete,
               "onUpdate":homeScreenTransitionUpdate
            });
            Starling.juggler.delayCall(transitionMiddlePointReached,_loc1_ * 0.5);
         }
         else
         {
            Starling.juggler.tween(homeScreen,_loc1_,{
               "y":0,
               "transition":transitionType,
               "onComplete":transitionComplete,
               "onUpdate":homeScreenTransitionUpdate
            });
            Starling.juggler.delayCall(transitionMiddlePointReached,_loc1_ * 0.5);
         }
         Starling.juggler.delayCall(transitionFx.hide,transitionFxHideDelayK * _loc1_,transitionFxHideDurationK * _loc1_);
      }
      
      private function getNextTransitionDuration() : Number
      {
         transitionNumInSession = Number(transitionNumInSession) + 1;
         return getCurrentTransitionDuration();
      }
      
      private function getCurrentTransitionDuration() : Number
      {
         var _loc1_:Number = NaN;
         if(transitionNumInSession >= transitionDurationByNum.length)
         {
            _loc1_ = transitionDurationByNum[transitionDurationByNum.length - 1];
         }
         else
         {
            _loc1_ = transitionDurationByNum[transitionNumInSession];
         }
         return _loc1_;
      }
      
      private function homeScreenTransitionUpdate() : void
      {
         clanScreen.graphics.y = homeScreen.y - yOffset;
      }
      
      private function transitionMiddlePointReached() : void
      {
         signal_transitionMiddlePointReached.dispatch();
      }
      
      private function handler_checkProgress(param1:AssetProgressProvider) : void
      {
         if(this.progress == param1)
         {
            if(param1.completed)
            {
               completePreloading();
            }
            if(progressBar)
            {
               progressBar.maxValue = param1.progressTotal;
               progressBar.value = param1.progressCurrent;
               if(param1.completed)
               {
                  progressBar.graphics.removeFromParent(true);
                  progressBar = null;
               }
            }
         }
         else
         {
            param1.signal_onProgress.remove(handler_checkProgress);
         }
      }
   }
}
