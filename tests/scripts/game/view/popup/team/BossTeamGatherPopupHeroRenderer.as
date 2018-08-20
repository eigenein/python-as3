package game.view.popup.team
{
   import game.mediator.gui.popup.team.TeamGatherPopupHeroValueObject;
   
   public class BossTeamGatherPopupHeroRenderer extends TeamGatherPopupHeroRenderer
   {
       
      
      public function BossTeamGatherPopupHeroRenderer()
      {
         super();
      }
      
      override protected function updateState(param1:TeamGatherPopupHeroValueObject) : void
      {
         var _loc2_:TeamGatherPopupHeroValueObject = param1 as TeamGatherPopupHeroValueObject;
         if(!_loc2_)
         {
            return;
         }
         button.isEnabled = _loc2_.isAvailable;
         checkIcon.visible = _loc2_ && _loc2_.selected;
         portrait.disabled = checkIcon.visible || !_loc2_.isEmpty && !_loc2_.isOwned;
         portrait.visible = !_loc2_.isEmpty;
         emptySlot.visible = !portrait.visible;
      }
   }
}
