package game.view.popup.team
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mechanics.grand.mediator.GrandAttackTeamGatherPopupMediator;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.GameScrolledList;
   import game.view.gui.components.tooltip.TooltipTextView;
   
   public class GrandAttackTeamGatherPopup extends MultiTeamGatherPopup
   {
       
      
      private var startButtonTooltip:TooltipVO;
      
      private var attackMediator:GrandAttackTeamGatherPopupMediator;
      
      private var flyingHeroes:TeamGatherFlyingHeroController;
      
      private const clip:GrandTeamGatherAttackPopupGuiClip = AssetStorage.rsx.popup_theme.create_dialog_dialog_grand_team_gather();
      
      public function GrandAttackTeamGatherPopup(param1:GrandAttackTeamGatherPopupMediator)
      {
         startButtonTooltip = new TooltipVO(TooltipTextView,"");
         this.attackMediator = param1;
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(flyingHeroes)
         {
            flyingHeroes.dispose();
         }
         attackMediator.selectedTeam.unsubscribe(handler_selectedTeam);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         width = int(clip.popup_size.graphics.width);
         height = int(clip.popup_size.graphics.height);
         addChild(clip.graphics);
         initTeamSelector(attackMediator,clip.team_selector);
         heroList = new GameScrolledList(clip.scrollBar,clip.gradient_top.graphics,clip.gradient_bottom.graphics);
         createHeroList(clip.hero_list_container.container,heroList,false);
         createTeamList(clip.team_list_container.container);
         flyingHeroes = new TeamGatherFlyingHeroController(heroList,teamList);
         flyingHeroes.setup(attackMediator);
         addChild(flyingHeroes.graphics);
         clip.tf_header.text = Translate.translate("UI_DIALOG_GRAND_GATHER_ATTACKERS_TITLE");
         clip.tf_enemy_power.text = String(attackMediator.enemy.power);
         clip.tf_label_enemy_team_hidden.text = attackMediator.enemyTeamTooltip;
         clip.tf_label_enemy_team.text = Translate.translate("UI_DIALOG_GRAND_GATHER_ATTACKERS_ENEMY_POWER");
         clip.tf_label_my_power.text = Translate.translate("UI_COMMON_HERO_POWER_COLON");
         clip.button_start.initialize(Translate.translate("UI_DIALOG_GRAND_ARENA_TO_BATTLE"),mediator.action_complete);
         TooltipHelper.addTooltip(clip.button_start.graphics,startButtonTooltip);
         clip.button_close.signal_click.add(close);
         clip.empty_team.tf_label_empty_team.text = mediator.emptyTeamString;
         attackMediator.currentTeamEmpty.onValue(handler_isEmptyState);
         attackMediator.canComplete.onValue(handler_canComplete);
         attackMediator.currentTeamPower.onValue(handler_currentTeamPower);
         attackMediator.selectedTeam.onValue(handler_selectedTeam);
      }
      
      private function updateCompleteButton(param1:int, param2:Boolean) : void
      {
         var _loc4_:* = param1 == attackMediator.teamCount - 1;
         if(_loc4_)
         {
            clip.button_start.label = Translate.translate("UI_DIALOG_GRAND_ARENA_TO_BATTLE");
         }
         else
         {
            clip.button_start.label = Translate.translate("UI_DIALOG_GRAND_GATHER_NEXT");
         }
         var _loc3_:Boolean = !_loc4_ || param2;
         clip.button_start.graphics.alpha = !!_loc3_?1:0.4;
         clip.button_start.isEnabled = _loc3_;
         clip.button_start.graphics.useHandCursor = _loc3_;
         clip.button_start.graphics.touchable = true;
         startButtonTooltip.hintData = getCompleteButtonHint(attackMediator);
      }
      
      protected function handler_selectedTeam(param1:int) : void
      {
         updateCompleteButton(param1,attackMediator.canComplete.value);
         startButtonTooltip.hintData = getCompleteButtonHint(attackMediator);
         var _loc2_:Vector.<UnitEntryValueObject> = attackMediator.enemyHeroes;
         clip.enemy_team_list.setUnitTeam(_loc2_);
         var _loc3_:* = _loc2_.length == 0;
         clip.tf_label_enemy_team_hidden.visible = _loc3_;
         clip.enemy_team_list.graphics.visible = !_loc3_;
      }
      
      override protected function handler_teamUpdate() : void
      {
         super.handler_teamUpdate();
         startButtonTooltip.hintData = getCompleteButtonHint(attackMediator);
      }
      
      private function handler_canComplete(param1:Boolean) : void
      {
         updateCompleteButton(attackMediator.selectedTeam.value,param1);
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
