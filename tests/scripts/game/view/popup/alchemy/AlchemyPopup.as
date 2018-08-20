package game.view.popup.alchemy
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import game.assets.storage.AssetStorage;
   import game.command.rpc.refillable.AlchemyRewardValueObject;
   import game.mediator.gui.popup.alchemy.AlchemyPopupMediator;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.IEscClosable;
   
   public class AlchemyPopup extends ClipBasedPopup implements ITutorialActionProvider, ITutorialNodePresenter, IEscClosable
   {
       
      
      private var mediator:AlchemyPopupMediator;
      
      private const clip:AlchemyPopupClip = AssetStorage.rsx.popup_theme.create_dialog_alchemy();
      
      private var __tmp_reward:AlchemyRewardValueObject;
      
      public function AlchemyPopup(param1:AlchemyPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "bank_gold";
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(mediator)
         {
            clip.button_close.signal_click.remove(mediator.close);
            mediator.resultDispenser.signal_onElement.remove(onRewardDispensered);
            mediator.signal_updateCostAndReward.remove(updateCostAndReward);
            if(__tmp_reward)
            {
               mediator.action_addReward(__tmp_reward);
            }
         }
         clip.crit_wheel.dispose();
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.ALCHEMY;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         _loc2_.addCloseButton(clip.button_close);
         _loc2_.addButton(TutorialNavigator.ACTION_ALCHEMY_USE,clip.button_single);
         return _loc2_;
      }
      
      override public function close() : void
      {
         if(__tmp_reward)
         {
            mediator.action_addReward(__tmp_reward);
            __tmp_reward = null;
         }
         clip.crit_wheel.dispose();
         super.close();
      }
      
      override protected function initialize() : void
      {
         var _loc2_:int = 0;
         super.initialize();
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         clip.button_close.signal_click.add(close);
         clip.button_single.signal_click.add(mediator.action_use_single);
         clip.button_multi.signal_click.add(mediator.action_use_multi);
         clip.tf_roll_single.text = Translate.translateArgs("UI_DIALOG_ALCHEMY_TF_ROLL_X",1);
         clip.tf_roll_multi.text = Translate.translateArgs("UI_DIALOG_ALCHEMY_TF_ROLL_X",AlchemyPopupMediator.MULTI_ROLL);
         mediator.resultDispenser.signal_onElement.add(onRewardDispensered);
         mediator.signal_updateCostAndReward.add(updateCostAndReward);
         updateResults();
         updateCostAndReward();
         updateVipLevel();
         clip.title = Translate.translate("UI_DIALOG_ALCHEMY_TITLE");
         clip.tf_history.text = Translate.translate("UI_DIALOG_ALCHEMY_HISTORY");
         var _loc1_:int = clip.crit_wheel.crit_wheel_face.sector.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            clip.crit_wheel.crit_wheel_face.sector[_loc2_].data = mediator.critWheelData[_loc2_];
            mediator.critWheelData[_loc2_].angle = -18 - 36 * _loc2_;
            _loc2_++;
         }
         clip.crit_wheel.signal_rewardRollComplete.add(handler_rewardRollComplete);
      }
      
      private function updateAttemptsCounter() : void
      {
         clip.tf_tries_label.text = Translate.translate("UI_DIALOG_ALCHEMY_EXCHANGES");
         clip.tf_tries_value.text = mediator.availableCount.toString();
      }
      
      private function updateResults() : void
      {
         updateAttemptsCounter();
         clip.log_list.list.dataProvider = new ListCollection(mediator.rewardList);
      }
      
      private function updateCostAndReward() : void
      {
         updateAttemptsCounter();
         clip.button_single.cost = mediator.nextUseCost_single;
         clip.button_multi.cost = mediator.nextUseCost_multi;
         clip.crit_wheel.tf_gold.text = String(mediator.nextUseReward);
      }
      
      private function updateVipLevel() : void
      {
         updateAttemptsCounter();
      }
      
      private function onRewardDispensered(param1:AlchemyRewardValueObject) : void
      {
         handler_rewardRollComplete();
         if(param1)
         {
            clip.crit_wheel.rotateTo(param1.crit);
            __tmp_reward = param1;
         }
      }
      
      private function handler_rewardRollComplete() : void
      {
         var _loc1_:* = null;
         if(__tmp_reward)
         {
            mediator.action_addReward(__tmp_reward);
            _loc1_ = __tmp_reward;
            clip.log_list.list.dataProvider.addItemAt(_loc1_,0);
            clip.log_list.list.verticalScrollPosition = clip.log_item.clip.bounds.height;
            clip.log_list.list.scrollToDisplayIndex(0,0.3);
            __tmp_reward = null;
         }
      }
   }
}
