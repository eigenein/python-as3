package game.view.popup.test
{
   import feathers.core.PopUpManager;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.BattleAssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.view.gui.components.toggle.ClipToggleButton;
   import game.view.gui.components.toggle.ToggleGroup;
   import game.view.popup.AsyncClipBasedPopup;
   import game.view.popup.common.PopupSideTab;
   import game.view.popup.team.TeamGatherPopupHeroList;
   import game.view.popup.team.TeamGatherPopupTeamList;
   import game.view.popup.test.grade.BattleTestGradeMediator;
   import starling.core.Starling;
   import starling.events.KeyboardEvent;
   
   public class BattleTestStatsPopup extends AsyncClipBasedPopup
   {
       
      
      private var mediator:BattleTestStatsPopupMediator;
      
      private var view:BattleTestStatsClip;
      
      private var toggle:ToggleGroup;
      
      private var grade_left:BattleTestGradeMediator;
      
      private var grade_right:BattleTestGradeMediator;
      
      public function BattleTestStatsPopup(param1:BattleTestStatsPopupMediator)
      {
         super(param1,AssetStorage.rsx.dialog_test_battle);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         mediator.onReportUpdated.remove(onCountUpdated);
         removeEventListener("keyDown",handler_keyDown);
         mediator.powerLeft.unsubscribe(handler_powerLeft);
         mediator.powerRight.unsubscribe(handler_powerRight);
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         var _loc3_:* = null;
         view = param1.create(BattleTestStatsClip,"dialog_test_battle");
         addChild(view.graphics);
         view.button_close.signal_click.add(close);
         view.button_clear.initialize("clear",mediator.action_clearResults);
         view.button_start.initialize("Запустить",mediator.action_toggle,mediator.startButtonEnabled);
         view.button_different_grade.initialize(mediator.gradeModeButtonName,mediator.action_changeGradeMode);
         view.button_different_grade_drop.initialize("Сбросить",mediator.action_dropGrade);
         view.button_start_one.initialize("Смотреть бой",mediator.action_startOne);
         view.button_refresh.initialize("F 5",mediator.action_refreshCode);
         view.button_config.initialize(mediator.configName,mediator.action_changeConfig);
         view.button_skin.initialize(mediator.skinMode,mediator.action_changeSkinMode);
         view.button_winrate_only.createNativeClickHandler().add(mediator.action_winrateOnly);
         view.button_attackersDefenders.createNativeClickHandler().add(mediator.action_attackersDefendersOnly);
         view.button_toggleInterpreter.setIsSelectedSilently(BattleAssetStorage.USE_INTERPRETER);
         view.button_toggleInterpreter.signal_updateSelectedState.add(handler_updateToggleInterpreter);
         handler_updateToggleInterpreter(view.button_toggleInterpreter);
         view.tf_lock_label.text = "Для заблокированной команды не меняется состав и не собирается статистика";
         view.button_lock_right.label.text = "Заблокировать состав";
         view.button_lock_right.setIsSelectedSilently(mediator.doNotRandomRight.value);
         view.button_lock_right.signal_updateSelectedState.add(handler_doNotRandomRight);
         handler_doNotRandomRight(view.button_lock_right);
         view.button_stat_task.initialize("Макротаск",mediator.action_macroTask);
         grade_left = new BattleTestGradeMediator(view.grade_left,mediator.grade_left);
         grade_right = new BattleTestGradeMediator(view.grade_right,mediator.grade_right);
         view.tf_config_label.text = "Режим боя:";
         view.tf_stats_label.text = "Статы последнего выбранного героя";
         view.counters.label_battles_started.text = "Всего";
         view.counters.label_battles_succeeded.text = "Успешно";
         view.counters.label_battles_bad.text = "Не завершено";
         view.tf_grade_different.text = "Настройки для левой и правой команд различаются. Можно их объединить, сбросив настройки правой команды.";
         view.tf_copy_url.text = "Нажми Home, чтобы получить url на эту конфигурацию";
         view.list_battleground.list.dataProvider = mediator.battlegrounds;
         mediator.onChangeVisibility.add(onChangeVisibility);
         mediator.onCountUpdated.add(onCountUpdated);
         mediator.onHeroStatsOutput.add(onHeroStatsOutput);
         mediator.onStartButtonToggled.add(onStartButtonToggled);
         mediator.codeIsRefreshing.onValue(handler_codeIsRefreshing);
         mediator.codeIsUpdated.onValue(handler_codeIsUpdated);
         mediator.reportIsAvailable.onValue(handler_report);
         mediator.reportIsCopied.onValue(handler_report);
         mediator.urlIsCopied.onValue(handler_report);
         mediator.shortWinrateReportIsCopied.onValue(handler_shortReportWinrateReportIsCopied);
         mediator.attackersDefendersWinrateReportIsCopied.onValue(handler_attackersDefendersWinrateReportIsCopied);
         mediator.onBattlegroundChanged.add(onBattlegroundChanged);
         onBattlegroundChanged();
         mediator.onReportUpdated.add(onReportUpdated);
         mediator.onConfigChanged.add(onConfigChanged);
         mediator.onSkinModeChanged.add(onSkinModeChanged);
         onStartButtonToggled();
         mediator.onGradeModeChanged.add(onGradeModeChanged);
         onGradeModeChanged();
         mediator.powerLeft.onValue(handler_powerLeft);
         mediator.powerRight.onValue(handler_powerRight);
         view.list_battleground.signal_itemSelected.add(mediator.action_selectBattleground);
         toggle = new ToggleGroup();
         toggle.signal_updateSelectedItem.add(handler_tabSelected);
         toggle.isSelectionRequired = false;
         var _loc5_:int = 0;
         var _loc4_:* = mediator.HERO_TABS;
         for each(var _loc2_ in mediator.HERO_TABS)
         {
            _loc3_ = new PopupSideTab();
            AssetStorage.rsx.popup_theme.factory.create(_loc3_,view.item_heroTab.clip);
            _loc3_.label = _loc2_;
            toggle.addItem(_loc3_);
            view.layout_tabs.addChild(_loc3_.graphics);
         }
         toggle.selectedIndex = mediator.selectedHeroTab.value;
         toggle.isSelectionRequired = true;
         mediator.selectedHeroTab.onValue(handler_heroTabUpdated);
         view.button_fill_empty_slots.signal_click.add(mediator.action_toggleEmptySlots);
         mediator.onFillEmptySlotsChanged.add(onFillEmptySlotsToggled);
         onFillEmptySlotsToggled();
         createTeamSelector(view.team_block_left,mediator.leftTeamMediator);
         createTeamSelector(view.team_block_right,mediator.rightTeamMediator);
         addEventListener("keyDown",handler_keyDown);
         view.inst0_mainframe_64_64_2_2.graphics.alpha = 0.5;
         Starling.juggler.tween(view.inst0_mainframe_64_64_2_2.graphics,2,{
            "alpha":1,
            "delay":0.5
         });
         Starling.juggler.tween(view.background.graphics,2,{
            "alpha":0,
            "delay":0.5
         });
         centerPopupBy(view.background.graphics);
      }
      
      protected function createTeamSelector(param1:ClipTeamBlock, param2:TeamGatherPopupMediatorAllHeroes) : void
      {
         var _loc5_:ClipTeamSelectBlock = param1.team_selector;
         param2.onEmptySlotsToggled.add(onFillEmptySlotsToggled);
         var _loc3_:TeamGatherPopupHeroList = new TeamGatherPopupHeroList();
         var _loc6_:* = 0.5;
         _loc3_.scaleY = _loc6_;
         _loc3_.scaleX = _loc6_;
         _loc3_.dataProvider = param2.heroList;
         _loc5_.heroList = _loc3_;
         _loc3_.width = _loc5_.container.width / _loc3_.scaleX;
         _loc3_.height = _loc5_.hero_list_container.container.height / _loc3_.scaleY;
         _loc5_.hero_list_container.container.addChild(_loc3_);
         var _loc4_:TeamGatherPopupTeamList = new TeamGatherPopupTeamList(param2);
         _loc6_ = 0.5;
         _loc4_.scaleY = _loc6_;
         _loc4_.scaleX = _loc6_;
         _loc4_.dataProvider = param2.teamListDataProvider;
         _loc4_.width = _loc5_.team_list_container.container.width / _loc4_.scaleY;
         _loc4_.height = _loc5_.team_list_container.container.height / _loc4_.scaleY;
         _loc5_.team_list_container.container.addChild(_loc4_);
      }
      
      protected function onFillEmptySlotsToggled() : void
      {
         view.button_fill_empty_slots.label.text = !!mediator.fillEmptySlots?"fill empty with random":"leave slots empty";
      }
      
      protected function onGradeModeChanged() : void
      {
         var _loc2_:* = false;
         view.button_different_grade.label = mediator.gradeModeButtonName;
         var _loc1_:Boolean = mediator.gradeMode == 0 && !mediator.sameGrades;
         view.tf_grade_different.graphics.visible = _loc1_;
         view.button_different_grade_drop.graphics.visible = _loc1_;
         if(_loc1_)
         {
            view.grade_left.graphics.visible = false;
            view.grade_right.graphics.visible = false;
         }
         else
         {
            _loc2_ = mediator.gradeMode == 2;
            view.grade_left.graphics.visible = !_loc2_;
            view.grade_right.graphics.visible = _loc2_;
         }
      }
      
      protected function onStartButtonToggled() : void
      {
         view.button_start.label.text = !!mediator.startButtonEnabled?"Остановить":"Запустить";
         var _loc1_:* = !mediator.startButtonEnabled;
         view.team_block_right.graphics.visible = _loc1_;
         view.team_block_left.graphics.visible = _loc1_;
      }
      
      protected function onReportUpdated() : void
      {
         view.counters.label_durations_report.text = mediator.durationsReport;
      }
      
      protected function onChangeVisibility(param1:Boolean) : void
      {
         if(param1)
         {
            PopUpManager.addPopUp(this);
         }
         else
         {
            PopUpManager.removePopUp(this);
         }
      }
      
      protected function onCountUpdated() : void
      {
         view.counters.setCounters(mediator.battlesStartedCount,mediator.battlesSucceededCount,mediator.battlesBadCount);
         view.tf_winrate.text = mediator.winrateString;
      }
      
      protected function onHeroStatsOutput(param1:String) : void
      {
         view.label_stat_output.text = param1;
      }
      
      protected function onBattlegroundChanged() : void
      {
         view.list_battleground.list.selectedIndex = mediator.currentBattlegroundIndex;
      }
      
      protected function onConfigChanged() : void
      {
         view.button_config.label = mediator.configName;
      }
      
      protected function onSkinModeChanged() : void
      {
         view.button_skin.label = mediator.skinMode;
      }
      
      private function handler_updateToggleInterpreter(param1:ClipToggleButton) : void
      {
         mediator.action_toggleInterpreter(view.button_toggleInterpreter.isSelected);
         if(mediator.useInterpreter)
         {
            view.button_toggleInterpreter.label.text = "slow";
         }
         else
         {
            view.button_toggleInterpreter.label.text = "fast";
         }
      }
      
      protected function handler_codeIsRefreshing(param1:Boolean) : void
      {
         view.button_refresh.graphics.visible = !param1;
      }
      
      protected function handler_codeIsUpdated(param1:Boolean) : void
      {
         view.tf_refresh_result.text = !!param1?"Загружены обновлённые скрипты":"";
      }
      
      private function handler_report(param1:Boolean) : void
      {
         if(mediator.urlIsCopied.value)
         {
            view.tf_copy_result.text = "URL скопирован!";
         }
         else if(mediator.reportIsCopied.value)
         {
            view.tf_copy_result.text = "Скопировано!";
         }
         else if(mediator.reportIsAvailable.value)
         {
            view.tf_copy_result.text = "Нажми Enter чтобы скопировать статистику";
         }
         else
         {
            view.tf_copy_result.text = "Запусти бои, чтобы набрать статистику";
         }
      }
      
      private function handler_shortReportWinrateReportIsCopied(param1:Boolean) : void
      {
         view.button_winrate_only.label = !!param1?"Скопировано":"Только винрейт%";
      }
      
      private function handler_attackersDefendersWinrateReportIsCopied(param1:Boolean) : void
      {
         view.button_attackersDefenders.label = !!param1?"Скопировано":"Атакующие/Защитники";
      }
      
      private function handler_keyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            mediator.action_copyReport();
         }
         if(param1.keyCode == 36)
         {
            mediator.action_copyUrl();
         }
      }
      
      private function handler_doNotRandomRight(param1:ClipToggleButton) : void
      {
         mediator.action_doNotRandomRight(param1.isSelected);
      }
      
      private function handler_powerLeft(param1:int) : void
      {
         view.tf_power_left.text = String(param1);
      }
      
      private function handler_powerRight(param1:int) : void
      {
         view.tf_power_right.text = String(param1);
      }
      
      private function handler_tabSelected() : void
      {
         mediator.action_selectHeroTab(toggle.selectedIndex);
      }
      
      private function handler_heroTabUpdated(param1:int) : void
      {
      }
   }
}
