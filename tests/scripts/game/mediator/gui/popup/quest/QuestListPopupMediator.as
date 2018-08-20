package game.mediator.gui.popup.quest
{
   import com.progrestar.common.lang.Translate;
   import feathers.core.PopUpManager;
   import feathers.data.ListCollection;
   import game.command.rpc.quest.CommandQuestFarm;
   import game.data.storage.DataStorage;
   import game.data.storage.quest.QuestDailyDescription;
   import game.data.storage.quest.QuestNormalDescription;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.friends.socialquest.SocialQuestPopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.quest.PlayerDayTimeQuestEntry;
   import game.model.user.quest.PlayerDayTimeQuestValueObject;
   import game.model.user.quest.PlayerQuestEntry;
   import game.model.user.quest.PlayerQuestValueObject;
   import game.screen.navigator.QuestMechanicNavigator;
   import game.stat.Stash;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.popup.PopupBase;
   import game.view.popup.quest.QuestListPopup;
   import game.view.popup.quest.QuestRewardPopup;
   import idv.cjcat.signals.Signal;
   
   public class QuestListPopupMediator extends PopupMediator
   {
      
      public static const TAB_NORMAL:int = 0;
      
      public static const TAB_DAILY:int = 1;
       
      
      private var _currentFilter:int;
      
      private var _navigator:QuestMechanicNavigator;
      
      private var _tabLabels:Vector.<String>;
      
      private var _items:ListCollection;
      
      private var _signal_tabUpdate:Signal;
      
      public function QuestListPopupMediator(param1:Player, param2:int = 0)
      {
         super(param1);
         _navigator = Game.instance.navigator.questHelper;
         _currentFilter = param2;
         _tabLabels = new Vector.<String>();
         _tabLabels.push(Translate.translate("UI_DIALOG_QUEST_LIST_NORMAL"));
         _tabLabels.push(Translate.translate("UI_DIALOG_QUEST_LIST_DAILY"));
         _signal_tabUpdate = new Signal();
         param1.questData.signal_questAdded.add(onQuestAdded);
         param1.questData.signal_questRemoved.add(onQuestRemoved);
         param1.questData.signal_questProgress.add(onQuestProgressUpdatedComplete);
         filterItems();
      }
      
      override protected function dispose() : void
      {
         player.questData.signal_questAdded.remove(onQuestAdded);
         player.questData.signal_questRemoved.remove(onQuestRemoved);
         player.questData.signal_questProgress.remove(onQuestProgressUpdatedComplete);
         super.dispose();
      }
      
      public function get name() : String
      {
         if(_currentFilter == 1)
         {
            return Translate.translate("UI_DIALOG_QUESTS_HEADER_DAILY");
         }
         return Translate.translate("UI_DIALOG_QUESTS_HEADER");
      }
      
      public function get tutorialNode() : TutorialNode
      {
         if(_currentFilter == 1)
         {
            return TutorialNavigator.DAILY_QUESTS;
         }
         return TutorialNavigator.QUESTS;
      }
      
      public function get navigator() : QuestMechanicNavigator
      {
         return _navigator;
      }
      
      public function get tabs() : Vector.<String>
      {
         return _tabLabels;
      }
      
      public function get items() : ListCollection
      {
         return _items;
      }
      
      public function get signal_tabUpdate() : Signal
      {
         return _signal_tabUpdate;
      }
      
      public function action_selectTab(param1:int) : void
      {
         if(_currentFilter != param1)
         {
            _currentFilter = param1;
            filterItems();
            _signal_tabUpdate.dispatch();
         }
      }
      
      public function action_farm(param1:PlayerQuestValueObject) : void
      {
         var _loc2_:PopupStashEventParams = Stash.click("get_reward:" + param1.id,_popup.stashParams);
         var _loc3_:CommandQuestFarm = GameModel.instance.actionManager.quest.questFarm(param1.entry);
         _loc3_.stashClick = _loc2_;
         _loc3_.onClientExecute(onQuestFarmComplete);
      }
      
      public function action_select(param1:PlayerQuestValueObject) : void
      {
         var _loc3_:* = null;
         navigator.helpWithQuest(param1.entry,_popup.stashParams);
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new QuestListPopup(this);
         _popup.stashParams.windowName = _currentFilter == 1?"quests_daily":"quests_normal";
         return _popup;
      }
      
      private function filterItems() : void
      {
         var _loc1_:* = undefined;
         if(_currentFilter == 1)
         {
            _loc1_ = createValueObjectList(player.questData.getDailyList());
            _loc1_.sort(sortQuests);
            _items = new ListCollection(_loc1_);
         }
         else
         {
            _loc1_ = createValueObjectList(player.questData.getNormalList());
            _loc1_.sort(sortQuests);
            _items = new ListCollection(_loc1_);
         }
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
      
      private function sortQuests(param1:PlayerQuestValueObject, param2:PlayerQuestValueObject) : int
      {
         return param2.sortValue - param1.sortValue;
      }
      
      private function onQuestRemoved(param1:PlayerQuestEntry) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc2_:int = _items.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = _items.getItemAt(_loc3_) as PlayerQuestValueObject;
            if(_loc4_.entry == param1)
            {
               _items.removeItem(_loc4_);
               break;
            }
            _loc3_++;
         }
      }
      
      private function onQuestAdded(param1:PlayerQuestEntry) : void
      {
         var _loc2_:* = null;
         if(param1.desc is QuestDailyDescription && _currentFilter == 1)
         {
            _loc2_ = createValueObject(param1);
            _items.addItemAt(_loc2_,0);
         }
         if(param1.desc is QuestNormalDescription && _currentFilter == 0)
         {
            _loc2_ = createValueObject(param1);
            _items.addItemAt(_loc2_,0);
         }
      }
      
      private function onQuestFarmComplete(param1:CommandQuestFarm) : void
      {
         var _loc2_:QuestRewardPopup = new QuestRewardPopup(param1.reward.outputDisplay,param1.entry);
         _loc2_.stashSourceClick = param1.stashClick;
         PopUpManager.addPopUp(_loc2_);
      }
      
      private function onQuestProgressUpdatedComplete(param1:PlayerQuestEntry) : void
      {
         var _loc2_:Vector.<PlayerQuestValueObject> = (_items.data as Vector.<PlayerQuestValueObject>).concat();
         _loc2_.sort(sortQuests);
         _items.data = _loc2_;
      }
   }
}
