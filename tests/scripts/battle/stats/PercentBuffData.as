package battle.stats
{
   import battle.BattleStats;
   import flash.Boot;
   
   public class PercentBuffData
   {
       
      
      public var physicalAttack:Number;
      
      public var magicResist:Number;
      
      public var magicPower:Number;
      
      public var armor:Number;
      
      public var allAttacks:Number;
      
      public function PercentBuffData()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         allAttacks = 0;
         magicPower = 0;
         physicalAttack = 0;
         magicResist = 0;
         armor = 0;
      }
      
      public function apply(param1:BattleStats) : void
      {
         param1.armor = param1.armor * (1 + armor / 100);
         param1.magicResist = param1.magicResist * (1 + magicResist / 100);
         param1.physicalAttack = param1.physicalAttack * (Number(1 + physicalAttack / 100) + allAttacks / 100);
         param1.magicPower = param1.magicPower * (Number(1 + magicPower / 100) + allAttacks / 100);
      }
   }
}
