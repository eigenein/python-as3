package game.model.user.tower
{
   public class PlayerTowerBuffEffect
   {
       
      
      private var _value:int;
      
      private var _type:String;
      
      public function PlayerTowerBuffEffect()
      {
         super();
      }
      
      public static function sort_goldFirst(param1:PlayerTowerBuffEffect, param2:PlayerTowerBuffEffect) : int
      {
         if(param1._type == "percentBuff_goldBonus")
         {
            return -1;
         }
         if(param2._type == "percentBuff_goldBonus")
         {
            return 1;
         }
         return 0;
      }
      
      public function get value() : int
      {
         return _value;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function setup(param1:String, param2:int) : void
      {
         this._type = param1;
         this._value = param2;
      }
   }
}
