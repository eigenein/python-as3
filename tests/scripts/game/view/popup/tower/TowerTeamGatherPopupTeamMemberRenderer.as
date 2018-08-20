package game.view.popup.tower
{
   import game.mediator.gui.popup.team.TeamGatherPopupHeroValueObject;
   import game.mediator.gui.popup.tower.TowerTeamGatherHeroValueObject;
   
   public class TowerTeamGatherPopupTeamMemberRenderer extends TowerTeamGatherPopupHeroRenderer
   {
       
      
      public function TowerTeamGatherPopupTeamMemberRenderer()
      {
         super();
      }
      
      override protected function updateState(param1:TeamGatherPopupHeroValueObject) : void
      {
         var _loc3_:TowerTeamGatherHeroValueObject = param1 as TowerTeamGatherHeroValueObject;
         updateHeroBattleState(_loc3_);
         var _loc2_:Boolean = _loc3_ && _loc3_.isAvailable;
         var _loc4_:Boolean = !!_loc3_?_loc3_.isEmpty:true;
         button.isEnabled = _loc2_;
         checkIcon.visible = false;
         state.disabled = _loc4_;
         portrait.disabled = _loc4_;
         portrait.visible = !_loc4_;
         emptySlot.visible = _loc4_;
      }
   }
}
