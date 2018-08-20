package game.mediator.gui.popup.billing.bundle
{
   import game.data.storage.skills.SkillDescription;
   import game.mediator.gui.popup.hero.skill.SkillTooltipMessageFactory;
   
   public class BundleSkillValueObject
   {
       
      
      private var f:SkillTooltipMessageFactory;
      
      private var _level:int;
      
      private var _desc:String;
      
      private var _skill:SkillDescription;
      
      public function BundleSkillValueObject(param1:SkillDescription, param2:SkillTooltipMessageFactory, param3:int = 80)
      {
         super();
         this._level = param3;
         this.f = param2;
         this._skill = param1;
      }
      
      public function get name() : String
      {
         return skill.name;
      }
      
      public function get desc() : String
      {
         return f.description(_level);
      }
      
      public function get skill() : SkillDescription
      {
         return _skill;
      }
   }
}
