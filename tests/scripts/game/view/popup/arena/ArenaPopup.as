package game.view.popup.arena
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.command.timer.GameTimer;
   import game.mediator.gui.popup.arena.ArenaPopupMediator;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.model.user.arena.PlayerArenaEnemy;
   import game.util.TimeFormatter;
   import game.view.gui.components.TeamView;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.IEscClosable;
   import starling.core.Starling;
   
   public class ArenaPopup extends ClipBasedPopup implements ITutorialActionProvider, ITutorialNodePresenter, IEscClosable
   {
       
      
      private var mediator:ArenaPopupMediator;
      
      private var clip:ArenaPopupClip;
      
      private var defendersList:TeamView;
      
      public function ArenaPopup(param1:ArenaPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "arena";
      }
      
      override public function dispose() : void
      {
         super.dispose();
         GameTimer.instance.oneSecTimer.remove(handler_gameTimer);
         mediator.signal_enemiesUpdate.remove(onEnemiesUpdate);
         mediator.signal_defendersUpdate.remove(onDefendersUpdate);
         mediator.signal_placeUpdate.remove(onPlaceUpdate);
         mediator.signal_attemptsCountUpdate.remove(onAttemptsCountUpdate);
         mediator.signal_buttonsLock.remove(onButtonsLock);
         mediator.signal_buttonsUnlock.remove(onButtonsUnlock);
         mediator.property_rerollBlocked.unsubscribe(handler_rerollBlocked);
         var _loc3_:int = 0;
         var _loc2_:* = clip.enemy;
         for each(var _loc1_ in clip.enemy)
         {
            _loc1_.signal_pick.remove(handler_enemyPicked);
            _loc1_.signal_mouseOver.remove(handler_enemyMouseOver);
            _loc1_.data = null;
            TooltipHelper.removeTooltip(_loc1_.graphics);
         }
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.ARENA;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         _loc2_.addCloseButton(clip.button_close);
         _loc2_.addButton(TutorialNavigator.ACTION_ARENA_ATTACK_1,clip.enemy[0].button_attack);
         _loc2_.addButton(TutorialNavigator.ACTION_ARENA_ATTACK_2,clip.enemy[1].button_attack);
         _loc2_.addButton(TutorialNavigator.ACTION_ARENA_ATTACK_3,clip.enemy[2].button_attack);
         _loc2_.addButton(TutorialNavigator.ACTION_ARENA_CHANGE_DEFENDERS,clip.btn_team);
         return _loc2_;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_arena();
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         clip.button_close.signal_click.add(mediator.close);
         clip.cooldowns_panel.skip_cost.costData = mediator.cost_skipCooldown;
         defendersList = new TeamView();
         defendersList.width = clip.team_list_container.width;
         defendersList.height = clip.team_list_container.height;
         clip.team_list_container.addChild(defendersList);
         clip.title = Translate.translate("UI_DIALOG_ARENA_NAME");
         var _loc3_:int = 0;
         var _loc2_:* = clip.enemy;
         for each(var _loc1_ in clip.enemy)
         {
            _loc1_.signal_pick.add(handler_enemyPicked);
            _loc1_.signal_mouseOver.add(handler_enemyMouseOver);
            _loc1_.data = null;
         }
         clip.btn_team.signal_click.add(mediator.action_setupTeam);
         clip.btn_logs.signal_click.add(mediator.action_toLogs);
         clip.btn_shop.signal_click.add(mediator.action_toShop);
         clip.battle_count_panel.battle_count_refillable.btn_plus.signal_click.add(handler_buyTries);
         clip.cooldowns_panel.btn_skip_cooldown.signal_click.add(mediator.action_skipCooldown_immediate);
         clip.button_rerollEnemies.initialize(Translate.translate("UI_DIALOG_ARENA_REROLL_ENEMIES"),mediator.action_rerollEnemies);
         clip.btn_rules.signal_click.add(mediator.action_toRules);
         handler_gameTimer();
         onAttemptsCountUpdate();
         onPlaceUpdate();
         onDefendersUpdate();
         mediator.action_rerollEnemies();
         mediator.signal_enemiesUpdate.add(onEnemiesUpdate);
         mediator.signal_defendersUpdate.add(onDefendersUpdate);
         mediator.signal_placeUpdate.add(onPlaceUpdate);
         mediator.signal_attemptsCountUpdate.add(onAttemptsCountUpdate);
         mediator.signal_buttonsLock.add(onButtonsLock);
         mediator.signal_buttonsUnlock.add(onButtonsUnlock);
         mediator.property_rerollBlocked.onValue(handler_rerollBlocked);
         GameTimer.instance.oneSecTimer.add(handler_gameTimer);
      }
      
      private function handler_enemyPicked(param1:PlayerArenaEnemy) : void
      {
         mediator.action_attack(param1);
      }
      
      private function handler_enemyMouseOver() : void
      {
         mediator.action_checkPlayerIsActive();
      }
      
      protected function onDefendersUpdate() : void
      {
         defendersList.team = mediator.defenders;
         clip.tf_my_power.text = mediator.defenderTeamPower.toString();
      }
      
      protected function onEnemiesUpdate() : void
      {
         var _loc3_:int = 0;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc2_:Vector.<ArenaEnemyPanelClip> = clip.enemy;
         var _loc4_:Vector.<PlayerArenaEnemy> = mediator.enemies;
         var _loc1_:int = _loc2_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            if(_loc4_.length > _loc3_)
            {
               _loc5_ = _loc4_[_loc3_];
               _loc2_[_loc3_].setDataWithDelay(mediator.enemies[_loc3_],_loc3_ * 0.1);
               _loc6_ = new TooltipVO(TooltipArenaEnemyTeamView,_loc4_[_loc3_],"TooltipVO.HINT_BEHAVIOR_MOVING");
               TooltipHelper.removeTooltip(_loc2_[_loc3_].graphics);
               TooltipHelper.addTooltip(_loc2_[_loc3_].graphics,_loc6_);
            }
            else
            {
               _loc2_[_loc3_].data = null;
            }
            _loc3_++;
         }
      }
      
      protected function onEnemySelect(param1:PlayerArenaEnemy) : void
      {
         mediator.action_attack(param1);
      }
      
      protected function onPlaceUpdate() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc1_:Boolean = mediator.rankingIsLocked;
         clip.tf_label_place.visible = !_loc1_;
         clip.tf_place.visible = !_loc1_;
         clip.PlaceBG_34_34_1_inst0.graphics.visible = !_loc1_;
         clip.tf_label_rankingLocked.visible = _loc1_;
         if(_loc1_)
         {
            clip.tf_label_rankingLocked.text = Translate.translateArgs("UI_DIALOG_ARENA_VICTORIES_LEFT",mediator.rankingIsLockedBattlesLeft);
         }
         else
         {
            _loc2_ = mediator.place;
            _loc3_ = _loc2_ > 0 && Tutorial.flags.showArenaPlace;
            if(_loc3_)
            {
               clip.tf_place.text = String(_loc2_);
            }
            else
            {
               clip.tf_place.text = "?";
            }
         }
      }
      
      protected function handler_gameTimer() : void
      {
         var _loc1_:int = 0;
         if(clip && clip.graphics)
         {
            _loc1_ = mediator.battleCooldown;
            clip.skipAvailable = mediator.skippedCooldowns < 1 && mediator.attemptsCount > 0;
            clip.cooldowns_panel.tf_timer.text = TimeFormatter.toMS2(_loc1_);
         }
      }
      
      protected function onAttemptsCountUpdate() : void
      {
         clip.battle_count_panel.setValues(mediator.attemptsCount,mediator.attemptsMaxCount);
         clip.skipAvailable = mediator.skippedCooldowns < 1 && mediator.attemptsCount > 0;
      }
      
      protected function onButtonsLock() : void
      {
         touchable = false;
      }
      
      protected function onButtonsUnlock() : void
      {
         touchable = true;
      }
      
      protected function handler_rerollBlocked(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         if(param1)
         {
            _loc2_ = clip.enemy.length;
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               clip.enemy[_loc5_].turnOff();
               _loc5_++;
            }
         }
         var _loc3_:* = !param1;
         clip.button_rerollEnemies.isEnabled = _loc3_;
         var _loc4_:Number = !!_loc3_?1:0.5;
         Starling.juggler.removeTweens(clip.button_rerollEnemies.graphics);
         Starling.juggler.tween(clip.button_rerollEnemies.graphics,0.4,{"alpha":_loc4_});
      }
      
      protected function handler_buyTries() : void
      {
         mediator.action_buyTries();
      }
   }
}
