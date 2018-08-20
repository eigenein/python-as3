package game.model.user.specialoffer
{
   import game.data.storage.DataStorage;
   import game.data.storage.rewardmodifier.RewardModifierDescription;
   import game.mediator.gui.popup.mission.MissionDropValueObject;
   import game.model.user.Player;
   import game.view.popup.reward.GuiElementExternalStyle;
   import game.view.popup.reward.RelativeAlignment;
   import game.view.specialoffer.rewardmodifier.SpecialOfferRewardModifierMissionHeroView;
   
   public class PlayerSpecialOfferRewardModifier extends PlayerSpecialOfferEntry
   {
      
      public static const OFFER_TYPE:String = "rewardModifier";
       
      
      private var rewardModifiers:Vector.<RewardModifierDescription>;
      
      public function PlayerSpecialOfferRewardModifier(param1:Player, param2:*)
      {
         rewardModifiers = new Vector.<RewardModifierDescription>();
         super(param1,param2);
         if(offerData && offerData.rewardModifiers)
         {
            var _loc5_:int = 0;
            var _loc4_:* = offerData.rewardModifiers;
            for each(var _loc3_ in offerData.rewardModifiers)
            {
               rewardModifiers.push(DataStorage.rewardModifier.getRewardModifierById(_loc3_));
            }
         }
      }
      
      public function get maxMultiplier() : Number
      {
         var _loc1_:* = 0;
         var _loc4_:int = 0;
         var _loc3_:* = rewardModifiers;
         for each(var _loc2_ in rewardModifiers)
         {
            if(_loc2_.multiplier > _loc1_)
            {
               _loc1_ = Number(_loc2_.multiplier);
            }
         }
         return _loc1_;
      }
      
      override public function start(param1:PlayerSpecialOfferData) : void
      {
         param1.hooks.missionDrop.add(handler_missionDrop);
      }
      
      override public function stop(param1:PlayerSpecialOfferData) : void
      {
         param1.hooks.missionDrop.remove(handler_missionDrop);
      }
      
      protected function applyMissionDropRewardModifier(param1:Vector.<MissionDropValueObject>, param2:RewardModifierDescription) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc3_ in param1)
         {
            if(_loc3_.dropType == "endMission" && param2.affectsItem(_loc3_.item))
            {
               _loc3_.externalStyleFactory = overlayFactory;
            }
         }
      }
      
      protected function overlayFactory() : GuiElementExternalStyle
      {
         var _loc1_:SpecialOfferRewardModifierMissionHeroView = new SpecialOfferRewardModifierMissionHeroView(this);
         var _loc2_:GuiElementExternalStyle = new GuiElementExternalStyle();
         _loc2_.signal_dispose.add(_loc1_.dispose);
         _loc2_.setOverlay(_loc1_.graphics,new RelativeAlignment());
         return _loc2_;
      }
      
      private function handler_missionDrop(param1:Vector.<MissionDropValueObject>) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = rewardModifiers;
         for each(var _loc2_ in rewardModifiers)
         {
            if(_loc2_.isOnMissionEnd || _loc2_.isOnRaidMission)
            {
               applyMissionDropRewardModifier(param1,_loc2_);
            }
         }
      }
   }
}
