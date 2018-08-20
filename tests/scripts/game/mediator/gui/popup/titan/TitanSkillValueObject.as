package game.mediator.gui.popup.titan
{
   import game.data.storage.skills.SkillDescription;
   import game.mediator.gui.popup.hero.skill.SkillTooltipValueObject;
   import game.model.user.hero.PlayerTitanEntry;
   import game.model.user.hero.UnitEntry;
   
   public class TitanSkillValueObject
   {
       
      
      private var _unit:UnitEntry;
      
      private var _skill:SkillDescription;
      
      public function TitanSkillValueObject(param1:UnitEntry, param2:SkillDescription)
      {
         super();
         _unit = param1;
         _skill = param2;
      }
      
      public function get skill() : SkillDescription
      {
         return _skill;
      }
      
      public function get tooltipVo() : SkillTooltipValueObject
      {
         var _loc1_:* = null;
         var _loc2_:SkillTooltipValueObject = new SkillTooltipValueObject(_unit,_skill);
         if(_unit is PlayerTitanEntry)
         {
            _loc1_ = _unit as PlayerTitanEntry;
            _loc2_.setup(_loc1_.level.level,false,true);
         }
         return _loc2_;
      }
   }
}
