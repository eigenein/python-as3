package game.model.user.artifactchest
{
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.model.user.Player;
   import idv.cjcat.signals.Signal;
   
   public class PlayerArtifactChest
   {
       
      
      private var _level:uint;
      
      private var _experience:uint;
      
      private var _prevExperienceValue:uint;
      
      private var _starmoneySpent:uint;
      
      private var _signal_experienceChange:Signal;
      
      private var _signal_levelChange:Signal;
      
      private var _signal_starmoneySpent:Signal;
      
      public function PlayerArtifactChest()
      {
         _signal_experienceChange = new Signal();
         _signal_levelChange = new Signal();
         _signal_starmoneySpent = new Signal();
         super();
      }
      
      public function get level() : uint
      {
         return _level;
      }
      
      public function get experience() : uint
      {
         return _experience;
      }
      
      public function get prevExperienceValue() : uint
      {
         return _prevExperienceValue;
      }
      
      public function get starmoneySpent() : uint
      {
         return _starmoneySpent;
      }
      
      public function set starmoneySpent(param1:uint) : void
      {
         _starmoneySpent = param1;
         _signal_starmoneySpent.dispatch();
      }
      
      public function get signal_experienceChange() : Signal
      {
         return _signal_experienceChange;
      }
      
      public function get signal_levelChange() : Signal
      {
         return _signal_levelChange;
      }
      
      public function get signal_starmoneySpent() : Signal
      {
         return _signal_starmoneySpent;
      }
      
      public function getOpenCostX1(param1:Player) : CostData
      {
         return param1.specialOffer.costReplace.artifactChestX1(DataStorage.rule.artifactChestRule.openCostX1);
      }
      
      public function getOpenCostX10(param1:Player) : CostData
      {
         return param1.specialOffer.costReplace.artifactChestX10(DataStorage.rule.artifactChestRule.openCostX10);
      }
      
      public function getOpenCostX100(param1:Player) : CostData
      {
         return param1.specialOffer.costReplace.artifactChestX100(DataStorage.rule.artifactChestRule.openCostX100);
      }
      
      public function getOpenCostX10Free(param1:Player) : CostData
      {
         return param1.specialOffer.costReplace.artifactChestX10Free(DataStorage.rule.artifactChestRule.openCostX10Free);
      }
      
      public function initialize(param1:Object) : void
      {
         _starmoneySpent = param1.starmoneySpent;
         _level = param1.level;
         _experience = param1.xp;
      }
      
      public function update(param1:Object) : void
      {
         starmoneySpent = param1.starmoneySpent;
         if(param1.newLevel > 0)
         {
            if(param1.newLevel != level)
            {
               _level = param1.newLevel;
               signal_experienceChange.dispatch();
            }
         }
         if(param1.xp != experience)
         {
            _prevExperienceValue = _experience;
            _experience = param1.xp;
            signal_experienceChange.dispatch();
         }
      }
   }
}
