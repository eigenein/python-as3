package battle.stats
{
   import flash.Boot;
   
   public class ElementStats
   {
       
      
      public var elementSpiritPower:Number;
      
      public var elementSpiritLevel:int;
      
      public var elementAttack:Number;
      
      public var elementArmor:Number;
      
      public var element:String;
      
      public function ElementStats()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         elementSpiritPower = 0;
         elementSpiritLevel = 0;
         elementArmor = 0;
         elementAttack = 0;
      }
      
      public static function stringIsCounterToString(param1:String, param2:String) : Boolean
      {
         var _loc3_:String = param1;
         if(_loc3_ == "fire")
         {
            return param2 == "earth";
         }
         if(_loc3_ == "water")
         {
            return param2 == "fire";
         }
         if(_loc3_ == "earth")
         {
            return param2 == "water";
         }
         return false;
      }
      
      public function toString() : String
      {
         var _loc4_:* = null as String;
         var _loc5_:* = null;
         var _loc6_:* = null as String;
         var _loc7_:* = 0;
         var _loc8_:int = 0;
         var _loc1_:Array = ["elementAttack","elementArmor","elementSpiritLevel","elementSpiritPower"];
         var _loc2_:String = "";
         var _loc3_:int = 0;
         while(_loc3_ < int(_loc1_.length))
         {
            _loc4_ = _loc1_[_loc3_];
            _loc3_++;
            _loc5_ = Reflect.field(this,_loc4_);
            if(_loc5_ != 0)
            {
               _loc6_ = _loc5_;
               _loc2_ = _loc2_ + ("\n" + _loc4_);
               _loc7_ = _loc4_.length + _loc6_.length;
               while(_loc7_ < 23)
               {
                  _loc7_++;
                  _loc8_ = _loc7_;
                  _loc2_ = _loc2_ + " ";
               }
               _loc2_ = _loc2_ + _loc6_;
            }
         }
         return _loc2_;
      }
      
      public function serialize() : *
      {
         var _loc4_:* = null as String;
         var _loc5_:* = null;
         var _loc1_:* = {};
         var _loc2_:Array = ["elementAttack","elementArmor","elementSpiritLevel","elementSpiritPower"];
         var _loc3_:int = 0;
         while(_loc3_ < int(_loc2_.length))
         {
            _loc4_ = _loc2_[_loc3_];
            _loc3_++;
            _loc5_ = this[_loc4_];
            if(_loc5_ != 0)
            {
               _loc1_[_loc4_] = _loc5_;
            }
         }
         return _loc1_;
      }
      
      public function nullify() : void
      {
         var _loc1_:* = 0;
         elementSpiritPower = _loc1_;
         _loc1_ = Number(_loc1_);
         elementArmor = _loc1_;
         elementAttack = _loc1_;
      }
      
      public function isCounterTo(param1:ElementStats) : Boolean
      {
         var _loc2_:String = element;
         var _loc3_:String = _loc2_;
         if(_loc3_ == "fire")
         {
            return param1.element == "earth";
         }
         if(_loc3_ == "water")
         {
            return param1.element == "fire";
         }
         if(_loc3_ == "earth")
         {
            return param1.element == "water";
         }
         return false;
      }
   }
}
