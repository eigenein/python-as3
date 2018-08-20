package game.view.gui.tutorial.tutorialtarget
{
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.pve.mission.MissionDescription;
   import game.data.storage.quest.QuestDescription;
   import game.data.storage.skills.SkillDescription;
   
   public class TutorialTarget
   {
       
      
      private var validKeys:Vector.<ITutorialTargetKey>;
      
      public function TutorialTarget()
      {
         super();
      }
      
      public function get unit() : UnitDescription
      {
         return getKeyOfClass(UnitDescription);
      }
      
      public function get skill() : SkillDescription
      {
         return getKeyOfClass(SkillDescription);
      }
      
      public function get quest() : QuestDescription
      {
         return getKeyOfClass(QuestDescription);
      }
      
      public function get mission() : MissionDescription
      {
         return getKeyOfClass(MissionDescription);
      }
      
      public function set unit(param1:UnitDescription) : void
      {
         return setKeyOfClass(UnitDescription,param1);
      }
      
      public function set skill(param1:SkillDescription) : void
      {
         return setKeyOfClass(SkillDescription,param1);
      }
      
      public function setKeys(param1:ITutorialTargetKey, param2:ITutorialTargetKey = null, param3:ITutorialTargetKey = null, param4:ITutorialTargetKey = null) : void
      {
         validKeys = new <ITutorialTargetKey>[param1];
         if(param2)
         {
            validKeys.push(param2);
         }
         if(param3)
         {
            validKeys.push(param3);
         }
         if(param4)
         {
            validKeys.push(param4);
         }
      }
      
      public function resolves(param1:ITutorialTargetKey) : Boolean
      {
         return param1 == null || validKeys == null || validKeys.indexOf(param1) != -1;
      }
      
      protected function getKeyOfClass(param1:Class) : *
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function setKeyOfClass(param1:Class, param2:*) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
   }
}
