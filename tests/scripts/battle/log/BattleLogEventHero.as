package battle.log
{
   import flash.Boot;
   
   public class BattleLogEventHero extends BattleLogEvent
   {
       
      
      public var heroId:int;
      
      public function BattleLogEventHero(param1:BattleLogReader = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1);
         heroId = int(param1.readInt16());
      }
   }
}
