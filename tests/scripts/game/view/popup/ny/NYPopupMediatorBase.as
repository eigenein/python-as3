package game.view.popup.ny
{
   import com.progrestar.common.lang.Translate;
   import game.command.timer.GameTimer;
   import game.mediator.gui.popup.clan.ClanPopupMediatorBase;
   import game.model.user.Player;
   import game.model.user.specialoffer.PlayerSpecialOfferWithTimer;
   import game.util.TimeFormatter;
   import idv.cjcat.signals.Signal;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class NYPopupMediatorBase extends ClanPopupMediatorBase
   {
       
      
      protected var offer:PlayerSpecialOfferWithTimer;
      
      public var signal_timerUpdate:Signal;
      
      public function NYPopupMediatorBase(param1:Player)
      {
         signal_timerUpdate = new Signal(String);
         super(param1);
         offer = param1.specialOffer.getSpecialOffer("newYear2018") as PlayerSpecialOfferWithTimer;
         GameTimer.instance.oneSecTimer.add(updateTime);
      }
      
      override protected function dispose() : void
      {
         GameTimer.instance.oneSecTimer.remove(updateTime);
         super.dispose();
      }
      
      public function get timerText() : String
      {
         var _loc3_:Number = NaN;
         var _loc2_:* = null;
         var _loc1_:String = "";
         if(offer)
         {
            _loc3_ = offer.endTime - GameTimer.instance.currentServerTime;
            _loc2_ = "";
            if(_loc3_ > 86400)
            {
               _loc2_ = TimeFormatter.toDH(_loc3_,"{d} {h} {m}"," ",true);
            }
            else
            {
               _loc2_ = TimeFormatter.toDH(_loc3_,"{h}:{m}:{s}"," ",true);
            }
            _loc1_ = Translate.translateArgs("UI_DIALOG_NY_WELCOME_TIMEOUT",ColorUtils.hexToRGBFormat(16645626) + _loc2_);
         }
         return _loc1_;
      }
      
      protected function updateTime() : void
      {
         if(_popup)
         {
            if(offer && offer.endTime > GameTimer.instance.currentServerTime)
            {
               signal_timerUpdate.dispatch(timerText);
            }
            else
            {
               close();
            }
         }
      }
   }
}
