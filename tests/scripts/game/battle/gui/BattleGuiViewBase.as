package game.battle.gui
{
   import battle.proxy.CustomAbilityProxy;
   import battle.proxy.displayEvents.CustomManualActionEvent;
   import engine.core.utils.VectorUtil;
   import engine.core.utils.property.IntPropertyWriteable;
   import engine.core.utils.property.ObjectPropertyWriteable;
   import feathers.controls.LayoutGroup;
   import feathers.core.FeathersControl;
   import feathers.core.IFeathersControl;
   import feathers.core.PopUpManager;
   import feathers.layout.AnchorLayout;
   import feathers.layout.AnchorLayoutData;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.BattleGUIAsset;
   import game.battle.controller.BattleProgressInfo;
   import game.battle.controller.BattleSettingsModel;
   import game.battle.controller.entities.BattleHero;
   import game.battle.controller.hero.BattleHeroControllerWithPanel;
   import game.battle.controller.hero.BattleInspectorLogView;
   import game.battle.gui.block.BattleGuiBlock;
   import game.battle.gui.block.BattleGuiUsersBlock;
   import game.battle.gui.teambuffs.BattleTeamEffectBar;
   import game.battle.gui.teambuffs.BattleTeamEffectIcon;
   import game.battle.gui.teamskill.BattleGuiFx;
   import game.battle.view.BattleBossHpBar;
   import game.data.reward.RewardData;
   import game.model.user.UserInfo;
   import game.view.gui.components.toggle.ClipToggleButton;
   import game.view.gui.tutorial.Tutorial;
   import game.view.popup.ClipBasedPopup;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   public class BattleGuiViewBase
   {
      
      private static const ENABLE_CLICK_SPEED_UP_IN_TEST_BUILD:Boolean = true;
       
      
      protected var mediator:BattleGuiMediator;
      
      private var ultTitle:UltTitleView;
      
      private var blocks:Vector.<BattleGuiBlock>;
      
      protected var attackersTeamEffectsBar:BattleTeamEffectBar;
      
      protected var defendersTeamEffectsBar:BattleTeamEffectBar;
      
      protected var clip_top_right:BattleGuiTopRight;
      
      protected var bottomGradient:Image;
      
      protected var inspectorLogView:BattleInspectorLogView;
      
      private var popupCount:int = 0;
      
      private var darkScreen:BattleGuiDarkScreen;
      
      private var fxs:BattleGuiFxContainer;
      
      public const graphics:LayoutGroup = new LayoutGroup();
      
      public const userAttacker:ObjectPropertyWriteable = new ObjectPropertyWriteable(UserInfo);
      
      public const userDefeneder:ObjectPropertyWriteable = new ObjectPropertyWriteable(UserInfo);
      
      public const timeLeft:IntPropertyWriteable = new IntPropertyWriteable();
      
      public function BattleGuiViewBase()
      {
         blocks = new Vector.<BattleGuiBlock>();
         super();
         graphics.layout = new AnchorLayout();
         AssetStorage.instance.globalLoader.requestAssetWithCallback(AssetStorage.rsx.battle_interface,handler_battleGuiAssetLoaded);
         darkScreen = new BattleGuiDarkScreen(NaN,NaN);
         fxs = new BattleGuiFxContainer(graphics);
         Starling.current.stage.addEventListener("resize",handler_resize);
         handler_resize(null);
      }
      
      public function dispose() : void
      {
         darkScreen.dispose();
         graphics.removeFromParent();
         ultTitle.graphics.dispose();
         graphics.dispose();
         Starling.current.stage.removeEventListener("resize",handler_resize);
         if(attackersTeamEffectsBar)
         {
            attackersTeamEffectsBar.dispose();
         }
         if(defendersTeamEffectsBar)
         {
            defendersTeamEffectsBar.dispose();
         }
         var _loc3_:int = 0;
         var _loc2_:* = blocks;
         for each(var _loc1_ in blocks)
         {
            _loc1_.dispose();
         }
      }
      
      public function advanceTime(param1:Number, param2:Number) : void
      {
         ultTitle.advanceTime(param1);
         if(attackersTeamEffectsBar)
         {
            attackersTeamEffectsBar.advanceTime(param1);
         }
         if(defendersTeamEffectsBar)
         {
            defendersTeamEffectsBar.advanceTime(param1);
         }
         fxs.advanceTime(param1,param2);
         var _loc5_:int = 0;
         var _loc4_:* = blocks;
         for each(var _loc3_ in blocks)
         {
            _loc3_.advanceTime(param1,param2);
         }
      }
      
      public function addBlock(param1:BattleGuiBlock) : void
      {
         blocks.push(param1);
         if(mediator)
         {
            param1.init(this);
         }
      }
      
      public function removeBlock(param1:BattleGuiBlock) : void
      {
         var _loc2_:int = blocks.indexOf(param1);
         if(_loc2_ != -1)
         {
            VectorUtil.removeAt(blocks,_loc2_);
            param1.dispose();
         }
      }
      
      public function setUsers(param1:UserInfo, param2:UserInfo) : void
      {
         userAttacker.value = param1;
         userDefeneder.value = param2;
         var _loc5_:int = 0;
         var _loc4_:* = blocks;
         for(var _loc3_ in blocks)
         {
            if(_loc3_ is BattleGuiUsersBlock)
            {
               return;
            }
         }
         addBlock(new BattleGuiUsersBlock());
      }
      
      public function attachHeroPanel(param1:BattleHeroControllerWithPanel) : void
      {
      }
      
      public function attachUserPanel(param1:UserInfo, param2:Boolean) : void
      {
      }
      
      public function addCustomManualActionEvent(param1:CustomManualActionEvent) : void
      {
      }
      
      public function addTeamSkill(param1:CustomAbilityProxy) : void
      {
      }
      
      public function action_toggleTeamSkill(param1:int) : void
      {
      }
      
      public function startUlt(param1:String) : void
      {
         ultTitle.addTitle(param1);
      }
      
      public function addFx(param1:BattleGuiFx) : void
      {
         fxs.add(param1);
      }
      
      public function addDroppedReward(param1:RewardData) : void
      {
         param1.add(param1);
      }
      
      public function addBossHpBar(param1:BattleBossHpBar) : void
      {
         graphics.addChild(param1.graphics);
      }
      
      public function addTeamEffect(param1:BattleTeamEffectIcon) : void
      {
         if(param1.isAttackersTeam)
         {
            if(attackersTeamEffectsBar == null)
            {
               attackersTeamEffectsBar = new BattleTeamEffectBar(true);
               graphics.addChild(attackersTeamEffectsBar.graphics);
            }
            attackersTeamEffectsBar.add(param1);
         }
         else
         {
            if(defendersTeamEffectsBar == null)
            {
               defendersTeamEffectsBar = new BattleTeamEffectBar(false);
               graphics.addChild(defendersTeamEffectsBar.graphics);
            }
            defendersTeamEffectsBar.add(param1);
         }
      }
      
      public function cleanUpBattle() : void
      {
         if(attackersTeamEffectsBar != null)
         {
            attackersTeamEffectsBar.cleanUpBattle();
         }
         if(defendersTeamEffectsBar != null)
         {
            defendersTeamEffectsBar.cleanUpBattle();
         }
      }
      
      public function addBattlePopup(param1:ClipBasedPopup, param2:Number = NaN) : void
      {
         if(popupCount == 0)
         {
            toggleDarkScreen(true,param2);
         }
         graphics.addChild(param1);
         PopUpManager.centerPopUp(param1);
         popupCount = Number(popupCount) + 1;
         param1.addEventListener("removed",handler_battlePopupRemoved);
         if(param1 is IFeathersControl)
         {
            param1.addEventListener("resize",popUp_resizeHandler);
         }
      }
      
      public function lockAndHideControlls() : void
      {
         graphics.removeChildren(0,-1,true);
         unsubscribeMediator(mediator);
      }
      
      public function subscribeSceneGraphics(param1:DisplayObject) : void
      {
         param1.addEventListener("touch",onTouch);
      }
      
      public function unsubscribeSceneGraphics(param1:DisplayObject) : void
      {
         param1.removeEventListener("touch",onTouch);
      }
      
      public function hidePauseClock() : void
      {
         clip_top_right.clock_icon.graphics.visible = false;
         clip_top_right.clock_glow.graphics.visible = false;
         clip_top_right.tf_timer.graphics.visible = false;
      }
      
      function subscribeSettings(param1:BattleSettingsModel) : void
      {
         param1.battleIsInteractive.onValue(handler_battleIsInteractive);
         param1.soundEnabled.onValue(clip_top_right.button_sound.setIsSelectedSilently);
         param1.onPause.onValue(clip_top_right.button_pause.setIsSelectedSilently);
      }
      
      function unsubscribeSettings(param1:BattleSettingsModel) : void
      {
         param1.battleIsInteractive.unsubscribe(handler_battleIsInteractive);
         param1.soundEnabled.unsubscribe(clip_top_right.button_sound.setIsSelectedSilently);
         param1.onPause.unsubscribe(clip_top_right.button_pause.setIsSelectedSilently);
      }
      
      function subscribeProgress(param1:BattleProgressInfo) : void
      {
         if(param1.waveCount > 1)
         {
            param1.waveIndex.onValue(handler_waveIndex);
         }
         param1.timeLeft.onValue(handler_timeLeft);
      }
      
      function subscribeMediator(param1:BattleGuiMediator) : void
      {
         this.mediator = param1;
         var _loc4_:int = 0;
         var _loc3_:* = blocks;
         for each(var _loc2_ in blocks)
         {
            _loc2_.init(this);
         }
         graphics.addEventListener("keyDown",param1.action_keyDown);
         graphics.addEventListener("keyUp",param1.action_keyUp);
         darkScreen.onClick.add(param1.action_continue);
         clip_top_right.button_sound.signal_updateSelectedState.add(handler_toggleSoundFromScreen);
         clip_top_right.button_pause.signal_updateSelectedState.add(handler_pause);
      }
      
      function unsubscribeMediator(param1:BattleGuiMediator) : void
      {
         if(param1)
         {
            graphics.removeEventListener("keyDown",param1.action_keyDown);
            graphics.removeEventListener("keyUp",param1.action_keyUp);
            graphics.removeEventListener("touch",onTouch);
            darkScreen.onClick.remove(param1.action_continue);
            clip_top_right.button_sound.signal_updateSelectedState.remove(handler_toggleSoundFromScreen);
            clip_top_right.button_pause.signal_updateSelectedState.remove(handler_pause);
         }
         this.mediator = null;
      }
      
      public function addAnchoredObject(param1:DisplayObject, param2:Number = NaN, param3:Number = NaN, param4:Number = NaN, param5:Number = NaN, param6:Number = NaN, param7:Number = NaN) : void
      {
         var _loc8_:* = null;
         if(param1 is FeathersControl)
         {
            _loc8_ = param1 as FeathersControl;
         }
         else
         {
            _loc8_ = new LayoutGroup();
            _loc8_.addChild(param1);
         }
         _loc8_.layoutData = new AnchorLayoutData(param2,param3,param4,param5,param6,param7);
         graphics.addChild(_loc8_);
      }
      
      public function setAutoToggleable(param1:Boolean) : void
      {
      }
      
      public function setPlayerTeamHeroesCount(param1:int) : void
      {
      }
      
      function setWaveCounter(param1:int) : void
      {
      }
      
      function hideWaveCounter() : void
      {
      }
      
      protected function toggleDarkScreen(param1:Boolean, param2:Number = NaN) : void
      {
         if(param1)
         {
            darkScreen.show(graphics,param2);
         }
         else
         {
            darkScreen.hide();
         }
      }
      
      protected function resize(param1:Number, param2:Number) : void
      {
         darkScreen.setSize(param1,param2);
         graphics.width = param1;
         graphics.height = param2;
      }
      
      private function onTouch(param1:TouchEvent) : void
      {
         var _loc2_:* = null;
         if(param1)
         {
            _loc2_ = param1.getTouch(param1.currentTarget as DisplayObject,"ended");
            if(_loc2_ && mediator)
            {
               mediator.action_clickScene();
            }
         }
      }
      
      protected function handler_battleGuiAssetLoaded(param1:BattleGUIAsset) : void
      {
         bottomGradient = new Image(param1.getTexture("bg_gradient"));
         bottomGradient.width = graphics.width;
         bottomGradient.y = graphics.height - bottomGradient.height;
         graphics.addChild(bottomGradient);
         ultTitle = param1.create_ultTitle();
         var _loc2_:LayoutGroup = new LayoutGroup();
         _loc2_.addChild(ultTitle.graphics);
         if(ultTitle.graphics.width < 1000)
         {
            _loc2_.layoutData = new AnchorLayoutData(40,NaN,NaN,NaN,0);
         }
         else
         {
            _loc2_.layoutData = new AnchorLayoutData(-20,NaN,NaN,0,NaN);
         }
         graphics.addChild(_loc2_);
         if(BattleHero.BATTLE_INSPECTOR)
         {
            inspectorLogView = new BattleInspectorLogView(graphics);
         }
         clip_top_right = param1.create(BattleGuiTopRight,"gui_top_right");
         if(Tutorial.flags.hideBattlePauseButton)
         {
            clip_top_right.button_pause.graphics.visible = false;
         }
         else
         {
            clip_top_right.button_sound.graphics.visible = false;
         }
         clip_top_right.layoutGroup.setSize(0,0);
         clip_top_right.layoutGroup.layoutData = new AnchorLayoutData(0,0);
         graphics.addChild(clip_top_right.layoutGroup);
      }
      
      private function handler_battlePopupRemoved(param1:Event) : void
      {
         var _loc2_:ClipBasedPopup = param1.target as ClipBasedPopup;
         if(_loc2_)
         {
            _loc2_.removeEventListener("removed",handler_battlePopupRemoved);
            popupCount = Number(popupCount) - 1;
            if(popupCount == 0)
            {
               toggleDarkScreen(false);
            }
         }
      }
      
      protected function handler_waveIndex(param1:int) : void
      {
      }
      
      protected function handler_timeLeft(param1:int) : void
      {
         timeLeft.value = param1;
         var _loc3_:int = param1 / 60;
         var _loc2_:int = param1 % 60;
         clip_top_right.tf_timer.text = (_loc3_ != 0?String(_loc3_):"0") + ":" + (_loc2_ >= 10?String(_loc2_):"0" + _loc2_);
      }
      
      function handler_battleIsInteractive(param1:Boolean) : void
      {
      }
      
      protected function handler_toggleAutoBattle(param1:ClipToggleButton) : void
      {
         mediator.action_toggleAutoBattle();
      }
      
      protected function handler_toggleSpeedUp() : void
      {
         mediator.action_toggleSpeedUp();
      }
      
      private function handler_toggleSoundFromScreen(param1:ClipToggleButton) : void
      {
         mediator.action_toggleSoundFromScreen();
      }
      
      private function handler_pause(param1:ClipToggleButton) : void
      {
         mediator.action_pause();
      }
      
      private function handler_resize(param1:Event) : void
      {
         resize(Starling.current.stage.stageWidth,Starling.current.stage.stageHeight);
      }
      
      protected function popUp_resizeHandler(param1:Event) : void
      {
         var _loc2_:DisplayObject = DisplayObject(param1.currentTarget);
         PopUpManager.centerPopUp(_loc2_);
      }
   }
}
