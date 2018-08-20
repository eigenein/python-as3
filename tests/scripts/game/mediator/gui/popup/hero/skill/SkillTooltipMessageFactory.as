package game.mediator.gui.popup.hero.skill
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.DataStorage;
   import game.data.storage.skills.SkillActionDescription;
   import game.data.storage.skills.SkillBehaviorDescription;
   import game.data.storage.skills.SkillDescription;
   import game.model.GameModel;
   import game.model.user.hero.PlayerTitanEntry;
   import game.model.user.hero.UnitEntry;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class SkillTooltipMessageFactory
   {
      
      public static const colorBaseMP:String = ColorUtils.hexToRGBFormat(11163101);
      
      public static const colorBasePA:String = ColorUtils.hexToRGBFormat(14505301);
      
      private static const colorValue:String = ColorUtils.hexToRGBFormat(5627221);
      
      private static const colorDesc:String = ColorUtils.hexToRGBFormat(15581850);
      
      private static const colorParam:String = ColorUtils.hexToRGBFormat(16777215);
      
      private static const colorTitle:String = ColorUtils.hexToRGBFormat(15007564);
       
      
      private var showSkillDetails:Boolean;
      
      private var skillBehavior:SkillBehaviorDescription;
      
      private var id:int;
      
      private var unitEntry:UnitEntry;
      
      private var skill:SkillDescription;
      
      public function SkillTooltipMessageFactory(param1:UnitEntry, param2:SkillDescription)
      {
         showSkillDetails = GameModel.instance.player.settings.showSkillDetails.getValue();
         super();
         skillBehavior = param2.behavior;
         id = param2.id;
         this.unitEntry = param1;
         this.skill = param2;
      }
      
      public function setSkill(param1:SkillDescription) : void
      {
         skillBehavior = param1.behavior;
         id = param1.id;
         this.skill = param1;
      }
      
      public function title(param1:String) : String
      {
         return colorTitle + param1;
      }
      
      public function description(param1:int) : String
      {
         return replaceParams(colorDesc,Translate.translate("LIB_SKILL_DESC_" + id),param1,true);
      }
      
      public function params(param1:int) : String
      {
         if(Translate.has(skill.localeId_currentLevel))
         {
            return replaceParams(colorParam,Translate.translate(skill.localeId_currentLevel),param1,true);
         }
         return "";
      }
      
      public function nextLevel(param1:int) : String
      {
         var _loc2_:String = Translate.translate("UI_DIALOG_HERO_SKILL_NEXT_LEVEL") + "\n";
         return colorDesc + _loc2_ + replaceParams(colorParam,Translate.translate(skill.localeId_nextLevel),param1 + 1,false);
      }
      
      public function upgrade() : String
      {
         return replaceParamsForUpgrade(Translate.translate(skill.localeId_nextLevel));
      }
      
      protected function replaceParams(param1:String, param2:String, param3:int, param4:Boolean) : String
      {
         param2 = param2.replace("%prime%",prime(param3,param4) + param1);
         param2 = param2.replace("%prime%",getParamValueText(skillBehavior.prime,param3,param4,false) + param1);
         param2 = param2.replace("%secondary%",secondary(param3,param4) + param1);
         param2 = param2.replace("%primeInt%",prime(param3,param4,true) + param1);
         param2 = param2.replace("%secondaryInt%",secondary(param3,param4,true) + param1);
         param2 = param2.replace("%level%",levelString(param3) + param1);
         param2 = param2.replace("%hits%",hits() + param1);
         param2 = param2.replace("%duration%",duration() + param1);
         param2 = param2.replace("%cooldown%",cooldown() + param1);
         if(DataStorage.hero.getHeroById(skill.hero))
         {
            param2 = param2.replace(/%name%/g,DataStorage.hero.getHeroById(skill.hero).name);
         }
         else
         {
            param2 = param2.replace(/%name%/g,DataStorage.titan.getTitanById(skill.hero).name);
         }
         return param1 + param2;
      }
      
      protected function replaceParamsForUpgrade(param1:String) : String
      {
         param1 = param1.replace("%prime%",primeForUpgrade());
         param1 = param1.replace("%secondary%",secondaryForUpgrade());
         param1 = param1.replace("%primeInt%",primeIntForUpgrade());
         param1 = param1.replace("%secondaryInt%",secondaryIntForUpgrade());
         param1 = param1.replace("%level%","+1");
         if(DataStorage.hero.getHeroById(skill.hero))
         {
            param1 = param1.replace(/%name%/g,DataStorage.hero.getHeroById(skill.hero).name);
         }
         else
         {
            param1 = param1.replace(/%name%/g,DataStorage.titan.getTitanById(skill.hero).name);
         }
         return param1;
      }
      
      protected function prime(param1:int, param2:Boolean, param3:Boolean = false) : String
      {
         return getParamText(skillBehavior.prime,param1,param2,param3);
      }
      
      protected function secondary(param1:int, param2:Boolean, param3:Boolean = false) : String
      {
         return getParamText(skillBehavior.secondary,param1,param2,param3);
      }
      
      protected function hits() : String
      {
         return String(skillBehavior.hits);
      }
      
      protected function duration() : String
      {
         return Translate.translateArgs("UI_DIALOG_HERO_SKILL_DURATION",skillBehavior.duration);
      }
      
      protected function cooldown() : String
      {
         return Translate.translateArgs("UI_DIALOG_HERO_SKILL_DURATION",skillBehavior.cooldown);
      }
      
      protected function levelString(param1:int) : String
      {
         return colorValue + param1;
      }
      
      protected function primeForUpgrade() : String
      {
         if(!skillBehavior.prime)
         {
            return "";
         }
         return "+" + skillBehavior.prime.scale;
      }
      
      protected function secondaryForUpgrade() : String
      {
         if(!skillBehavior.secondary)
         {
            return "";
         }
         return "+" + skillBehavior.secondary.scale;
      }
      
      protected function primeIntForUpgrade() : String
      {
         if(!skillBehavior.prime)
         {
            return "";
         }
         return "+" + int(skillBehavior.prime.scale);
      }
      
      protected function secondaryIntForUpgrade() : String
      {
         if(!skillBehavior.secondary)
         {
            return "";
         }
         return "+" + int(skillBehavior.secondary.scale);
      }
      
      public function getParamValueText(param1:SkillActionDescription, param2:int, param3:Boolean, param4:Boolean = false) : String
      {
         var _loc5_:* = null;
         if(!param1)
         {
            return "";
         }
         var _loc6_:Number = param1.getValue(!!unitEntry?unitEntry.battleStats:null,param2);
         if(param4)
         {
            _loc5_ = colorTagByAction(param1) + int(_loc6_);
         }
         else
         {
            _loc5_ = colorTagByAction(param1) + smartRound(_loc6_);
         }
         return _loc5_;
      }
      
      public function getParamText(param1:SkillActionDescription, param2:int, param3:Boolean, param4:Boolean = false) : String
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         if(!param1)
         {
            return "";
         }
         var _loc7_:Number = param1.getValue(!!unitEntry?unitEntry.battleStats:null,param2);
         if(param4)
         {
            _loc5_ = colorTagByAction(param1) + int(_loc7_);
         }
         else
         {
            _loc5_ = colorTagByAction(param1) + smartRound(_loc7_);
         }
         if(param1.base)
         {
            if(showSkillDetails)
            {
               _loc6_ = actionDetails(param1,param2);
            }
            else if(param3)
            {
               _loc6_ = actionDetailsSimple(param1,param2);
            }
            if(_loc6_)
            {
               _loc5_ = _loc5_ + (colorDesc + " (" + _loc6_ + ")");
            }
         }
         return _loc5_;
      }
      
      private function actionDetails(param1:SkillActionDescription, param2:int) : String
      {
         var _loc3_:* = null;
         if(unitEntry is PlayerTitanEntry)
         {
            _loc3_ = Translate.translate("UI_SKILL_STAT_TITAN_" + param1.base);
         }
         else
         {
            _loc3_ = Translate.translate("UI_SKILL_STAT_" + param1.base);
         }
         if(param1.K && param1.K != 1)
         {
            _loc3_ = int(param1.K * 100) + "% " + _loc3_;
         }
         var _loc4_:Number = (!!param1.c?param1.c:0) + (!!param1.scale?param1.scale:0) * param2;
         if(_loc4_ != 0)
         {
            _loc3_ = _loc3_ + (" + " + smartRound(_loc4_));
         }
         return _loc3_;
      }
      
      private function actionDetailsSimple(param1:SkillActionDescription, param2:int) : String
      {
         if(unitEntry is PlayerTitanEntry)
         {
            return Translate.translate("UI_SKILL_STAT_DEPENDS_TITAN_" + param1.base);
         }
         return Translate.translate("UI_SKILL_STAT_DEPENDS_" + param1.base);
      }
      
      private function colorTagByAction(param1:SkillActionDescription) : String
      {
         if(param1.type == "physical")
         {
            return colorBasePA;
         }
         if(param1.type == "magic")
         {
            return colorBaseMP;
         }
         return colorValue;
      }
      
      private function smartRound(param1:Number) : String
      {
         if(param1 > 999)
         {
            return String(Math.round(param1));
         }
         var _loc2_:String = param1.toPrecision(4);
         if(_loc2_.indexOf(".") != -1)
         {
            while(_loc2_.charAt(_loc2_.length - 1) == "0")
            {
               _loc2_ = _loc2_.slice(0,_loc2_.length - 1);
            }
            if(_loc2_.charAt(_loc2_.length - 1) == ".")
            {
               _loc2_ = _loc2_.slice(0,_loc2_.length - 1);
            }
         }
         return _loc2_;
      }
   }
}
