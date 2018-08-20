package game.view.popup.team
{
   import feathers.controls.List;
   import feathers.layout.HorizontalLayout;
   import game.mediator.gui.popup.team.TeamGatherPopupMediator;
   
   public class TeamGatherPopupTeamList extends List
   {
       
      
      private var mediator:TeamGatherPopupMediator;
      
      public function TeamGatherPopupTeamList(param1:TeamGatherPopupMediator)
      {
         super();
         this.mediator = param1;
         itemRendererType = TeamGatherPopupTeamMemberRenderer;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:HorizontalLayout = new HorizontalLayout();
         _loc1_.gap = 8;
         _loc1_.verticalAlign = "middle";
         layout = _loc1_;
         interactionMode = "mouse";
         scrollBarDisplayMode = "fixed";
         horizontalScrollPolicy = "off";
         verticalScrollPolicy = "on";
      }
   }
}
