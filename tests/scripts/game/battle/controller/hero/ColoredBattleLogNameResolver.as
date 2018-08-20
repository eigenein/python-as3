package game.battle.controller.hero
{
   import flash.utils.Dictionary;
   import game.mediator.gui.popup.hero.skill.SkillTooltipMessageFactory;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class ColoredBattleLogNameResolver extends GameBattleLogNameResolver
   {
       
      
      private var _default:String;
      
      private var _hero:String;
      
      private var _skill:String;
      
      private var _damagePhysical:String;
      
      private var _damageMagic:String;
      
      public function ColoredBattleLogNameResolver(param1:Dictionary)
      {
         _default = BattleInspectorLog.DEFAULT_COLOR;
         _hero = ColorUtils.hexToRGBFormat(16777215);
         _skill = ColorUtils.hexToRGBFormat(16777215);
         _damagePhysical = SkillTooltipMessageFactory.colorBasePA;
         _damageMagic = SkillTooltipMessageFactory.colorBaseMP;
         super(param1);
      }
      
      override public function hero(param1:int) : String
      {
         return _hero + super.hero(param1) + _default;
      }
      
      override public function skill(param1:int, param2:int) : String
      {
         return _skill + super.skill(param1,param2) + _default;
      }
   }
}
