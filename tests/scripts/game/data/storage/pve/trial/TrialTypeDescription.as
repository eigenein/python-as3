package game.data.storage.pve.trial
{
   import game.data.storage.DataStorage;
   import game.data.storage.DescriptionBase;
   import game.data.storage.refillable.RefillableDescription;
   
   public class TrialTypeDescription extends DescriptionBase
   {
       
      
      private var _type:String;
      
      private var _day:Array;
      
      private var _perk:int;
      
      private var _tries:RefillableDescription;
      
      private var _cooldown:RefillableDescription;
      
      private var _questType:int;
      
      public function TrialTypeDescription(param1:Object)
      {
         super();
         _type = param1.type;
         _day = param1.day;
         _perk = param1.perk;
         _questType = param1.questType;
         _tries = DataStorage.refillable.getById(param1.tries) as RefillableDescription;
         _cooldown = DataStorage.refillable.getById(param1.cooldown) as RefillableDescription;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get day() : Array
      {
         return _day;
      }
      
      public function get perk() : int
      {
         return _perk;
      }
      
      public function get tries() : RefillableDescription
      {
         return _tries;
      }
      
      public function get cooldown() : RefillableDescription
      {
         return _cooldown;
      }
      
      public function get questType() : int
      {
         return _questType;
      }
   }
}
