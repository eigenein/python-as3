package game.battle.controller.hero
{
   import battle.BattleCore;
   import battle.Hero;
   import battle.HeroStats;
   import battle.skills.Effect;
   import battle.skills.Skill;
   import battle.skills.SkillCondition;
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.property.StringPropertyWriteable;
   import game.assets.storage.AssetStorage;
   import game.data.storage.DataStorage;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.tooltip.BattleInspectorTooltipText14View;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   import starling.display.DisplayObject;
   
   public class BattleHeroInspector
   {
      
      private static const NOT_FULLFILLED_SKILL_CONDITION_DESC_MAP:Object = {
         "fullEnergy":"нет энергии",
         "rangeOccupied":"нет цели",
         "allyTeamRange":"нет союзной цели",
         "canDoActions":"занят",
         "canUseSkills":"оглушение",
         "canUseMagic":"молчание",
         "canCastManual":"ультовать нельзя",
         "hasSkillToCast":"нечего скопировать",
         "has no spheres":"сфера уже есть",
         "healthThreshold":"уровень здоровья"
      };
      
      public static const SKILL_COLORS:Array = ["",ColorUtils.hexToRGBFormat(12038323),ColorUtils.hexToRGBFormat(7655003),ColorUtils.hexToRGBFormat(7446527),ColorUtils.hexToRGBFormat(14970366),"","","","","","",""];
      
      private static const _gray:String = ColorUtils.hexToRGBFormat(16573879);
      
      private static const _white:String = ColorUtils.hexToRGBFormat(16777215);
      
      private static const _red:String = ColorUtils.hexToRGBFormat(10823977);
      
      private static var statsByPriority:Array;
       
      
      private var hero:Hero;
      
      private var logInspector:BattleInspectorLog;
      
      private var initialStats:HeroStats;
      
      private var _button:ClipButton;
      
      private var _tooltipString:StringPropertyWriteable;
      
      private var _tooltip:TooltipVO;
      
      public function BattleHeroInspector(param1:Hero, param2:BattleInspectorLog)
      {
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         _button = AssetStorage.rsx.battle_interface.create(ClipButton,"BattleInspectorButton");
         _tooltipString = new StringPropertyWriteable();
         _tooltip = new TooltipVO(BattleInspectorTooltipText14View,_tooltipString);
         super();
         this.hero = param1;
         this.logInspector = param2;
         param2.registerHero(param1);
         initialStats = param1.desc.stats.cloneHeroStats();
         initialStats.processHeroStats();
         _button.graphics.x = 0;
         _button.graphics.y = -50;
         _button.signal_click.add(handler_click);
         TooltipHelper.addTooltip(_button.graphics,_tooltip);
         if(statsByPriority == null)
         {
            statsByPriority = [];
            _loc4_ = [];
            var _loc8_:int = 0;
            var _loc7_:* = DataStorage.rule.battleStatDataPriority;
            for(var _loc3_ in DataStorage.rule.battleStatDataPriority)
            {
               if(initialStats.hasOwnProperty(_loc3_))
               {
                  _loc6_ = DataStorage.rule.battleStatDataPriority[_loc3_];
                  _loc4_[_loc6_] = _loc3_;
               }
            }
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               if(_loc4_[_loc5_])
               {
                  statsByPriority.push(_loc4_[_loc5_]);
               }
               _loc5_++;
            }
         }
      }
      
      public function get graphics() : DisplayObject
      {
         return _button.graphics;
      }
      
      public function get tooltip() : TooltipVO
      {
         return _tooltip;
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:String = getFormatedStats();
         var _loc4_:Number = hero.getVisualPosition();
         _loc2_ = _loc2_ + ("\n\n" + _gray + "x = " + _white + _loc4_.toFixed(2));
         if(hero.body.vx != 0)
         {
            _loc3_ = hero.body.vx;
            _loc2_ = _loc2_ + (" vx = " + _loc3_.toFixed(2));
         }
         if(!hero.canMove.enabled)
         {
            _loc2_ = _loc2_ + ", не управляет своим перемещением";
         }
         else if(!hero.canWalk.enabled)
         {
            _loc2_ = _loc2_ + ", не может начать идти";
         }
         _loc2_ = _loc2_ + ("\n\n" + getCooldownsText());
         _loc2_ = _loc2_ + ("\n\n" + getEffectsTextList());
         logInspector.advanceTime(param1);
         _tooltipString.value = _loc2_;
      }
      
      protected function getFormatedStats() : String
      {
         var _loc6_:Number = NaN;
         var _loc8_:* = null;
         var _loc7_:Number = NaN;
         var _loc3_:* = null;
         var _loc4_:HeroStats = hero.updatedStats();
         var _loc5_:Boolean = true;
         var _loc1_:Array = [];
         var _loc10_:int = 0;
         var _loc9_:* = statsByPriority;
         for each(var _loc2_ in statsByPriority)
         {
            _loc6_ = _loc4_[_loc2_];
            if(_loc6_ != 0)
            {
               _loc8_ = "LIB_BATTLESTATDATA_" + _loc2_.toUpperCase();
               if(Translate.has(_loc8_))
               {
                  _loc7_ = initialStats[_loc2_];
                  _loc3_ = _gray + Translate.translate(_loc8_) + ": " + _white + statToString(_loc6_);
                  if(_loc2_ == "armor" || _loc2_ == "magicResist")
                  {
                     _loc3_ = _loc3_ + (_gray + " (-" + (int(100 - 100 / (1 + int(_loc6_) / BattleCore.ARMOR_SCALE_FACTOR))) + "%)");
                  }
                  if(initialStats[_loc2_] != _loc6_)
                  {
                     if(_loc5_)
                     {
                        _loc5_ = false;
                        _loc3_ = _loc3_ + (_gray + " (" + statToString(initialStats[_loc2_]) + " первоначально)");
                     }
                     else
                     {
                        _loc3_ = _loc3_ + (_gray + " (" + statToString(initialStats[_loc2_]) + ")");
                     }
                  }
                  _loc1_.push(_loc3_);
               }
            }
         }
         return _loc1_.join("\n");
      }
      
      protected function getEffectsTextList() : String
      {
         var _loc4_:* = null;
         if(hero.effects.effects.length == 0)
         {
            return "\n";
         }
         var _loc2_:String = "Эффекты на герое" + _gray + "\n";
         var _loc1_:Vector.<Effect> = hero.effects.effects;
         var _loc6_:int = 0;
         var _loc5_:* = _loc1_;
         for each(var _loc3_ in _loc1_)
         {
            _loc2_ = _loc2_ + (_white + _loc3_.ident + _gray + (_loc3_.execution && _loc3_.execution.hasOwnProperty("hp") && _loc3_.execution.hp?"(" + int(_loc3_.execution.hp) + ")":""));
            if(_loc3_.skillCast.skill != null)
            {
               _loc4_ = SKILL_COLORS[_loc3_.skillCast.skill.tier];
               if(_loc3_.skillCast.hero != null)
               {
                  _loc2_ = _loc2_ + (" от " + _loc4_ + _loc3_.skillCast.skill.tier + " скила" + _gray + " героя " + _white + _loc3_.skillCast.hero.desc.name + _gray);
               }
               else
               {
                  _loc2_ = _loc2_ + (" от " + _loc4_ + _loc3_.skillCast.skill.tier + " скила" + _gray + " не героя " + _gray);
               }
            }
            _loc2_ = _loc2_ + "\n";
         }
         return _loc2_;
      }
      
      protected function getCooldownsText() : String
      {
         var _loc2_:* = NaN;
         var _loc8_:* = null;
         var _loc7_:* = undefined;
         var _loc5_:* = null;
         var _loc6_:String = "";
         var _loc1_:Vector.<Skill> = hero.skills.skills;
         var _loc12_:int = 0;
         var _loc11_:* = _loc1_;
         for each(var _loc3_ in _loc1_)
         {
            _loc2_ = Number(_loc3_.nextCastTime - hero.engine.timeline.time);
            if(_loc2_ < 1000)
            {
               if(_loc2_ < 0)
               {
                  _loc2_ = 0;
               }
               _loc8_ = "";
               _loc7_ = _loc3_.conditions;
               var _loc10_:int = 0;
               var _loc9_:* = _loc7_;
               for each(var _loc4_ in _loc7_)
               {
                  if(!_loc4_.check())
                  {
                     if(_loc8_.length > 0)
                     {
                        _loc8_ = _loc8_ + ", ";
                     }
                     else
                     {
                        _loc8_ = _loc8_ + " ";
                     }
                     _loc8_ = _loc8_ + (_red + NOT_FULLFILLED_SKILL_CONDITION_DESC_MAP[_loc4_._name] + _gray);
                  }
               }
               _loc5_ = _loc3_.range != null?" (" + _loc3_.range.getRadius() + ") ":"";
               _loc6_ = _loc6_ + (_gray + _loc3_.desc.tier + ":" + _loc3_.desc.level + ": " + _white + _loc2_.toFixed(1) + _gray + "/" + _loc3_.desc.cooldown + _loc8_ + _loc5_ + "\n");
            }
         }
         return _loc6_;
      }
      
      private function statToString(param1:Number) : String
      {
         if(param1 != Math.round(param1))
         {
            return param1.toFixed(2);
         }
         return String(param1);
      }
      
      private function handler_click() : void
      {
         logInspector.showLog.toggle();
      }
   }
}
