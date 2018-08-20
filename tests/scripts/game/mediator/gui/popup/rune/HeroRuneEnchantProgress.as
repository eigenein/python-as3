package game.mediator.gui.popup.rune
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.MathUtil;
   import game.data.storage.DataStorage;
   import game.data.storage.rune.RuneLevelDescription;
   import game.data.storage.rune.RuneTypeDescription;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class HeroRuneEnchantProgress
   {
       
      
      private var _rune:PlayerHeroRuneValueObject;
      
      private const BROWN:String = ColorUtils.hexToRGBFormat(16573879);
      
      private const WHITE:String = ColorUtils.hexToRGBFormat(16645626);
      
      private const GREEN:String = ColorUtils.hexToRGBFormat(15007564);
      
      private const LEVEL_ARROWS_SPRITE:String = "^{sprite:alchemy_arrow_right}^";
      
      private var _levelCap:int;
      
      private var _capReached:Boolean;
      
      private var _baseLevel:RuneLevelDescription;
      
      private var _curentValueCapped:int;
      
      private var _newValueCapped:int;
      
      private var _newLevel:int;
      
      private var _goldCost:int;
      
      private var _gemCost:int;
      
      private var _starmoneyCost:int;
      
      public function HeroRuneEnchantProgress()
      {
         super();
      }
      
      public function get level() : int
      {
         return _rune.level;
      }
      
      public function get maxLevel() : int
      {
         return _rune.maxLevel;
      }
      
      public function get levelToEnchant() : int
      {
         return _newLevel;
      }
      
      public function get currentValue() : int
      {
         return _rune.currentValue;
      }
      
      public function get nextLevelValue() : int
      {
         return _baseLevel.nextLevel.enchantValue;
      }
      
      public function get levelValue() : int
      {
         return _baseLevel.enchantValue;
      }
      
      public function get selectedValue() : int
      {
         return _newValueCapped - _curentValueCapped;
      }
      
      public function get canIncreaseLevel() : Boolean
      {
         return level < _rune.levelCap;
      }
      
      public function get canIncrease() : Boolean
      {
         return !_capReached;
      }
      
      public function get starmoneyCost() : int
      {
         return _starmoneyCost;
      }
      
      public function get goldCost() : int
      {
         return _goldCost;
      }
      
      public function get gemCost() : int
      {
         return _gemCost;
      }
      
      public function get currentLevelProgressValue() : Number
      {
         return MathUtil.clamp((_curentValueCapped - _baseLevel.enchantValue) / (_baseLevel.nextLevel.enchantValue - _baseLevel.enchantValue),0,1);
      }
      
      public function get nextLevelProgressValue() : Number
      {
         var _loc5_:* = NaN;
         if(_newValueCapped <= _curentValueCapped)
         {
            return currentLevelProgressValue;
         }
         var _loc1_:int = _newValueCapped;
         var _loc3_:int = this.level;
         var _loc4_:* = DataStorage.rune.getLevel(_loc3_);
         var _loc2_:RuneLevelDescription = DataStorage.rune.getLevel(_loc3_ + 1);
         if(!_loc2_)
         {
            return 1;
         }
         var _loc6_:int = 0;
         while(_loc2_ && _loc1_ > _loc2_.enchantValue && _loc2_.level < _levelCap)
         {
            _loc6_++;
            _loc4_ = _loc2_;
            _loc2_ = _loc2_.nextLevel;
         }
         var _loc7_:int = !!_loc4_?_loc4_.enchantValue:0;
         if(_loc2_)
         {
            _loc5_ = Number(MathUtil.clamp((_loc1_ - _loc7_) / (_loc2_.enchantValue - _loc7_),0,1));
         }
         else
         {
            _loc5_ = 1;
         }
         return _loc6_ + _loc5_;
      }
      
      public function get statString() : String
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:RuneTypeDescription = _rune.type;
         var _loc1_:String = Translate.translate("LIB_BATTLESTATDATA_" + _loc5_.stat.toUpperCase());
         if(level > 0)
         {
            _loc3_ = _loc5_.getValueByLevel(_rune.level);
            _loc1_ = _loc1_ + (": " + WHITE + _loc3_);
         }
         if(levelToEnchant > level)
         {
            _loc2_ = _loc5_.getValueByLevel(levelToEnchant);
            _loc4_ = _loc2_ - _loc3_;
            _loc1_ = _loc1_ + (GREEN + " +" + _loc4_);
         }
         return _loc1_;
      }
      
      public function get enchantPointsString() : String
      {
         var _loc1_:* = null;
         var _loc4_:int = this.levelValue;
         var _loc5_:int = this.currentValue - _loc4_;
         var _loc2_:int = this.nextLevelValue - _loc4_;
         var _loc3_:int = this.selectedValue;
         var _loc6_:String = BROWN + Translate.translate("UI_DIALOG_RUNES_EXP") + " " + WHITE + _loc5_ + "/" + _loc2_;
         if(_loc3_ > 0)
         {
            _loc1_ = GREEN + "+" + _loc3_;
            _loc6_ = _loc6_ + " " + _loc1_;
         }
         return _loc6_;
      }
      
      public function get levelString() : String
      {
         var _loc1_:String = BROWN + Translate.translate("UI_DIALOG_RUNES_LEVEL") + " " + WHITE + level;
         if(levelToEnchant > level)
         {
            _loc1_ = _loc1_ + (" ^{sprite:alchemy_arrow_right}^ " + GREEN + levelToEnchant);
         }
         if(levelToEnchant == _levelCap)
         {
            _loc1_ = _loc1_ + (" " + Translate.translate("UI_DIALOG_RUNES_LEVEL_MAX"));
         }
         return _loc1_;
      }
      
      public function setupValues(param1:int, param2:PlayerHeroRuneValueObject, param3:int) : void
      {
         this._rune = param2;
         _levelCap = _rune.levelCap;
         var _loc5_:int = _rune.currentValue;
         var _loc6_:RuneLevelDescription = DataStorage.rune.getLevel(_rune.level);
         var _loc4_:int = DataStorage.rune.getLevel(_levelCap).enchantValue;
         _curentValueCapped = _loc5_;
         _newValueCapped = Math.min(_loc5_ + param3,_loc4_);
         if(_levelCap > 0 && _rune.level == _levelCap)
         {
            _baseLevel = DataStorage.rune.getLevel(_levelCap - 1);
         }
         else
         {
            _baseLevel = _loc6_;
         }
         if(_loc6_.nextLevel)
         {
            _gemCost = getGemCost(_loc5_,DataStorage.rune.getLevel(_rune.level + 1).enchantValue);
         }
         _newLevel = DataStorage.rune.getLevelByEnchantment(_newValueCapped);
         _capReached = _newLevel == _levelCap || param2.locked;
         _goldCost = getGoldCost(_loc5_,_newValueCapped,_loc6_,DataStorage.rune.getLevel(_newLevel));
      }
      
      protected function getGemCost(param1:int, param2:int) : int
      {
         return (param2 - param1) * DataStorage.rule.runeEnchantStarmoney;
      }
      
      protected function getGoldCost(param1:int, param2:int, param3:RuneLevelDescription, param4:RuneLevelDescription) : int
      {
         if(param1 >= param2)
         {
            return 0;
         }
         var _loc6_:int = param3.summaryGoldCost + param3.goldPerEnchantPoint * (param1 - param3.enchantValue);
         var _loc5_:int = param4.summaryGoldCost + param4.goldPerEnchantPoint * (param2 - param4.enchantValue);
         return _loc5_ - _loc6_;
      }
   }
}
