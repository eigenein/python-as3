package game.mechanics.expedition.popup
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.MathUtil;
   import feathers.layout.HorizontalLayout;
   import feathers.layout.TiledRowsLayout;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.expedition.mediator.ExpeditionTeamGatherPopupMediator;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.util.NumberUtils;
   import game.view.gui.components.tooltip.TooltipTextView;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   import game.view.popup.team.TeamGatherFlyingHeroController;
   import game.view.popup.team.TeamGatherPopupTeamMemberRenderer;
   import starling.core.Starling;
   
   public class ExpeditionTeamGatherPopup extends AsyncClipBasedPopupWithPreloader
   {
       
      
      private var mediator:ExpeditionTeamGatherPopupMediator;
      
      private const clip:ExpeditionTeamGatherPopupClip = new ExpeditionTeamGatherPopupClip();
      
      private var flyingHeroes:TeamGatherFlyingHeroController;
      
      private var startButtonTooltip:TooltipVO;
      
      public function ExpeditionTeamGatherPopup(param1:ExpeditionTeamGatherPopupMediator)
      {
         startButtonTooltip = new TooltipVO(TooltipTextView,"");
         super(param1,AssetStorage.rsx.dialog_expedition);
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
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         _loc2_.addCloseButton(clip.button_close);
         _loc2_.addButton(mediator.tutorialStartAction,clip.button_start);
         return _loc2_;
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         param1.initGuiClip(clip,"dialog_expedition_team_gather");
         addChild(clip.graphics);
         clip.tf_header.text = mediator.text_dialogCaption;
         clip.tf_label_power.text = Translate.translate("UI_DIALOG_EXPEDITION_CURRENT_TEAM_POWER");
         clip.empty_team.tf_label_empty_team.text = mediator.emptyTeamString;
         clip.animation_full.stop();
         if(mediator.minTeamSize > 0)
         {
            clip.tf_label_count_requirement.text = Translate.translateArgs("UI_DIALOG_EXPEDITION_TEAM_GATHER_COUNT_REQUIREMENT",mediator.minTeamSize);
         }
         clip.tf_label_count_requirement.touchable = false;
         clip.button_start.label = mediator.startButtonLabel;
         clip.button_close.signal_click.add(close);
         clip.button_start.signal_click.add(mediator.action_complete);
         clip.button_auto.signal_click.add(mediator.action_auto);
         clip.button_auto.label = Translate.translate("UI_DIALOG_EXPEDITION_TEAM_GATHER_AUTO");
         setupPowerRequirement();
         createHeroList();
         createTeamList();
         flyingHeroes = new TeamGatherFlyingHeroController(clip.hero_list,clip.team_list);
         flyingHeroes.setup(mediator);
         addChild(flyingHeroes.graphics);
         mediator.currentTeamPower.onValue(handler_currentTeamPower);
         mediator.signal_teamUpdate.add(handler_teamUpdate);
         handler_teamUpdate();
         mediator.canComplete.onValue(handler_canComplete);
         mediator.enoughPowerAndTeamSize.onValue(handler_enoughPowerAndTeamSize);
         TooltipHelper.addTooltip(clip.button_start.graphics,startButtonTooltip);
         width = int(clip.popup_size.graphics.width);
         height = int(clip.popup_size.graphics.height);
      }
      
      protected function createTeamList() : void
      {
         clip.team_list.itemRendererType = TeamGatherPopupTeamMemberRenderer;
         clip.team_list.dataProvider = mediator.teamListDataProvider;
         clip.team_list.interactionMode = "mouse";
         clip.team_list.scrollBarDisplayMode = "fixed";
         clip.team_list.horizontalScrollPolicy = "off";
         clip.team_list.verticalScrollPolicy = "on";
         var _loc1_:HorizontalLayout = new HorizontalLayout();
         _loc1_.gap = 8;
         _loc1_.verticalAlign = "middle";
         clip.team_list.layout = _loc1_;
      }
      
      protected function createHeroList() : void
      {
         var _loc1_:TiledRowsLayout = new TiledRowsLayout();
         _loc1_.gap = 8;
         _loc1_.paddingTop = 5;
         _loc1_.paddingBottom = 5;
         _loc1_.useSquareTiles = false;
         clip.hero_list.layout = _loc1_;
         clip.hero_list.scrollBarDisplayMode = "fixed";
         clip.hero_list.horizontalScrollPolicy = "off";
         clip.hero_list.verticalScrollPolicy = "on";
         clip.hero_list.interactionMode = "mouse";
         clip.hero_list.itemRendererFactory = heroListItemRendererFactory;
         clip.hero_list.dataProvider = mediator.heroList;
      }
      
      private function setupPowerRequirement() : void
      {
         clip.tf_power_requirement.text = NumberUtils.numberToString(mediator.powerRequirement);
      }
      
      private function heroListItemRendererFactory() : ExpeditionTeamGatherPopupHeroRenderer
      {
         var _loc1_:ExpeditionTeamGatherPopupHeroRenderer = new ExpeditionTeamGatherPopupHeroRenderer();
         return _loc1_;
      }
      
      private function updateEmptyTeamState() : void
      {
         var _loc1_:Boolean = mediator.isEmptyTeam;
         clip.empty_team.graphics.visible = _loc1_;
      }
      
      private function updateCompleteButton(param1:Boolean) : void
      {
      }
      
      private function handler_enoughPowerAndTeamSize(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:Boolean = param1 && param2;
         Starling.juggler.removeTweens(clip.button_start.graphics);
         Starling.juggler.tween(clip.button_start.graphics,0.3,{"alpha":(!!_loc3_?1:Number(!!param2?0.4:0))});
         clip.button_auto.graphics.visible = !param2;
         Starling.juggler.removeTweens(clip.tf_label_count_requirement.graphics);
         Starling.juggler.tween(clip.tf_label_count_requirement.graphics,0.3,{"alpha":(!!param2?0:1)});
         clip.button_start.isEnabled = _loc3_;
         clip.button_start.graphics.useHandCursor = _loc3_;
         clip.button_start.graphics.touchable = param2;
      }
      
      private function handler_teamUpdate() : void
      {
         updateEmptyTeamState();
      }
      
      private function handler_currentTeamPower(param1:int) : void
      {
         var _loc2_:int = clip.progress.graphics.x - clip.progress_back.graphics.x;
         var _loc4_:int = clip.progress_back.graphics.width - _loc2_ * 2;
         var _loc5_:Number = _loc4_ * param1 / mediator.powerRequirement;
         var _loc3_:* = clip.progress.graphics.width < _loc4_;
         clip.progress.graphics.width = MathUtil.clamp(_loc5_,5,_loc4_);
         if(_loc3_ && clip.progress.graphics.width == _loc4_)
         {
            clip.animation_full.stopOnFrame(26);
            clip.animation_full.gotoAndPlay(0);
         }
         clip.tf_power.text = NumberUtils.numberToString(param1) + " / " + NumberUtils.numberToString(mediator.powerRequirement);
         startButtonTooltip.hintData = Translate.translateArgs("UI_DIALOG_EXPEDITION_TEAM_GATHER_POWER_REQUIREMENT",NumberUtils.numberToString(param1),NumberUtils.numberToString(mediator.powerRequirement));
      }
      
      private function handler_canComplete(param1:Boolean) : void
      {
         updateCompleteButton(param1);
      }
   }
}
