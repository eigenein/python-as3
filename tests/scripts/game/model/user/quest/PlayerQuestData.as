package game.model.user.quest
{
   import engine.core.utils.VectorUtil;
   import flash.utils.Dictionary;
   import game.command.rpc.RPCCommandBase;
   import game.command.timer.GameTimer;
   import game.data.storage.DataStorage;
   import game.data.storage.quest.QuestDailyDescription;
   import game.data.storage.quest.QuestDescription;
   import game.data.storage.quest.QuestNormalDescription;
   import game.data.storage.quest.QuestSpecialDescription;
   import game.data.storage.quest.SpecialQuestEventChainElementDescription;
   import idv.cjcat.signals.Signal;
   
   public class PlayerQuestData
   {
       
      
      private var eventUpdateManager:PlayerQuestEventUpdateManager;
      
      private var activeQuests:Dictionary;
      
      private var events:Vector.<PlayerQuestEventEntry>;
      
      private var _signal_questAdded:Signal;
      
      private var _signal_questProgress:Signal;
      
      private var _signal_questRemoved:Signal;
      
      private var _signal_questFarmed:Signal;
      
      private var _signal_eventAdd:Signal;
      
      private var _signal_eventRemove:Signal;
      
      private var _signal_eventTimeLeft:Signal;
      
      public function PlayerQuestData()
      {
         eventUpdateManager = new PlayerQuestEventUpdateManager();
         super();
         _signal_questAdded = new Signal(PlayerQuestEntry);
         _signal_questRemoved = new Signal(PlayerQuestEntry);
         _signal_questFarmed = new Signal(PlayerQuestEntry);
         _signal_questProgress = new Signal(PlayerQuestEntry);
         _signal_eventAdd = new Signal(PlayerQuestEventEntry);
         _signal_eventRemove = new Signal(PlayerQuestEventEntry);
         _signal_eventTimeLeft = new Signal(PlayerQuestEventEntry);
         activeQuests = new Dictionary();
         events = new Vector.<PlayerQuestEventEntry>();
      }
      
      public function get signal_questAdded() : Signal
      {
         return _signal_questAdded;
      }
      
      public function get signal_questProgress() : Signal
      {
         return _signal_questProgress;
      }
      
      public function get signal_questRemoved() : Signal
      {
         return _signal_questRemoved;
      }
      
      public function get signal_questFarmed() : Signal
      {
         return _signal_questFarmed;
      }
      
      public function get signal_eventAdd() : Signal
      {
         return _signal_eventAdd;
      }
      
      public function get signal_eventRemove() : Signal
      {
         return _signal_eventRemove;
      }
      
      public function get signal_eventTimeLeft() : Signal
      {
         return _signal_eventTimeLeft;
      }
      
      public function init(param1:Object) : void
      {
         var _loc4_:int = 0;
         var _loc2_:Array = param1 as Array || [];
         var _loc3_:int = _loc2_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            createQuestEntry(_loc2_[_loc4_],true);
            _loc4_++;
         }
      }
      
      public function initEvents(param1:Object) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         events.length = 0;
         var _loc2_:Array = param1 as Array || [];
         var _loc4_:int = _loc2_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = new PlayerQuestEventEntry(_loc2_[_loc5_]);
            _loc3_.signal_timeLeft.add(handler_EventTimeLeft);
            events.push(_loc3_);
            _loc5_++;
         }
      }
      
      public function reset(param1:Array) : void
      {
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(!param1)
         {
            return;
         }
         var _loc7_:int = param1.length;
         addOrUpdateQuests(param1);
         var _loc3_:Vector.<PlayerQuestEntry> = new Vector.<PlayerQuestEntry>(0);
         var _loc9_:int = 0;
         var _loc8_:* = activeQuests;
         for each(_loc2_ in activeQuests)
         {
            _loc6_ = _loc2_.desc.id;
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               if(param1[_loc5_].id != _loc6_)
               {
                  _loc5_++;
                  continue;
               }
               break;
            }
            if(_loc5_ == _loc7_)
            {
               _loc3_[_loc3_.length] = _loc2_;
            }
         }
         var _loc11_:int = 0;
         var _loc10_:* = _loc3_;
         for each(_loc2_ in _loc3_)
         {
            delete activeQuests[_loc2_.desc.id];
            if(_loc2_ is PlayerDayTimeQuestEntry)
            {
               (_loc2_ as PlayerDayTimeQuestEntry).dispose();
            }
            _signal_questRemoved.dispatch(_loc2_);
         }
      }
      
      public function resetEvents(param1:Array) : void
      {
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc6_:int = 0;
         if(!param1)
         {
            return;
         }
         var _loc4_:Object = {};
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            _loc3_ = param1[_loc5_];
            if(!(_loc3_.endTime && _loc3_.endTime <= GameTimer.instance.currentServerTime))
            {
               _loc4_[_loc3_.id] = true;
               _loc2_ = getEventById(_loc3_.id);
               if(!_loc2_)
               {
                  _loc2_ = new PlayerQuestEventEntry(_loc3_);
                  _loc2_.signal_timeLeft.add(handler_EventTimeLeft);
                  events.push(_loc2_);
                  _signal_eventAdd.dispatch(_loc2_);
               }
               else
               {
                  _loc2_.applyUpdate(_loc3_);
               }
            }
            _loc5_++;
         }
         _loc6_ = 0;
         while(_loc6_ < events.length)
         {
            if(!_loc4_[events[_loc6_].id])
            {
               _loc2_ = events[_loc6_];
               _loc2_.signal_timeLeft.remove(handler_EventTimeLeft);
               VectorUtil.removeAt(events,_loc6_);
               _loc6_--;
               _signal_eventRemove.dispatch(_loc2_);
            }
            _loc6_++;
         }
      }
      
      public function getQuest(param1:int) : PlayerQuestEntry
      {
         return activeQuests[param1];
      }
      
      public function addOrUpdateQuests(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(!param1)
         {
            return;
         }
         var _loc5_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc3_ = param1[_loc4_];
            if(!activeQuests[_loc3_.id])
            {
               createQuestEntry(_loc3_);
            }
            else
            {
               _loc2_ = activeQuests[_loc3_.id];
               _loc2_.applyUpdate(_loc3_);
               _signal_questProgress.dispatch(_loc2_);
            }
            _loc4_++;
         }
      }
      
      public function get hasQuestsToFarm() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = activeQuests;
         for each(var _loc1_ in activeQuests)
         {
            if(!(_loc1_.desc is QuestDailyDescription) && !(_loc1_.desc is QuestSpecialDescription) && _loc1_.canFarm)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get hasDailyQuestsToFarm() : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:* = activeQuests;
         for each(var _loc1_ in activeQuests)
         {
            if(_loc1_.desc is QuestDailyDescription && _loc1_.canFarm)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get hasDailyQuestsWithExpToFarm() : Boolean
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = activeQuests;
         for each(var _loc1_ in activeQuests)
         {
            if(_loc1_.desc is QuestDailyDescription && _loc1_.canFarm)
            {
               _loc2_ = 0;
               while(_loc2_ < _loc1_.desc.reward.outputDisplay.length)
               {
                  if(_loc1_.desc.reward.outputDisplay[_loc2_].item == DataStorage.pseudo.XP)
                  {
                     return true;
                  }
                  _loc2_++;
               }
               continue;
            }
         }
         return false;
      }
      
      public function get hasSpecialQuestsToFarm() : Boolean
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = activeQuests;
         for each(var _loc1_ in activeQuests)
         {
            if(_loc1_.desc is QuestSpecialDescription && _loc1_.canFarm)
            {
               _loc2_ = DataStorage.specialQuestEvent.getChainById((_loc1_.desc as QuestSpecialDescription).eventChainId);
               if(_loc2_)
               {
                  _loc3_ = getEventById(_loc2_.eventId);
                  if(_loc3_ && _loc3_.endTime > GameTimer.instance.currentServerTime)
                  {
                     return true;
                  }
               }
            }
         }
         return false;
      }
      
      public function get hasSpecialEvents() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         _loc1_ = 0;
         while(_loc1_ < events.length)
         {
            _loc2_ = events[_loc1_];
            if(_loc2_.endTime > GameTimer.instance.currentServerTime)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function onRpc_checkQuestUpdates(param1:RPCCommandBase) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:* = null;
         if(param1.result.questUpdateData)
         {
            _loc2_ = param1.result.questUpdateData.newQuests;
            _loc3_ = _loc2_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               createQuestEntry(_loc2_[_loc5_]);
               _loc5_++;
            }
            _loc2_ = param1.result.questUpdateData.updates;
            _loc3_ = _loc2_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc6_ = _loc2_[_loc5_].id;
               _loc4_ = activeQuests[_loc6_];
               if(_loc4_)
               {
                  _loc4_.applyUpdate(_loc2_[_loc5_]);
                  _signal_questProgress.dispatch(_loc4_);
               }
               _loc5_++;
            }
         }
      }
      
      public function questFarm(param1:PlayerQuestEntry) : void
      {
         delete activeQuests[param1.desc.id];
         if(param1 is PlayerDayTimeQuestEntry)
         {
            (param1 as PlayerDayTimeQuestEntry).dispose();
         }
         _signal_questRemoved.dispatch(param1);
         _signal_questFarmed.dispatch(param1);
      }
      
      public function getDailyList() : Vector.<PlayerQuestEntry>
      {
         var _loc2_:Vector.<PlayerQuestEntry> = new Vector.<PlayerQuestEntry>();
         var _loc4_:int = 0;
         var _loc3_:* = activeQuests;
         for each(var _loc1_ in activeQuests)
         {
            if(_loc1_.desc is QuestDailyDescription && !_loc1_.desc.hidden)
            {
               _loc2_.push(_loc1_);
            }
         }
         return _loc2_;
      }
      
      public function getNormalList() : Vector.<PlayerQuestEntry>
      {
         var _loc2_:Vector.<PlayerQuestEntry> = new Vector.<PlayerQuestEntry>();
         var _loc4_:int = 0;
         var _loc3_:* = activeQuests;
         for each(var _loc1_ in activeQuests)
         {
            if(_loc1_.desc is QuestNormalDescription && !_loc1_.desc.hidden)
            {
               _loc2_.push(_loc1_);
            }
         }
         return _loc2_;
      }
      
      public function getSpecialListByEventChainId(param1:int) : Vector.<PlayerQuestEntry>
      {
         var _loc3_:Vector.<PlayerQuestEntry> = new Vector.<PlayerQuestEntry>();
         var _loc5_:int = 0;
         var _loc4_:* = activeQuests;
         for each(var _loc2_ in activeQuests)
         {
            if(_loc2_.desc is QuestSpecialDescription && (_loc2_.desc as QuestSpecialDescription).eventChainId == param1 && !_loc2_.desc.hidden)
            {
               _loc3_.push(_loc2_);
            }
         }
         _loc3_.sort(sortQuests);
         return _loc3_;
      }
      
      private function sortQuests(param1:PlayerQuestEntry, param2:PlayerQuestEntry) : int
      {
         if((param1.desc as QuestSpecialDescription).chainOrder > (param2.desc as QuestSpecialDescription).chainOrder)
         {
            return 1;
         }
         if((param1.desc as QuestSpecialDescription).chainOrder < (param2.desc as QuestSpecialDescription).chainOrder)
         {
            return -1;
         }
         return 0;
      }
      
      public function getEvents() : Vector.<PlayerQuestEventEntry>
      {
         return events;
      }
      
      public function hasEvent(param1:int) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = events.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(events[_loc3_].id == param1)
            {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public function getEventById(param1:int) : PlayerQuestEventEntry
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < events.length)
         {
            if(events[_loc2_].id == param1)
            {
               return events[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getEventCanFarm(param1:PlayerQuestEventEntry) : Boolean
      {
         var _loc7_:* = null;
         var _loc4_:Vector.<SpecialQuestEventChainElementDescription> = DataStorage.specialQuestEvent.getChainByEventId(param1.id);
         var _loc6_:Vector.<int> = new Vector.<int>();
         var _loc9_:int = 0;
         var _loc8_:* = _loc4_;
         for each(var _loc3_ in _loc4_)
         {
            _loc6_.push(_loc3_.id);
         }
         var _loc5_:Vector.<PlayerQuestEntry> = new Vector.<PlayerQuestEntry>();
         var _loc11_:int = 0;
         var _loc10_:* = activeQuests;
         for each(var _loc2_ in activeQuests)
         {
            _loc7_ = _loc2_.desc as QuestSpecialDescription;
            if(_loc7_ != null && !_loc7_.hidden && _loc2_.canFarm && _loc6_.indexOf(_loc7_.eventChainId) != -1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getChainCanFarm(param1:int) : Boolean
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function createQuestEntry(param1:*, param2:Boolean = false) : void
      {
         var _loc3_:* = null;
         var _loc4_:QuestDescription = DataStorage.quest.getQuestById(param1.id);
         if(_loc4_ == null)
         {
            return;
         }
         if(_loc4_.farmCondition.stateFunc.ident == "dayTimeHour")
         {
            _loc3_ = new PlayerDayTimeQuestEntry(this,param1);
         }
         else
         {
            _loc3_ = new PlayerQuestEntry(param1);
         }
         activeQuests[param1.id] = _loc3_;
         if(!param2)
         {
            _signal_questAdded.dispatch(_loc3_);
         }
      }
      
      private function handler_EventTimeLeft(param1:PlayerQuestEventEntry) : void
      {
         eventUpdateManager.requestUpdate();
      }
   }
}
