package game.data.storage.level
{
   public class LevelBase
   {
       
      
      public var level:int;
      
      public var exp:int;
      
      public var nextLevel:LevelBase;
      
      public var prevLevel:LevelBase;
      
      public function LevelBase(param1:Object)
      {
         super();
         level = param1.level;
         exp = param1.exp;
      }
   }
}
