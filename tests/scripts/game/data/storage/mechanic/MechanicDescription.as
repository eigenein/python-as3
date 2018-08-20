package game.data.storage.mechanic
{
   import game.data.storage.level.LevelRequirement;
   
   public class MechanicDescription extends LevelRequirement
   {
       
      
      private var _type:String;
      
      private var _enabled:Boolean;
      
      private var _minHeroLevel:int;
      
      private var _mercenaryActivity:String;
      
      private var _teamType:String;
      
      private var _battleConfig:String;
      
      public function MechanicDescription(param1:Object)
      {
         super(param1);
         _type = param1.type;
         _minHeroLevel = param1.minHeroLevel;
         _mercenaryActivity = param1.mercenaryActivity;
         _battleConfig = param1.battleConfig;
         _enabled = int(param1.enabled) != 0;
         _teamType = param1.teamType;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get enabled() : Boolean
      {
         return _enabled;
      }
      
      public function get minHeroLevel() : int
      {
         return _minHeroLevel;
      }
      
      public function get mercenaryActivity() : String
      {
         return _mercenaryActivity;
      }
      
      public function get teamType() : String
      {
         return _teamType;
      }
      
      public function get battleConfig() : String
      {
         return _battleConfig;
      }
   }
}
