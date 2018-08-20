package game.view.gui.homescreen
{
   import game.command.timer.GameTimer;
   import game.model.GameModel;
   import game.model.user.shop.SpecialShopModel;
   import game.model.user.specialoffer.PlayerSpecialOfferEvent;
   import game.util.TimeFormatter;
   import idv.cjcat.signals.ISignal;
   import idv.cjcat.signals.Signal;
   
   public class NewYearSpecialOfferController
   {
       
      
      private var _btn:HomeScreenVagonButton;
      
      private var _model:SpecialShopModel;
      
      private var newYearSpecialOffer:PlayerSpecialOfferEvent;
      
      private var _clickSignal:Signal;
      
      public function NewYearSpecialOfferController(param1:HomeScreenVagonButton)
      {
         _clickSignal = new Signal();
         super();
         _btn = param1;
         _model = GameModel.instance.player.specialShop.model;
         onUpdate();
         _model.signal_update.add(onUpdate);
         _btn.signal_click.add(onButtonClick);
      }
      
      private function onButtonClick() : void
      {
         _clickSignal.dispatch();
      }
      
      private function onUpdate() : void
      {
         var _loc1_:Boolean = GameModel.instance.player.specialOffer.hasSpecialOffer("newYear2016Tree");
         _btn.graphics.visible = _loc1_;
         if(_loc1_)
         {
            newYearSpecialOffer = GameModel.instance.player.specialOffer.getSpecialOffer("newYear2016Tree") as PlayerSpecialOfferEvent;
            GameTimer.instance.oneSecTimer.add(handler_onGameTimer);
            handler_onGameTimer();
         }
      }
      
      private function handler_onGameTimer() : void
      {
         var _loc1_:Number = NaN;
         if(newYearSpecialOffer)
         {
            _loc1_ = newYearSpecialOffer.endTime - GameTimer.instance.currentServerTime;
            if(_loc1_ >= 0)
            {
               if(_loc1_ > 86400)
               {
                  _btn.label = TimeFormatter.toDH(_loc1_,"{d} {h} {m}"," ",true);
               }
               else
               {
                  _btn.label = TimeFormatter.toDH(_loc1_,"{h}:{m}:{s}"," ",true);
               }
               _btn.guiClipLabel.graphics.visible = true;
               _btn.labelBackground.graphics.visible = true;
            }
            else if(newYearSpecialOffer.currentPhase == 2)
            {
               _btn.graphics.visible = false;
            }
            else
            {
               _btn.guiClipLabel.graphics.visible = false;
               _btn.labelBackground.graphics.visible = false;
            }
         }
      }
      
      public function get clickSignal() : ISignal
      {
         return _clickSignal;
      }
   }
}
