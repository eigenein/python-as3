package game.mediator.gui.popup.hero.skill
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.hero.PlayerHeroSkill;
   import org.osflash.signals.Signal;
   import starling.textures.Texture;
   
   public class HeroPopupSkillValueObject
   {
       
      
      private var _tooltipValueObject:SkillTooltipValueObject;
      
      private var _skill:PlayerHeroSkill;
      
      private var _updateSignal:Signal;
      
      private var _upgradeCost:CostData;
      
      private var _canUpgrade:Boolean;
      
      public function HeroPopupSkillValueObject(param1:PlayerHeroEntry, param2:PlayerHeroSkill, param3:Boolean)
      {
         super();
         _canUpgrade = param3;
         _skill = param2;
         _updateSignal = new Signal();
         updateCost();
         _tooltipValueObject = new SkillTooltipValueObject(param1,param2.skill);
         updateTooltipData();
      }
      
      public function get skill() : PlayerHeroSkill
      {
         return _skill;
      }
      
      public function get tooltipValueObject() : SkillTooltipValueObject
      {
         return _tooltipValueObject;
      }
      
      public function get name() : String
      {
         return _skill.skill.name;
      }
      
      public function get available() : Boolean
      {
         return _skill.level != 0;
      }
      
      public function get level() : int
      {
         return _skill.visibleLevel;
      }
      
      public function get updateSignal() : Signal
      {
         return _updateSignal;
      }
      
      public function get upgradeCost() : CostData
      {
         return _upgradeCost;
      }
      
      public function set canUpgrade(param1:Boolean) : void
      {
         _canUpgrade = param1;
      }
      
      public function get canUpgrade() : Boolean
      {
         return _canUpgrade;
      }
      
      public function get maxPossibleLevel() : Boolean
      {
         return _skill.level >= DataStorage.level.getMaxTeamLevel();
      }
      
      public function get icon() : Texture
      {
         return AssetStorage.skillIcon.getItemTexture(_skill.skill);
      }
      
      public function get qualityFrameTexture() : Texture
      {
         return AssetStorage.rsx.popup_theme.getTexture(_skill.skill.frameAssetTexture);
      }
      
      public function get lockedTextDesc() : String
      {
         switch(int(_skill.skill.tier) - 2)
         {
            case 0:
               return Translate.translate("SKILL_LOCKED_GREEN");
            case 1:
               return Translate.translate("SKILL_LOCKED_BLUE");
            case 2:
               return Translate.translate("SKILL_LOCKED_PURPLE");
         }
      }
      
      public function updateCost() : void
      {
         _upgradeCost = DataStorage.level.getSkillLevelCost(skill.level,skill.skill.tier);
      }
      
      public function updateTooltipData() : void
      {
         _tooltipValueObject.setup(_skill.level,available && !maxPossibleLevel,false);
      }
   }
}
