package battle.action
{
   import battle.HeroStats;
   import flash.Boot;
   
   public class ActionMP extends Action
   {
       
      
      public function ActionMP(param1:* = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1);
      }
      
      override public function getValue(param1:HeroStats, param2:int) : Number
      {
         return Number(Number(param1.magicPower * K + scale * param2) + c);
      }
      
      override public function getBase() : String
      {
         return "MP";
      }
   }
}
