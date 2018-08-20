package game.battle.controller.entities
{
   import battle.objects.BattleEntity;
   
   public interface IBattleEntityMediator
   {
       
      
      function dispose() : void;
      
      function setEntity(param1:BattleEntity) : void;
      
      function removeEntity() : void;
      
      function advanceTime(param1:Number) : void;
   }
}
