package game.battle.view.hero
{
   import game.battle.controller.entities.BattleHero;
   
   public class HeroTeamPlacer
   {
      
      private static const sortingList:Vector.<BattleHero> = new Vector.<BattleHero>();
      
      public static const INITIAL_Y_VARIATION:Number = 80;
       
      
      public var heroes:Vector.<BattleHero>;
      
      public var routes:Vector.<TravelRoute>;
      
      public function HeroTeamPlacer()
      {
         heroes = new Vector.<BattleHero>();
         routes = new Vector.<TravelRoute>();
         super();
      }
      
      public static function getX(param1:BattleHero) : Number
      {
         return param1.hero.getVisualPosition();
      }
      
      public static function getY(param1:int) : Number
      {
         return param1 % 2 * 80 + 0.01 * Math.random();
      }
      
      public function add(param1:BattleHero, param2:TravelRoute) : void
      {
         heroes.push(param1);
         routes.push(param2);
      }
      
      public function getIndexDecision() : Boolean
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
   }
}
