package game.mechanics.grand.popup
{
   import com.progrestar.common.lang.Translate;
   import feathers.controls.Label;
   import game.assets.storage.AssetStorage;
   import game.command.timer.GameTimer;
   import game.mechanics.grand.mediator.GrandPopupMediator;
   import game.mediator.gui.popup.hero.HeroEntryValueObject;
   import game.util.TimeFormatter;
   import game.view.gui.components.GameButton;
   import game.view.gui.components.GameLabel;
   import game.view.gui.tutorial.Tutorial;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.IEscClosable;
   
   public class GrandPopup extends ClipBasedPopup implements IEscClosable
   {
       
      
      protected var mediator:GrandPopupMediator;
      
      private const clip:GrandPopupClip = AssetStorage.rsx.popup_theme.create_dialog_grand_arena();
      
      protected var coinsLabel:Label;
      
      protected var coinsCount:Label;
      
      protected var coinsByHourLabel:Label;
      
      protected var coinsByHourCount:Label;
      
      protected var farmCoinsButton:GameButton;
      
      public function GrandPopup(param1:GrandPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         param1.onCoinsUpdate.add(onCoinsUpdate);
         stashParams.windowName = "grandArena";
      }
      
      override public function dispose() : void
      {
         super.dispose();
         GameTimer.instance.oneSecTimer.remove(handler_gameTimer);
         mediator.signal_defendersUpdate.remove(onDefendersUpdate);
         mediator.signal_placeUpdate.remove(onPlaceUpdate);
         mediator.signal_attemptsCountUpdate.remove(onAttemptsCountUpdate);
         mediator.signal_buttonsLock.remove(onButtonsLock);
         mediator.signal_buttonsUnlock.remove(onButtonsUnlock);
         mediator.onCoinsUpdate.remove(onCoinsUpdate);
      }
      
      override protected function initialize() : void
      {
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         clip.title = Translate.translate("UI_DIALOG_GRAND_TITLE");
         clip.tf_label_defenders.text = Translate.translate("UI_DIALOG_GRAND_ARENA_TF_LABEL_DEFENDERS");
         clip.tf_label_reward.text = Translate.translate("UI_DIALOG_GRAND_ARENA_TF_LABEL_REWARD");
         clip.tf_label_placement_reward.text = Translate.translate("UI_DIALOG_GRAND_ARENA_TF_LABEL_PLACEMENT_REWARD");
         clip.tf_label_place.text = Translate.translate("UI_DIALOG_GRAND_ARENA_TF_LABEL_PLACE");
         clip.tf_label_power.text = Translate.translate("UI_DIALOG_GRAND_ARENA_TF_LABEL_POWER");
         clip.tf_label_no_defenders.text = Translate.translate("UI_DIALOG_GRAND_ARENA_TF_LABEL_NO_DEFENDERS");
         clip.battle_count_panel.tf_header.text = Translate.translate("UI_DIALOG_ARENA_BATTLE_COUNT");
         clip.button_close.signal_click.add(mediator.close);
         clip.button_shop.initialize(Translate.translate("UI_DIALOG_ARENA_SHOP"),mediator.action_toShop);
         clip.button_rules.initialize(Translate.translate("UI_DIALOG_ARENA_RULES"),mediator.action_toRules);
         clip.button_logs.initialize(Translate.translate("UI_DIALOG_ARENA_LOGS"),mediator.action_toLogs);
         clip.button_top.initialize(Translate.translate("UI_DIALOG_GRAND_RATING"),mediator.action_toRating);
         clip.button_defenders.initialize(Translate.translate("UI_DIALOG_ARENA_MY_TEAM_SETUP"),mediator.action_setupTeam);
         clip.button_start.initialize(Translate.translate("UI_DIALOG_GRAND_ARENA_TO_BATTLE"),mediator.action_findEnemies);
         clip.button_no_defenders.initialize(Translate.translate("UI_DIALOG_GRAND_ARENA_SELECT_DEFENDERS"),mediator.action_setupTeam);
         clip.tf_label_1.text = "1";
         clip.tf_label_2.text = "2";
         clip.tf_label_3.text = "3";
         coinsLabel = GameLabel.label();
         coinsLabel.text = Translate.translate("UI_DIALOG_ARENA_AVAILABLE");
         coinsCount = GameLabel.label();
         coinsByHourLabel = GameLabel.label();
         coinsByHourLabel.text = Translate.translate("UI_DIALOG_ARENA_COINS_BY_HOUR");
         coinsByHourCount = GameLabel.label();
         clip.cooldowns_panel.skip_cost.costData = mediator.cost_skipCooldown;
         clip.cooldowns_panel.btn_skip_cooldown.signal_click.add(mediator.action_skipCooldown_immediate);
         clip.battle_count_panel.battle_count_refillable.btn_plus.signal_click.add(handler_buyTries);
         clip.button_collect.initialize(Translate.translate("UI_DIALOG_ARENA_GET"),mediator.action_getCoins);
         clip.icon_reward.image.texture = AssetStorage.rsx.popup_theme.getTexture(mediator.resourceTextureIdent);
         clip.icon_reward_placement.image.texture = AssetStorage.rsx.popup_theme.getTexture(mediator.resourceTextureIdent);
         mediator.signal_defendersUpdate.add(onDefendersUpdate);
         mediator.signal_placeUpdate.add(onPlaceUpdate);
         mediator.signal_attemptsCountUpdate.add(onAttemptsCountUpdate);
         mediator.signal_buttonsLock.add(onButtonsLock);
         mediator.signal_buttonsUnlock.add(onButtonsUnlock);
         GameTimer.instance.oneSecTimer.add(handler_gameTimer);
         updateDefendersVisibility();
         onDefendersUpdate();
         onPlaceUpdate();
         onAttemptsCountUpdate();
         handler_gameTimer();
         super.initialize();
      }
      
      protected function handler_buyTries() : void
      {
         mediator.action_buyTries();
      }
      
      protected function updateDefendersVisibility() : void
      {
         var _loc1_:Boolean = mediator.place;
         clip.button_start.graphics.alpha = !!_loc1_?1:0.5;
         clip.button_collect.graphics.alpha = !!_loc1_?1:0.5;
         clip.button_start.isEnabled = _loc1_;
         clip.button_collect.isEnabled = _loc1_;
         clip.tf_label_1.graphics.visible = _loc1_;
         clip.tf_label_2.graphics.visible = _loc1_;
         clip.tf_label_3.graphics.visible = _loc1_;
         clip.team1.graphics.visible = _loc1_;
         clip.team2.graphics.visible = _loc1_;
         clip.team3.graphics.visible = _loc1_;
         clip.tf_label_power.visible = _loc1_;
         clip.tf_power.visible = _loc1_;
         clip.icon_power.graphics.visible = _loc1_;
         clip.button_defenders.graphics.visible = _loc1_;
         clip.tf_label_no_defenders.graphics.visible = !_loc1_;
         clip.button_no_defenders.graphics.visible = !_loc1_;
      }
      
      protected function onDefendersUpdate() : void
      {
         var _loc1_:Vector.<Vector.<HeroEntryValueObject>> = mediator.defenders;
         clip.team1.setTeam(_loc1_[0]);
         clip.team2.setTeam(_loc1_[1]);
         clip.team3.setTeam(_loc1_[2]);
         clip.tf_power.text = String(mediator.defendersPower);
      }
      
      protected function onPlaceUpdate() : void
      {
         var _loc1_:int = mediator.place;
         var _loc2_:Boolean = _loc1_ > 0 && Tutorial.flags.showArenaPlace;
         if(_loc2_)
         {
            clip.tf_place.text = String(_loc1_);
         }
         else
         {
            clip.tf_place.text = "?";
         }
         updateDefendersVisibility();
         clip.tf_placement_amount.text = Translate.translateArgs("UI_DIALOG_GRAND_PLACEMENT_REWARD",mediator.coinsByHour);
      }
      
      protected function onAttemptsCountUpdate() : void
      {
         clip.battle_count_panel.setValues(mediator.attemptsCount,mediator.attemptsMaxCount);
         clip.skipAvailable = mediator.skippedCooldowns < 1 && mediator.attemptsCount > 0;
      }
      
      protected function onCoinsUpdate() : void
      {
         var _loc1_:int = mediator.farmableCoins;
         clip.icon_has_reward.graphics.visible = _loc1_ > 0;
         clip.tf_amount.text = String(_loc1_);
      }
      
      protected function onButtonsLock() : void
      {
         touchable = false;
      }
      
      protected function onButtonsUnlock() : void
      {
         touchable = true;
      }
      
      protected function handler_gameTimer() : void
      {
         var _loc1_:int = 0;
         if(clip.graphics)
         {
            _loc1_ = mediator.battleCooldown;
            clip.skipAvailable = mediator.skippedCooldowns < 1 && mediator.attemptsCount > 0;
            clip.cooldowns_panel.tf_timer.text = TimeFormatter.toMS2(_loc1_);
         }
         onCoinsUpdate();
      }
   }
}
