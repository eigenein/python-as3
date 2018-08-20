package com.progrestar.common.util
{
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class PropertyMapManager
   {
      
      private static const propertyDictionary:Dictionary = new Dictionary();
      
      private static const classXmlDictionary:Dictionary = new Dictionary();
      
      private static const classTypeMapDictionary:Dictionary = new Dictionary();
      
      private static const classTypeMapConstDictionary:Dictionary = new Dictionary();
       
      
      public function PropertyMapManager()
      {
         super();
      }
      
      public static function getMap(param1:*) : Vector.<String>
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = 0;
         var _loc5_:int = 0;
         if(!param1)
         {
            return new Vector.<String>(0);
         }
         var _loc6_:Vector.<String> = propertyDictionary[param1];
         if(!_loc6_)
         {
            var _loc7_:* = new Vector.<String>();
            propertyDictionary[param1] = _loc7_;
            _loc6_ = _loc7_;
            _loc3_ = describeType(param1);
            if(_loc3_.@isStatic == "true")
            {
               _loc3_ = _loc3_.factory[0];
            }
            _loc4_ = _loc3_.accessor;
            _loc2_ = uint(_loc4_.length());
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               if(_loc4_[_loc5_].@access == "readwrite")
               {
                  _loc6_.push(_loc4_[_loc5_].@name.toString());
               }
               _loc5_++;
            }
            _loc4_ = _loc3_.variable;
            _loc2_ = uint(_loc4_.length());
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc6_.push(_loc4_[_loc5_].@name.toString());
               _loc5_++;
            }
         }
         return _loc6_;
      }
      
      public static function getMapOfType(param1:*, param2:Class) : Vector.<String>
      {
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = 0;
         var _loc7_:int = 0;
         if(!param1 || !param2)
         {
            return new Vector.<String>(0);
         }
         var _loc5_:String = getQualifiedClassName(param2);
         var _loc8_:Vector.<String> = propertyDictionary[param1];
         if(!_loc8_)
         {
            var _loc9_:* = new Vector.<String>();
            propertyDictionary[param1] = _loc9_;
            _loc8_ = _loc9_;
            _loc4_ = describeType(param1);
            if(_loc4_.@isStatic == "true")
            {
               _loc4_ = _loc4_.factory[0];
            }
            _loc6_ = _loc4_.accessor;
            _loc3_ = uint(_loc6_.length());
            _loc7_ = 0;
            while(_loc7_ < _loc3_)
            {
               if(_loc6_[_loc7_].@access == "readwrite" && _loc6_[_loc7_].@type == _loc5_)
               {
                  _loc8_.push(_loc6_[_loc7_].@name.toString());
               }
               _loc7_++;
            }
            _loc6_ = _loc4_.variable;
            _loc3_ = uint(_loc6_.length());
            _loc7_ = 0;
            while(_loc7_ < _loc3_)
            {
               if(_loc6_[_loc7_].@type == _loc5_)
               {
                  _loc8_.push(_loc6_[_loc7_].@name.toString());
               }
               _loc7_++;
            }
         }
         return _loc8_;
      }
      
      public static function describeTypeXml(param1:*) : XML
      {
         if(classXmlDictionary[param1])
         {
            return classXmlDictionary[param1];
         }
         var _loc2_:* = describeType(param1);
         classXmlDictionary[param1] = _loc2_;
         return _loc2_;
      }
      
      public static function getTypeMap(param1:*, param2:Boolean = false) : Dictionary
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public static function getConstants(param1:*) : Vector.<String>
      {
         var _loc4_:* = null;
         var _loc2_:* = 0;
         var _loc5_:int = 0;
         var _loc6_:Vector.<String> = new Vector.<String>();
         var _loc3_:XML = describeTypeXml(param1);
         _loc4_ = _loc3_.constant;
         _loc2_ = uint(_loc4_.length());
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc6_.push(_loc4_[_loc5_].@name.toString());
            _loc5_++;
         }
         return _loc6_;
      }
      
      public static function getStaticMap(param1:Class) : Vector.<String>
      {
         var _loc4_:* = null;
         var _loc2_:* = 0;
         var _loc5_:int = 0;
         var _loc6_:Vector.<String> = new Vector.<String>();
         var _loc3_:XML = describeTypeXml(param1);
         _loc4_ = _loc3_.accessor;
         _loc2_ = uint(_loc4_.length());
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            if(_loc4_[_loc5_].@access == "readwrite")
            {
               _loc6_.push(_loc4_[_loc5_].@name.toString());
            }
            _loc5_++;
         }
         _loc4_ = _loc3_.variable;
         _loc2_ = uint(_loc4_.length());
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc6_.push(_loc4_[_loc5_].@name.toString());
            _loc5_++;
         }
         return _loc6_;
      }
      
      public static function getMethods(param1:*, param2:Boolean = false) : Vector.<String>
      {
         var _loc5_:* = null;
         var _loc3_:* = 0;
         var _loc6_:int = 0;
         var _loc7_:Vector.<String> = new Vector.<String>();
         var _loc4_:XML = describeTypeXml(param1);
         if(_loc4_.@isStatic == "true")
         {
            if(!param2)
            {
               _loc4_ = _loc4_.factory[0];
            }
         }
         else if(param2)
         {
            return _loc7_;
         }
         _loc5_ = _loc4_.method;
         _loc3_ = uint(_loc5_.length());
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc7_.push(_loc5_[_loc6_].@name.toString());
            _loc6_++;
         }
         return _loc7_;
      }
      
      public static function getMapForInstance(param1:Object) : Vector.<String>
      {
         var _loc4_:* = undefined;
         var _loc3_:String = getQualifiedClassName(param1);
         if(_loc3_ == "Object")
         {
            _loc4_ = new Vector.<String>();
            var _loc6_:int = 0;
            var _loc5_:* = param1;
            for(var _loc2_ in param1)
            {
               _loc4_.push(_loc2_);
            }
            return _loc4_;
         }
         return getMap(getDefinitionByName(_loc3_) as Class);
      }
      
      public static function implementsInterface(param1:Class, param2:String) : Boolean
      {
         var _loc3_:* = null;
         if(classXmlDictionary[param1])
         {
            _loc3_ = classXmlDictionary[param1];
         }
         else
         {
            var _loc4_:* = describeType(param1);
            classXmlDictionary[param1] = _loc4_;
            _loc3_ = _loc4_;
         }
         var _loc5_:* = _loc3_.factory.implementsInterface;
         var _loc6_:int = 0;
         var _loc7_:* = new XMLList("");
         return _loc3_.factory.implementsInterface.(@type == param2).length() != 0;
      }
      
      public static function apply(param1:Object, param2:Object) : void
      {
         var _loc5_:* = 0;
         var _loc4_:* = null;
         var _loc6_:Vector.<String> = getMapForInstance(param1);
         var _loc3_:uint = _loc6_.length;
         _loc5_ = uint(0);
         while(_loc5_ < _loc3_)
         {
            _loc4_ = _loc6_[_loc5_];
            if(param2.hasOwnProperty(_loc4_))
            {
               param2[_loc4_] = param1[_loc4_];
            }
            _loc5_++;
         }
      }
      
      public static function merge(... rest) : Object
      {
         var _loc3_:* = 0;
         var _loc5_:* = 0;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc2_:* = 0;
         var _loc6_:* = 0;
         var _loc4_:Object = {};
         if(rest)
         {
            _loc3_ = uint(rest.length);
            _loc5_ = uint(0);
            while(_loc5_ < _loc3_)
            {
               _loc7_ = rest[_loc5_];
               _loc8_ = getMapForInstance(_loc7_);
               _loc2_ = uint(_loc8_.length);
               _loc6_ = uint(0);
               while(_loc6_ < _loc2_)
               {
                  _loc4_[_loc8_[_loc6_]] = _loc7_[_loc8_[_loc6_]];
                  _loc6_++;
               }
               _loc5_++;
            }
         }
         return _loc4_;
      }
   }
}
