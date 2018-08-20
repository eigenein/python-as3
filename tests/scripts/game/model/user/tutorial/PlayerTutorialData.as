package game.model.user.tutorial
{
   import flash.utils.Dictionary;
   import game.data.storage.DataStorage;
   import game.data.storage.tutorial.TutorialParams;
   import game.data.storage.tutorial.TutorialTaskChainDescription;
   import game.data.storage.tutorial.TutorialTaskDescription;
   import game.view.gui.tutorial.Tutorial;
   
   public class PlayerTutorialData
   {
       
      
      private const tutorialProgress:Dictionary = new Dictionary();
      
      private var _params:TutorialParams;
      
      private var identProgress:Vector.<String>;
      
      public function PlayerTutorialData()
      {
         identProgress = new Vector.<String>();
         super();
      }
      
      public function get params() : TutorialParams
      {
         return _params;
      }
      
      public function init(param1:Object) : void
      {
         initParams(param1.params);
         initChains(param1.chains);
         Tutorial.initializeData(this);
      }
      
      public function hasChain(param1:int) : Boolean
      {
         return tutorialProgress.hasOwnProperty(param1);
      }
      
      public function getChainProgress(param1:int) : int
      {
         return tutorialProgress[param1];
      }
      
      public function setChainProgress(param1:int, param2:int) : int
      {
         var _loc3_:* = param2;
         tutorialProgress[param1] = _loc3_;
         return _loc3_;
      }
      
      public function hasIdent(param1:String) : Boolean
      {
         return identProgress.indexOf(param1) != -1;
      }
      
      public function getTutorialChainProgressByIdent(param1:String) : int
      {
         var _loc2_:TutorialTaskChainDescription = DataStorage.tutorial.getChainByIdent(param1);
         if(_loc2_)
         {
            return tutorialProgress[_loc2_.id];
         }
         return 0;
      }
      
      public function getUnlockerState(param1:String) : Boolean
      {
         var _loc9_:int = 0;
         var _loc3_:* = null;
         var _loc6_:* = null;
         var _loc2_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:* = null;
         var _loc11_:int = 0;
         var _loc10_:* = tutorialProgress;
         for(var _loc5_ in tutorialProgress)
         {
            _loc9_ = tutorialProgress[_loc5_];
            _loc3_ = DataStorage.tutorial.getChainById(_loc5_);
            if(_loc3_)
            {
               _loc6_ = _loc3_.getTaskByProgressState(_loc9_);
               if(_loc6_)
               {
                  _loc2_ = _loc3_.getIndexByTask(_loc6_);
                  _loc7_ = _loc3_.length;
                  _loc8_ = _loc2_ + 1;
                  while(_loc8_ < _loc7_)
                  {
                     _loc4_ = _loc3_.getTaskByIndex(_loc8_);
                     if(_loc4_.unlockers && _loc4_.unlockers.indexOf(param1) != -1)
                     {
                        return false;
                     }
                     _loc8_++;
                  }
                  continue;
               }
               continue;
            }
         }
         return true;
      }
      
      private function initParams(param1:Object) : void
      {
         _params = new TutorialParams(param1);
      }
      
      private function initChains(param1:Object) : void
      {
         var _loc3_:int = 0;
         if(!param1 || param1 is Array)
         {
            return;
         }
         if(param1 is Array)
         {
            identProgress = Vector.<String>(param1);
         }
         else
         {
            var _loc5_:int = 0;
            var _loc4_:* = param1;
            for(var _loc2_ in param1)
            {
               _loc3_ = param1[int(_loc2_)];
               tutorialProgress[int(_loc2_)] = _loc3_;
            }
         }
      }
   }
}
