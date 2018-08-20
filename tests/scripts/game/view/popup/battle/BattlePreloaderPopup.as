package game.view.popup.battle
{
   import engine.core.assets.AssetLoader;
   import engine.core.assets.AssetProgressProvider;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.battle.BattlePreloaderPopupMediator;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.IEscClosable;
   
   public class BattlePreloaderPopup extends ClipBasedPopup implements ITutorialNodePresenter, IEscClosable
   {
       
      
      private var assetLoader:AssetLoader;
      
      private var clip:BattlePreloaderPopupClip;
      
      private var mediator:BattlePreloaderPopupMediator;
      
      private var smoothProgress:Number;
      
      public function BattlePreloaderPopup(param1:BattlePreloaderPopupMediator)
      {
         this.mediator = param1;
         this.assetLoader = AssetStorage.instance.globalLoader;
         smoothProgress = 0;
         super(param1);
      }
      
      override public function dispose() : void
      {
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.IN_GAME_PRELOADER;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.battle_interface.create_preloaderPopup();
         addChild(clip.graphics);
         mediator.progress.signal_onProgress.add(updateProgress);
         updateProgress(mediator.progress);
      }
      
      override public function close() : void
      {
      }
      
      private function updateProgress(param1:AssetProgressProvider) : void
      {
         if(param1.completed)
         {
            mediator.close();
            return;
         }
         var _loc2_:Number = param1.progressCurrent / param1.progressTotal;
         smoothProgress = _loc2_ * 0.5 + smoothProgress * 0.5;
         clip.setProgress(smoothProgress);
      }
   }
}
