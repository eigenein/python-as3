package game.view.popup.team
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mechanics.grand.mediator.GrandDefendersTeamGatherPopupMedaitor;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.GameScrolledList;
   import game.view.gui.components.tooltip.TooltipTextView;
   
   public class GrandDefendersTeamGatherPopup extends MultiTeamGatherPopup
   {
       
      
      private var startButtonTooltip:TooltipVO;
      
      private var grandMediator:GrandDefendersTeamGatherPopupMedaitor;
      
      private var flyingHeroes:TeamGatherFlyingHeroController;
      
      private const clip:GrandTeamGatherPopupGuiClip = AssetStorage.rsx.popup_theme.create_dialog_dialog_grand_team_gather_defenders();
      
      public function GrandDefendersTeamGatherPopup(param1:GrandDefendersTeamGatherPopupMedaitor)
      {
         startButtonTooltip = new TooltipVO(TooltipTextView,"");
         grandMediator = param1;
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(flyingHeroes)
         {
            flyingHeroes.dispose();
         }
         grandMediator.currentTeamEmpty.unsubscribe(handler_isEmptyState);
         grandMediator.canComplete.unsubscribe(handler_canComplete);
         grandMediator.currentTeamPower.unsubscribe(handler_currentTeamPower);
         grandMediator.selectedTeam.unsubscribe(handler_selectedTeam);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         width = int(clip.popup_size.graphics.width);
         height = int(clip.popup_size.graphics.height);
         addChild(clip.graphics);
         initTeamSelector(grandMediator,clip.team_selector);
         heroList = new GameScrolledList(clip.scrollBar,clip.gradient_top.graphics,clip.gradient_bottom.graphics);
         createHeroList(clip.hero_list_container.container,heroList);
         createTeamList(clip.team_list_container.container);
         if(mediator.heroList.length <= 20)
         {
            clip.scrollBar.visible = false;
            heroList.x = heroList.x + 12;
         }
         flyingHeroes = new TeamGatherFlyingHeroController(heroList,teamList);
         flyingHeroes.setup(grandMediator);
         addChild(flyingHeroes.graphics);
         clip.title = Translate.translate("UI_DIALOG_GRAND_GATHER_DEFENDERS_TITLE");
         clip.button_start.initialize(Translate.translate("UI_DIALOG_GRAND_GATHER_DEFENDERS_SAVE"),mediator.action_complete);
         clip.button_start.guiClipLabel.adjustSizeToFitWidth();
         TooltipHelper.addTooltip(clip.button_start.graphics,startButtonTooltip);
         clip.button_close.signal_click.add(close);
         clip.empty_team.tf_label_empty_team.text = Translate.translate("UI_DIALOG_TEAM_GATHER_EMPTY");
         grandMediator.currentTeamEmpty.onValue(handler_isEmptyState);
         grandMediator.canComplete.onValue(handler_canComplete);
         grandMediator.currentTeamPower.onValue(handler_currentTeamPower);
         grandMediator.selectedTeam.onValue(handler_selectedTeam);
      }
      
      private function updateCompleteButton(param1:int, param2:Boolean) : void
      {
         var _loc4_:* = param1 == grandMediator.teamCount - 1;
         if(_loc4_)
         {
            clip.button_start.label = Translate.translate("UI_DIALOG_GRAND_GATHER_DEFENDERS_SAVE");
         }
         else
         {
            clip.button_start.label = Translate.translate("UI_DIALOG_GRAND_GATHER_NEXT");
         }
         clip.button_start.guiClipLabel.adjustSizeToFitWidth();
         var _loc3_:Boolean = !_loc4_ || param2;
         clip.button_start.graphics.alpha = !!_loc3_?1:0.4;
         clip.button_start.isEnabled = _loc3_;
         clip.button_start.graphics.useHandCursor = _loc3_;
         clip.button_start.graphics.touchable = true;
         startButtonTooltip.hintData = getCompleteButtonHint(grandMediator);
      }
      
      protected function handler_selectedTeam(param1:int) : void
      {
         updateCompleteButton(param1,grandMediator.canComplete.value);
         startButtonTooltip.hintData = getCompleteButtonHint(grandMediator);
      }
      
      override protected function handler_teamUpdate() : void
      {
         super.handler_teamUpdate();
         startButtonTooltip.hintData = getCompleteButtonHint(grandMediator);
      }
      
      private function handler_canComplete(param1:Boolean) : void
      {
         updateCompleteButton(grandMediator.selectedTeam.value,param1);
      }
      
      private function handler_isEmptyState(param1:Boolean) : void
      {
         clip.empty_team.graphics.visible = param1;
      }
      
      private function handler_currentTeamPower(param1:int) : void
      {
         clip.tf_my_power.text = String(param1);
      }
   }
}
