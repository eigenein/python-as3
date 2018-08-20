package engine.core.utils
{
   public class VectorUtil
   {
      
      private static const canRemoveAt:Boolean = checkRemoveAtCompatibility();
       
      
      public function VectorUtil()
      {
         super();
      }
      
      private static function checkRemoveAtCompatibility() : Boolean
      {
         try
         {
            new <int>[0]["removeAt"](0);
            var _loc2_:Boolean = true;
            return _loc2_;
         }
         catch(e:*)
         {
            trace("Метод Vector.removeAt недоступен на данной версии flashPlayer");
            var _loc3_:Boolean = false;
            return _loc3_;
         }
         return false;
      }
      
      public static function remove(param1:*, param2:*) : Boolean
      {
         var _loc6_:int = 0;
         var _loc5_:* = 0;
         var _loc3_:Vector.<*> = param1;
         var _loc4_:int = _loc3_.indexOf(param2);
         if(_loc4_ != -1)
         {
            if(canRemoveAt)
            {
               param1.removeAt(_loc4_);
            }
            else
            {
               _loc6_ = _loc3_.length - 1;
               _loc5_ = _loc4_;
               while(_loc5_ < _loc6_)
               {
                  _loc3_[_loc5_] = _loc3_[_loc5_ + 1];
                  _loc5_++;
               }
               _loc3_.length = _loc6_;
            }
            return true;
         }
         return false;
      }
      
      public static function removeAt(param1:*, param2:int) : *
      {
         var _loc5_:int = 0;
         var _loc4_:* = 0;
         var _loc3_:Vector.<*> = param1;
         if(canRemoveAt)
         {
            return param1.removeAt(param2);
         }
         _loc5_ = _loc3_.length - 1;
         _loc4_ = param2;
         while(_loc4_ < _loc5_)
         {
            _loc3_[_loc4_] = _loc3_[_loc4_ + 1];
            _loc4_++;
         }
         _loc3_.length = _loc5_;
         return _loc3_;
      }
      
      public static function insertAt(param1:*, param2:int, param3:*) : void
      {
         var _loc5_:int = 0;
         var _loc4_:Vector.<*> = param1;
         if(canRemoveAt)
         {
            param1.insertAt(param2,param3);
         }
         else
         {
            _loc5_ = _loc4_.length;
            while(_loc5_ > param2)
            {
               _loc4_[_loc5_] = _loc4_[_loc5_ - 1];
               _loc5_--;
            }
            _loc4_[param2] = param3;
         }
      }
      
      public static function sortString(param1:String, param2:String) : int
      {
         return param1 == param2?0:Number(param1 > param2?1:-1);
      }
      
      public static function sortInt(param1:int, param2:int) : int
      {
         return param1 - param2;
      }
      
      public static function sortNumber(param1:Number, param2:Number) : int
      {
         return param1 == param2?0:Number(param1 > param2?1:-1);
      }
   }
}
