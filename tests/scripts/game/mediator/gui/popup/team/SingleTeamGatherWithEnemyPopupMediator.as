package game.mediator.gui.popup.team
{
   import game.data.storage.mechanic.MechanicDescription;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   import game.view.popup.team.ArenaAttackTeamGatherPopupWithEnemyTeam;
   
   public class SingleTeamGatherWithEnemyPopupMediator extends TeamGatherByActivityPopupMediator
   {
       
      
      public function SingleTeamGatherWithEnemyPopupMediator(param1:Player, param2:MechanicDescription)
      {
         super(param1,param2);
      }
      
      public function get enemyTeam() : Vector.<UnitEntryValueObject>
      {
         throw new Error("abstract method! ノಥ益ಥ）ノ︵┻━┻ ");
      }
      
      public function get enemyTeamPower() : int
      {
         throw new Error("abstract method! （╯°□°）╯︵┻━┻ ");
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ArenaAttackTeamGatherPopupWithEnemyTeam(this);
         return _popup;
      }
   }
}
