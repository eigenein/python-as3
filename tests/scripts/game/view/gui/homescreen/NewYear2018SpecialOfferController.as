package game.view.gui.homescreen
{
   import game.command.timer.GameTimer;
   import game.data.storage.DataStorage;
   import game.model.GameModel;
   import game.model.user.ny.NewYearData;
   import game.model.user.specialoffer.PlayerSpecialOfferWithTimer;
   import game.util.TimeFormatter;
   import idv.cjcat.signals.ISignal;
   import idv.cjcat.signals.Signal;
   
   public class NewYear2018SpecialOfferController
   {
       
      
      private var _btn:HomeScreenNYVagonButton;
      
      private var newYearSpecialOffer:PlayerSpecialOfferWithTimer;
      
      private var newYearGiftsSpecialOffer:PlayerSpecialOfferWithTimer;
      
      private var model:NewYearData;
      
      private var _clickSignal:Signal;
      
      public function NewYear2018SpecialOfferController(param1:HomeScreenNYVagonButton)
      {
         _clickSignal = new Signal();
         super();
         _btn = param1;
         _btn.guiClipLabel.graphics.visible = false;
         _btn.labelBackground.graphics.visible = false;
         _btn.signal_click.add(onButtonClick);
         model = GameModel.instance.player.ny;
         model.signal_treeExpChange.add(handler_treeExpChange);
         model.signal_giftsToOpenChange.add(handler_giftsToOpenChange);
         onUpdate();
         handler_treeExpChange();
         handler_giftsToOpenChange();
      }
      
      private function onButtonClick() : void
      {
         _clickSignal.dispatch();
      }
      
      private function onUpdate() : void
      {
         if(GameModel.instance.player.specialOffer.hasSpecialOffer("newYear2018"))
         {
            newYearSpecialOffer = GameModel.instance.player.specialOffer.getSpecialOffer("newYear2018") as PlayerSpecialOfferWithTimer;
         }
         else
         {
            newYearSpecialOffer = null;
         }
         if(GameModel.instance.player.specialOffer.hasSpecialOffer("newYear2018gifts"))
         {
            newYearGiftsSpecialOffer = GameModel.instance.player.specialOffer.getSpecialOffer("newYear2018gifts") as PlayerSpecialOfferWithTimer;
         }
         else
         {
            newYearGiftsSpecialOffer = null;
         }
         _btn.graphics.visible = newYearSpecialOffer != null || newYearGiftsSpecialOffer != null;
         if(newYearSpecialOffer || newYearGiftsSpecialOffer)
         {
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
            if(_loc1_ > 0)
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
            else
            {
               _btn.guiClipLabel.graphics.visible = false;
               _btn.labelBackground.graphics.visible = false;
               onUpdate();
            }
         }
         else if(newYearGiftsSpecialOffer)
         {
            if(newYearGiftsSpecialOffer.endTime - GameTimer.instance.currentServerTime <= 0)
            {
               onUpdate();
            }
         }
      }
      
      public function get clickSignal() : ISignal
      {
         return _clickSignal;
      }
      
      private function handler_treeExpChange() : void
      {
         if(model)
         {
            _btn.setNYTreeLevel(DataStorage.rule.ny2018TreeRule.getAssetLevelByLevel(model.treeLevel));
         }
      }
      
      private function handler_giftsToOpenChange() : void
      {
         _btn.red_dot.graphics.visible = model.giftsToOpen > 0;
      }
   }
}
