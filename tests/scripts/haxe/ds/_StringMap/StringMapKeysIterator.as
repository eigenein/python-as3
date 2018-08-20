package haxe.ds._StringMap
{
   import flash.Boot;
   
   public class StringMapKeysIterator
   {
       
      
      public var rh;
      
      public var nextIndex:int;
      
      public var isReserved:Boolean;
      
      public var index:int;
      
      public var h;
      
      public function StringMapKeysIterator(param1:* = undefined, param2:* = undefined)
      {
         var _loc6_:* = null;
         var _loc7_:int = 0;
         if(Boot.skip_constructor)
         {
            return;
         }
         h = param1;
         rh = param2;
         index = 0;
         isReserved = false;
         var _loc3_:* = h;
         var _loc4_:int = index;
         var _loc5_:Boolean = §§hasnext(h,_loc4_);
         if(!_loc5_ && rh != null)
         {
            _loc6_ = rh;
            h = _loc6_;
            _loc3_ = _loc6_;
            _loc7_ = 0;
            index = _loc7_;
            _loc4_ = _loc7_;
            rh = null;
            isReserved = true;
            _loc5_ = §§hasnext(_loc6_,_loc4_);
         }
         nextIndex = _loc4_;
         return;
         §§push(_loc5_);
      }
      
      public function next() : String
      {
         var _loc1_:String = §§nextname(nextIndex,h);
         index = nextIndex;
         if(isReserved)
         {
            _loc1_ = _loc1_.substr(1);
         }
         return _loc1_;
      }
      
      public function hasNext() : Boolean
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc1_:* = h;
         var _loc2_:int = index;
         var _loc3_:Boolean = §§hasnext(h,_loc2_);
         if(!_loc3_ && rh != null)
         {
            _loc4_ = rh;
            h = _loc4_;
            _loc1_ = _loc4_;
            _loc5_ = 0;
            index = _loc5_;
            _loc2_ = _loc5_;
            rh = null;
            isReserved = true;
            _loc3_ = §§hasnext(_loc4_,_loc2_);
         }
         nextIndex = _loc2_;
         return _loc3_;
      }
   }
}
