package game.mediator.gui.popup.hero
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.DataStorage;
   
   public class BattleStatValueObject
   {
       
      
      private var _isInteger:Boolean;
      
      private var _isPercentage:Boolean;
      
      private var _statValue:Number;
      
      private var _priority:int;
      
      private var _ident:String;
      
      private var _value:String;
      
      public function BattleStatValueObject(param1:String, param2:Number, param3:Boolean, param4:Boolean = false)
      {
         super();
         this._isInteger = param3;
         this._isPercentage = param4;
         this._statValue = param2;
         this._ident = param1;
         var _loc5_:Object = DataStorage.rule.battleStatDataPriority;
         if(_loc5_)
         {
            _priority = _loc5_[param1];
         }
         _value = !!param3?int(param2).toString():param2.toFixed(1);
      }
      
      public function get isPercentage() : Boolean
      {
         return _isPercentage;
      }
      
      public function get isInteger() : Boolean
      {
         return _isInteger;
      }
      
      public function get statValue() : Number
      {
         return _statValue;
      }
      
      public function get priority() : int
      {
         return _priority;
      }
      
      public function get descriptionLocaleKey() : String
      {
         return "LIB_BATTLESTATDATA_DESC_" + _ident.toUpperCase();
      }
      
      public function get name() : String
      {
         return Translate.translate("LIB_BATTLESTATDATA_" + _ident.toUpperCase());
      }
      
      public function get value() : String
      {
         return !!isPercentage?_value + "%":_value;
      }
      
      public function get ident() : String
      {
         return _ident;
      }
      
      public function rewrite(param1:BattleStatValueObject) : void
      {
         if(statValue != param1.statValue)
         {
            _statValue = param1.statValue;
            _value = !!_isInteger?int(statValue).toString():statValue.toFixed(1);
         }
      }
      
      public function subtract(param1:BattleStatValueObject) : void
      {
         _statValue = _statValue - param1.statValue;
         _value = !!_isInteger?int(statValue).toString():statValue.toFixed(1);
      }
      
      public function equals(param1:BattleStatValueObject) : Boolean
      {
         return statValue == param1.statValue && ident == param1.ident;
      }
      
      public function diff(param1:BattleStatValueObject) : BattleStatValueObject
      {
         var _loc2_:Number = statValue - param1.statValue;
         if(_isInteger)
         {
            _statValue = int(statValue);
         }
         else
         {
            _statValue = Math.round(statValue * 10) / 10;
         }
         return new BattleStatValueObject(_ident,_loc2_,_isInteger,isPercentage);
      }
      
      public function clone() : BattleStatValueObject
      {
         return new BattleStatValueObject(_ident,statValue,_isInteger,isPercentage);
      }
   }
}
