package game.model.user.hero
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.hero.HeroDescription;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class HeroUtils
   {
      
      private static var LIGHT_BROWN:String = ColorUtils.hexToRGBFormat(16573879);
      
      private static var LIGHT_GREEN:String = ColorUtils.hexToRGBFormat(15007564);
       
      
      public function HeroUtils()
      {
         super();
      }
      
      public static function getSkillsPower(param1:PlayerHeroSkillData) : int
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc4_:* = 0;
         _loc3_ = 1;
         while(_loc3_ <= 4)
         {
            _loc2_ = param1.getLevelByTier(_loc3_);
            if(_loc2_)
            {
               _loc4_ = Number(_loc4_ + _loc2_.skill.power * _loc2_.level);
            }
            _loc3_++;
         }
         return _loc4_;
      }
      
      public static function getFullRolesDescription(param1:HeroDescription, param2:String = "\n", param3:Boolean = true) : String
      {
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc5_:Vector.<String> = param1.role.localizedExtendedRoleList;
         var _loc8_:String = Translate.translate("LIB_BATTLESTATDATA_" + param1.mainStat.name.toUpperCase());
         if(param3)
         {
            _loc6_ = Translate.translateArgs(_loc5_.length == 1?"UI_DIALOG_HERO_ROLE_SINGLE":"UI_DIALOG_HERO_ROLE_LIST",LIGHT_GREEN + _loc5_.join(", "));
            _loc4_ = LIGHT_BROWN + Translate.translateArgs("UI_DIALOG_HERO_MAIN_STAT",LIGHT_GREEN + _loc8_);
         }
         else
         {
            _loc6_ = Translate.translateArgs(_loc5_.length == 1?"UI_DIALOG_HERO_ROLE_SINGLE":"UI_DIALOG_HERO_ROLE_LIST",_loc5_.join(", "));
            _loc4_ = Translate.translateArgs("UI_DIALOG_HERO_MAIN_STAT",_loc8_);
         }
         var _loc7_:String = param1.role.localizedPrimaryRoleDesc + param2 + _loc6_ + param2 + _loc4_;
         return _loc7_;
      }
   }
}
