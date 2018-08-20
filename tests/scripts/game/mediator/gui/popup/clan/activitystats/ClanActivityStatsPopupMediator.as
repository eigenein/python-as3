package game.mediator.gui.popup.clan.activitystats
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.IntPropertyWriteable;
   import flash.utils.Dictionary;
   import game.command.rpc.clan.CommandClanGetWeeklyStat;
   import game.command.rpc.clan.CommandClanSendGifts;
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.clan.ClanPopupMediatorBase;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.PopupBase;
   import game.view.popup.clan.activitystats.ClanActivityStatsPopup;
   import game.view.popup.clan.activitystats.ClanActivityStatsPopupVO;
   import game.view.popup.clan.activitystats.ClanGiftStatsVO;
   import org.osflash.signals.Signal;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class ClanActivityStatsPopupMediator extends ClanPopupMediatorBase
   {
      
      public static const TAB_DUNGEON_ACTIVITY:String = "tab_titanit";
      
      public static const TAB_ACTIVITY:String = "tab_clan_points";
      
      public static const TAB_GIFTS:String = "tab_gifts";
       
      
      private var giftsVODict:Dictionary;
      
      private var _days:Vector.<String>;
      
      private var _signal_data:Signal;
      
      private var _activityStatsSortedFieldIndex:int;
      
      private var _property_redMarkState:BooleanProperty;
      
      private var _playerPermission_canSendGifts:BooleanPropertyWriteable;
      
      private var _property_freeGiftAmount:IntPropertyWriteable;
      
      private var _property_freeGiftSelectedPeopleAmount:IntPropertyWriteable;
      
      private var _tabs:Vector.<String>;
      
      private var _listData_dungeonActivity:Vector.<ClanActivityStatsPopupVO>;
      
      private var _listData_gifts:Vector.<ClanGiftStatsVO>;
      
      private var _listData_activity:Vector.<ClanActivityStatsPopupVO>;
      
      private var _selectedTab:int;
      
      public function ClanActivityStatsPopupMediator(param1:Player)
      {
         _signal_data = new Signal();
         _playerPermission_canSendGifts = new BooleanPropertyWriteable();
         _property_freeGiftAmount = new IntPropertyWriteable();
         _property_freeGiftSelectedPeopleAmount = new IntPropertyWriteable();
         super(param1);
         _tabs = new Vector.<String>();
         _tabs[0] = "tab_clan_points";
         _tabs[1] = "tab_titanit";
         _tabs[2] = "tab_gifts";
         activityStatsSortedFieldIndex = 0;
         _property_freeGiftAmount = param1.clan.clan.property_giftsCount;
         var _loc2_:CommandClanGetWeeklyStat = GameModel.instance.actionManager.clan.clanGetWeeklyStat();
         _loc2_.signal_complete.add(handler_commandComplete);
         _playerPermission_canSendGifts.value = param1.clan.playerRole.permission_disband;
         _property_redMarkState = param1.clan.property_redMark_clanGiftCount;
      }
      
      public function get days() : Vector.<String>
      {
         return _days;
      }
      
      public function get signal_data() : Signal
      {
         return _signal_data;
      }
      
      public function get activityStatsSortedFieldIndex() : int
      {
         return _activityStatsSortedFieldIndex;
      }
      
      public function set activityStatsSortedFieldIndex(param1:int) : void
      {
         _activityStatsSortedFieldIndex = param1;
      }
      
      public function get property_redMarkState() : BooleanProperty
      {
         return _property_redMarkState;
      }
      
      public function get playerPermission_canSendGifts() : BooleanProperty
      {
         return _playerPermission_canSendGifts;
      }
      
      public function get property_freeGiftAmount() : IntProperty
      {
         return _property_freeGiftAmount;
      }
      
      public function get property_freeGiftSelectedPeopleAmount() : IntProperty
      {
         return _property_freeGiftSelectedPeopleAmount;
      }
      
      public function get tabs() : Vector.<String>
      {
         return _tabs;
      }
      
      public function get listData_dungeonActivity() : Vector.<ClanActivityStatsPopupVO>
      {
         return _listData_dungeonActivity;
      }
      
      public function get listData_gifts() : Vector.<ClanGiftStatsVO>
      {
         return _listData_gifts;
      }
      
      public function get listData_activity() : Vector.<ClanActivityStatsPopupVO>
      {
         return _listData_activity;
      }
      
      public function get selectedTab() : String
      {
         return tabs[_selectedTab];
      }
      
      public function get descSendGiftsText() : String
      {
         if(property_freeGiftAmount.value > 0)
         {
            if(player.clan.playerRole.code == 255)
            {
               return Translate.translateArgs("UI_DIALOG_CLAN_ACTIVITY_DESC",ColorUtils.hexToRGBFormat(16645626) + property_freeGiftAmount.value + ColorUtils.hexToRGBFormat(16573879),property_freeGiftAmount.value);
            }
            return Translate.translateArgs("UI_DIALOG_CLAN_ACTIVITY_DESC2",ColorUtils.hexToRGBFormat(16645626) + property_freeGiftAmount.value + ColorUtils.hexToRGBFormat(16573879),property_freeGiftAmount.value);
         }
         return Translate.translate("UI_DIALOG_CLAN_ACTIVITY_DESC3");
      }
      
      public function get giftContents() : Vector.<InventoryItem>
      {
         return DataStorage.rule.clanRule.clanGiftReward.outputDisplay;
      }
      
      public function action_setTab(param1:int) : void
      {
         _selectedTab = param1;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ClanActivityStatsPopup(this);
         return _popup;
      }
      
      public function action_sortClanActivityList(param1:uint) : void
      {
         activityStatsSortedFieldIndex = param1;
         listData_activity.sort(sortByActivity);
      }
      
      public function action_sortDungeonActivityList(param1:uint) : void
      {
         activityStatsSortedFieldIndex = param1;
         listData_dungeonActivity.sort(sortByActivity);
      }
      
      public function action_sendGifts() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = null;
         var _loc3_:Vector.<String> = new Vector.<String>();
         var _loc2_:int = _listData_gifts.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            if(_listData_gifts[_loc4_].property_selected.value)
            {
               _loc3_.push(_listData_gifts[_loc4_].id);
            }
            _loc4_++;
         }
         if(_loc3_.length)
         {
            _loc1_ = GameModel.instance.actionManager.clan.clanSendGifts(_loc3_);
            _loc1_.signal_complete.add(handler_commandComplete_send);
         }
         else
         {
            PopupList.instance.message(Translate.translate("UI_DIALOG_CLAN_ACTIVITY_MSG"));
         }
      }
      
      private function sortByActivity(param1:ClanActivityStatsPopupVO, param2:ClanActivityStatsPopupVO) : int
      {
         if(activityStatsSortedFieldIndex == -1)
         {
            return param2.value_total - param1.value_total;
         }
         return param2.activity[activityStatsSortedFieldIndex] - param1.activity[activityStatsSortedFieldIndex];
      }
      
      private function sortByLikes(param1:ClanGiftStatsVO, param2:ClanGiftStatsVO) : int
      {
         return param2.likes_total - param1.likes_total;
      }
      
      private function handler_commandComplete(param1:CommandClanGetWeeklyStat) : void
      {
         var _loc9_:int = 0;
         var _loc5_:int = 0;
         var _loc13_:* = null;
         var _loc10_:* = null;
         var _loc11_:int = 0;
         var _loc14_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:* = null;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         player.clan.clan.property_giftsCount.value = param1.result.body.giftsCount;
         _listData_activity = new Vector.<ClanActivityStatsPopupVO>();
         _listData_dungeonActivity = new Vector.<ClanActivityStatsPopupVO>();
         _listData_gifts = new Vector.<ClanGiftStatsVO>();
         giftsVODict = new Dictionary();
         var _loc2_:Array = param1.result.body.stat as Array;
         _days = new Vector.<String>();
         var _loc12_:int = param1.result.body.dayInWeek;
         _loc12_--;
         if(_loc12_ < 0)
         {
            _loc12_ = 6;
         }
         _loc5_ = 0;
         while(_loc5_ < 7)
         {
            _days.unshift(Translate.translate("LIB_WEEK_DAY_" + (_loc12_ + 1) + "_SHORT"));
            _loc12_--;
            if(_loc12_ < 0)
            {
               _loc12_ = 6;
            }
            _loc5_++;
         }
         _loc9_ = _loc2_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc9_)
         {
            _loc13_ = _loc2_[_loc5_];
            _loc10_ = new ClanActivityStatsPopupVO(_loc13_,_loc13_.dungeonActivity);
            _loc10_.isPlayer = _loc10_.id == player.id;
            _loc10_.isDungeon = true;
            _listData_dungeonActivity.push(_loc10_);
            _loc10_.member = player.clan.clan.getMemberById(_loc13_.id);
            _loc10_ = new ClanActivityStatsPopupVO(_loc13_,_loc13_.activity);
            _listData_activity.push(_loc10_);
            _loc10_.isPlayer = _loc10_.id == player.id;
            _loc10_.member = player.clan.clan.getMemberById(_loc13_.id);
            _loc11_ = 0;
            _loc14_ = _loc13_.clanGifts.length;
            _loc7_ = 0;
            while(_loc7_ < _loc14_)
            {
               _loc11_ = _loc11_ + _loc13_.clanGifts[_loc7_];
               _loc7_++;
            }
            _loc3_ = new ClanGiftStatsVO(_loc13_,_loc11_,_playerPermission_canSendGifts.value);
            _loc3_.member = player.clan.clan.getMemberById(_loc13_.id);
            _loc3_.signal_select.add(handler_giftVOSelect);
            _loc3_.isPlayer = _loc10_.id == player.id;
            _listData_gifts.push(_loc3_);
            giftsVODict[_loc3_.id] = _loc3_;
            _loc5_++;
         }
         var _loc4_:Object = {};
         _loc8_ = 0;
         while(_loc8_ < 6)
         {
            activityStatsSortedFieldIndex = _loc8_;
            listData_dungeonActivity.sort(sortByActivity);
            listData_activity.sort(sortByActivity);
            _loc6_ = 0;
            while(_loc6_ < 3)
            {
               if(_listData_dungeonActivity.length > _loc6_)
               {
                  _loc10_ = _listData_dungeonActivity[_loc6_];
                  if(_loc10_.activity[_loc8_] != 0)
                  {
                     _loc10_.likeFlags[_loc8_] = true;
                     _loc3_ = giftsVODict[_loc10_.id];
                     if(_loc3_)
                     {
                        _loc3_.setLikesReceived_dungeon(_loc3_.likes_dungeonActivity + 1);
                     }
                  }
                  _loc10_ = listData_activity[_loc6_];
                  if(_loc10_.activity[_loc8_] != 0)
                  {
                     _loc10_.likeFlags[_loc8_] = true;
                     _loc3_ = giftsVODict[_loc10_.id];
                     if(_loc3_)
                     {
                        _loc3_.setLikesReceived_activity(_loc3_.likes_activity + 1);
                     }
                  }
                  _loc6_++;
                  continue;
               }
               break;
            }
            _loc8_++;
         }
         giftsVODict = null;
         _listData_gifts.sort(sortByLikes);
         handler_giftVOSelect(null);
         _signal_data.dispatch();
      }
      
      private function handler_giftVOSelect(param1:ClanGiftStatsVO) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc4_:int = _listData_gifts.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = _listData_gifts[_loc5_];
            if(_loc3_.property_selected.value)
            {
               _loc2_++;
            }
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = _listData_gifts[_loc5_];
            if(_loc2_ >= _property_freeGiftAmount.value)
            {
               _loc3_.property_selectable.value = _loc3_.property_selected.value;
            }
            else
            {
               _loc3_.property_selectable.value = true;
            }
            _loc5_++;
         }
         _property_freeGiftSelectedPeopleAmount.value = _loc2_;
      }
      
      private function handler_commandComplete_send(param1:CommandClanSendGifts) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = _listData_gifts.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _listData_gifts[_loc4_];
            if(_loc3_.property_selected.value)
            {
               player.clan.clan.property_giftsCount.value = player.clan.clan.property_giftsCount.value - 1;
               _loc3_.property_selected.value = false;
               _loc3_.action_addGift(1);
            }
            _loc4_++;
         }
         handler_giftVOSelect(null);
      }
   }
}
