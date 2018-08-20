package battle.skills
{
   import battle.BattleEngine;
   import battle.BattlePrint;
   import battle.proxy.ISceneProxy;
   
   public class Context
   {
      
      public static var scene:ISceneProxy;
      
      public static var engine:BattleEngine;
      
      public static var printer:BattlePrint;
       
      
      public function Context()
      {
      }
   }
}
