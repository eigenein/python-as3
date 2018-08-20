package game.model.user.arena
{
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   
   public interface IUnitEntryValueObjectTeamProvider
   {
       
      
      function getTeam(param1:int) : Vector.<UnitEntryValueObject>;
   }
}
