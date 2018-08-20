package game.mediator.gui.popup.hero.slot
{
   import battle.BattleStats;
   import battle.stats.ElementStats;
   import com.progrestar.common.lang.Translate;
   import game.mediator.gui.popup.hero.BattleStatValueObject;
   import game.model.user.hero.PlayerHeroArtifact;
   import game.model.user.hero.PlayerTitanArtifact;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class BattleStatValueObjectProvider
   {
      
      public static const PERCENT_STATS:Vector.<String> = new <String>["lifesteal"];
      
      public static const HIDDEN_STATS:Vector.<String> = new <String>["elementSpiritLevel"];
       
      
      public function BattleStatValueObjectProvider()
      {
         super();
      }
      
      public static function fromBattleStats(param1:BattleStats) : Vector.<BattleStatValueObject>
      {
         var _loc4_:* = false;
         var _loc3_:Vector.<BattleStatValueObject> = new Vector.<BattleStatValueObject>();
         var _loc5_:Object = param1.serialize();
         var _loc7_:int = 0;
         var _loc6_:* = _loc5_;
         for(var _loc2_ in _loc5_)
         {
            _loc4_ = PERCENT_STATS.indexOf(_loc2_) != -1;
            _loc3_.push(new BattleStatValueObject(_loc2_,_loc5_[_loc2_],_loc5_[_loc2_] is int,_loc4_));
         }
         _loc3_.sort(sortStats);
         return _loc3_;
      }
      
      public static function fromElementStats(param1:ElementStats) : Vector.<BattleStatValueObject>
      {
         var _loc3_:* = false;
         var _loc5_:* = false;
         var _loc4_:Vector.<BattleStatValueObject> = new Vector.<BattleStatValueObject>();
         var _loc6_:Object = param1.serialize();
         var _loc8_:int = 0;
         var _loc7_:* = _loc6_;
         for(var _loc2_ in _loc6_)
         {
            _loc3_ = HIDDEN_STATS.indexOf(_loc2_) != -1;
            if(!_loc3_)
            {
               _loc5_ = PERCENT_STATS.indexOf(_loc2_) != -1;
               _loc4_.push(new BattleStatValueObject(_loc2_,_loc6_[_loc2_],_loc6_[_loc2_] is int,_loc5_));
            }
         }
         _loc4_.sort(sortStats);
         return _loc4_;
      }
      
      public static function calculateDiff(param1:Vector.<BattleStatValueObject>, param2:Vector.<BattleStatValueObject>) : Vector.<BattleStatValueObject>
      {
         var _loc7_:int = 0;
         var _loc9_:Boolean = false;
         var _loc10_:* = null;
         var _loc5_:int = 0;
         var _loc8_:* = null;
         var _loc6_:Vector.<BattleStatValueObject> = new Vector.<BattleStatValueObject>();
         var _loc4_:int = param2.length;
         var _loc3_:int = param1.length;
         _loc7_ = 0;
         while(_loc7_ < _loc4_)
         {
            _loc9_ = false;
            _loc10_ = param2[_loc7_];
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc8_ = param1[_loc5_];
               if(_loc8_.ident == _loc10_.ident)
               {
                  _loc9_ = true;
                  if(!_loc10_.equals(_loc8_))
                  {
                     _loc6_.push(_loc10_.diff(_loc8_));
                  }
                  break;
               }
               _loc5_++;
            }
            if(!_loc9_)
            {
               _loc6_.push(_loc10_.clone());
            }
            _loc7_++;
         }
         _loc6_.sort(sortStats);
         return _loc6_;
      }
      
      public static function getArtifactStats(param1:PlayerHeroArtifact, param2:Boolean, param3:Boolean, param4:Boolean = true) : String
      {
         var _loc9_:* = undefined;
         var _loc6_:* = undefined;
         var _loc5_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         if(param1.awakened)
         {
            _loc6_ = param1.desc.getStatValueObjects(param1.stars,param1.level);
            _loc5_ = null;
            if(param2 || param3)
            {
               _loc5_ = param1.desc.getStatValueObjects(param1.stars + (!!param2?1:0),param1.level + (!!param3?1:0));
            }
            _loc9_ = foldStats(_loc6_,_loc5_,foldStatCurrentNext,param4);
         }
         else
         {
            _loc7_ = param1.desc.getStatValueObjects(1,1);
            _loc8_ = param1.desc.getStatValueObjects(param1.maxEvolutionStar.star,param1.maxLevelData.level);
            _loc9_ = foldStats(_loc7_,_loc8_,foldStatFromTo,param4);
         }
         return _loc9_.join("\n");
      }
      
      public static function getTitanArtifactStats(param1:PlayerTitanArtifact, param2:Boolean, param3:Boolean, param4:Boolean = true, param5:Boolean = false) : String
      {
         var _loc11_:* = undefined;
         var _loc8_:* = undefined;
         var _loc7_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc6_:String = "";
         if(param1.awakened)
         {
            _loc8_ = param1.desc.getStatValueObjects(param1.stars,param1.level,param5);
            _loc7_ = null;
            if(param2 || param3)
            {
               _loc7_ = param1.desc.getStatValueObjects(param1.stars + (!!param2?1:0),param1.level + (!!param3?1:0),param5);
            }
            _loc11_ = foldStats(_loc8_,_loc7_,foldStatCurrentNext,param4);
         }
         else
         {
            _loc9_ = param1.desc.getStatValueObjects(1,1,param5);
            _loc10_ = param1.desc.getStatValueObjects(param1.maxEvolutionStar.star,param1.maxLevelData.level,param5);
            _loc11_ = foldStats(_loc9_,_loc10_,foldStatFromTo,param4);
         }
         return _loc11_.join("\n");
      }
      
      private static function foldStats(param1:Vector.<BattleStatValueObject>, param2:Vector.<BattleStatValueObject>, param3:Function, param4:Boolean = true) : Vector.<String>
      {
         var _loc6_:int = 0;
         var _loc7_:* = null;
         var _loc5_:Vector.<String> = new Vector.<String>();
         var _loc8_:int = param1.length;
         if(param2 && param2.length < param1.length)
         {
            _loc8_ = param2.length;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc8_)
         {
            if(param2 == null || param1[_loc6_].ident == param2[_loc6_].ident)
            {
               _loc7_ = param3(param1[_loc6_],param2 == null?null:param2[_loc6_]);
               if(param4)
               {
                  _loc7_ = ColorUtils.hexToRGBFormat(16568453) + param1[_loc6_].name + ": " + _loc7_;
               }
               _loc5_.push(_loc7_);
            }
            _loc6_++;
         }
         return _loc5_;
      }
      
      private static function foldStatFromTo(param1:BattleStatValueObject, param2:BattleStatValueObject) : String
      {
         return ColorUtils.hexToRGBFormat(16645626) + Translate.translateArgs("UI_DIALOG_FROM_TO_ONE_LINE",param1.value,param2.value);
      }
      
      private static function foldStatCurrentNext(param1:BattleStatValueObject, param2:BattleStatValueObject) : String
      {
         var _loc3_:* = 0;
         if(param2 && param2.value != param1.value)
         {
            _loc3_ = Number(Math.round(param2.statValue - param1.statValue));
         }
         if(_loc3_ != 0)
         {
            return ColorUtils.hexToRGBFormat(16645626) + "+" + param1.value + ColorUtils.hexToRGBFormat(15919178) + " +" + _loc3_;
         }
         return ColorUtils.hexToRGBFormat(16645626) + "+" + param1.value;
      }
      
      public static function sortStats(param1:BattleStatValueObject, param2:BattleStatValueObject) : int
      {
         return param1.priority - param2.priority;
      }
   }
}
