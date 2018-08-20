package com.progrestar.framework.ares.extension
{
   import avmplus.getQualifiedClassName;
   import com.progrestar.common.util.assert;
   import com.progrestar.framework.ares.core.ClipAsset;
   import flash.utils.Dictionary;
   
   public class DataExtensionType
   {
      
      private static const REGISTERED_TYPES:Dictionary = new Dictionary();
       
      
      private var _name:String;
      
      private var dataTypeClass:Class;
      
      public function DataExtensionType(param1:*, param2:String)
      {
         super();
         assert(!REGISTERED_TYPES[param2] || getQualifiedClassName(REGISTERED_TYPES[param2].dataTypeClass) == getQualifiedClassName(param1));
         if(!REGISTERED_TYPES[param2])
         {
            REGISTERED_TYPES[param2] = this;
         }
         this._name = param2;
         this.dataTypeClass = param1;
      }
      
      public static function getTypeByName(param1:String) : DataExtensionType
      {
         return REGISTERED_TYPES[param1];
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function createInstance(param1:ClipAsset) : DataExtensionBase
      {
         assert(param1.getData(this) == null);
         var _loc2_:DataExtensionBase = new dataTypeClass(param1);
         param1.setData(_loc2_);
         return _loc2_;
      }
   }
}
