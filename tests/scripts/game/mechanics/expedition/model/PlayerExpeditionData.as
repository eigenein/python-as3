package game.mechanics.expedition.model
{
   import engine.core.utils.VectorUtil;
   import engine.core.utils.property.VectorProperty;
   import engine.core.utils.property.VectorPropertyWriteable;
   import game.mechanics.expedition.mediator.ExpeditionValueObject;
   import game.model.GameModel;
   import org.osflash.signals.Signal;
   
   public class PlayerExpeditionData
   {
       
      
      private var _expeditions:Vector.<PlayerExpeditionEntry>;
      
      private var _list:VectorPropertyWriteable;
      
      private var _signal_redDotStateChange:Signal;
      
      public function PlayerExpeditionData()
      {
         _expeditions = new Vector.<PlayerExpeditionEntry>();
         _list = new VectorPropertyWriteable(_expeditions as Vector.<*>);
         _signal_redDotStateChange = new Signal();
         super();
      }
      
      public function get list() : VectorProperty
      {
         return _list;
      }
      
      public function get minTeamSizeToStartExpedition() : int
      {
         return 5;
      }
      
      public function get signal_redDotStateChange() : Signal
      {
         return _signal_redDotStateChange;
      }
      
      public function init(param1:Object) : void
      {
         updateExpeditions(param1);
      }
      
      public function requestUpdate() : CommandExpeditionGet
      {
         return GameModel.instance.actionManager.expedition.expeditionGet();
      }
      
      public function sendHeroes(param1:PlayerExpeditionEntry, param2:Vector.<int>) : CommandExpeditionSendHeroes
      {
         return GameModel.instance.actionManager.expedition.expeditionSendHeroes(param1.id,param2);
      }
      
      public function farm(param1:ExpeditionValueObject) : CommandExpeditionFarm
      {
         return GameModel.instance.actionManager.expedition.expeditionFarm(param1);
      }
      
      public function getExpeditionByHero(param1:int) : PlayerExpeditionEntry
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function getExpeditionList() : Vector.<PlayerExpeditionEntry>
      {
         return _expeditions.concat();
      }
      
      function updateExpeditions(param1:Object) : void
      {
         var _loc3_:int = 0;
         if(!param1)
         {
            return;
         }
         var _loc2_:int = _expeditions.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _unsubscribe(_expeditions[_loc3_]);
            _loc3_++;
         }
         _expeditions.length = 0;
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for each(var _loc4_ in param1)
         {
            createExpedition(_loc4_);
         }
         sortExpeditions();
         _list.signal_update.dispatch(_list.value);
         _signal_redDotStateChange.dispatch();
      }
      
      function handleHeroesSent(param1:int, param2:Vector.<int>, param3:int) : void
      {
         var _loc4_:PlayerExpeditionEntry = getExpeditionById(param1);
         _loc4_.setInProgress(param3,param2);
      }
      
      function handleFarm(param1:int, param2:Object) : void
      {
         var _loc3_:PlayerExpeditionEntry = getExpeditionById(param1);
         _loc3_.setFarmed();
         removeExpeditionBySlotId(_loc3_.slotId);
         if(param2)
         {
            createExpedition(param2);
            sortExpeditions();
            _list.signal_update.dispatch(_list.value);
         }
         _signal_redDotStateChange.dispatch();
      }
      
      protected function createExpedition(param1:Object) : PlayerExpeditionEntry
      {
         var _loc2_:PlayerExpeditionEntry = new PlayerExpeditionEntry(param1);
         _subscribe(_loc2_);
         _expeditions.push(_loc2_);
         return _loc2_;
      }
      
      protected function getExpeditionById(param1:int) : PlayerExpeditionEntry
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function removeExpeditionBySlotId(param1:int) : PlayerExpeditionEntry
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function sortExpeditions() : void
      {
         _expeditions.sort(PlayerExpeditionEntry.sort_bySlotId);
      }
      
      private function _unsubscribe(param1:PlayerExpeditionEntry) : void
      {
         param1.readyToFarm.signal_update.remove(handler_readyToFarmCheck);
      }
      
      private function _subscribe(param1:PlayerExpeditionEntry) : void
      {
         param1.readyToFarm.signal_update.add(handler_readyToFarmCheck);
      }
      
      private function handler_readyToFarmCheck(param1:Boolean) : void
      {
         _signal_redDotStateChange.dispatch();
      }
   }
}
