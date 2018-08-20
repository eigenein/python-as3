package game.mediator.gui.popup.alchemy
{
   public class AlchemyPopupCritWheelValueObject
   {
       
      
      private var _crit:int;
      
      private var _index:int;
      
      public var angle:int;
      
      public function AlchemyPopupCritWheelValueObject(param1:int, param2:int)
      {
         super();
         this._index = param2;
         this._crit = param1;
      }
      
      public function get crit() : int
      {
         return _crit;
      }
      
      public function get index() : int
      {
         return _index;
      }
   }
}
