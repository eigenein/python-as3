package game.mediator.gui.popup.battle
{
   import engine.core.assets.AssetProgressProvider;
   import game.mediator.gui.popup.PopupMediator;
   import game.view.popup.PopupBase;
   import game.view.popup.battle.BattlePreloaderPopup;
   
   public class BattlePreloaderPopupMediator extends PopupMediator
   {
       
      
      private var _progress:AssetProgressProvider;
      
      public function BattlePreloaderPopupMediator(param1:AssetProgressProvider)
      {
         super(null);
         this._progress = param1;
      }
      
      override protected function dispose() : void
      {
         super.dispose();
         _progress.dispose();
      }
      
      public function get progress() : AssetProgressProvider
      {
         return _progress;
      }
      
      override public function createPopup() : PopupBase
      {
         this._popup = new BattlePreloaderPopup(this);
         return _popup;
      }
   }
}
