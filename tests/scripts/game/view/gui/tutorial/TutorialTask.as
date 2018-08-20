package game.view.gui.tutorial
{
   import engine.debug.ClickLoger;
   import game.data.reward.RewardData;
   import game.data.storage.tutorial.TutorialTaskDescription;
   import game.view.gui.tutorial.condition.TutorialCondition;
   import game.view.gui.tutorial.condition.TutorialStateCondition;
   import game.view.gui.tutorial.dialogs.TutorialMessageEntry;
   import game.view.gui.tutorial.tutorialtarget.ITutorialTargetKey;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import idv.cjcat.signals.Signal;
   
   public class TutorialTask implements ITutorialConditionListener
   {
       
      
      public var chain:TutorialTaskChain;
      
      public var description:TutorialTaskDescription;
      
      public var targetScreenNode:TutorialNode;
      
      public const target:TutorialTarget = new TutorialTarget();
      
      public var message:TutorialMessageEntry;
      
      public var startCondition:TutorialCondition;
      
      var skipCondition:TutorialStateCondition;
      
      public var completeCondition:TutorialCondition;
      
      private var availableActions:Vector.<TutorialNode>;
      
      private var notLockingScreens:Vector.<TutorialNode>;
      
      private var _signal_onStart:Signal;
      
      private var _signal_onHideMessage:Signal;
      
      private var _signal_onComplete:Signal;
      
      private var _signal_onReward:Signal;
      
      private var _reward:RewardData;
      
      private var started:Boolean = false;
      
      private var manager:TutorialTaskManager;
      
      public function TutorialTask(param1:TutorialTaskDescription, param2:TutorialTaskChain)
      {
         super();
         this.description = param1;
         this.chain = param2;
      }
      
      public function dispose() : void
      {
         if(_signal_onStart)
         {
            _signal_onStart.clear();
            _signal_onStart = null;
         }
         if(_signal_onHideMessage)
         {
            _signal_onHideMessage.clear();
            _signal_onHideMessage = null;
         }
         if(_signal_onComplete)
         {
            _signal_onComplete.clear();
            _signal_onComplete = null;
         }
      }
      
      public function get signal_onStart() : Signal
      {
         if(_signal_onStart)
         {
            §§push(_signal_onStart);
         }
         else
         {
            _signal_onStart = new Signal(TutorialTask);
            §§push(new Signal(TutorialTask));
         }
         return §§pop();
      }
      
      public function get signal_onHideMessage() : Signal
      {
         if(_signal_onHideMessage)
         {
            §§push(_signal_onHideMessage);
         }
         else
         {
            _signal_onHideMessage = new Signal(TutorialTask);
            §§push(new Signal(TutorialTask));
         }
         return §§pop();
      }
      
      public function get signal_onComplete() : Signal
      {
         if(_signal_onComplete)
         {
            §§push(_signal_onComplete);
         }
         else
         {
            _signal_onComplete = new Signal(TutorialTask);
            §§push(new Signal(TutorialTask));
         }
         return §§pop();
      }
      
      public function get signal_onReward() : Signal
      {
         if(_signal_onReward)
         {
            §§push(_signal_onReward);
         }
         else
         {
            _signal_onReward = new Signal(TutorialTask);
            §§push(new Signal(TutorialTask));
         }
         return §§pop();
      }
      
      public function get needConfirmButton() : Boolean
      {
         return completeCondition.ident == "tutorialOk";
      }
      
      public function get hasGuiTask() : Boolean
      {
         return targetScreenNode != null || availableActions && availableActions.length > 0;
      }
      
      public function get reward() : RewardData
      {
         return _reward;
      }
      
      public function filterNavigationAndCompleteCondition(param1:ITutorialTargetKey, param2:ITutorialTargetKey = null) : void
      {
         setKeys(param1,param2);
         completeCondition.data = param1;
      }
      
      public function setKeys(param1:ITutorialTargetKey, param2:ITutorialTargetKey = null, param3:ITutorialTargetKey = null, param4:ITutorialTargetKey = null) : TutorialTask
      {
         target.setKeys(param1,param2,param3,param4);
         return this;
      }
      
      public function setGuiTarget(param1:TutorialNode, ... rest) : void
      {
         targetScreenNode = param1;
         if(rest && rest.length > 0)
         {
            this.availableActions = Vector.<TutorialNode>(rest);
         }
      }
      
      public function setGuiTargetWithArray(param1:TutorialNode, param2:Array) : void
      {
         targetScreenNode = param1;
         if(param2 && param2.length > 0)
         {
            this.availableActions = Vector.<TutorialNode>(param2);
         }
      }
      
      public function doNotLockButtonsOn(param1:TutorialNode) : void
      {
         if(!notLockingScreens)
         {
            notLockingScreens = new Vector.<TutorialNode>();
         }
         notLockingScreens.push(param1);
      }
      
      public function isActionAllowed(param1:TutorialActiveAction, param2:TutorialNode) : Boolean
      {
         return (param1.node == targetScreenNode || param1.node == param2 || availableActions && availableActions.indexOf(param1.node) != -1) && target.resolves(param1.key);
      }
      
      public function shouldLockScreen(param1:TutorialNode) : Boolean
      {
         return notLockingScreens && notLockingScreens.indexOf(param1) != -1;
      }
      
      public function triggerStart() : void
      {
         if(_signal_onStart)
         {
            _signal_onStart.dispatch(this);
         }
      }
      
      public function triggerHideMessage() : void
      {
         if(_signal_onHideMessage)
         {
            _signal_onHideMessage.dispatch(this);
         }
      }
      
      public function triggerComplete() : void
      {
         if(_signal_onComplete)
         {
            _signal_onComplete.dispatch(this);
         }
      }
      
      public function setReward(param1:RewardData) : void
      {
         this._reward = param1;
         if(_signal_onReward)
         {
            _signal_onReward.dispatch(this);
         }
      }
      
      public function initiate(param1:TutorialTaskManager) : void
      {
         this.manager = param1;
         if(skipCondition && skipCondition.check(this))
         {
            Tutorial.__print("skipTask",description.name,description.params);
            triggerComplete();
         }
         else if(startCondition && startCondition.ident != "start" && !Tutorial.events.checkState(startCondition))
         {
            started = false;
            Tutorial.__print("addStartCondition for",this + ":",startCondition.ident,startCondition.data);
            param1.addCondition(startCondition,this);
         }
         else
         {
            start();
         }
      }
      
      public function triggerCondition(param1:TutorialCondition) : void
      {
         manager.removeCondition(param1);
         if(!started)
         {
            Tutorial.__print("triggerStartCondition","for",this);
            start();
         }
         else
         {
            Tutorial.__print("triggerCompleteCondition","for",this);
            manager.completeTask(this);
            if(manager.tutorialShouldWait)
            {
               manager.signal_tutorialCanGo.addOnce(complete);
            }
            else
            {
               complete();
            }
         }
         ClickLoger.trigger_tutorialCondition();
      }
      
      public function complete() : void
      {
         triggerComplete();
         dispose();
      }
      
      public function toString() : String
      {
         return "{" + description.name + (!!description.params.length?" " + description.params:"") + "}";
      }
      
      private function start() : void
      {
         Tutorial.__print("start",description.name,description.params);
         triggerStart();
         if(skipCondition && skipCondition.check(this))
         {
            Tutorial.__print("skipAlreadyStartedTask",description.name,description.params);
            manager.completeTask(this);
            triggerComplete();
         }
         else if(completeCondition)
         {
            started = true;
            manager.execute(this);
            Tutorial.__print("addCompleteCondition for",this + ":",completeCondition.ident,completeCondition.data);
            manager.addCondition(completeCondition,this);
         }
         else
         {
            manager.completeTask(this);
            triggerComplete();
         }
      }
   }
}
