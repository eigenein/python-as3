package game.battle.gui
{
   import battle.proxy.CustomAbilityProxy;
   import battle.proxy.displayEvents.CustomManualActionEvent;
   import com.progrestar.common.lang.Translate;
   import feathers.controls.Label;
   import feathers.controls.LayoutGroup;
   import feathers.layout.AnchorLayoutData;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.BattleGUIAsset;
   import game.battle.controller.BattleProgressInfo;
   import game.battle.controller.BattleSettingsModel;
   import game.battle.controller.hero.BattleHeroControllerWithPanel;
   import game.battle.gui.hero.BattleGUIHeroListLayoutGroup;
   import game.battle.gui.teamskill.BattleTeamSkillIcon;
   import game.view.gui.components.LayoutFactory;
   import game.view.gui.tutorial.Tutorial;
   
   public class BattleGuiView extends BattleGuiViewBase
   {
       
      
      private var reward:BattleGuiRewardBlock;
      
      private var heroButtonsLayoutGroup:BattleGUIHeroListLayoutGroup;
      
      private var customSkillLayoutGroup:LayoutGroup;
      
      private var waveCounter:BattleGUIWaveCounter;
      
      private var controllButtonsBlock:LayoutGroup;
      
      private var autoAttack_button:BattleGuiToggleButton;
      
      private var speedRun_button:BattleGuiSpeedUpButton;
      
      private var clock_label:Label;
      
      private var teamSkills:Vector.<BattleTeamSkillIcon>;
      
      public function BattleGuiView()
      {
         teamSkills = new Vector.<BattleTeamSkillIcon>();
         super();
         heroButtonsLayoutGroup = new BattleGUIHeroListLayoutGroup();
         heroButtonsLayoutGroup.layoutData = new AnchorLayoutData(NaN,NaN,20,NaN,0);
         graphics.addChild(heroButtonsLayoutGroup);
      }
      
      override public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = teamSkills;
         for each(var _loc1_ in teamSkills)
         {
            _loc1_.dispose();
         }
         teamSkills.length = 0;
         super.dispose();
      }
      
      override public function advanceTime(param1:Number, param2:Number) : void
      {
         super.advanceTime(param1,param2);
         var _loc5_:int = 0;
         var _loc4_:* = teamSkills;
         for each(var _loc3_ in teamSkills)
         {
            _loc3_.advanceTime(param1);
         }
      }
      
      override public function attachHeroPanel(param1:BattleHeroControllerWithPanel) : void
      {
         heroButtonsLayoutGroup.attachHeroPanel(param1);
      }
      
      override public function addCustomManualActionEvent(param1:CustomManualActionEvent) : void
      {
         heroButtonsLayoutGroup.addCustomManualActionEvent(param1);
      }
      
      override public function addTeamSkill(param1:CustomAbilityProxy) : void
      {
         if(customSkillLayoutGroup == null)
         {
            customSkillLayoutGroup = new LayoutGroup();
            customSkillLayoutGroup.layoutData = new AnchorLayoutData(NaN,NaN,10,20);
            graphics.addChild(customSkillLayoutGroup);
         }
         var _loc2_:BattleTeamSkillIcon = new BattleTeamSkillIcon();
         _loc2_.setData(param1);
         teamSkills.push(_loc2_);
         customSkillLayoutGroup.addChild(_loc2_.graphics);
      }
      
      override public function action_toggleTeamSkill(param1:int) : void
      {
         if(teamSkills.length > param1 && teamSkills[param1] != null)
         {
            teamSkills[param1].tryToActivate();
         }
      }
      
      override function subscribeSettings(param1:BattleSettingsModel) : void
      {
         super.subscribeSettings(param1);
         param1.auto.onValue(autoAttack_button.setIsSelectedSilently);
         param1.isFast.onValue(speedRun_button.setIsSelectedSilently);
      }
      
      override function unsubscribeSettings(param1:BattleSettingsModel) : void
      {
         super.unsubscribeSettings(param1);
         param1.auto.unsubscribe(autoAttack_button.setIsSelectedSilently);
         param1.isFast.unsubscribe(speedRun_button.setIsSelectedSilently);
      }
      
      override function subscribeProgress(param1:BattleProgressInfo) : void
      {
         super.subscribeProgress(param1);
         if(param1.waveCount > 1)
         {
            waveCounter.graphics.visible = true;
         }
         else
         {
            waveCounter.graphics.visible = false;
         }
      }
      
      override function subscribeMediator(param1:BattleGuiMediator) : void
      {
         super.subscribeMediator(param1);
         autoAttack_button.signal_updateSelectedState.add(handler_toggleAutoBattle);
         speedRun_button.signal_click.add(handler_toggleSpeedUp);
         param1.speedUpIsAvailable.onValue(handler_speedUpIsAvailable);
      }
      
      override function unsubscribeMediator(param1:BattleGuiMediator) : void
      {
         if(param1)
         {
            autoAttack_button.signal_updateSelectedState.remove(handler_toggleAutoBattle);
            speedRun_button.signal_click.remove(handler_toggleSpeedUp);
            param1.speedUpIsAvailable.unsubscribe(handler_speedUpIsAvailable);
         }
         super.unsubscribeMediator(param1);
      }
      
      override public function setAutoToggleable(param1:Boolean) : void
      {
         if(param1)
         {
            autoAttack_button.graphics.alpha = 1;
         }
         else
         {
            autoAttack_button.graphics.alpha = 0.5;
         }
         autoAttack_button.isEnabled = param1;
      }
      
      override function handler_battleIsInteractive(param1:Boolean) : void
      {
         heroButtonsLayoutGroup.enabled = param1;
      }
      
      override function setWaveCounter(param1:int) : void
      {
         waveCounter.graphics.visible = true;
         waveCounter.waveNumber = param1;
      }
      
      override function hideWaveCounter() : void
      {
         waveCounter.graphics.visible = false;
      }
      
      override protected function handler_battleGuiAssetLoaded(param1:BattleGUIAsset) : void
      {
         super.handler_battleGuiAssetLoaded(param1);
         waveCounter = param1.create_waveCounter();
         var _loc2_:LayoutGroup = new LayoutGroup();
         _loc2_.addChild(waveCounter.graphics);
         _loc2_.layoutData = new AnchorLayoutData(25,NaN,NaN,NaN,0);
         graphics.addChild(_loc2_);
         graphics.addChild(createControlButtons());
      }
      
      override protected function handler_waveIndex(param1:int) : void
      {
         waveCounter.waveNumber = param1;
      }
      
      private function createControlButtons() : LayoutGroup
      {
         var _loc1_:LayoutGroup = LayoutFactory.vertical(0);
         _loc1_.layoutData = new AnchorLayoutData(NaN,17,17,NaN);
         autoAttack_button = AssetStorage.rsx.battle_interface.create_toggleLabeledButton();
         autoAttack_button.isEnabled = false;
         autoAttack_button.label.text = Translate.translate("UI_POPUP_BATTLE_AUTO");
         speedRun_button = AssetStorage.rsx.battle_interface.create_toggleSpeedUpButton();
         autoAttack_button.graphics.visible = Tutorial.flags.autoBattleAvailable;
         _loc1_.addChild(autoAttack_button.graphics);
         _loc1_.addChild(speedRun_button.graphics);
         return _loc1_;
      }
      
      protected function handler_speedUpIsAvailable(param1:Boolean) : void
      {
         speedRun_button.speedUpIsAvailblele = param1;
         speedRun_button.graphics.visible = param1 || mediator.showSpeedUpButton;
      }
   }
}
