package game.data.storage.quest
{
   import game.data.reward.RewardData;
   import game.data.storage.DescriptionBase;
   import game.view.gui.tutorial.tutorialtarget.ITutorialTargetKey;
   
   public class QuestDescription extends DescriptionBase implements ITutorialTargetKey
   {
       
      
      private var _farmCondition:QuestConditionDescription;
      
      private var _reward:RewardData;
      
      private var _translationMethod:String;
      
      private var _hidden:Boolean;
      
      private var _localeTaskDescription:String;
      
      public function QuestDescription(param1:Object)
      {
         super();
         _id = param1.id;
         _farmCondition = new QuestConditionDescription(param1.farmCondition);
         _reward = new RewardData(param1.reward);
         _translationMethod = param1.translationMethod;
         _hidden = param1.hidden;
      }
      
      public function get farmCondition() : QuestConditionDescription
      {
         return _farmCondition;
      }
      
      public function get reward() : RewardData
      {
         return _reward;
      }
      
      public function get translationMethod() : String
      {
         return _translationMethod;
      }
      
      public function get hidden() : Boolean
      {
         return _hidden;
      }
      
      public function get localeTaskDescription() : String
      {
         return _localeTaskDescription;
      }
      
      function setLocaleTaskDescription(param1:String) : void
      {
         if(_localeTaskDescription == param1)
         {
            return;
         }
         _localeTaskDescription = param1;
      }
   }
}
