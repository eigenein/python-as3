package game.view.popup.team
{
   import com.progrestar.common.lang.Translate;
   import game.mediator.gui.popup.team.MultiTeamGatherPopupMediator;
   
   public class MultiTeamGatherPopup extends TeamGatherPopup
   {
       
      
      private var selector:MultiTeamGatherSelectorBlock;
      
      public function MultiTeamGatherPopup(param1:MultiTeamGatherPopupMediator)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         selector.dispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
      }
      
      protected function initTeamSelector(param1:MultiTeamGatherPopupMediator, param2:GrandTeamSelectorClip) : void
      {
         selector = new MultiTeamGatherSelectorBlock(param1,param2);
      }
      
      override protected function heroListItemRendererFactory() : TeamGatherPopupHeroRenderer
      {
         var _loc1_:MultiTeamGatherPopupHeroRenderer = new MultiTeamGatherPopupHeroRenderer();
         return _loc1_;
      }
      
      protected function getCompleteButtonHint(param1:MultiTeamGatherPopupMediator) : String
      {
         if(param1.canComplete.value)
         {
            return Translate.translateArgs("UI_DIALOG_GRAND_GATHER_SELECTED_HEROES",param1.selectedHeroesCount,param1.teamCount * param1.maxTeamLength);
         }
         return Translate.translate("UI_DIALOG_GRAND_GATHER_NOT_SELECTED_HEROES");
      }
   }
}
