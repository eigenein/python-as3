package game.data.storage.hero
{
   import com.progrestar.common.lang.Translate;
   
   public class HeroRoleDescription
   {
       
      
      private var primary:String;
      
      private var extended:Array;
      
      private var _character:String;
      
      public function HeroRoleDescription(param1:String, param2:Array, param3:String)
      {
         super();
         this._character = param3;
         this.extended = param2;
         this.primary = param1;
      }
      
      public function get character() : String
      {
         return _character;
      }
      
      public function get localizedPrimaryRoleDesc() : String
      {
         return Translate.translate("LIB_HERO_LINE_" + primary.toUpperCase() + "_DESC");
      }
      
      public function get localizedExtendedRoleList() : Vector.<String>
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:Vector.<String> = new Vector.<String>();
         if(extended)
         {
            _loc2_ = extended.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_[_loc3_] = Translate.translate("LIB_HERO_ROLE_" + extended[_loc3_].toUpperCase());
               _loc3_++;
            }
         }
         return _loc1_;
      }
      
      public function get extendedRoleStringList() : Array
      {
         return extended;
      }
   }
}
