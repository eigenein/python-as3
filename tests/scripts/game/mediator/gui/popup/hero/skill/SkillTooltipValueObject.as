package game.mediator.gui.popup.hero.skill
{
   import game.data.storage.skills.SkillDescription;
   import game.model.user.hero.UnitEntry;
   import org.osflash.signals.Signal;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class SkillTooltipValueObject
   {
       
      
      private var skill:SkillDescription;
      
      private var messageFactory:SkillTooltipMessageFactory;
      
      private var _showNextLevel:Boolean;
      
      private var _showName:Boolean;
      
      private var locale_desc:String;
      
      private var locale_param:String;
      
      private var locale_next:String;
      
      public const signal_update:Signal = new Signal();
      
      public function SkillTooltipValueObject(param1:UnitEntry, param2:SkillDescription)
      {
         super();
         this.skill = param2;
         messageFactory = new SkillTooltipMessageFactory(param1,param2);
      }
      
      public function get showParams() : Boolean
      {
         return true;
      }
      
      public function get showNextLevel() : Boolean
      {
         return _showNextLevel;
      }
      
      public function get showName() : Boolean
      {
         return _showName && skill.name && skill.name.length > 0;
      }
      
      public function get name() : String
      {
         return ColorUtils.hexToRGBFormat(16777215) + skill.name;
      }
      
      public function get description() : String
      {
         return locale_desc;
      }
      
      public function get param() : String
      {
         return locale_param;
      }
      
      public function get nextLevel() : String
      {
         return locale_next;
      }
      
      public function setup(param1:int, param2:Boolean, param3:Boolean) : void
      {
         this._showNextLevel = param2;
         this._showName = param3;
         if(param1 == 0)
         {
            param1 = skill.visibleLevelOffset;
            if(param1 == 0)
            {
               param1 = 1;
            }
         }
         locale_desc = messageFactory.description(param1);
         locale_param = messageFactory.params(param1);
         locale_next = messageFactory.nextLevel(param1);
         signal_update.dispatch();
      }
      
      public function getUpgradeMessage() : String
      {
         return messageFactory.upgrade();
      }
   }
}
