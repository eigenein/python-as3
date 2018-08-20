package game.data.storage.skills
{
   import battle.data.BattleHeroDescription;
   import battle.data.BattleSkillDescription;
   import com.progrestar.common.lang.Translate;
   import game.data.storage.DataStorage;
   import game.data.storage.DescriptionBase;
   import game.view.gui.tutorial.tutorialtarget.ITutorialTargetKey;
   
   public class SkillDescription extends DescriptionBase implements ITutorialTargetKey
   {
      
      public static const TIER_AUTOATTACK:int = 0;
      
      public static const TIER_ULTIMATE:int = 1;
      
      public static const TIER_SKILL_GREEN:int = 2;
      
      public static const TIER_SKILL_BLUE:int = 3;
      
      public static const TIER_SKILL_PURPLE:int = 4;
      
      public static const TIER_LEGENDARY:int = 5;
       
      
      public var tier:int;
      
      public var hero:int;
      
      public var power:Number;
      
      public var icon_assetTexture:String;
      
      public var icon_assetAtlas:int;
      
      public var disabled:Boolean;
      
      public var behavior:SkillBehaviorDescription;
      
      private var _locale_id_currentLevel:String;
      
      private var _locale_id_nextLevel:String;
      
      public function SkillDescription(param1:Object)
      {
         super();
         if(param1)
         {
            _id = param1.id;
            tier = param1.tier;
            hero = param1.hero;
            power = param1.power;
            disabled = param1.disabled;
            _locale_id_currentLevel = param1.locale_id_currentLevel;
            if(!_locale_id_currentLevel)
            {
               _locale_id_currentLevel = "LIB_SKILL_PARAM_" + _id;
            }
            _locale_id_nextLevel = param1.locale_id_nextLevel;
            if(!_locale_id_nextLevel)
            {
               _locale_id_nextLevel = "LIB_SKILL_NEXT_" + _id;
            }
            icon_assetTexture = param1.icon_assetTexture;
            icon_assetAtlas = param1.icon_assetAtlas;
            if(param1.behavior)
            {
               behavior = new SkillBehaviorDescription(param1.behavior);
            }
         }
      }
      
      public static function sort_byTier(param1:SkillDescription, param2:SkillDescription) : int
      {
         return param1.tier - param2.tier;
      }
      
      public function get localeId_currentLevel() : String
      {
         return _locale_id_currentLevel;
      }
      
      public function get localeId_nextLevel() : String
      {
         return _locale_id_nextLevel;
      }
      
      public function get ultimate() : Boolean
      {
         return tier == 1;
      }
      
      public function get visibleLevelOffset() : int
      {
         return DataStorage.enum.getbyId_SkillTier(tier).skillMinLevel;
      }
      
      public function get frameAssetTexture() : String
      {
         return DataStorage.enum.getbyId_SkillTier(tier).frameAssetTexture;
      }
      
      override public function applyLocale() : void
      {
         if(Translate.has("LIB_SKILL_" + id))
         {
            _name = Translate.translate("LIB_SKILL_" + id);
         }
         else
         {
            _name = "";
         }
      }
      
      public function createBattleSkillDescription(param1:BattleHeroDescription, param2:int = 0) : BattleSkillDescription
      {
         return new BattleSkillDescription(param2,param1,tier,behavior);
      }
   }
}
