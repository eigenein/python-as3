package game.mediator.gui.popup.team
{
   import game.data.storage.mechanic.MechanicDescription;
   import game.model.user.Player;
   
   public class StateBasedTeamGatherPopupMediator extends SingleTeamGatherWithEnemyPopupMediator
   {
       
      
      public function StateBasedTeamGatherPopupMediator(param1:Player, param2:MechanicDescription)
      {
         super(param1,param2);
      }
   }
}
