package game.mediator.gui.popup.clan.log
{
   import com.progrestar.common.lang.Translate;
   import game.command.rpc.clan.CommandClanGetLog;
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.clan.ClanLogEventValueObject;
   import game.mediator.gui.popup.clan.ClanPopupMediatorBase;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.chat.ChatUserData;
   import game.util.DateFormatter;
   import game.view.popup.PopupBase;
   import idv.cjcat.signals.Signal;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class ClanLogPopUpMediator extends ClanPopupMediatorBase
   {
       
      
      private var clanLog:Array;
      
      private var users:Object;
      
      private var _signal_update:Signal;
      
      public function ClanLogPopUpMediator(param1:Player)
      {
         _signal_update = new Signal();
         super(param1);
      }
      
      public function get signal_update() : Signal
      {
         return _signal_update;
      }
      
      public function getUserNickById(param1:int) : String
      {
         if(users[param1])
         {
            return (users[param1] as ChatUserData).nickname + " (id " + param1 + ")";
         }
         return "(id " + param1 + ")";
      }
      
      public function get logTexts() : Array
      {
         var _loc1_:* = null;
         var _loc10_:* = null;
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc11_:* = null;
         var _loc9_:int = 0;
         var _loc7_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc6_:* = null;
         var _loc8_:* = null;
         if(clanLog)
         {
            _loc1_ = [];
            _loc10_ = "";
            _loc5_ = -1;
            _loc9_ = 0;
            while(_loc9_ < clanLog.length)
            {
               _loc11_ = clanLog[_loc9_] as ClanLogEventValueObject;
               if(_loc11_)
               {
                  _loc2_ = new Date(_loc11_.ctime * 1000);
                  if(_loc2_.getDate() != _loc5_)
                  {
                     if(_loc10_ && _loc10_.length)
                     {
                        _loc1_.push(_loc10_);
                     }
                     _loc5_ = _loc2_.getDate();
                     _loc10_ = "";
                  }
                  if(_loc10_ && _loc10_.length)
                  {
                     _loc10_ = _loc10_ + "\n";
                  }
                  _loc10_ = _loc10_ + (ColorUtils.hexToRGBFormat(16645626) + "[" + getTimeString(_loc2_) + "] ");
                  _loc7_ = ColorUtils.hexToRGBFormat(16573879);
                  _loc4_ = ColorUtils.hexToRGBFormat(15919178);
                  _loc3_ = ColorUtils.hexToRGBFormat(11087871);
                  var _loc12_:* = _loc11_.event;
                  if("blackListAdd" !== _loc12_)
                  {
                     if("blackListRemove" !== _loc12_)
                     {
                        if("create" !== _loc12_)
                        {
                           if("join" !== _loc12_)
                           {
                              if("leave" !== _loc12_)
                              {
                                 if("kick" !== _loc12_)
                                 {
                                    if("rename" !== _loc12_)
                                    {
                                       if("newLeader" !== _loc12_)
                                       {
                                          if("change" !== _loc12_)
                                          {
                                             if("points" !== _loc12_)
                                             {
                                                if("dungeonPoints" !== _loc12_)
                                                {
                                                   _loc10_ = _loc10_ + (_loc7_ + "undefined event");
                                                }
                                                else
                                                {
                                                   _loc10_ = _loc10_ + (_loc7_ + Translate.translateArgs("UI_DIALOG_CLAN_LOG_DUNGEON_POINTS",_loc4_ + _loc11_.details.value + _loc7_));
                                                }
                                             }
                                             else
                                             {
                                                _loc10_ = _loc10_ + (_loc7_ + Translate.translateArgs("UI_DIALOG_CLAN_LOG_POINTS",_loc4_ + _loc11_.details.value + _loc7_));
                                             }
                                          }
                                          else
                                          {
                                             _loc8_ = player.clan.clan.roleNames.getRoleString(DataStorage.clanRole.getByCode(_loc11_.details.newRole));
                                             _loc10_ = _loc10_ + (_loc7_ + Translate.translateArgs("UI_DIALOG_CLAN_LOG_CHANGE",_loc4_ + getUserNickById(_loc11_.details.userId) + _loc7_,_loc4_ + _loc8_ + _loc7_,_loc4_ + getUserNickById(_loc11_.userId) + _loc7_));
                                          }
                                       }
                                       else
                                       {
                                          _loc6_ = player.clan.clan.roleNames.getRoleString(DataStorage.clanRole.getByCode(_loc11_.details.newRole));
                                          _loc10_ = _loc10_ + (_loc7_ + Translate.translateArgs("UI_DIALOG_CLAN_LOG_CHANGE",_loc3_ + getUserNickById(_loc11_.details.userId) + _loc7_,_loc3_ + _loc6_ + _loc7_,_loc4_ + getUserNickById(_loc11_.userId) + _loc7_));
                                       }
                                    }
                                    else
                                    {
                                       _loc10_ = _loc10_ + (_loc7_ + Translate.translateArgs("UI_DIALOG_CLAN_LOG_RENAME",_loc4_ + _loc11_.details.newName + _loc7_,_loc4_ + _loc11_.details.oldName + _loc7_));
                                    }
                                 }
                                 else
                                 {
                                    _loc10_ = _loc10_ + (_loc7_ + Translate.translateArgs("UI_DIALOG_CLAN_LOG_KICK",_loc4_ + getUserNickById(_loc11_.details.userId) + _loc7_,_loc4_ + getUserNickById(_loc11_.userId) + _loc7_));
                                 }
                              }
                              else
                              {
                                 _loc10_ = _loc10_ + (_loc7_ + Translate.translateArgs("UI_DIALOG_CLAN_LOG_LEAVE",_loc4_ + getUserNickById(_loc11_.userId) + _loc7_));
                              }
                           }
                           else
                           {
                              _loc10_ = _loc10_ + (_loc7_ + Translate.translateArgs("UI_DIALOG_CLAN_LOG_JOIN",_loc4_ + getUserNickById(_loc11_.userId) + _loc7_));
                           }
                        }
                        else
                        {
                           _loc10_ = _loc10_ + (_loc7_ + Translate.translateArgs("UI_DIALOG_CLAN_LOG_CREATE",_loc4_ + player.clan.clan.title + _loc7_,_loc4_ + getUserNickById(_loc11_.userId) + _loc7_));
                        }
                     }
                     else
                     {
                        _loc10_ = _loc10_ + (_loc7_ + Translate.translateArgs("UI_DIALOG_CLAN_LOG_BLACKLISTREMOVE",_loc4_ + getUserNickById(_loc11_.details.userId) + _loc7_,_loc4_ + getUserNickById(_loc11_.userId) + _loc7_));
                     }
                  }
                  else
                  {
                     _loc10_ = _loc10_ + (_loc7_ + Translate.translateArgs("UI_DIALOG_CLAN_LOG_BLACKLISTADD",_loc4_ + getUserNickById(_loc11_.details.userId) + _loc7_,_loc4_ + getUserNickById(_loc11_.userId) + _loc7_));
                  }
               }
               _loc9_++;
            }
            if(_loc10_ && _loc10_.length)
            {
               _loc1_.push(_loc10_);
            }
            return _loc1_;
         }
         return null;
      }
      
      public function get datesTexts() : Array
      {
         var _loc1_:* = null;
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc6_:* = null;
         var _loc4_:int = 0;
         if(clanLog)
         {
            _loc1_ = [];
            _loc5_ = "";
            _loc3_ = -1;
            _loc4_ = 0;
            while(_loc4_ < clanLog.length)
            {
               _loc6_ = clanLog[_loc4_] as ClanLogEventValueObject;
               if(_loc6_)
               {
                  _loc2_ = new Date(_loc6_.ctime * 1000);
                  if(_loc2_.getDate() != _loc3_)
                  {
                     _loc3_ = _loc2_.getDate();
                     if(_loc5_ && _loc5_.length)
                     {
                        _loc1_.push(_loc5_);
                        _loc5_ = "\n";
                     }
                     else
                     {
                        _loc5_ = "";
                     }
                     _loc5_ = _loc5_ + (ColorUtils.hexToRGBFormat(16645626) + getDateString(_loc2_));
                  }
               }
               _loc4_++;
            }
            if(_loc5_ && _loc5_.length)
            {
               _loc1_.push(_loc5_);
            }
            return _loc1_;
         }
         return null;
      }
      
      public function getTimeString(param1:Date) : String
      {
         return DateFormatter.dateToHHMM(param1);
      }
      
      public function getDateString(param1:Date) : String
      {
         return DateFormatter.dateToDDMMYYYY(param1);
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ClanLogPopUp(this);
         return _popup;
      }
      
      public function action_refreshLog() : void
      {
         var _loc1_:CommandClanGetLog = GameModel.instance.actionManager.clan.clanGetLog();
         _loc1_.signal_complete.add(handler_clanGetInfo);
      }
      
      private function handler_clanGetInfo(param1:CommandClanGetLog) : void
      {
         var _loc7_:* = null;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         users = {};
         clanLog = [];
         var _loc3_:Object = param1.result.body.users;
         var _loc9_:int = 0;
         var _loc8_:* = _loc3_;
         for(var _loc6_ in _loc3_)
         {
            users[_loc6_] = new ChatUserData(_loc3_[_loc6_]);
         }
         var _loc5_:Array = param1.result.body.history as Array;
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            _loc7_ = new ClanLogEventValueObject();
            _loc7_.deserialize(_loc5_[_loc4_]);
            clanLog.push(_loc7_);
            if(_loc7_.event == "points")
            {
               _loc2_ = new Date();
               _loc7_.ctime = int(_loc7_.ctime / 3600) * 3600;
            }
            if(_loc7_.event == "dungeonPoints")
            {
               _loc7_.ctime = int(_loc7_.ctime / 3600) * 3600;
            }
            _loc4_++;
         }
         clanLog.sort(_sort);
         signal_update.dispatch();
      }
      
      private function _sort(param1:ClanLogEventValueObject, param2:ClanLogEventValueObject) : int
      {
         return param1.ctime - param2.ctime;
      }
   }
}
