package starling.utils
{
   public function execute(param1:Function, ... rest) : void
   {
      var _loc4_:int = 0;
      var _loc3_:int = 0;
      if(param1 != null)
      {
         _loc3_ = param1.length;
         _loc4_ = rest.length;
         while(_loc4_ < _loc3_)
         {
            rest[_loc4_] = null;
            _loc4_++;
         }
         switch(int(_loc3_))
         {
            case 0:
               param1();
               break;
            case 1:
               param1(rest[0]);
               break;
            case 2:
               param1(rest[0],rest[1]);
               break;
            case 3:
               param1(rest[0],rest[1],rest[2]);
               break;
            case 4:
               param1(rest[0],rest[1],rest[2],rest[3]);
               break;
            case 5:
               param1(rest[0],rest[1],rest[2],rest[3],rest[4]);
               break;
            case 6:
               param1(rest[0],rest[1],rest[2],rest[3],rest[4],rest[5]);
               break;
            case 7:
               param1(rest[0],rest[1],rest[2],rest[3],rest[4],rest[5],rest[6]);
         }
      }
   }
}
