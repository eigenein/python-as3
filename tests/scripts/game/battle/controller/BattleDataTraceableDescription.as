package game.battle.controller
{
   public class BattleDataTraceableDescription
   {
       
      
      public var seed:uint;
      
      public var description:String;
      
      public var result:String;
      
      public function BattleDataTraceableDescription(param1:uint, param2:String)
      {
         super();
         this.seed = param1;
         this.description = param2;
      }
      
      public function printWithResult(param1:String) : void
      {
         this.result = param1;
         print();
      }
      
      public function print() : void
      {
      }
   }
}
