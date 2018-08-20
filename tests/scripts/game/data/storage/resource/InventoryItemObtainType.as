package game.data.storage.resource
{
   import com.progrestar.common.lang.Translate;
   import flash.utils.Dictionary;
   
   public class InventoryItemObtainType
   {
      
      public static const TYPEBASE_CHEST:String = "chest";
      
      public static const TYPEBASE_DISABLED:String = "disabled";
      
      public static const TYPEBASE_TITAN:String = "titan";
      
      private static var dict:Dictionary = new Dictionary();
       
      
      protected var _descText:String;
      
      protected var _typeBase:String;
      
      protected var _typeSubject:String;
      
      protected var _type:String;
      
      private var _canNavigateTo:Boolean;
      
      public function InventoryItemObtainType(param1:String)
      {
         super();
         this._type = param1;
         var _loc2_:Array = _type.split(":");
         _typeBase = _loc2_[0];
         if(_loc2_[1])
         {
            _typeSubject = _loc2_[1];
         }
      }
      
      public static function applyLocale() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = dict;
         for each(var _loc1_ in dict)
         {
            _loc1_._applyLocale();
         }
      }
      
      public static function getObject(param1:String) : InventoryItemObtainType
      {
         var _loc2_:* = null;
         if(!dict[param1])
         {
            _loc2_ = new InventoryItemObtainType(param1);
            dict[param1] = _loc2_;
         }
         else
         {
            _loc2_ = dict[param1];
         }
         return _loc2_;
      }
      
      public static function getList() : Vector.<InventoryItemObtainType>
      {
         var _loc2_:Vector.<InventoryItemObtainType> = new Vector.<InventoryItemObtainType>();
         var _loc4_:int = 0;
         var _loc3_:* = dict;
         for each(var _loc1_ in dict)
         {
            _loc2_.push(_loc1_);
         }
         return _loc2_;
      }
      
      public function get descText() : String
      {
         return _descText;
      }
      
      public function get typeBase() : String
      {
         return _typeBase;
      }
      
      public function get typeSubject() : String
      {
         return _typeSubject;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get canNavigateTo() : Boolean
      {
         return _canNavigateTo;
      }
      
      public function set canNavigateTo(param1:Boolean) : void
      {
         if(_canNavigateTo == param1)
         {
            return;
         }
         _canNavigateTo = param1;
      }
      
      public function get isObtainable() : Boolean
      {
         return typeBase != "disabled";
      }
      
      protected function _applyLocale() : void
      {
         var _loc1_:String = type.replace(":","__");
         _descText = Translate.translate("LIB_GEAR_OBTAIN_TYPE_" + _loc1_.toUpperCase());
      }
   }
}
