package game.view.popup.activity
{
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import game.command.timer.GameTimer;
   import game.model.user.Player;
   import game.util.TimeFormatter;
   
   public class QuestEventValueObjectBase
   {
       
      
      protected var player:Player;
      
      protected var _canFarm:BooleanPropertyWriteable;
      
      public function QuestEventValueObjectBase(param1:Player)
      {
         _canFarm = new BooleanPropertyWriteable(false);
         super();
         this.player = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function get hasEndTime() : Boolean
      {
         return false;
      }
      
      public function get endTime() : Number
      {
         return 0;
      }
      
      public function get name() : String
      {
         return null;
      }
      
      public function get desc() : String
      {
         return "";
      }
      
      public function get iconAsset() : String
      {
         return "";
      }
      
      public function get backgroundAsset() : String
      {
         return "";
      }
      
      public function get sortOrder() : int
      {
         return 0;
      }
      
      public function get canFarmSortIgnore() : Boolean
      {
         return false;
      }
      
      public function get canFarm() : BooleanProperty
      {
         return _canFarm;
      }
      
      public function get timeLeft() : Number
      {
         if(hasEndTime)
         {
            return endTime - GameTimer.instance.currentServerTime;
         }
         return 0;
      }
      
      public function get timeString() : String
      {
         if(timeLeft > 86400)
         {
            return TimeFormatter.toDH(timeLeft,"{d} {h}"," ",true);
         }
         if(timeLeft > 3600)
         {
            return TimeFormatter.toDH(timeLeft,"{h}:{m}"," ",true);
         }
         return TimeFormatter.toDH(timeLeft,"{m}:{s}"," ",true);
      }
   }
}
