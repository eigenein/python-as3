package game.view.gui.tutorial
{
   import game.command.timer.GameTimer;
   import game.data.storage.DataStorage;
   import game.data.storage.tutorial.TutorialDescription;
   import game.data.storage.tutorial.TutorialTaskChainDescription;
   import game.data.storage.tutorial.TutorialTaskDescription;
   import game.model.GameModel;
   import game.model.user.tutorial.PlayerTutorialData;
   import game.view.gui.tutorial.condition.TutorialCondition;
   import idv.cjcat.signals.Signal;
   
   public class TutorialTaskManager
   {
       
      
      private var playerTutorial:PlayerTutorialData;
      
      private var factory:TutorialTaskFactory;
      
      private var events:TutorialEvents;
      
      private var executor:TutorialTaskExecutor;
      
      private var navigator:TutorialNavigator;
      
      private var overlay:TutorialOverlay;
      
      private const chains:Vector.<TutorialTaskChain> = new Vector.<TutorialTaskChain>();
      
      private var activeGuiTaskStack:Vector.<TutorialTask>;
      
      private var completedTasks:Vector.<TutorialTask>;
      
      public function TutorialTaskManager(param1:TutorialEvents, param2:TutorialTaskExecutor, param3:TutorialNavigator, param4:TutorialOverlay, param5:TutorialTaskFactory)
      {
         activeGuiTaskStack = new Vector.<TutorialTask>();
         completedTasks = new Vector.<TutorialTask>();
         super();
         this.events = param1;
         this.executor = param2;
         this.navigator = param3;
         this.overlay = param4;
         this.factory = param5;
      }
      
      public function get tutorialShouldWait() : Boolean
      {
         return navigator.tutorialShouldWait;
      }
      
      public function get signal_tutorialCanGo() : Signal
      {
         return navigator.tutorialCanGo;
      }
      
      public function initialize(param1:PlayerTutorialData) : void
      {
         var _loc4_:* = null;
         var _loc5_:int = 0;
         this.playerTutorial = param1;
         var _loc3_:Vector.<TutorialDescription> = DataStorage.tutorial.getList();
         var _loc10_:int = 0;
         var _loc9_:* = _loc3_;
         for each(var _loc2_ in _loc3_)
         {
            var _loc8_:int = 0;
            var _loc7_:* = _loc2_.chains;
            for each(var _loc6_ in _loc2_.chains)
            {
               if(param1.hasChain(_loc6_.id))
               {
                  _loc4_ = new TutorialTaskChain(this,_loc6_);
                  _loc5_ = param1.getChainProgress(_loc6_.id);
                  if(_loc5_ < _loc6_.length)
                  {
                     _loc4_.initialize(_loc5_);
                     chains.push(_loc4_);
                  }
               }
            }
         }
         GameTimer.instance.oneFrameTimer.add(handler_oneFrameTimer);
      }
      
      public function addCondition(param1:TutorialCondition, param2:ITutorialConditionListener) : void
      {
         var _loc3_:TutorialTaskDescription = (param2 as TutorialTask).description;
         param1.listener = param2;
         events.addCondition(param1);
      }
      
      public function removeCondition(param1:TutorialCondition) : void
      {
         events.removeCondition(param1);
      }
      
      public function createTaskFromDescription(param1:TutorialTaskChain, param2:TutorialTaskDescription) : TutorialTask
      {
         return factory.createFromDescription(param1,param2);
      }
      
      public function execute(param1:TutorialTask) : void
      {
         if(param1.hasGuiTask)
         {
            activeGuiTaskStack.push(param1);
            Tutorial.__print("add GUI task",param1,"  to:",activeGuiTaskStack.toString());
            executor.execute(param1);
         }
         if(param1.message)
         {
            overlay.showMessageFromTask(param1);
         }
      }
      
      public function completeTask(param1:TutorialTask) : void
      {
         checkTutorialProgress(param1);
         deprecateTask(param1);
      }
      
      public function deprecateTask(param1:TutorialTask) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = activeGuiTaskStack.indexOf(param1);
         if(_loc2_ != -1)
         {
            if(_loc2_ == activeGuiTaskStack.length - 1)
            {
               executor.deprecate(param1);
               if(_loc2_ > 0)
               {
                  _loc3_ = activeGuiTaskStack[_loc2_ - 1];
                  executor.execute(_loc3_);
                  if(_loc3_.message)
                  {
                     overlay.showMessageFromTask(_loc3_);
                  }
               }
            }
            activeGuiTaskStack.splice(_loc2_,1);
         }
         param1.triggerHideMessage();
         events.removeConditionByListener(param1);
         Tutorial.__print("rem GUI task",param1,"left:",activeGuiTaskStack.toString());
      }
      
      public function checkTutorialProgress(param1:TutorialTask) : void
      {
         if(param1.description.saveState > 0)
         {
            playerTutorial.setChainProgress(param1.chain.descirption.id,param1.description.saveState);
         }
         if(param1.description.saveState > 0 || param1.description.tutorialStep > 0 || param1.description.serverMethod != null)
         {
            completedTasks.push(param1);
            Tutorial.__print("save progress",param1.chain.descirption.id + ":" + param1.description.id);
         }
      }
      
      public function getUnlockerState(param1:String) : Boolean
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function handler_oneFrameTimer() : void
      {
         if(completedTasks.length > 0)
         {
            GameModel.instance.actionManager.tutorialSaveProgress(completedTasks);
            completedTasks.length = 0;
         }
      }
   }
}
