package game.data.storage.hero
{
   import com.progrestar.common.lang.Translate;
   import flash.utils.Dictionary;
   import game.data.storage.resource.InventoryItemObtainType;
   
   public class HeroObtainType extends InventoryItemObtainType
   {
      
      private static var dict:Dictionary = new Dictionary();
       
      
      private var _typeSubjectId:String;
      
      public function HeroObtainType(param1:String)
      {
         super(param1);
         this._type = param1;
         var _loc2_:Array = _type.split(":");
         _typeBase = _loc2_[0];
         if(_loc2_[1])
         {
            _typeSubject = _loc2_[1];
         }
         if(_loc2_[2])
         {
            _typeSubjectId = _loc2_[2];
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
      
      public static function getObject(param1:String) : HeroObtainType
      {
         var _loc2_:* = null;
         if(!dict[param1])
         {
            _loc2_ = new HeroObtainType(param1);
            dict[param1] = _loc2_;
         }
         else
         {
            _loc2_ = dict[param1];
         }
         return _loc2_;
      }
      
      public static function getList() : Vector.<HeroObtainType>
      {
         var _loc2_:Vector.<HeroObtainType> = new Vector.<HeroObtainType>();
         var _loc4_:int = 0;
         var _loc3_:* = dict;
         for each(var _loc1_ in dict)
         {
            _loc2_.push(_loc1_);
         }
         return _loc2_;
      }
      
      public function get typeSubjectId() : String
      {
         return _typeSubjectId;
      }
      
      override protected function _applyLocale() : void
      {
         var _loc1_:String = type.replace(":","__");
         _loc1_ = _typeBase + "__" + _typeSubject;
         _descText = Translate.translate("LIB_HERO_OBTAIN_TYPE_" + _loc1_.toUpperCase());
      }
   }
}
