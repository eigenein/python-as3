package game.data.storage.tutorial
{
   public class TutorialTaskChainDescription
   {
       
      
      private var _id:int;
      
      private var _ident:String;
      
      private var tasks:Vector.<TutorialTaskDescription>;
      
      public function TutorialTaskChainDescription(param1:*)
      {
         tasks = new Vector.<TutorialTaskDescription>();
         super();
         this._id = param1.id;
         this._ident = param1.ident;
      }
      
      public function get length() : int
      {
         return tasks.length;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get ident() : String
      {
         return _ident;
      }
      
      function addTask(param1:TutorialTaskDescription) : void
      {
         tasks.push(param1);
      }
      
      public function getIndexByTask(param1:TutorialTaskDescription) : int
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function getTaskByIndex(param1:int) : TutorialTaskDescription
      {
         return param1 < tasks.length?tasks[param1]:null;
      }
      
      public function getTasksByParent(param1:TutorialTaskDescription) : Vector.<TutorialTaskDescription>
      {
         var _loc5_:int = 0;
         var _loc2_:Vector.<TutorialTaskDescription> = new Vector.<TutorialTaskDescription>();
         var _loc3_:int = 0;
         var _loc4_:int = tasks.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            if(tasks[_loc5_].parent == param1.id)
            {
               _loc3_++;
               _loc2_[_loc3_] = tasks[_loc5_];
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      public function getNextChildTask(param1:TutorialTaskDescription) : TutorialTaskDescription
      {
         var _loc2_:int = tasks.indexOf(param1);
         if(_loc2_ == -1 || _loc2_ + 1 >= tasks.length)
         {
            return null;
         }
         var _loc3_:TutorialTaskDescription = tasks[_loc2_ + 1];
         if(_loc3_.parent != param1.parent || _loc3_.startCondition != null)
         {
            return null;
         }
         return _loc3_;
      }
      
      public function getNextParentTask(param1:TutorialTaskDescription) : TutorialTaskDescription
      {
         var _loc4_:int = 0;
         var _loc3_:int = tasks.indexOf(param1);
         var _loc2_:int = tasks.length;
         if(_loc3_ == -1 || _loc3_ >= tasks.length)
         {
            return null;
         }
         _loc4_ = _loc3_ + 1;
         while(_loc4_ < _loc2_)
         {
            if(tasks[_loc4_].parent == 0)
            {
               return tasks[_loc4_];
            }
            _loc4_++;
         }
         return null;
      }
      
      public function getTaskById(param1:int) : TutorialTaskDescription
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function getTaskByProgressState(param1:int) : TutorialTaskDescription
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
   }
}
