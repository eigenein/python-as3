package battle.log
{
   import flash.Boot;
   
   public class BattleLogEventHero2 extends BattleLogEventHero
   {
       
      
      public var hero2Id:int;
      
      public function BattleLogEventHero2(param1:BattleLogReader = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1);
         hero2Id = int(param1.readInt16());
      }
   }
}
