package game.view.popup.activity
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import game.command.rpc.quest.CommandQuestFarm;
   import game.command.timer.GameTimer;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.quest.SpecialQuestEventChainElementDescription;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.friends.socialquest.SocialQuestPopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.quest.PlayerDayTimeQuestEntry;
   import game.model.user.quest.PlayerDayTimeQuestValueObject;
   import game.model.user.quest.PlayerQuestEntry;
   import game.model.user.quest.PlayerQuestEventEntry;
   import game.model.user.quest.PlayerQuestValueObject;
   import game.model.user.specialoffer.PlayerSpecialOfferDailyReward;
   import game.model.user.specialoffer.PlayerSpecialOfferTripleSkinBundle;
   import game.screen.navigator.QuestMechanicNavigator;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.activity.customtab.SpecialOfferCustomTabs;
   import org.osflash.signals.Signal;
   
   public class SpecialQuestEventPopupMediator extends PopupMediator
   {
      
      public static const ACTION_GET_BONUS:String = "ACTION_GET_BONUS";
       
      
      private var navigator:QuestMechanicNavigator;
      
      private var _chainTabs:Vector.<SpecialQuestEventChainTabValueObject>;
      
      private var desiredEventId:int;
      
      private var skinShopVO:QuestEventSkinShopValueObject;
      
      private var _signal_questRemoved:Signal;
      
      public const signal_dropReward:Signal = new Signal(RewardData,PlayerQuestEntry);
      
      private var _eventList:ListCollection;
      
      public const signal_someRedMarkerUpdate:Signal = new Signal();
      
      public function SpecialQuestEventPopupMediator(param1:Player, param2:int = -1)
      {
         _chainTabs = new Vector.<SpecialQuestEventChainTabValueObject>();
         _signal_questRemoved = new Signal(PlayerQuestEntry);
         super(param1);
         this.desiredEventId = param2;
         navigator = Game.instance.navigator.questHelper;
         param1.questData.signal_questRemoved.add(onQuestRemoved);
         param1.questData.signal_eventAdd.add(onEventAdd);
         param1.questData.signal_eventRemove.add(onEventRemove);
      }
      
      override protected function dispose() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function get signal_questRemoved() : Signal
      {
         return _signal_questRemoved;
      }
      
      public function get firstEventIndex() : int
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         var _loc3_:* = null;
         if(desiredEventId == -1)
         {
            return 0;
         }
         var _loc2_:int = _eventList.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc1_ = _eventList.getItemAt(_loc4_) as QuestEventValueObjectBase;
            _loc3_ = _loc1_ as QuestEventSpecialValueObject;
            if(_loc3_ && _loc3_.eventId == desiredEventId)
            {
               return _loc4_;
            }
            if(_loc1_.sortOrder == desiredEventId)
            {
               return _loc4_;
            }
            _loc4_++;
         }
         return 0;
      }
      
      public function get eventList() : ListCollection
      {
         var _loc2_:* = null;
         var _loc7_:* = null;
         var _loc4_:* = null;
         var _loc1_:* = null;
         var _loc3_:* = undefined;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         if(!_eventList)
         {
            _loc2_ = [];
            _loc7_ = new QuestEventDailyBonusValueObject(player);
            _loc7_.canFarm.signal_update.add(handler_currentEventMarkerUpdate);
            _loc2_.push(_loc7_);
            _loc4_ = player.specialOffer.getSpecialOffer("sideBarIcon_tripleSkinBundle") as PlayerSpecialOfferTripleSkinBundle;
            _loc1_ = player.specialOffer.getSpecialOffer("dailyReward") as PlayerSpecialOfferDailyReward;
            if(_loc4_)
            {
               skinShopVO = new QuestEventSkinShopValueObject(_loc4_,_loc1_);
               skinShopVO.mediator.signal_OfferRemoved.add(handler_skinShopOfferRemoved);
               skinShopVO.canFarm.signal_update.add(handler_currentEventMarkerUpdate);
               _loc2_.push(skinShopVO);
            }
            _loc3_ = player.questData.getEvents();
            if(_loc3_ && _loc3_.length)
            {
               _loc5_ = 0;
               while(_loc5_ < _loc3_.length)
               {
                  if(_loc3_[_loc5_].endTime > GameTimer.instance.currentServerTime)
                  {
                     _loc6_ = new QuestEventSpecialValueObject(player,_loc3_[_loc5_]);
                     _loc6_.canFarm.signal_update.add(handler_currentEventMarkerUpdate);
                     _loc2_.push(_loc6_);
                  }
                  _loc5_++;
               }
            }
            _loc2_.sort(sort_events);
            _eventList = new ListCollection(_loc2_);
         }
         return _eventList;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new SpecialQuestEventPopup(this);
         return _popup;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney(true);
         _loc1_.requre_gold(true);
         return _loc1_;
      }
      
      public function getChainByEventId(param1:int) : Vector.<SpecialQuestEventChainTabValueObject>
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function getQuestListByEventChainId(param1:int) : Vector.<PlayerQuestValueObject>
      {
         return createValueObjectList(player.questData.getSpecialListByEventChainId(param1));
      }
      
      public function getSpecialListDailyFlagByEventChainId(param1:int) : Boolean
      {
         return DataStorage.quest.getEventChainDailyFlagById(param1);
      }
      
      public function action_quest_farm(param1:PlayerQuestValueObject) : void
      {
         var _loc4_:* = null;
         var _loc3_:PopupStashEventParams = Stash.click("get_reward:" + param1.id,_popup.stashParams);
         var _loc2_:Boolean = false;
         if(_loc2_)
         {
            signal_dropReward.dispatch(param1.entry.reward,param1.entry);
            signal_questRemoved.dispatch(param1.entry);
         }
         else
         {
            _loc4_ = GameModel.instance.actionManager.quest.questFarm(param1.entry);
            _loc4_.stashClick = _loc3_;
            _loc4_.onClientExecute(onQuestFarmComplete);
         }
      }
      
      public function action_quest_select(param1:PlayerQuestValueObject) : void
      {
         var _loc3_:* = null;
         navigator.helpWithQuest(param1.entry,_popup.stashParams);
      }
      
      public function action_check_and_farm_daily_reward_skin_coins(param1:QuestEventSkinShopValueObject) : void
      {
         if(param1.mediator.dailyRewardOffer && !param1.mediator.dailyRewardOffer.freeRewardObtained.value)
         {
            param1.mediator.dailyRewardOffer.action_farm_daily_reward();
         }
      }
      
      private function sort_events(param1:QuestEventValueObjectBase, param2:QuestEventValueObjectBase) : int
      {
         var _loc4_:Boolean = false;
         var _loc3_:Boolean = false;
         if(!param1.canFarmSortIgnore && !param2.canFarmSortIgnore)
         {
            _loc4_ = param1.canFarm.value;
            _loc3_ = param2.canFarm.value;
            if(!_loc4_ && _loc3_)
            {
               return 1;
            }
            if(_loc4_ && !_loc3_)
            {
               return -1;
            }
         }
         return param1.sortOrder - param2.sortOrder;
      }
      
      private function createValueObjectList(param1:Vector.<PlayerQuestEntry>) : Vector.<PlayerQuestValueObject>
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc2_:Vector.<PlayerQuestValueObject> = new Vector.<PlayerQuestValueObject>();
         var _loc3_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = createValueObject(param1[_loc4_]);
            _loc2_[_loc4_] = _loc5_;
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function createValueObject(param1:PlayerQuestEntry) : PlayerQuestValueObject
      {
         var _loc2_:* = null;
         if(param1.desc.farmCondition.stateFunc.ident == "dayTimeHour")
         {
            _loc2_ = new PlayerDayTimeQuestValueObject(param1 as PlayerDayTimeQuestEntry,navigator.hasNavigatorForQuestEntry(param1));
            return _loc2_;
         }
         return new PlayerQuestValueObject(param1,navigator.hasNavigatorForQuestEntry(param1));
      }
      
      private function onQuestRemoved(param1:PlayerQuestEntry) : void
      {
         _signal_questRemoved.dispatch(param1);
      }
      
      private function onEventAdd(param1:PlayerQuestEventEntry) : void
      {
         var _loc2_:* = null;
         if(_eventList && param1 && param1.endTime > GameTimer.instance.currentServerTime)
         {
            _loc2_ = new QuestEventSpecialValueObject(player,param1);
            _loc2_.canFarm.signal_update.add(handler_currentEventMarkerUpdate);
            _eventList.push(_loc2_);
         }
      }
      
      private function onEventRemove(param1:PlayerQuestEventEntry) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         if(_eventList)
         {
            _loc3_ = 0;
            while(_loc3_ < _eventList.length)
            {
               _loc2_ = _eventList.getItemAt(_loc3_) as QuestEventSpecialValueObject;
               if(_loc2_ is QuestEventSpecialValueObject && (_loc2_ as QuestEventSpecialValueObject).eventId == param1.id)
               {
                  _eventList.removeItemAt(_loc3_);
                  _loc2_.canFarm.signal_update.remove(handler_currentEventMarkerUpdate);
                  _loc2_.dispose();
                  break;
               }
               _loc3_++;
            }
         }
      }
      
      private function onQuestFarmComplete(param1:CommandQuestFarm) : void
      {
         var _loc2_:Vector.<InventoryItem> = param1.reward.outputDisplay;
         if(_loc2_.length > 0)
         {
            signal_dropReward.dispatch(param1.reward,param1.entry);
         }
         else
         {
            PopupList.instance.message(Translate.translate("UI_POPUP_QUEST_REWARD_HEADER"));
         }
      }
      
      private function handler_currentEventMarkerUpdate(param1:Boolean) : void
      {
         signal_someRedMarkerUpdate.dispatch();
      }
      
      private function handler_skinShopOfferRemoved() : void
      {
         if(skinShopVO)
         {
            _eventList.removeItem(skinShopVO);
            skinShopVO = null;
         }
      }
   }
}
