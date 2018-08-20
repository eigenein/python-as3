package game.mediator.gui.popup.chat
{
   import feathers.core.PopUpManager;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import game.battle.controller.thread.ArenaBattleThread;
   import game.battle.controller.thread.BattleThread;
   import game.battle.controller.thread.ReplayBattleThread;
   import game.command.rpc.arena.ArenaBattleResultValueObject;
   import game.command.rpc.grand.CommandGrandReplayPack;
   import game.command.rpc.mission.CommandBattleGetReplay;
   import game.command.rpc.mission.CommandBattleStartReplay;
   import game.data.storage.mechanic.MechanicStorage;
   import game.global.GlobalEventController;
   import game.mediator.gui.popup.mission.MissionDefeatPopupMediator;
   import game.model.GameModel;
   import game.model.user.UserInfo;
   import game.model.user.sharedobject.RefreshMetadata;
   import game.view.popup.fightresult.pvp.ArenaVictoryPopup;
   import idv.cjcat.signals.Signal;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class ProcessingURLTextMediator
   {
      
      public static const URL_PATTERN:RegExp = /^(?:http(s)?:\/\/)[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&'\(\)\*\+,;=.%]+$/;
      
      public static var signal_replayStart:Signal = new Signal();
      
      public static var signal_replayComplete:Signal = new Signal();
       
      
      public function ProcessingURLTextMediator()
      {
         super();
      }
      
      public static function findURL(param1:String) : Boolean
      {
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         if(param1 && param1.length)
         {
            _loc2_ = " ";
            _loc3_ = param1.split(_loc2_);
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _loc5_ = _loc3_[_loc4_];
               if(URL_PATTERN.test(_loc5_))
               {
                  return true;
               }
               _loc4_++;
            }
         }
         return false;
      }
      
      public static function prepareText(param1:String, param2:uint) : String
      {
         var _loc4_:* = null;
         var _loc10_:* = 0;
         var _loc12_:* = null;
         var _loc5_:* = null;
         var _loc8_:Boolean = false;
         var _loc7_:int = 0;
         var _loc11_:Boolean = false;
         var _loc6_:* = 0;
         var _loc9_:int = 0;
         var _loc3_:String = "";
         if(param1)
         {
            _loc4_ = " ";
            _loc10_ = uint(50);
            _loc3_ = _loc3_ + ColorUtils.hexToRGBFormat(param2);
            _loc5_ = param1.split(_loc4_);
            _loc8_ = false;
            _loc7_ = 0;
            while(_loc7_ < _loc5_.length)
            {
               if(_loc7_ > 0)
               {
                  _loc3_ = _loc3_ + _loc4_;
               }
               _loc12_ = _loc5_[_loc7_];
               _loc11_ = URL_PATTERN.test(_loc5_[_loc7_]);
               if(_loc11_ && !_loc8_)
               {
                  _loc3_ = _loc3_ + "^{sprite:url_icon}^";
                  _loc3_ = _loc3_ + ColorUtils.hexToRGBFormat(15919178);
               }
               _loc6_ = uint(Math.ceil(_loc12_.length / _loc10_));
               _loc9_ = 0;
               while(_loc9_ < _loc6_)
               {
                  if(_loc9_ > 0)
                  {
                     _loc3_ = _loc3_ + "\n";
                  }
                  _loc3_ = _loc3_ + _loc12_.substr(_loc9_ * _loc10_,Math.min(_loc10_,_loc12_.length - _loc9_ * _loc10_));
                  _loc9_++;
               }
               if(_loc11_ && !_loc8_)
               {
                  _loc3_ = _loc3_ + ColorUtils.hexToRGBFormat(param2);
                  _loc8_ = true;
               }
               _loc7_++;
            }
         }
         return _loc3_;
      }
      
      public static function navigateToFirstURL(param1:String) : Boolean
      {
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc5_:* = null;
         var _loc8_:int = 0;
         var _loc2_:* = null;
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc9_:int = 0;
         var _loc7_:* = null;
         var _loc3_:* = null;
         var _loc12_:* = null;
         if(param1)
         {
            _loc10_ = " ";
            _loc5_ = param1.split(_loc10_);
            _loc8_ = 0;
            while(_loc8_ < _loc5_.length)
            {
               _loc11_ = _loc5_[_loc8_];
               if(URL_PATTERN.test(_loc11_))
               {
                  if(_loc11_.indexOf(GameModel.instance.context.platformFacade.gameURL) >= 0 && _loc11_.indexOf("replay_id") >= 0)
                  {
                     _loc2_ = _loc11_.split(GameModel.instance.context.platformFacade.urlParamsSeparator);
                     if(_loc2_.length > 1)
                     {
                        _loc6_ = _loc2_[1];
                        _loc4_ = _loc6_.split("&");
                        _loc9_ = 0;
                        while(_loc9_ < _loc4_.length)
                        {
                           _loc7_ = _loc4_[_loc9_];
                           if(_loc7_.indexOf("replay_id") >= 0)
                           {
                              _loc3_ = _loc7_.split("=");
                              if(_loc3_.length > 1)
                              {
                                 replay(_loc3_[1]);
                              }
                              break;
                           }
                           _loc9_++;
                        }
                     }
                     return true;
                  }
                  GlobalEventController.signal_redirect.dispatch();
                  _loc12_ = new URLRequest(_loc11_);
                  navigateToURL(_loc12_,"_blank");
                  return true;
               }
               _loc8_++;
            }
         }
         return false;
      }
      
      public static function replay(param1:String) : void
      {
         replayId = param1;
         if(replayId == null)
         {
            return;
         }
         if(replayId.indexOf("r") != -1)
         {
            var replayId:String = replayId.split("r").join("");
         }
         var cmd:CommandBattleStartReplay = new CommandBattleStartReplay(replayId);
         cmd.signal_replayStart.add(handler_replayStart);
         cmd.signal_replayComplete.add(handler_replayComplete);
         GameModel.instance.actionManager.executeRPCCommand(cmd);
         var refreshMetaData:RefreshMetadata = GameModel.instance.player.sharedObjectStorage.refreshMeta;
         GameModel.instance.player.sharedObjectStorage.refreshMeta = null;
         if(refreshMetaData && refreshMetaData.action == "arenaBattle")
         {
            handler_arenaReplayComplete = function(param1:BattleThread):void
            {
               var _loc3_:* = null;
               if(!(param1 is ReplayBattleThread))
               {
                  return;
               }
               var _loc2_:ArenaBattleResultValueObject = new ArenaBattleResultValueObject();
               _loc2_.win = param1.battleResult.victory;
               _loc2_.result = param1.battleResult;
               _loc2_.oldPlace = refreshMetaData.arenaOldPlace;
               _loc2_.newPlace = refreshMetaData.arenaNewPlace;
               if(_loc2_.win)
               {
                  PopUpManager.addPopUp(new ArenaVictoryPopup(_loc2_));
               }
               else
               {
                  _loc3_ = new MissionDefeatPopupMediator(GameModel.instance.player,_loc2_,MechanicStorage.ARENA);
                  _loc3_.open();
               }
            };
            cmd.signal_replayComplete.add(handler_arenaReplayComplete);
         }
      }
      
      public static function replayGrand(param1:String) : void
      {
         var _loc4_:int = 0;
         var _loc2_:Array = param1.split(",");
         var _loc3_:Vector.<String> = new Vector.<String>();
         var _loc6_:int = _loc2_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc3_.push(_loc2_[_loc4_]);
            _loc4_++;
         }
         var _loc5_:CommandBattleStartReplay = new CommandGrandReplayPack(_loc3_);
         _loc5_.signal_replayStart.add(handler_replayStart);
         _loc5_.signal_replayComplete.add(handler_replayComplete);
         GameModel.instance.actionManager.executeRPCCommand(_loc5_);
         var _loc7_:RefreshMetadata = GameModel.instance.player.sharedObjectStorage.refreshMeta;
         GameModel.instance.player.sharedObjectStorage.refreshMeta = null;
      }
      
      private static function handler_replayStart() : void
      {
         signal_replayStart.dispatch();
      }
      
      private static function handler_replayComplete(param1:BattleThread) : void
      {
         signal_replayComplete.dispatch();
      }
      
      private static function onGetBattleReplay(param1:CommandBattleGetReplay) : void
      {
         var _loc6_:* = null;
         var _loc2_:* = false;
         var _loc8_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc9_:* = null;
         var _loc3_:* = null;
         if(param1.result.body && param1.result.body.replay)
         {
            _loc6_ = param1.result.body.replay.typeId;
            _loc2_ = param1.playerId == _loc6_;
            _loc8_ = {};
            var _loc11_:int = 0;
            var _loc10_:* = param1.result.body.users;
            for each(var _loc7_ in param1.result.body.users)
            {
               _loc4_ = new UserInfo();
               _loc4_.parse(_loc7_);
               _loc8_[_loc4_.id] = _loc4_;
            }
            _loc5_ = _loc8_[param1.result.body.replay.userId];
            _loc9_ = _loc8_[param1.result.body.replay.typeId];
            _loc3_ = new ReplayBattleThread(param1.result.body.replay,_loc2_,_loc5_,_loc9_);
            _loc3_.onComplete.addOnce(onBattleEnded);
            _loc3_.run();
            signal_replayStart.dispatch();
         }
      }
      
      private static function onBattleEnded(param1:ArenaBattleThread) : void
      {
         Game.instance.screen.hideBattle();
         signal_replayComplete.dispatch();
      }
   }
}
