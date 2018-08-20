package game.battle.view.hero
{
   public interface IHeroViewContainer
   {
       
      
      function get scale() : Number;
      
      function get isoScale() : Number;
      
      function addHero(param1:HeroView) : void;
      
      function removeHero(param1:HeroView) : void;
   }
}
