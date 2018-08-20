package
{
   import flash.Boot;
   
   public class EReg
   {
       
      
      public var result;
      
      public var r:RegExp;
      
      public function EReg(param1:String = undefined, param2:String = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         r = new RegExp(param1,param2);
      }
      
      public function replace(param1:String, param2:String) : String
      {
         return param1.replace(r,param2);
      }
      
      public function matchedPos() : Object
      {
         if(result == null)
         {
            throw "No string matched";
         }
         return {
            "pos":int(result["index"]),
            "len":result[0].length
         };
      }
      
      public function matched(param1:int) : String
      {
         if(result != null && param1 >= 0 && param1 < int(result.length))
         {
            return result[param1];
         }
         throw "EReg::matched";
      }
      
      public function matchSub(param1:String, param2:int, param3:int = -1) : Boolean
      {
         var _loc4_:* = false;
         var _loc5_:* = null;
         if(r.global)
         {
            r.lastIndex = param2;
            result = r.exec(param3 < 0?param1:param1.substr(0,param2 + param3));
            _loc4_ = result != null;
            if(_loc4_)
            {
               result.input = param1;
            }
            return _loc4_;
         }
         _loc4_ = Boolean(match(param3 < 0?param1.substr(param2):param1.substr(param2,param3)));
         if(_loc4_)
         {
            result.input = param1;
            _loc5_ = result;
            _loc5_["index"] = _loc5_["index"] + param2;
         }
         return _loc4_;
      }
      
      public function match(param1:String) : Boolean
      {
         if(r.global)
         {
            r.lastIndex = 0;
         }
         result = r.exec(param1);
         return result != null;
      }
   }
}
