package game.battle.gui
{
   import engine.context.GameContext;
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import game.battle.controller.BattleController;
   import game.battle.controller.BattleSettingsModel;
   import game.data.storage.mechanic.MechanicStorage;
   import game.mechanics.expedition.mediator.SubscriptionPopupMediator;
   import game.mechanics.expedition.popup.SubscriptionPopup;
   import game.mediator.gui.popup.battle.BattlePausePopupMediator;
   import game.model.GameModel;
   import game.model.user.subscription.PlayerSubscriptionData;
   import game.view.gui.components.toggle.ClipToggleButton;
   import game.view.gui.tutorial.Tutorial;
   import game.view.popup.PopupBase;
   import game.view.popup.battle.BattlePausePopup;
   import starling.events.KeyboardEvent;
   
   public class BattleGuiMediator
   {
      
      public static var enableTestSpeedUp:BooleanPropertyWriteable = new BooleanPropertyWriteable(false);
       
      
      private var pausePopup:BattlePausePopup;
      
      private var subscriptionPopup:SubscriptionPopup;
      
      private var currentPopup:PopupBase;
      
      protected var controller:BattleController;
      
      private var model:BattleSettingsModel;
      
      private var view:BattleGuiViewBase;
      
      private var shiftDown:Boolean = false;
      
      private const _speedUpIsAvailable:BooleanPropertyWriteable = new BooleanPropertyWriteable(false);
      
      public function BattleGuiMediator(param1:BattleGuiViewBase, param2:BattleController)
      {
         super();
         this.view = param1;
         this.controller = param2;
         model = param2.battleSettings;
         param1.subscribeMediator(this);
         param1.subscribeSettings(model);
         param1.subscribeProgress(param2.progressInfo);
         model.onPause.onValue(handler_onPause);
         GameModel.instance.player.subscription.signal_updated.add(handler_updateSubscription);
         enableTestSpeedUp.onValue(handler_enableTestSpeedUp);
      }
      
      public function dispose() : void
      {
         GameModel.instance.player.subscription.signal_updated.remove(handler_updateSubscription);
         view.unsubscribeMediator(this);
         view.unsubscribeSettings(model);
         if(pausePopup)
         {
            pausePopup.dispose();
         }
         if(subscriptionPopup)
         {
            subscriptionPopup.dispose();
         }
      }
      
      public function get speedUpIsAvailable() : BooleanProperty
      {
         return _speedUpIsAvailable;
      }
      
      public function get showSpeedUpButton() : Boolean
      {
         return GameModel.instance.player.levelData.level.level >= MechanicStorage.SUBSCRIPTION.teamLevel || GameModel.instance.player.subscription.subscriptionInfo.isActive && Tutorial.flags.autoBattleAvailable;
      }
      
      function action_pause() : void
      {
         controller.action_pause();
      }
      
      function action_continue() : void
      {
         controller.action_pause();
      }
      
      function action_retreat() : void
      {
         controller.action_retreat();
      }
      
      function action_toggleSoundFromScreen() : void
      {
         controller.action_toggleAllSounds();
      }
      
      function action_toggleAutoBattle() : void
      {
         controller.action_toggleAutoBattle();
      }
      
      function action_toggleSpeedUp() : void
      {
         if(_speedUpIsAvailable.value)
         {
            controller.action_toggleSpeedUp();
         }
         else
         {
            showSubscriptionPopup();
            controller.action_pause();
         }
      }
      
      function action_toggleSpeed() : void
      {
         controller.action_toggleSpeed();
      }
      
      function action_keyDown(param1:KeyboardEvent) : void
      {
         if(Tutorial.inputIsBlocked)
         {
            return;
         }
         var _loc2_:Boolean = model.onPause.value;
         if(param1.keyCode == 32 && _loc2_)
         {
            togglePausePopup();
         }
         else if(param1.keyCode == 27)
         {
            controller.action_pause();
         }
         else if(param1.keyCode == 16)
         {
            if(!shiftDown && _speedUpIsAvailable.value)
            {
               shiftDown = true;
               controller.action_toggleSpeedUp();
            }
         }
         else if(param1.keyCode == 65)
         {
            controller.action_toggleAutoBattle();
         }
         else if(param1.keyCode >= 49 && param1.keyCode <= 53)
         {
            controller.action_toggleHero(param1.keyCode - 49 + 1);
         }
         else if(param1.keyCode == 81)
         {
            view.action_toggleTeamSkill(0);
         }
      }
      
      function action_keyUp(param1:KeyboardEvent) : void
      {
         if(Tutorial.inputIsBlocked)
         {
            return;
         }
         if(param1.keyCode == 16)
         {
            if(shiftDown && _speedUpIsAvailable.value)
            {
               shiftDown = false;
               controller.action_toggleSpeedUp();
            }
         }
      }
      
      function action_clickScene() : void
      {
         controller.action_clickScene();
      }
      
      protected function createPausePopup() : BattlePausePopup
      {
         var _loc1_:BattlePausePopupMediator = new BattlePausePopupMediator(controller.playerSettings,controller.isReplay);
         _loc1_.signal_continue.add(handler_pausePopupContinue);
         _loc1_.signal_retreat.add(handler_pausePopupRetreat);
         return _loc1_.createPopup() as BattlePausePopup;
      }
      
      protected function createSubscriptionPopup() : SubscriptionPopup
      {
         var _loc1_:SubscriptionPopupMediator = new SubscriptionPopupMediator(GameModel.instance.player);
         _loc1_.signal_dispose.add(handler_subscriptionPopupDispose);
         return _loc1_.createPopup() as SubscriptionPopup;
      }
      
      private function showSubscriptionPopup() : void
      {
         if(subscriptionPopup == null)
         {
            subscriptionPopup = createSubscriptionPopup();
         }
         currentPopup = subscriptionPopup;
         view.addBattlePopup(subscriptionPopup,0.9);
      }
      
      private function showPausePopup() : void
      {
         if(pausePopup == null)
         {
            pausePopup = createPausePopup();
         }
         currentPopup = pausePopup;
         view.addBattlePopup(pausePopup);
      }
      
      private function hideCurrentPopup() : void
      {
         if(!model.onPause.value && currentPopup && currentPopup.parent)
         {
            currentPopup.removeFromParent();
            if(currentPopup != pausePopup)
            {
               if(currentPopup == subscriptionPopup)
               {
                  subscriptionPopup = null;
               }
               currentPopup.dispose();
               currentPopup = null;
            }
         }
      }
      
      private function togglePausePopup() : void
      {
         if(!pausePopup || !model.onPause.value)
         {
            return;
         }
         if(pausePopup.parent)
         {
            pausePopup.removeFromParent();
         }
         else
         {
            view.addBattlePopup(pausePopup);
         }
      }
      
      protected function handler_onPause(param1:Boolean) : void
      {
         if(param1)
         {
            if(currentPopup == null || currentPopup != subscriptionPopup)
            {
               showPausePopup();
            }
         }
         else
         {
            hideCurrentPopup();
         }
      }
      
      protected function handler_pausePopupContinue() : void
      {
         controller.action_pause();
         if(pausePopup && pausePopup.parent)
         {
            pausePopup.removeFromParent();
         }
      }
      
      protected function handler_subscriptionPopupDispose() : void
      {
         var _loc2_:* = null;
         var _loc1_:Boolean = false;
         if(subscriptionPopup)
         {
            _loc2_ = subscriptionPopup;
            subscriptionPopup = null;
            if(_loc2_.parent)
            {
               _loc2_.removeFromParent(true);
            }
            _loc1_ = model.onPause.value;
            if(_loc1_)
            {
               controller.action_pause();
            }
         }
      }
      
      protected function handler_pausePopupRetreat() : void
      {
         controller.action_retreat();
      }
      
      protected function onSoundToggledFromScreen(param1:ClipToggleButton) : void
      {
         GameModel.instance.player.settings.playSounds.setValue(param1.isSelected);
         GameModel.instance.player.settings.playMusic.setValue(param1.isSelected);
      }
      
      protected function handler_enableTestSpeedUp(param1:Boolean) : void
      {
         _speedUpIsAvailable.value = GameModel.instance.player.subscription.subscriptionInfo.isActive || enableTestSpeedUp.value || GameContext.instance.consoleEnabled;
      }
      
      protected function handler_updateSubscription(param1:PlayerSubscriptionData) : void
      {
         _speedUpIsAvailable.value = GameModel.instance.player.subscription.subscriptionInfo.isActive || enableTestSpeedUp.value;
      }
   }
}
