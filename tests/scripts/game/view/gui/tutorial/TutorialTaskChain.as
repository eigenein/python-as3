package game.view.gui.tutorial
{
   import game.data.storage.tutorial.TutorialTaskChainDescription;
   import game.data.storage.tutorial.TutorialTaskDescription;
   
   public class TutorialTaskChain
   {
       
      
      private var manager:TutorialTaskManager;
      
      private var desc:TutorialTaskChainDescription;
      
      private var currentTask:TutorialTask;
      
      private var childTasks:Vector.<TutorialTask>;
      
      public function TutorialTaskChain(param1:TutorialTaskManager, param2:TutorialTaskChainDescription)
      {
         childTasks = new Vector.<TutorialTask>();
         super();
         this.manager = param1;
         this.desc = param2;
      }
      
      public function get descirption() : TutorialTaskChainDescription
      {
         return desc;
      }
      
      public function initialize(param1:int) : void
      {
         var _loc2_:* = null;
         var _loc3_:TutorialTaskDescription = desc.getTaskByProgressState(param1);
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc3_.parent != 0)
         {
            _loc2_ = manager.createTaskFromDescription(this,desc.getTaskById(_loc3_.parent));
            if(_loc2_.skipCondition && _loc2_.skipCondition.check(_loc2_))
            {
               _loc3_ = desc.getNextParentTask(_loc2_.description);
               if(_loc3_ == null)
               {
                  return;
               }
            }
         }
         tryStartTask(_loc3_);
      }
      
      private function currentTaskStarted(param1:TutorialTask) : void
      {
         startChildrenTasks(param1);
      }
      
      private function currentTaskCompleted(param1:TutorialTask) : void
      {
         removeChildTasks();
         var _loc2_:TutorialTaskDescription = desc.getNextParentTask(currentTask.description);
         if(_loc2_ == null)
         {
            completeChain();
         }
         else
         {
            tryStartTask(_loc2_);
         }
      }
      
      public function hasLockOn(param1:String) : Boolean
      {
         var _loc5_:* = 0;
         var _loc2_:* = null;
         if(!currentTask)
         {
            return false;
         }
         var _loc4_:int = desc.length;
         var _loc3_:int = desc.getIndexByTask(currentTask.description);
         _loc5_ = _loc3_;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = desc.getTaskByIndex(_loc5_);
            if(_loc2_.unlockers && _loc2_.unlockers.indexOf(param1) != -1)
            {
               return true;
            }
            _loc5_++;
         }
         return false;
      }
      
      protected function tryStartTask(param1:TutorialTaskDescription) : void
      {
         if(param1 == null)
         {
            return;
            §§push(trace("Tutorial error tryStart null task"));
         }
         else
         {
            currentTask = manager.createTaskFromDescription(this,param1);
            if(currentTask == null)
            {
               return;
               §§push(trace("Tutorial error, no such tusk"));
            }
            else
            {
               currentTask.signal_onStart.addOnce(currentTaskStarted);
               currentTask.signal_onComplete.addOnce(currentTaskCompleted);
               currentTask.initiate(manager);
               return;
            }
         }
      }
      
      protected function completeChain() : void
      {
         currentTask = null;
      }
      
      private function startChildrenTasks(param1:TutorialTask) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         var _loc2_:Vector.<TutorialTaskDescription> = desc.getTasksByParent(param1.description);
         var _loc3_:int = _loc2_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc2_[_loc4_].startCondition != null)
            {
               _loc5_ = _loc4_ < _loc3_ - 1 && _loc2_[_loc4_ + 1].startCondition == null;
               tryStartChildTask(_loc2_[_loc4_],_loc5_);
            }
            _loc4_++;
         }
      }
      
      public function tryStartChildTask(param1:TutorialTaskDescription, param2:Boolean) : void
      {
         var _loc3_:TutorialTask = manager.createTaskFromDescription(this,param1);
         if(_loc3_ == null)
         {
            return;
            §§push(trace("Tutorial error, no such tusk"));
         }
         else
         {
            if(param2)
            {
               _loc3_.signal_onComplete.add(onChildTaskCompleted);
            }
            _loc3_.initiate(manager);
            childTasks.push(_loc3_);
            return;
         }
      }
      
      private function removeChildTasks() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function onChildTaskCompleted(param1:TutorialTask) : void
      {
         var _loc4_:Boolean = false;
         var _loc2_:int = childTasks.indexOf(param1);
         if(_loc2_ != -1)
         {
            childTasks.splice(_loc2_,1);
         }
         var _loc3_:TutorialTaskDescription = desc.getNextChildTask(param1.description);
         if(_loc3_)
         {
            _loc4_ = desc.getNextChildTask(_loc3_);
            tryStartChildTask(_loc3_,_loc4_);
         }
      }
   }
}
