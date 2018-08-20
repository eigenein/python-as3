package game.battle.controller.thread
{
   import battle.utils.Version;
   import com.progrestar.common.Logger;
   import com.progrestar.common.lang.Translate;
   import game.battle.BattleLogEncoder;
   import game.battle.controller.MultiBattleResult;
   import game.command.rpc.arena.ArenaBattleResultValueObject;
   import game.mediator.gui.popup.PopupList;
   import game.model.GameModel;
   import game.view.popup.PromptPopup;
   
   public class InvalidBattleHandler
   {
       
      
      public function InvalidBattleHandler()
      {
         super();
      }
      
      public static function tower(param1:MultiBattleResult, param2:*) : void
      {
         var _loc3_:int = param2.serverVersion;
         if(testCorrectVersion(_loc3_))
         {
            PopupList.instance.message(Translate.translate("UI_TOWER_VALIDATION_ERROR"));
            logInvalidation(param1,"CommandTowerEndBattle");
         }
      }
      
      public static function dungeon(param1:MultiBattleResult, param2:*) : void
      {
         var _loc3_:int = param2.serverVersion;
         if(testCorrectVersion(_loc3_))
         {
            PopupList.instance.message(Translate.translate("UI_TOWER_VALIDATION_ERROR"));
            logInvalidation(param1,"CommandDungeonEndBattle");
         }
      }
      
      public static function missionWithMessage(param1:MultiBattleResult, param2:int) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(testCorrectVersion(param2))
         {
            _loc3_ = Translate.translate("UI_DIALOG_MISSION_VALIDATION_ERROR_TITLE");
            _loc4_ = Translate.translate("UI_DIALOG_MISSION_VALIDATION_ERROR_DEFAULT");
            PopupList.instance.message(_loc4_,_loc3_);
            mission(param1,param2);
         }
      }
      
      public static function mission(param1:MultiBattleResult, param2:int) : void
      {
         if(param2 == Version.last)
         {
            logInvalidation(param1,"CommandMissionEnd");
         }
      }
      
      public static function boss(param1:MultiBattleResult, param2:int) : void
      {
         if(testCorrectVersion(param2))
         {
            PopupList.instance.message(Translate.translate("UI_TOWER_VALIDATION_ERROR"));
            logInvalidation(param1,"CommandBossEndBattle");
         }
      }
      
      public static function beforeReplay(param1:ArenaBattleResultValueObject, param2:Boolean, param3:Boolean) : PromptPopup
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         if(param2)
         {
            _loc4_ = Translate.translate("LIB_MAIL_TYPE_MASSIMPORTANT_DEFAULT_TITLE");
            _loc5_ = !!Translate.has("UI_ARENA_VALIDATION_ERROR_REFRESH")?Translate.translate("UI_ARENA_VALIDATION_ERROR_REFRESH"):Translate.translate("UI_POPUP_ERROR_BATTLE_VERSION_LOW");
            PopupList.instance.error(_loc5_,_loc4_,true);
            return null;
         }
         if(param3)
         {
            _loc4_ = Translate.translate("UI_ARENA_VALIDATION_ERROR_OLD_HEADER");
            _loc5_ = Translate.translate("UI_ARENA_VALIDATION_ERROR_OLD_MESSAGE");
            return PopupList.instance.prompt(_loc5_,_loc4_,Translate.translate("UI_ARENA_VALIDATION_ERROR_BACK"),Translate.translate("UI_ARENA_VALIDATION_ERROR_WATCH"));
         }
         if(param1 != null)
         {
            encodeErrorBattleLog(Logger.getLogger("InvalidArenaReplay"),param1.result.getBattleLog());
         }
         _loc4_ = Translate.translate("UI_POPUP_ERROR_HEADER");
         _loc5_ = Translate.translate("UI_ARENA_VALIDATION_ERROR");
         return PopupList.instance.prompt(_loc5_,_loc4_,Translate.translate("UI_ARENA_VALIDATION_ERROR_BACK"),Translate.translate("UI_ARENA_VALIDATION_ERROR_WATCH"));
      }
      
      public static function arena(param1:MultiBattleResult, param2:Object) : void
      {
         var _loc3_:int = param2.serverVersion;
         if(Version.last == _loc3_)
         {
            encodeErrorBattleLog(Logger.getLogger("InvalidArenaReplay"),param1.getBattleLog());
            PopupList.instance.message(Translate.translate("UI_ARENA_VALIDATION_ERROR"));
         }
         else if(Version.last > _loc3_)
         {
            PopupList.instance.message(Translate.translate("UI_ARENA_INCORRECT_VERSION_LOW"));
         }
         else
         {
            PopupList.instance.message(Translate.translate("UI_ARENA_INCORRECT_VERSION_HIGH"));
         }
      }
      
      public static function clanWar(param1:MultiBattleResult, param2:*) : void
      {
         var _loc4_:* = null;
         var _loc3_:int = param2.serverVersion;
         if(Translate.has("UI_POPUP_ERROR_VALIDATION_TRIES_SAFE"))
         {
            _loc4_ = "\n" + Translate.translate("UI_POPUP_ERROR_VALIDATION_TRIES_SAFE");
         }
         else
         {
            _loc4_ = "";
         }
         if(testCorrectVersion(_loc3_,_loc4_))
         {
            PopupList.instance.message(Translate.translate("UI_TOWER_VALIDATION_ERROR") + _loc4_);
            logInvalidation(param1,"CommandClanWarEndBattle");
         }
      }
      
      protected static function encodeErrorBattleLog(param1:Logger, param2:String) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 1600;
         var _loc6_:int = 0;
         var _loc7_:String = GameModel.instance.player.id + " " + GameModel.instance.player.serverId + " # " + param2;
         _loc7_ = BattleLogEncoder.encode(_loc7_);
         var _loc5_:int = 0;
         var _loc4_:int = _loc7_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_++;
            param1.error(_loc5_,_loc7_.slice(_loc6_,_loc6_ + 1600));
            _loc6_ = _loc6_ + 1600;
         }
      }
      
      protected static function error(param1:String, param2:String) : void
      {
      }
      
      protected static function testCorrectVersion(param1:int, param2:String = "") : Boolean
      {
         var _loc3_:int = Version.last;
         if(param1 == _loc3_)
         {
            return true;
         }
         Logger.getLogger("IncorrectBattleVersion").error("server:" + param1,"client:" + _loc3_);
         if(param1 > _loc3_)
         {
            PopupList.instance.error(Translate.translate("UI_POPUP_ERROR_BATTLE_VERSION_LOW") + param2,"",true);
         }
         else
         {
            PopupList.instance.error(Translate.translate("UI_POPUP_ERROR_BATTLE_VERSION_HIGH") + param2,"",true);
         }
         return false;
      }
      
      protected static function logInvalidation(param1:MultiBattleResult, param2:String) : void
      {
         if(param1.b)
         {
            Logger.getLogger("b" + param2).error();
         }
         else
         {
            encodeErrorBattleLog(Logger.getLogger(param2),param1.getBattleLog());
         }
      }
   }
}
