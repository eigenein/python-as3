package game.model.user.specialoffer
{
   import game.mediator.gui.popup.mission.MissionDropValueObject;
   import game.model.user.Player;
   import game.view.popup.reward.GuiElementExternalStyle;
   import game.view.popup.reward.RelativeAlignment;
   import game.view.specialoffer.energyspent.SpecialOfferEnergySpentEventDropView;
   import game.view.specialoffer.energyspent.SpecialOfferEnergySpentRewardBackground;
   
   public class PlayerSpecialOfferEnergySpentEventDrop extends PlayerSpecialOfferEnergySpent
   {
       
      
      public function PlayerSpecialOfferEnergySpentEventDrop(param1:Player, param2:*)
      {
         super(param1,param2);
      }
      
      override protected function overlayFactory() : GuiElementExternalStyle
      {
         var _loc3_:GuiElementExternalStyle = new GuiElementExternalStyle();
         var _loc1_:SpecialOfferEnergySpentEventDropView = new SpecialOfferEnergySpentEventDropView(this);
         _loc3_.signal_dispose.add(_loc1_.dispose);
         _loc3_.setOverlay(_loc1_.graphics,new RelativeAlignment());
         var _loc2_:SpecialOfferEnergySpentRewardBackground = new SpecialOfferEnergySpentRewardBackground();
         _loc3_.setBackground(_loc2_.graphics,new RelativeAlignment());
         return _loc3_;
      }
      
      override protected function handler_missionDrop(param1:Vector.<MissionDropValueObject>) : void
      {
         var _loc3_:MissionDropValueObject = new MissionDropValueObject(reward.outputDisplay[0],"offer_endMission",0,100000000);
         var _loc2_:PlayerSpecialOfferData = player.specialOffer;
         var _loc4_:Boolean = _loc2_.hasSpecialOffer("energySpent") || _loc2_.hasSpecialOffer("energySpentWithoutTimer");
         if(!_loc4_)
         {
            _loc3_.externalStyleFactory = overlayFactory;
         }
         param1.push(_loc3_);
      }
   }
}
