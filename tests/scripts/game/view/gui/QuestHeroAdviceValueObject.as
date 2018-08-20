package game.view.gui
{
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.quest.QuestHeroAdviceDescription;
   import game.model.user.quest.PlayerQuestEntry;
   
   public class QuestHeroAdviceValueObject
   {
       
      
      private var _quest:PlayerQuestEntry;
      
      private var _hero:UnitDescription;
      
      private var _advice:QuestHeroAdviceDescription;
      
      public function QuestHeroAdviceValueObject(param1:PlayerQuestEntry, param2:UnitDescription, param3:QuestHeroAdviceDescription)
      {
         super();
         this._advice = param3;
         this._hero = param2;
         this._quest = param1;
      }
      
      public function get quest() : PlayerQuestEntry
      {
         return _quest;
      }
      
      public function get hero() : UnitDescription
      {
         return _hero;
      }
      
      public function get advice() : QuestHeroAdviceDescription
      {
         return _advice;
      }
      
      public function get text() : String
      {
         return _advice.name;
      }
      
      public function get questText() : String
      {
         return _quest.desc.localeTaskDescription;
      }
   }
}
