package battle.action
{
   import battle.HeroStats;
   import flash.Boot;
   
   public class ActionPA extends Action
   {
       
      
      public function ActionPA(param1:* = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1);
      }
      
      override public function getValue(param1:HeroStats, param2:int) : Number
      {
         return Number(Number(param1.physicalAttack * K + scale * param2) + c);
      }
      
      override public function getBase() : String
      {
         return "PA";
      }
   }
}
