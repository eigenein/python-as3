package game.model.user.clan
{
   import com.adobe.crypto.MD5;
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.IntPropertyWriteable;
   import game.command.rpc.clan.CommandClanGetActivityStat;
   import game.command.rpc.clan.value.ClanBlackListValueObject;
   import game.command.rpc.clan.value.ClanIconValueObject;
   import game.command.rpc.clan.value.ClanStatValueObject;
   import game.command.timer.AlarmEvent;
   import game.command.timer.GameTimer;
   import game.model.user.Player;
   import idv.cjcat.signals.ISignal;
   import idv.cjcat.signals.Signal;
   
   public class ClanPrivateInfoValueObject extends ClanBasicInfoValueObject
   {
       
      
      protected const _activityPoints:IntPropertyWriteable = new IntPropertyWriteable();
      
      protected const _dungeonActivityPoints:IntPropertyWriteable = new IntPropertyWriteable();
      
      private var player:Player;
      
      public const activityUpdateManager:ClanActivityUpdateManager = new ClanActivityUpdateManager();
      
      private var _property_giftsCount:IntPropertyWriteable;
      
      public const signal_titleUpdated:Signal = new Signal();
      
      public const signal_descriptionUpdated:Signal = new Signal();
      
      public const signal_newsUpdated:Signal = new Signal();
      
      public const signal_iconUpdated:Signal = new Signal();
      
      public const signal_countryUpdated:Signal = new Signal();
      
      public const signal_minLevelUpdated:Signal = new Signal();
      
      public const signal_activityPointsUpdated:Signal = new Signal();
      
      public const signal_dungeonActivityPointsUpdated:Signal = new Signal();
      
      public const signal_newMember:Signal = new Signal(ClanMemberValueObject);
      
      public const signal_dismissedMember:Signal = new Signal(ClanMemberValueObject);
      
      public const activityPoints:IntProperty = _activityPoints;
      
      public const dungeonActivityPoints:IntProperty = _dungeonActivityPoints;
      
      protected var _blackList:ClanBlackListValueObject;
      
      protected var _stat:ClanStatValueObject;
      
      protected var _news:String;
      
      private var _signal_hasUnreadNews:Signal;
      
      private var _hasUnreadNews:Boolean;
      
      private var _resetAlarm:AlarmEvent;
      
      private var _clanWarEndSeasonTime:int;
      
      private var _freeClanChangeIntervalStart:int;
      
      private var _freeClanChangeIntervalEnd:int;
      
      private var _clanWarLeagueId:uint;
      
      public function ClanPrivateInfoValueObject(param1:Object, param2:Player)
      {
         var _loc6_:* = null;
         _property_giftsCount = new IntPropertyWriteable();
         _signal_hasUnreadNews = new Signal(Boolean);
         this.player = param2;
         var _loc4_:Object = param1.clan;
         _clanWarLeagueId = _loc4_.league;
         _property_giftsCount.value = _loc4_.giftsCount;
         super(_loc4_);
         _stat = new ClanStatValueObject(param1.stat);
         _stat.todayActivity.signal_update.add(handler_playerActivityUpdate);
         _stat.todayDungeonActivity.signal_update.add(handler_playerDungeonActivityUpdate);
         _blackList = new ClanBlackListValueObject(_loc4_.blackList);
         updateResetTime(param1.serverResetTime);
         var _loc8_:int = 0;
         var _loc7_:* = _loc4_.members;
         for each(var _loc5_ in _loc4_.members)
         {
            _loc6_ = new ClanMemberValueObject(this,_loc5_);
            _members.push(_loc6_);
         }
         parseMemberStat(param1);
         _activityPoints.value = _loc4_.activityPoints;
         _dungeonActivityPoints.value = _loc4_.dungeonPoints;
         _news = _loc4_.news;
         _clanWarEndSeasonTime = param1.clanWarEndSeasonTime;
         if(param1.freeClanChangeInterval)
         {
            _freeClanChangeIntervalStart = param1.freeClanChangeInterval.start;
            _freeClanChangeIntervalEnd = param1.freeClanChangeInterval.end;
         }
         var _loc3_:String = param2.chat.settings.lastReadClanNewsHash;
         _hasUnreadNews = _loc3_ == null || _news == null || _loc3_ != MD5.hash(_news);
      }
      
      override public function get membersCount() : int
      {
         return _members.length;
      }
      
      public function get property_giftsCount() : IntPropertyWriteable
      {
         return _property_giftsCount;
      }
      
      public function get blackList() : ClanBlackListValueObject
      {
         return _blackList;
      }
      
      public function get stat() : ClanStatValueObject
      {
         return _stat;
      }
      
      public function get news() : String
      {
         return _news;
      }
      
      public function get signal_hasUnreadNews() : ISignal
      {
         return _signal_hasUnreadNews;
      }
      
      public function get hasUnreadNews() : Boolean
      {
         return _hasUnreadNews;
      }
      
      public function get resetTime() : int
      {
         return _resetAlarm.time;
      }
      
      public function get clanWarEndSeasonTime() : int
      {
         return _clanWarEndSeasonTime;
      }
      
      public function get serverTimeInFreeClanChangeInterval() : Boolean
      {
         return _freeClanChangeIntervalStart < GameTimer.instance.currentServerTime && _freeClanChangeIntervalEnd > GameTimer.instance.currentServerTime;
      }
      
      public function get clanWarLeagueId() : uint
      {
         return _clanWarLeagueId;
      }
      
      public function setDescription(param1:String) : void
      {
         _description = param1;
         signal_descriptionUpdated.dispatch();
      }
      
      public function setNews(param1:String) : void
      {
         if(param1 != _news)
         {
            _news = param1;
            setHasUnreadNews(true);
            signal_newsUpdated.dispatch();
         }
      }
      
      public function setIcon(param1:ClanIconValueObject) : void
      {
         _icon = param1;
         signal_iconUpdated.dispatch();
      }
      
      public function setCountry(param1:int) : void
      {
         _country = param1;
         signal_countryUpdated.dispatch();
      }
      
      public function setMinLevel(param1:int) : void
      {
         _minLevel = param1;
         signal_minLevelUpdated.dispatch();
      }
      
      public function spendItemsForActivity(param1:int) : void
      {
         _activityPoints.value = _activityPoints.value + param1;
         signal_activityPointsUpdated.dispatch();
         stat.spendItemsForActivity(param1);
      }
      
      public function updateActivity(param1:CommandClanGetActivityStat) : void
      {
         _activityPoints.value = int(param1.clanActivity);
         _dungeonActivityPoints.value = int(param1.dungeonActivity);
         _stat.update(param1.stat);
      }
      
      public function updateDungeonActivityOnly(param1:int) : void
      {
         _dungeonActivityPoints.value = param1;
      }
      
      public function action_changeTitle(param1:String) : void
      {
         if(param1 != _title)
         {
            _title = param1;
            signal_titleUpdated.dispatch();
         }
      }
      
      public function saveLastReadClanNewsHash() : void
      {
         var _loc1_:String = _news == null?null:MD5.hash(_news);
         if(_loc1_ != player.chat.settings.lastReadClanNewsHash)
         {
            player.chat.settings.lastReadClanNewsHash = _loc1_;
            player.chat.settingsChange = true;
         }
         setHasUnreadNews(false);
      }
      
      private function setHasUnreadNews(param1:Boolean) : void
      {
         if(_hasUnreadNews != param1)
         {
            _hasUnreadNews = param1;
            _signal_hasUnreadNews.dispatch(_hasUnreadNews);
         }
      }
      
      private function updateResetTime(param1:int) : void
      {
         if(_resetAlarm != null)
         {
            if(_resetAlarm.time == param1)
            {
               return;
            }
            GameTimer.instance.removeAlarm(_resetAlarm);
         }
         _resetAlarm = new AlarmEvent(param1,"clanReset " + param1);
         _resetAlarm.callback = handler_reset;
         _resetAlarm.data = this;
      }
      
      function internal_handleInfoUpdate(param1:Object) : void
      {
         _icon = ClanIconValueObject.fromRawData(param1.icon);
         signal_iconUpdated.dispatch();
         action_changeTitle(param1.title);
         if(param1.roleNames)
         {
            roleNames.update(param1.roleNames);
            var _loc4_:int = 0;
            var _loc3_:* = _members;
            for each(var _loc2_ in _members)
            {
               _loc2_.signal_updateRole.dispatch(_loc2_);
            }
         }
         setNews(param1.news);
      }
      
      function internal_updateServerInfo(param1:Object) : void
      {
         parseMemberStat(param1);
         _stat.update(param1.stat);
         _activityPoints.value = param1.clan.activityPoints;
         _dungeonActivityPoints.value = param1.clan.dungeonPoints;
         updateResetTime(param1.serverResetTime);
         signal_activityPointsUpdated.dispatch();
      }
      
      function internal_addMember(param1:ClanMemberValueObject) : void
      {
         _members.push(param1);
         signal_newMember.dispatch(param1);
      }
      
      function internal_handleActivityRewardMessage(param1:Object) : void
      {
         _property_giftsCount.value = param1.gifts;
      }
      
      function internal_removeMember(param1:String) : void
      {
         var _loc2_:ClanMemberValueObject = getMemberById(param1);
         if(_loc2_)
         {
            _members.splice(_members.indexOf(_loc2_),1);
            signal_dismissedMember.dispatch(_loc2_);
         }
      }
      
      function internal_updateTodayActivityOnMemberDismiss(param1:int) : void
      {
         _activityPoints.value = param1;
         signal_activityPointsUpdated.dispatch();
      }
      
      function internal_updateTodayDungeonActivityOnMemberDismiss(param1:int) : void
      {
         _dungeonActivityPoints.value = param1;
         signal_dungeonActivityPointsUpdated.dispatch();
      }
      
      private function handler_reset(param1:AlarmEvent) : void
      {
         updateResetTime(param1.time + 86400);
      }
      
      private function handler_playerActivityUpdate(param1:int) : void
      {
         var _loc2_:ClanMemberValueObject = getMemberById(player.id);
         _loc2_.internal_setActivity(_stat.activitySum.value,_stat.todayActivity.value);
      }
      
      private function handler_playerDungeonActivityUpdate(param1:int) : void
      {
         var _loc2_:ClanMemberValueObject = getMemberById(player.id);
         _loc2_.internal_setDungeonActivity(_stat.dungeonActivitySum.value,_stat.todayDungeonActivity.value);
      }
   }
}
