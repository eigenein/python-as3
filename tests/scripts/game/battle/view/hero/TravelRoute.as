package game.battle.view.hero
{
   import flash.geom.Point;
   import game.battle.controller.entities.BattleHero;
   
   public class TravelRoute extends Point
   {
       
      
      public var duration:Number;
      
      public function TravelRoute()
      {
         super();
      }
      
      public function setTarget(param1:BattleHero, param2:Boolean = false) : void
      {
         x = HeroTeamPlacer.getX(param1);
         y = HeroTeamPlacer.getY(param1.hero.getTeamPosition() + (!!param2?1:0));
      }
      
      public function updateDuration(param1:HeroView, param2:Number) : void
      {
         var _loc3_:Number = (x - param1.position.x) * (x - param1.position.x) + (y - param1.position.y) * (y - param1.position.y);
         duration = Math.sqrt(_loc3_) / param2;
      }
   }
}
