package game.view.popup.test.stattask
{
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   
   public class BattleStatTaskPopup extends AsyncClipBasedPopupWithPreloader
   {
       
      
      private var clip:BattleStatTaskPopupClip;
      
      private var mediator:BattleStatTaskPopupMediator;
      
      public function BattleStatTaskPopup(param1:BattleStatTaskPopupMediator)
      {
         super(param1,AssetStorage.rsx.dialog_test_battle);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         mediator.progressReport.unsubscribe(handler_progressReport);
         mediator.resultReport.unsubscribe(handler_resultReport);
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         clip = param1.create(BattleStatTaskPopupClip,"dialog_battle_stat_task");
         addChild(clip.graphics);
         clip.button_close.signal_click.add(mediator.close);
         clip.button_result.createNativeClickHandler().add(handler_buttonResult);
         clip.button_result.label = "Скопировать";
         clip.button_start.initialize("Выполнить",handler_start);
         mediator.progressReport.onValue(handler_progressReport);
         mediator.resultReport.onValue(handler_resultReport);
      }
      
      private function handler_buttonResult() : void
      {
         mediator.action_copy();
      }
      
      private function handler_start() : void
      {
         mediator.action_start(clip.input.text);
      }
      
      private function handler_progressReport(param1:String) : void
      {
         clip.tf_output.text = param1;
      }
      
      private function handler_resultReport(param1:String) : void
      {
         clip.tf_result.text = param1;
      }
   }
}
