package game.mechanics.expedition.mediator
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.property.BooleanGroupProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import game.data.storage.hero.UnitDescription;
   import game.mechanics.expedition.model.PlayerExpeditionEntry;
   import game.mechanics.expedition.popup.ExpeditionTeamGatherHeroValueObject;
   import game.mechanics.expedition.popup.ExpeditionTeamGatherPopup;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.team.TeamGatherHeroBlockReason;
   import game.mediator.gui.popup.team.TeamGatherPopupHeroValueObject;
   import game.mediator.gui.popup.team.TeamGatherPopupMediator;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.view.popup.PopupBase;
   
   public class ExpeditionTeamGatherPopupMediator extends TeamGatherPopupMediator
   {
       
      
      private var _expedition:ExpeditionValueObject;
      
      private var _enoughPower:BooleanPropertyWriteable;
      
      private var _enoughTeamSize:BooleanPropertyWriteable;
      
      public const enoughPowerAndTeamSize:BooleanGroupProperty = new BooleanGroupProperty(_enoughPower,_enoughTeamSize);
      
      public function ExpeditionTeamGatherPopupMediator(param1:Player, param2:ExpeditionValueObject)
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function get expedition() : ExpeditionValueObject
      {
         return _expedition;
      }
      
      public function get minTeamSize() : int
      {
         return player.expedition.minTeamSizeToStartExpedition;
      }
      
      public function get powerRequirement() : int
      {
         return _expedition.power;
      }
      
      override public function get startButtonLabel() : String
      {
         return Translate.translate("UI_DIALOG_MISSION_START_GO");
      }
      
      override public function get text_dialogCaption() : String
      {
         if(Translate.has("UI_TOWER_TEAM_GATHER_TITLE_EXPEDITION"))
         {
            return Translate.translate("UI_TOWER_TEAM_GATHER_TITLE_EXPEDITION");
         }
         return Translate.translate("UI_TOWER_TEAM_GATHER_TITLE");
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ExpeditionTeamGatherPopup(this);
         return new ExpeditionTeamGatherPopup(this);
      }
      
      public function getHeroLockingExpedition(param1:int) : PlayerExpeditionEntry
      {
         return player.expedition.getExpeditionByHero(param1);
      }
      
      public function getTopPowerUnitExcludes(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc4_:int = _heroList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc3_ = _heroList[_loc2_];
            if(!_loc3_.isEmpty && _loc3_.isAvailable && !_loc3_.selected && _loc3_.unitEntryVo.id != param1)
            {
               return _loc3_.power;
            }
            _loc2_++;
         }
         return 0;
      }
      
      public function getTopPowerExcludes(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         if(_heroList == null)
         {
            return 0;
         }
         var _loc6_:int = _heroList.length;
         var _loc5_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc6_ && param2 > 0)
         {
            _loc4_ = _heroList[_loc3_];
            if(!_loc4_.isEmpty && _loc4_.isAvailable && !_loc4_.selected && _loc4_.unitEntryVo.id != param1)
            {
               param2--;
               _loc5_ = _loc5_ + _loc4_.power;
            }
            _loc3_++;
         }
         return _loc5_;
      }
      
      public function action_auto() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      override protected function updateCurrentTeamState() : void
      {
         var _loc1_:int = getCurrentTeamPower();
         _currentTeamPower.value = _loc1_;
         adjustTeamLength();
         _enoughPower.value = _loc1_ >= powerRequirement;
         _enoughTeamSize.value = heroesSelected >= minTeamSize;
         _canComplete.value = _enoughPower.value && _enoughTeamSize.value;
      }
      
      override protected function createHeroValueObject(param1:UnitDescription) : TeamGatherPopupHeroValueObject
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:PlayerHeroEntry = player.heroes.getById(param1.id);
         if(_loc4_)
         {
            _loc2_ = new ExpeditionTeamGatherHeroValueObject(this,UnitEntryValueObject.create(param1,_loc4_));
            _loc3_ = isHeroUnavailable(_loc2_);
            if(_loc3_)
            {
               _loc2_.setUnavailable(_loc3_);
            }
            return _loc2_;
         }
         return null;
      }
      
      override protected function createEmptyHeroValueObject() : TeamGatherPopupHeroValueObject
      {
         return new ExpeditionTeamGatherHeroValueObject(this,null);
      }
      
      override public function isHeroUnavailable(param1:TeamGatherPopupHeroValueObject) : TeamGatherHeroBlockReason
      {
         var _loc2_:PlayerExpeditionEntry = player.expedition.getExpeditionByHero(param1.desc.id);
         if(!_loc2_.isNull)
         {
            return new TeamGatherHeroBlockReason("Этот герой уже в экспедиции.\nДо окончания осталось " + _loc2_.endTime.toDaysOrHoursAndMinutes);
         }
         return null;
      }
      
      private function _sortByPower(param1:ExpeditionTeamGatherHeroValueObject, param2:ExpeditionTeamGatherHeroValueObject) : int
      {
         return param2.power - param1.power;
      }
   }
}
