package game.view.popup.team
{
   import feathers.controls.List;
   import feathers.layout.TiledRowsLayout;
   import game.mediator.gui.popup.team.TeamGatherPopupMediator;
   import game.view.gui.components.GameScrolledList;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.ClipBasedPopup;
   import starling.display.DisplayObjectContainer;
   
   public class TeamGatherPopup extends ClipBasedPopup implements ITutorialNodePresenter
   {
       
      
      protected var mediator:TeamGatherPopupMediator;
      
      protected var teamList:TeamGatherPopupTeamList;
      
      protected var heroList:GameScrolledList;
      
      public function TeamGatherPopup(param1:TeamGatherPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         param1.signal_teamUpdate.add(handler_teamUpdate);
         handler_teamUpdate();
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return mediator.tutorialNode;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         return _loc2_;
      }
      
      protected function get teamListLayout() : DisplayObjectContainer
      {
         return null;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
      }
      
      protected function createTeamList(param1:DisplayObjectContainer) : void
      {
         teamList = new TeamGatherPopupTeamList(mediator);
         teamList.itemRendererType = TeamGatherPopupTeamMemberRenderer;
         teamList.dataProvider = mediator.teamListDataProvider;
         teamList.width = param1.width;
         teamList.height = param1.height;
         param1.addChild(teamList);
      }
      
      protected function createHeroList(param1:DisplayObjectContainer, param2:List, param3:Boolean = true) : void
      {
         var _loc4_:TiledRowsLayout = new TiledRowsLayout();
         _loc4_.gap = 8;
         _loc4_.paddingTop = !!param3?20:5;
         _loc4_.paddingBottom = 6;
         param2.layout = _loc4_;
         param1.addChild(param2);
         param2.width = param1.width;
         param2.height = param1.height;
         param2.scrollBarDisplayMode = "fixed";
         param2.horizontalScrollPolicy = "off";
         param2.verticalScrollPolicy = "on";
         param2.interactionMode = "mouse";
         param2.itemRendererFactory = heroListItemRendererFactory;
         param2.dataProvider = mediator.heroList;
      }
      
      protected function heroListItemRendererFactory() : TeamGatherPopupHeroRenderer
      {
         var _loc1_:TeamGatherPopupHeroRenderer = new TeamGatherPopupHeroRenderer();
         return _loc1_;
      }
      
      protected function handler_teamUpdate() : void
      {
      }
   }
}
