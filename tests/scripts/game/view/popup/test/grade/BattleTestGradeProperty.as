package game.view.popup.test.grade
{
   import engine.core.utils.property.IntPropertyWriteable;
   
   public class BattleTestGradeProperty extends IntPropertyWriteable
   {
       
      
      private var _name:String;
      
      private var _minValue:int;
      
      private var _maxValue:int;
      
      private var _step:int;
      
      private var _toStringMethod:Function;
      
      public function BattleTestGradeProperty(param1:String, param2:int, param3:int, param4:int, param5:Function, param6:int = 1)
      {
         super();
         this._name = param1;
         this._minValue = param2;
         this._maxValue = param3;
         this._step = param4;
         this._toStringMethod = param5;
         _value = param6;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get minValue() : int
      {
         return _minValue;
      }
      
      public function get maxValue() : int
      {
         return _maxValue;
      }
      
      public function get step() : int
      {
         return _step;
      }
      
      public function toString() : String
      {
         return _toStringMethod(_value);
      }
   }
}
