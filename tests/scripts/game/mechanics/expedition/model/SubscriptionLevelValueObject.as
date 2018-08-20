package game.mechanics.expedition.model
{
   import game.data.storage.subscription.SubscriptionLevelDescription;
   
   public class SubscriptionLevelValueObject
   {
       
      
      public var currentLevel:int;
      
      public var lastLevel:int;
      
      private var _level:SubscriptionLevelDescription;
      
      public function SubscriptionLevelValueObject(param1:SubscriptionLevelDescription)
      {
         super();
         this._level = param1;
      }
      
      public function get level() : SubscriptionLevelDescription
      {
         return _level;
      }
   }
}
