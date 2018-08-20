package
{
   import flash.Boot;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getQualifiedSuperclassName;
   
   public class Type
   {
       
      
      public function Type()
      {
      }
      
      public static function getClass(param1:Object) : Class
      {
         var _loc2_:String = getQualifiedClassName(param1);
         if(_loc2_ == "null" || _loc2_ == "Object" || _loc2_ == "int" || _loc2_ == "Number" || _loc2_ == "Boolean")
         {
            return null;
         }
         if(param1.hasOwnProperty("prototype"))
         {
            return null;
         }
         var _loc3_:* = getDefinitionByName(_loc2_) as Class;
         if(_loc3_.__isenum)
         {
            return null;
         }
         return _loc3_;
      }
      
      public static function getSuperClass(param1:Class) : Class
      {
         var _loc2_:String = getQualifiedSuperclassName(param1);
         if(_loc2_ == null || _loc2_ == "Object")
         {
            return null;
         }
         return getDefinitionByName(_loc2_) as Class;
      }
      
      public static function getClassName(param1:Class) : String
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:String = getQualifiedClassName(param1);
         var _loc3_:String = _loc2_;
         if(_loc3_ == "int")
         {
            return "Int";
         }
         if(_loc3_ == "Number")
         {
            return "Float";
         }
         if(_loc3_ == "Boolean")
         {
            return "Bool";
         }
         return _loc2_.split("::").join(".");
      }
      
      public static function resolveClass(param1:String) : Class
      {
         var _loc3_:* = null as Class;
         var _loc5_:* = null as String;
         try
         {
            _loc3_ = getDefinitionByName(param1) as Class;
            if(_loc3_.__isenum)
            {
               return null;
            }
            return _loc3_;
         }
         catch(_loc4_:*)
         {
            _loc5_ = param1;
            if(_loc5_ == "Int")
            {
               return int;
            }
            if(_loc5_ == "Float")
            {
               return Number;
            }
            return null;
         }
         if(_loc3_ == null || _loc3_.__name__ == null)
         {
            return null;
         }
         return _loc3_;
      }
      
      public static function resolveEnum(param1:String) : Class
      {
         var _loc3_:* = null;
         try
         {
            _loc3_ = getDefinitionByName(param1);
            if(!_loc3_.__isenum)
            {
               return null;
            }
            return _loc3_;
         }
         catch(_loc4_:*)
         {
            if(param1 == "Bool")
            {
               return Boolean;
            }
            return null;
         }
         if(_loc3_ == null || _loc3_.__ename__ == null)
         {
            return null;
         }
         return _loc3_;
      }
      
      public static function createInstance(param1:Class, param2:Array) : Object
      {
         var _loc3_:int = param2.length;
         switch(_loc3_)
         {
            case 0:
               return new param1();
            case 1:
               return new param1(param2[0]);
            case 2:
               return new param1(param2[0],param2[1]);
            case 3:
               return new param1(param2[0],param2[1],param2[2]);
            case 4:
               return new param1(param2[0],param2[1],param2[2],param2[3]);
            case 5:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4]);
            case 6:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5]);
            case 7:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6]);
            case 8:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7]);
            case 9:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8]);
            case 10:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9]);
            case 11:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9],param2[10]);
            case 12:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9],param2[10],param2[11]);
            case 13:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9],param2[10],param2[11],param2[12]);
            case 14:
               return new param1(param2[0],param2[1],param2[2],param2[3],param2[4],param2[5],param2[6],param2[7],param2[8],param2[9],param2[10],param2[11],param2[12],param2[13]);
         }
      }
      
      public static function createEmptyInstance(param1:Class) : Object
      {
         var _loc3_:* = null as Object;
         try
         {
            Boot.skip_constructor = true;
            _loc3_ = new param1();
            Boot.skip_constructor = false;
            return _loc3_;
         }
         catch(_loc4_:*)
         {
            Boot.skip_constructor = false;
            throw _loc4_;
         }
         return null;
      }
      
      public static function enumEq(param1:Object, param2:Object) : Boolean
      {
         var _loc4_:* = null as Array;
         var _loc5_:* = null as Array;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(param1 == param2)
         {
            return true;
         }
         try
         {
            if(param1.index != param2.index)
            {
               return false;
            }
            _loc4_ = param1.params;
            _loc5_ = param2.params;
            _loc6_ = 0;
            _loc7_ = _loc4_.length;
            while(_loc6_ < _loc7_)
            {
               _loc6_++;
               _loc8_ = _loc6_;
               if(!Type.enumEq(_loc4_[_loc8_],_loc5_[_loc8_]))
               {
                  return false;
               }
            }
         }
         catch(_loc9_:*)
         {
            return false;
         }
         return true;
      }
      
      public static function enumConstructor(param1:Object) : String
      {
         return param1.tag;
      }
      
      public static function enumParameters(param1:Object) : Array
      {
         if(param1.params == null)
         {
            return [];
         }
         return param1.params;
      }
   }
}
