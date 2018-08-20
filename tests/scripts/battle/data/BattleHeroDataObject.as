package battle.data
{
   import battle.HeroStats;
   import flash.Boot;
   
   public class BattleHeroDataObject extends HeroStats
   {
       
      
      public var skin:int;
      
      public var scale:Number;
      
      public var name:String;
      
      public var level:int;
      
      public var id:int;
      
      public var elementSpiritPower:Number;
      
      public var elementSpiritLevel:int;
      
      public var elementAttack:Number;
      
      public var elementArmor:Number;
      
      public var element:String;
      
      public function BattleHeroDataObject(param1:MainStat = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         elementSpiritPower = 0;
         elementSpiritLevel = 0;
         elementArmor = 0;
         elementAttack = 0;
         element = null;
         scale = 0;
         skin = 0;
         level = 0;
         name = null;
         id = 0;
         super(param1);
      }
   }
}
