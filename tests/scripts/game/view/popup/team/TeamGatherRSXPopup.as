package game.view.popup.team
{
   import com.progrestar.common.lang.Translate;
   import feathers.controls.List;
   import feathers.layout.TiledRowsLayout;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.team.TeamGatherPopupMediator;
   import game.view.gui.components.GameScrolledList;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.PopupBase;
   import game.view.popup.common.PopupTitle;
   
   public class TeamGatherRSXPopup extends PopupBase implements ITutorialActionProvider, ITutorialNodePresenter
   {
       
      
      protected var mediator:TeamGatherPopupMediator;
      
      protected var heroList:List;
      
      private var teamList:TeamGatherPopupTeamList;
      
      private var flyingHeroes:TeamGatherFlyingHeroController;
      
      private var clip:TeamGatherPopupGuiClip;
      
      public function TeamGatherRSXPopup(param1:TeamGatherPopupMediator)
      {
         super();
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(flyingHeroes)
         {
            flyingHeroes.dispose();
         }
         mediator.signal_teamUpdate.remove(handler_teamUpdate);
         mediator.currentTeamPower.unsubscribe(handler_currentTeamPower);
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return mediator.tutorialNode;
      }
      
      protected function get heroListItemRendererType() : Class
      {
         return TeamGatherPopupHeroRenderer;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         _loc2_.addCloseButton(clip.button_close);
         _loc2_.addButton(mediator.tutorialStartAction,clip.button_start);
         return _loc2_;
      }
      
      override protected function initialize() : void
      {
         var _loc1_:* = null;
         super.initialize();
         clip = createClip();
         addChild(clip.graphics);
         if(clip.scrollBar && clip.gradient_top && clip.gradient_bottom)
         {
            heroList = new GameScrolledList(clip.scrollBar,clip.gradient_top.graphics,clip.gradient_bottom.graphics);
            heroList.itemRendererType = heroListItemRendererType;
            _loc1_ = new TiledRowsLayout();
            _loc1_.paddingTop = 20;
            _loc1_.paddingBottom = 12;
            _loc1_.gap = 8;
            heroList.layout = _loc1_;
            heroList.scrollBarDisplayMode = "fixed";
            heroList.horizontalScrollPolicy = "off";
            heroList.verticalScrollPolicy = "on";
            heroList.interactionMode = "mouse";
            if(mediator.heroList.length <= 20)
            {
               clip.scrollBar.visible = false;
               heroList.x = heroList.x + 12;
            }
         }
         else
         {
            heroList = new TeamGatherPopupHeroList();
         }
         heroList.dataProvider = mediator.heroList;
         heroList.width = clip.hero_list_container.container.width;
         heroList.height = clip.hero_list_container.container.height;
         clip.hero_list_container.container.addChild(heroList);
         clip.tf_label_my_power.text = Translate.translate("UI_COMMON_HERO_POWER_COLON");
         teamList = new TeamGatherPopupTeamList(mediator);
         teamList.dataProvider = mediator.teamListDataProvider;
         teamList.width = clip.team_list_container.container.width;
         teamList.height = clip.team_list_container.container.height;
         clip.team_list_container.container.addChild(teamList);
         flyingHeroes = new TeamGatherFlyingHeroController(heroList,teamList);
         flyingHeroes.setup(mediator);
         addChild(flyingHeroes.graphics);
         clip.button_start.label = mediator.startButtonLabel;
         clip.button_close.signal_click.add(mediator.close);
         clip.button_start.signal_click.add(mediator.action_complete);
         clip.empty_team.tf_label_empty_team.text = mediator.emptyTeamString;
         PopupTitle.create(Translate.translate("UI_DIALOG_TEAM_GATHER_TITLE"),clip.header_layout_container);
         mediator.currentTeamPower.onValue(handler_currentTeamPower);
         mediator.signal_teamUpdate.add(handler_teamUpdate);
         updateEmptyTeamState();
         width = int(clip.popup_size.graphics.width);
         height = int(clip.popup_size.graphics.height);
      }
      
      protected function createClip() : TeamGatherPopupGuiClip
      {
         return AssetStorage.rsx.popup_theme.create_dialog_hero_select();
      }
      
      private function updateEmptyTeamState() : void
      {
         var _loc1_:Boolean = mediator.isEmptyTeam;
         clip.empty_team.graphics.visible = _loc1_;
         clip.button_start.isEnabled = !_loc1_;
      }
      
      private function handler_teamUpdate() : void
      {
         updateEmptyTeamState();
      }
      
      private function handler_currentTeamPower(param1:int) : void
      {
         clip.tf_my_power.text = String(param1);
      }
   }
}
