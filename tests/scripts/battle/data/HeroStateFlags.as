package battle.data
{
   import flash.Boot;
   import haxe.ds.StringMap;
   import haxe.ds._StringMap.StringMapKeysIterator;
   
   public class HeroStateFlags
   {
       
      
      public var data:StringMap;
      
      public function HeroStateFlags()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         data = new StringMap();
      }
      
      public function equalRaw(param1:*) : Boolean
      {
         var _loc3_:* = null as StringMap;
         var _loc4_:* = null;
         var _loc5_:* = null as String;
         var _loc6_:* = null;
         var _loc2_:int = 0;
         if(param1 != null)
         {
            _loc2_ = _loc2_ + param1.length;
         }
         if(data != null)
         {
            _loc3_ = data;
            _loc4_ = new StringMapKeysIterator(_loc3_.h,_loc3_.rh);
            while(_loc4_.hasNext())
            {
               _loc5_ = _loc4_.next();
               if(_loc2_ == 0)
               {
                  return false;
               }
               if(!Reflect.hasField(param1,_loc5_))
               {
                  return false;
               }
               _loc3_ = data;
               if(_loc5_ in StringMap.reserved)
               {
                  _loc6_ = _loc3_.getReserved(_loc5_);
               }
               else
               {
                  _loc6_ = _loc3_.h[_loc5_];
               }
               if(param1[_loc5_] != _loc6_)
               {
                  return false;
               }
               _loc2_--;
            }
         }
         return _loc2_ == 0;
      }
      
      public function equal(param1:HeroStateFlags) : Boolean
      {
         var _loc3_:* = null as StringMap;
         var _loc5_:* = null as String;
         var _loc2_:int = 0;
         _loc3_ = param1.data;
         var _loc4_:* = new StringMapKeysIterator(_loc3_.h,_loc3_.rh);
         while(_loc4_.hasNext())
         {
            _loc5_ = _loc4_.next();
            _loc2_++;
         }
         _loc3_ = data;
         _loc4_ = new StringMapKeysIterator(_loc3_.h,_loc3_.rh);
         while(_loc4_.hasNext())
         {
            _loc5_ = _loc4_.next();
            _loc3_ = data;
            _loc3_ = param1.data;
            if((_loc5_ in StringMap.reserved?_loc3_.getReserved(_loc5_):_loc3_.h[_loc5_]) != (_loc5_ in StringMap.reserved?_loc3_.getReserved(_loc5_):_loc3_.h[_loc5_]))
            {
               return false;
            }
            _loc2_--;
         }
         return _loc2_ == 0;
      }
   }
}
