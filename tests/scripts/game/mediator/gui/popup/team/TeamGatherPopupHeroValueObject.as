package game.mediator.gui.popup.team
{
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import game.command.timer.GameTimer;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.titan.TitanDescription;
   import game.mediator.gui.popup.hero.HeroEntryValueObject;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.model.user.hero.HeroEntry;
   import org.osflash.signals.Signal;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class TeamGatherPopupHeroValueObject
   {
       
      
      private var _unit:UnitEntryValueObject;
      
      private var _property_isAvailable:BooleanPropertyWriteable;
      
      protected var _power:int;
      
      protected var mediator:TeamGatherPopupMediator;
      
      private var _selected:Boolean;
      
      private var _blockingReason:TeamGatherHeroBlockReason = null;
      
      private var _signal_update:Signal;
      
      public function TeamGatherPopupHeroValueObject(param1:TeamGatherPopupMediator, param2:UnitEntryValueObject)
      {
         _property_isAvailable = new BooleanPropertyWriteable();
         super();
         _unit = param2;
         if(_unit && _unit.owned)
         {
            _power = _unit.getPower();
         }
         _signal_update = new Signal(TeamGatherPopupHeroValueObject);
         this.mediator = param1;
      }
      
      public static function sortByBattleOrder(param1:TeamGatherPopupHeroValueObject, param2:TeamGatherPopupHeroValueObject) : int
      {
         return param2.battleOrder - param1.battleOrder;
      }
      
      public function dispose() : void
      {
      }
      
      public function get desc() : UnitDescription
      {
         return !!_unit?_unit.unit:null;
      }
      
      public function get unitEntryVo() : UnitEntryValueObject
      {
         return _unit;
      }
      
      public function set heroEntry(param1:HeroEntry) : void
      {
         if(param1)
         {
            _unit = new HeroEntryValueObject(param1.hero,param1);
         }
         else
         {
            _unit = null;
         }
         _property_isAvailable.value = isAvailable;
      }
      
      public function get power() : int
      {
         return _power;
      }
      
      public function get level() : int
      {
         return !!_unit?_unit.level:0;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(_selected != param1)
         {
            _selected = param1;
            _signal_update.dispatch(this);
         }
      }
      
      public function get battleOrder() : int
      {
         if(_unit && !_unit.empty)
         {
            return _unit.unit.battleOrder;
         }
         return 0;
      }
      
      public function get blockReason() : TeamGatherHeroBlockReason
      {
         return _blockingReason;
      }
      
      public function get isAvailable() : Boolean
      {
         return _unit != null && _blockingReason == null && !_unit.empty;
      }
      
      public function get isEmpty() : Boolean
      {
         return _unit == null || _unit.empty;
      }
      
      public function get isOwned() : Boolean
      {
         return _unit != null && _unit.owned;
      }
      
      public function get property_isAvailable() : BooleanProperty
      {
         return _property_isAvailable;
      }
      
      public function get roleString() : String
      {
         var _loc2_:* = null;
         var _loc3_:* = undefined;
         var _loc1_:* = null;
         if(_unit == null)
         {
            return "";
         }
         if(_unit.unit is HeroDescription)
         {
            _loc2_ = _unit.unit as HeroDescription;
            _loc3_ = _loc2_.role.localizedExtendedRoleList;
         }
         else if(_unit.unit is TitanDescription)
         {
            _loc1_ = _unit.unit as TitanDescription;
            _loc3_ = _loc1_.role.localizedExtendedRoleList;
         }
         if(_loc3_.length > 0)
         {
            return ColorUtils.hexToRGBFormat(16568453) + _loc3_.join(", ");
         }
         return "";
      }
      
      public function get signal_update() : Signal
      {
         return _signal_update;
      }
      
      public function get signal_timer() : Signal
      {
         return GameTimer.instance.oneSecTimer;
      }
      
      public function setUnavailable(param1:TeamGatherHeroBlockReason) : void
      {
         this._blockingReason = param1;
         _property_isAvailable.value = isAvailable;
      }
      
      public function select() : void
      {
         mediator.action_pick(this);
      }
   }
}
