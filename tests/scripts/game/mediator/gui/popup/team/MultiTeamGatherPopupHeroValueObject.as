package game.mediator.gui.popup.team
{
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   
   public class MultiTeamGatherPopupHeroValueObject extends TeamGatherPopupHeroValueObject
   {
       
      
      private var _currentTeam:int = -1;
      
      public function MultiTeamGatherPopupHeroValueObject(param1:MultiTeamGatherPopupMediator, param2:UnitEntryValueObject)
      {
         super(param1,param2);
      }
      
      public function set currentTeam(param1:int) : void
      {
         _currentTeam = param1;
      }
      
      public function get currentTeam() : int
      {
         return _currentTeam;
      }
      
      public function get currentTeamString() : String
      {
         return String(_currentTeam + 1);
      }
      
      public function get inCurrentTeam() : Boolean
      {
         return (mediator as MultiTeamGatherPopupMediator).selectedTeam.value == _currentTeam;
      }
   }
}
