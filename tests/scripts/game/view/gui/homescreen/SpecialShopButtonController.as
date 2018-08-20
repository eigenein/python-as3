package game.view.gui.homescreen
{
   import game.command.timer.GameTimer;
   import game.model.GameModel;
   import game.model.user.shop.SpecialShopMerchant;
   import game.model.user.shop.SpecialShopModel;
   import game.util.TimeFormatter;
   import idv.cjcat.signals.ISignal;
   import idv.cjcat.signals.Signal;
   
   public class SpecialShopButtonController
   {
       
      
      private var _btn:HomeScreenVagonButton;
      
      private var _model:SpecialShopModel;
      
      private var _merchant:SpecialShopMerchant;
      
      private var _clickSignal:Signal;
      
      public function SpecialShopButtonController(param1:HomeScreenVagonButton)
      {
         _clickSignal = new Signal(SpecialShopMerchant);
         super();
         _btn = param1;
         _model = GameModel.instance.player.specialShop.model;
         onUpdate();
         _model.signal_update.add(onUpdate);
         _btn.signal_click.add(onButtonClick);
      }
      
      private function onButtonClick() : void
      {
         _clickSignal.dispatch(_merchant);
      }
      
      private function onUpdate() : void
      {
         if(_merchant == null || !_merchant.canBuy())
         {
            _merchant = _model.getAvailableMerchant();
            if(_merchant != null)
            {
               GameTimer.instance.oneSecTimer.add(handler_onGameTimer);
               handler_onGameTimer();
               _btn.graphics.visible = true;
            }
         }
      }
      
      private function handler_onGameTimer() : void
      {
         _btn.label = TimeFormatter.toMS2(_merchant.timeLeft).toString();
      }
      
      public function get clickSignal() : ISignal
      {
         return _clickSignal;
      }
   }
}
