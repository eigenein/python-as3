package game.view.popup.activity
{
   import com.progrestar.common.lang.Translate;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.quest.PlayerQuestEntry;
   import idv.cjcat.signals.Signal;
   
   public class ChainQuestsListRendererMediator
   {
       
      
      private var player:Player;
      
      private var _chainElement:SpecialQuestEventChainTabValueObject;
      
      private var _signalUpdate:Signal;
      
      public function ChainQuestsListRendererMediator()
      {
         _signalUpdate = new Signal();
         super();
         player = GameModel.instance.player;
         player.questData.signal_questAdded.add(onQuestAdded);
         player.questData.signal_questRemoved.add(onQuestRemoved);
         player.questData.signal_questProgress.add(onQuestProgressUpdatedComplete);
      }
      
      public function dispose() : void
      {
         signalUpdate.clear();
         player.questData.signal_questAdded.remove(onQuestAdded);
         player.questData.signal_questRemoved.remove(onQuestRemoved);
         player.questData.signal_questProgress.remove(onQuestProgressUpdatedComplete);
         player = null;
         chainElement = null;
      }
      
      public function get chainElement() : SpecialQuestEventChainTabValueObject
      {
         return _chainElement;
      }
      
      public function set chainElement(param1:SpecialQuestEventChainTabValueObject) : void
      {
         if(chainElement == param1)
         {
            return;
         }
         _chainElement = param1;
      }
      
      public function get chainName() : String
      {
         return Translate.translate(chainElement.name);
      }
      
      public function get signalUpdate() : Signal
      {
         return _signalUpdate;
      }
      
      public function notFarmQuestsAvaliable() : Boolean
      {
         var _loc1_:* = undefined;
         var _loc2_:int = 0;
         if(chainElement && chainElement.chainDescription)
         {
            _loc1_ = player.questData.getSpecialListByEventChainId(chainElement.chainDescription.id);
            if(_loc1_)
            {
               _loc2_ = 0;
               while(_loc2_ < _loc1_.length)
               {
                  if(_loc1_[_loc2_].canFarm)
                  {
                     return true;
                  }
                  _loc2_++;
               }
            }
         }
         return false;
      }
      
      private function onQuestAdded(param1:PlayerQuestEntry) : void
      {
         signalUpdate.dispatch();
      }
      
      private function onQuestRemoved(param1:PlayerQuestEntry) : void
      {
         signalUpdate.dispatch();
      }
      
      private function onQuestProgressUpdatedComplete(param1:PlayerQuestEntry) : void
      {
         signalUpdate.dispatch();
      }
   }
}
