package game.model.user.specialoffer
{
   import com.progrestar.common.lang.Translate;
   import game.command.timer.GameTimer;
   import game.data.ResourceListData;
   import game.data.reward.RewardData;
   import game.mediator.gui.popup.mission.MissionDropValueObject;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.reward.GuiElementExternalStyle;
   import game.view.popup.reward.RelativeAlignment;
   import game.view.specialoffer.energyspent.SpecialOfferEnergySpentRewardBackground;
   import game.view.specialoffer.energyspent.SpecialOfferEnergySpentView;
   import org.osflash.signals.Signal;
   
   public class PlayerSpecialOfferEnergySpent extends PlayerSpecialOfferWithTimer
   {
      
      public static const OFFER_TYPE:String = "energySpent";
       
      
      private var _reward:RewardData;
      
      private var _current:int;
      
      private var _limit:int;
      
      private var _signal_progressUpdated:Signal;
      
      public function PlayerSpecialOfferEnergySpent(param1:Player, param2:*)
      {
         super(param1,param2);
         if(offerData && offerData.reward)
         {
            _reward = new RewardData(offerData.reward);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(endAlarm)
         {
            GameTimer.instance.removeAlarm(endAlarm);
            endAlarm = null;
         }
      }
      
      public function get reward() : RewardData
      {
         return _reward;
      }
      
      override public function get signal_updated() : Signal
      {
         return !!hasEndTime?GameTimer.instance.oneSecTimer:_signal_progressUpdated;
      }
      
      public function get hasLimit() : Boolean
      {
         return _limit > 0;
      }
      
      public function get progressString() : String
      {
         return _current + "/" + _limit;
      }
      
      public function get localeTitle() : String
      {
         if(clientData && clientData.locale && clientData.locale.title)
         {
            return Translate.translate(clientData.locale.title);
         }
         return Translate.translate("UI_SPECIALOFFER_UNIQUE_EVENT");
      }
      
      public function get localeDesc() : String
      {
         if(clientData && clientData.locale && clientData.locale.desc)
         {
            return Translate.translate(clientData.locale.desc);
         }
         return Translate.translate("UI_SPECIALOFFER_UNIQUE_SOUL_STONES_PER_ENERGY");
      }
      
      public function get localeTimer() : String
      {
         if(clientData && clientData.locale && clientData.locale.timer)
         {
            return Translate.translate(clientData.locale.timer);
         }
         return Translate.translate("UI_SPECIALOFFER_TIME_LEFT");
      }
      
      public function get localeButton() : String
      {
         if(clientData && clientData.locale && clientData.locale.button)
         {
            return Translate.translate(clientData.locale.button);
         }
         return "";
      }
      
      override public function start(param1:PlayerSpecialOfferData) : void
      {
         super.start(param1);
         param1.hooks.missionDrop.add(handler_missionDrop);
      }
      
      override public function stop(param1:PlayerSpecialOfferData) : void
      {
         param1.hooks.missionDrop.remove(handler_missionDrop);
      }
      
      override protected function get daysLeftString() : String
      {
         var _loc2_:int = 0;
         _loc2_ = 86400;
         var _loc1_:int = _endTime - GameTimer.instance.currentServerTime;
         return Translate.translateArgs("UI_DIALOG_BILLING_SUBSCRIPTION_DAYS",Math.ceil(_loc1_ / 86400));
      }
      
      override protected function update(param1:*) : void
      {
         super.update(param1);
         if(param1.extraData)
         {
            if(param1.extraData.current)
            {
               _current = getItemAmount(param1.extraData.current);
            }
            if(param1.extraData.limit)
            {
               _limit = getItemAmount(param1.extraData.limit);
            }
         }
         if(!hasEndTime)
         {
            if(!_signal_progressUpdated)
            {
               _signal_progressUpdated = new Signal();
            }
            else
            {
               _signal_progressUpdated.dispatch();
            }
         }
      }
      
      protected function getItemAmount(param1:*) : int
      {
         var _loc4_:ResourceListData = new ResourceListData(param1);
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = _loc4_.outputDisplay;
         for each(var _loc3_ in _loc4_.outputDisplay)
         {
            _loc2_ = _loc2_ + _loc3_.amount;
         }
         return _loc2_;
      }
      
      protected function overlayFactory() : GuiElementExternalStyle
      {
         var _loc3_:GuiElementExternalStyle = new GuiElementExternalStyle();
         var _loc1_:SpecialOfferEnergySpentView = new SpecialOfferEnergySpentView(this);
         _loc3_.signal_dispose.add(_loc1_.dispose);
         _loc3_.setOverlay(_loc1_.graphics,new RelativeAlignment());
         var _loc2_:SpecialOfferEnergySpentRewardBackground = new SpecialOfferEnergySpentRewardBackground();
         _loc3_.setBackground(_loc2_.graphics,new RelativeAlignment());
         return _loc3_;
      }
      
      protected function handler_missionDrop(param1:Vector.<MissionDropValueObject>) : void
      {
         var _loc2_:MissionDropValueObject = new MissionDropValueObject(reward.outputDisplay[0],"offer_endMission",0,100000000);
         _loc2_.externalStyleFactory = overlayFactory;
         param1.push(_loc2_);
      }
   }
}
