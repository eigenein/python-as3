package game.data.storage.level
{
   import game.data.storage.DescriptionBase;
   
   public class LevelRequirement extends DescriptionBase
   {
       
      
      protected var _teamLevel:int;
      
      public function LevelRequirement(param1:Object)
      {
         super();
         _teamLevel = param1.teamLevel;
      }
      
      public function get teamLevel() : int
      {
         return _teamLevel;
      }
   }
}
