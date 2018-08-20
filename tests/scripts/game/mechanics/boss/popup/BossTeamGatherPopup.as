package game.mechanics.boss.popup
{
   import com.progrestar.common.lang.Translate;
   import feathers.layout.TiledRowsLayout;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.boss.mediator.BossTeamGatherPopupMediator;
   import game.view.gui.components.GameScrolledList;
   import game.view.popup.AsyncClipBasedPopup;
   import game.view.popup.team.BossTeamGatherPopupHeroRenderer;
   import game.view.popup.team.TeamGatherFlyingHeroController;
   import game.view.popup.team.TeamGatherPopupHeroRenderer;
   import game.view.popup.team.TeamGatherPopupTeamList;
   import game.view.popup.team.TeamGatherPopupTeamMemberRenderer;
   
   public class BossTeamGatherPopup extends AsyncClipBasedPopup
   {
       
      
      private var mediator:BossTeamGatherPopupMediator;
      
      private var clip:BossTeamGatherPopupClip;
      
      private var teamList:TeamGatherPopupTeamList;
      
      private var heroList:GameScrolledList;
      
      private var flyingHeroes:TeamGatherFlyingHeroController;
      
      public function BossTeamGatherPopup(param1:BossTeamGatherPopupMediator)
      {
         super(param1,AssetStorage.rsx.dialog_boss);
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
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         clip = param1.create(BossTeamGatherPopupClip,"dialog_boss_team_gather");
         addChild(clip.graphics);
         clip.title = Translate.translate("UI_TOWER_TEAM_GATHER_TITLE");
         clip.tf_description.text = mediator.recommendedHeroesText;
         clip.tf_description.adjustSizeToFitWidth();
         clip.tf_label_my_power.text = Translate.translate("UI_COMMON_HERO_POWER_COLON");
         clip.empty_team.tf_label_empty_team.text = mediator.emptyTeamString;
         clip.button_start.label = mediator.startButtonLabel;
         clip.button_close.signal_click.add(close);
         clip.button_start.signal_click.add(mediator.action_complete);
         createHeroList();
         createTeamList();
         flyingHeroes = new TeamGatherFlyingHeroController(heroList,teamList);
         flyingHeroes.setup(mediator);
         addChild(flyingHeroes.graphics);
         mediator.currentTeamPower.onValue(handler_currentTeamPower);
         mediator.signal_teamUpdate.add(handler_teamUpdate);
         handler_teamUpdate();
         width = int(clip.popup_size.graphics.width);
         height = int(clip.popup_size.graphics.height);
      }
      
      protected function createTeamList() : void
      {
         teamList = new TeamGatherPopupTeamList(mediator);
         teamList.itemRendererType = TeamGatherPopupTeamMemberRenderer;
         teamList.dataProvider = mediator.teamListDataProvider;
         teamList.width = clip.team_list.container.width;
         teamList.height = clip.team_list.container.height;
         clip.team_list.container.addChild(teamList);
      }
      
      protected function createHeroList() : void
      {
         var _loc1_:TiledRowsLayout = new TiledRowsLayout();
         _loc1_.gap = 8;
         _loc1_.paddingTop = 5;
         _loc1_.paddingBottom = 5;
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
      
      private function heroListItemRendererFactory() : TeamGatherPopupHeroRenderer
      {
         var _loc1_:BossTeamGatherPopupHeroRenderer = new BossTeamGatherPopupHeroRenderer();
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
