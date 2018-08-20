package game.battle.view.hero
{
   import game.assets.battle.BattleAsset;
   
   public interface IBattleSubsystem
   {
       
      
      function dispose() : void;
      
      function requestAssets(param1:BattleAsset) : void;
      
      function advanceTime(param1:Number) : void;
      
      function startBattle(param1:BattleContext) : void;
      
      function endBattle() : void;
      
      function cleanUpBattle() : void;
   }
}
