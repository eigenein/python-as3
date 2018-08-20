package game.view.popup.test
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.ClipSprite;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.view.gui.components.toggle.ClipToggleButton;
   import game.view.popup.AsyncClipBasedPopup;
   
   public class BattleTestVerificationPopup extends AsyncClipBasedPopup
   {
       
      
      private var mediator:BattleTestVerificationPopupMediator;
      
      private var clip:BattleTestVerificationPopupClip;
      
      public function BattleTestVerificationPopup(param1:BattleTestVerificationPopupMediator)
      {
         super(param1,AssetStorage.rsx.dialog_test_battle);
         this.mediator = param1;
         param1.onStartButtonToggled.add(onStartButtonToggled);
         param1.onCountUpdated.add(onCountUpdated);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         mediator.onStartButtonToggled.remove(onStartButtonToggled);
         mediator.onCountUpdated.remove(onCountUpdated);
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         clip = param1.create(BattleTestVerificationPopupClip,"dialog_test_verification");
         addChild(clip.graphics);
         clip.tf_header.text = "Верификация";
         clip.button_toggle.signal_updateSelectedState.add(handler_toggled);
         clip.button_toggle.label.text = startButtonName;
         clip.button_close.signal_click.add(mediator.close);
         clip.marker_girl.container.addChild(AssetStorage.rsx.asset_bundle.create(ClipSprite,"vendor_girl").graphics);
         onCountUpdated();
      }
      
      private function get startButtonName() : String
      {
         return Translate.translate(!!mediator.startButtonEnabled?"Остановить":"Запустить");
      }
      
      protected function onStartButtonToggled() : void
      {
         clip.button_toggle.label.text = startButtonName;
      }
      
      protected function onCountUpdated() : void
      {
         clip.tf_count.text = String(mediator.count);
         var _loc1_:int = mediator.failCount;
         clip.tf_result.text = _loc1_ > 0?"Всё плохо " + _loc1_ + " раз":"Пока всё хорошо";
      }
      
      protected function handler_toggled(param1:ClipToggleButton) : void
      {
         mediator.action_toggle();
      }
   }
}
