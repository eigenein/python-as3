package game.mechanics.expedition.popup
{
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.IntPropertyWriteable;
   import game.mechanics.expedition.mediator.ExpeditionTeamGatherPopupMediator;
   import game.mechanics.expedition.model.PlayerExpeditionEntry;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.team.TeamGatherPopupHeroValueObject;
   
   public class ExpeditionTeamGatherHeroValueObject extends TeamGatherPopupHeroValueObject
   {
      
      public static const HIGHLIGHT_NONE:int = 0;
      
      public static const HIGHLIGHT_NOT_FIT:int = 1;
      
      public static const HIGHLIGHT_CAN_FIT:int = 2;
      
      public static const HIGHLIGHT_FIT:int = 3;
       
      
      private var _mediator:ExpeditionTeamGatherPopupMediator;
      
      private var _highLightValue:IntPropertyWriteable;
      
      private var _currentHeroExpedition:PlayerExpeditionEntry;
      
      public function ExpeditionTeamGatherHeroValueObject(param1:ExpeditionTeamGatherPopupMediator, param2:UnitEntryValueObject)
      {
         var _loc3_:* = null;
         _highLightValue = new IntPropertyWriteable(1);
         super(param1,param2);
         this._mediator = param1;
         param1.currentTeamPower.onValue(handler_currentTeamPower);
         if(param2)
         {
            _loc3_ = param1.getHeroLockingExpedition(param2.id);
            if(!_loc3_.isNull && _loc3_.isInProgress)
            {
               _currentHeroExpedition = _loc3_;
               _loc3_.heroesAreLocked.signal_update.add(handler_expeditionHeroesAreLocked);
            }
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _mediator.currentTeamPower.unsubscribe(handler_currentTeamPower);
         if(_currentHeroExpedition)
         {
            _currentHeroExpedition.heroesAreLocked.unsubscribe(handler_expeditionHeroesAreLocked);
            _currentHeroExpedition = null;
         }
      }
      
      public function get isBusy() : Boolean
      {
         if(unitEntryVo == null)
         {
            return false;
         }
         return !_mediator.getHeroLockingExpedition(unitEntryVo.id).isNull;
      }
      
      public function get timeLeft() : String
      {
         if(unitEntryVo == null)
         {
            return "";
         }
         var _loc1_:PlayerExpeditionEntry = _mediator.getHeroLockingExpedition(unitEntryVo.id);
         if(!_loc1_.isNull)
         {
            return _loc1_.endTime.toDaysOrHoursOrMinutes;
         }
         return "";
      }
      
      public function get isWaitingForRewardToCollect() : Boolean
      {
         if(unitEntryVo == null)
         {
            return true;
         }
         var _loc1_:PlayerExpeditionEntry = _mediator.getHeroLockingExpedition(unitEntryVo.id);
         if(!_loc1_.isNull)
         {
            return _loc1_.isReadyToFarm;
         }
         return false;
      }
      
      public function get highLightValue() : IntProperty
      {
         return _highLightValue;
      }
      
      public function forceUpdatePowerEstimation() : void
      {
         handler_currentTeamPower(_mediator.currentTeamPower.value);
      }
      
      private function handler_currentTeamPower(param1:int) : void
      {
         var _loc3_:Boolean = false;
         var _loc2_:Number = NaN;
         var _loc4_:int = 0;
         if(unitEntryVo == null || unitEntryVo.empty || !isAvailable || selected)
         {
            _loc3_ = false;
            _highLightValue.value = 0;
         }
         else if(_mediator.heroesSelected == _mediator.minTeamSize)
         {
            _highLightValue.value = 1;
         }
         else
         {
            _loc4_ = _mediator.minTeamSize - _mediator.heroesSelected - 1;
            if(param1 + unitEntryVo.getPower() + _mediator.getTopPowerExcludes(unitEntryVo.id,_loc4_) >= _mediator.powerRequirement)
            {
               _highLightValue.value = 3;
            }
            else
            {
               _highLightValue.value = 1;
            }
         }
      }
      
      private function handler_expeditionHeroesAreLocked(param1:Boolean) : void
      {
         if(_currentHeroExpedition == null || _mediator == null)
         {
            return;
         }
         _currentHeroExpedition.heroesAreLocked.unsubscribe(handler_expeditionHeroesAreLocked);
         _currentHeroExpedition = null;
         setUnavailable(_mediator.isHeroUnavailable(this));
         forceUpdatePowerEstimation();
      }
   }
}
