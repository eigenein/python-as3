package game.view.popup.team
{
   import com.progrestar.common.lang.Translate;
   import feathers.layout.TiledRowsLayout;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.team.StateBasedTeamGatherPopupMediator;
   import game.view.gui.components.GameScrolledList;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.tower.TowerTeamGatherPopupHeroRenderer;
   import game.view.popup.tower.TowerTeamGatherPopupTeamMemberRenderer;
   
   public class TowerTeamGatherPopup extends ClipBasedPopup
   {
       
      
      private var mediator:StateBasedTeamGatherPopupMediator;
      
      private const clip:TowerTeamGatherClip = AssetStorage.rsx.popup_theme.create_dialog_tower_team_gather();
      
      private var teamList:TeamGatherPopupTeamList;
      
      private var heroList:GameScrolledList;
      
      private var flyingHeroes:TeamGatherFlyingHeroController;
      
      public function TowerTeamGatherPopup(param1:StateBasedTeamGatherPopupMediator)
      {
         super(param1);
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
      
      override protected function initialize() : void
      {
         super.initialize();
         addChild(clip.graphics);
         clip.tf_header.text = mediator.text_dialogCaption;
         clip.tf_label_enemy_team.text = Translate.translate("UI_TOWER_ENEMY_TEAM");
         clip.tf_label_my_power.text = Translate.translate("UI_COMMON_HERO_POWER_COLON");
         clip.empty_team.tf_label_empty_team.text = mediator.emptyTeamString;
         clip.button_start.label = mediator.startButtonLabel;
         clip.button_close.signal_click.add(close);
         clip.button_start.signal_click.add(mediator.action_complete);
         mediator.currentTeamPower.onValue(handler_currentTeamPower);
         mediator.signal_teamUpdate.add(handler_teamUpdate);
         handler_teamUpdate();
         setupEnemyTeam();
         createHeroList();
         createTeamList();
         flyingHeroes = new TeamGatherFlyingHeroController(heroList,teamList);
         flyingHeroes.setup(mediator);
         addChild(flyingHeroes.graphics);
         width = int(clip.popup_size.graphics.width);
         height = int(clip.popup_size.graphics.height);
      }
      
      protected function createTeamList() : void
      {
         teamList = new TeamGatherPopupTeamList(mediator);
         teamList.itemRendererType = TowerTeamGatherPopupTeamMemberRenderer;
         teamList.dataProvider = mediator.teamListDataProvider;
         teamList.width = clip.team_list.container.width;
         teamList.height = clip.team_list.container.height;
         clip.team_list.container.addChild(teamList);
      }
      
      protected function createHeroList() : void
      {
         var _loc1_:TiledRowsLayout = new TiledRowsLayout();
         _loc1_.paddingTop = 7;
         _loc1_.paddingBottom = 15;
         _loc1_.paddingLeft = -5;
         _loc1_.paddingRight = -5;
         _loc1_.verticalGap = 15;
         _loc1_.horizontalGap = 10;
         _loc1_.useSquareTiles = false;
         heroList = new GameScrolledList(clip.scrollBar,clip.gradient_top.graphics,clip.gradient_bottom.graphics);
         heroList.layout = _loc1_;
         clip.hero_list.container.addChild(heroList);
         heroList.width = clip.hero_list.graphics.width;
         heroList.height = clip.hero_list.graphics.height;
         heroList.scrollBarDisplayMode = "fixed";
         heroList.horizontalScrollPolicy = "off";
         heroList.verticalScrollPolicy = "on";
         heroList.interactionMode = "mouse";
         heroList.itemRendererFactory = heroListItemRendererFactory;
         heroList.dataProvider = mediator.heroList;
      }
      
      protected function setupEnemyTeam() : void
      {
         clip.enemy_team_list.setUnitTeam(mediator.enemyTeam);
         clip.tf_enemy_power.text = String(mediator.enemyTeamPower);
      }
      
      private function heroListItemRendererFactory() : TowerTeamGatherPopupHeroRenderer
      {
         var _loc1_:TowerTeamGatherPopupHeroRenderer = new TowerTeamGatherPopupHeroRenderer();
         return _loc1_;
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
