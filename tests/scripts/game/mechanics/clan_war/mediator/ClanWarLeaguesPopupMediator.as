package game.mechanics.clan_war.mediator
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.DataStorage;
   import game.mechanics.clan_war.model.ClanWarRaitingData;
   import game.mechanics.clan_war.model.command.CommandClanWarLeagueInfo;
   import game.mechanics.clan_war.model.command.CommandClanWarLeagueTop;
   import game.mechanics.clan_war.popup.leagues.ClanWarLeagueInfoValueObject;
   import game.mechanics.clan_war.popup.leagues.ClanWarLeaguesPopup;
   import game.mechanics.clan_war.storage.ClanWarLeagueDescription;
   import game.mediator.gui.popup.clan.ClanPopupMediatorBase;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.clan.PlayerClanData;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import idv.cjcat.signals.Signal;
   
   public class ClanWarLeaguesPopupMediator extends ClanPopupMediatorBase
   {
      
      private static const TAB_LAST_WEEK:String = "LAST_WEEK";
      
      private static const TAB_CURRENT_WEEK:String = "CURRENT_WEEK";
       
      
      private var _leagueInfo:ClanWarLeagueInfoValueObject;
      
      public const signal_ratingUpdate:Signal = new Signal();
      
      public const signal_leagueInfoUpdate:Signal = new Signal();
      
      private var _tabs:Vector.<String>;
      
      public var rating:ClanWarRaitingData;
      
      public var selecetdLeague:ClanWarLeagueDescription;
      
      public var currentWeekFlag:Boolean;
      
      public function ClanWarLeaguesPopupMediator(param1:Player)
      {
         super(param1);
         _tabs = new <String>["LAST_WEEK","CURRENT_WEEK"];
         var _loc2_:CommandClanWarLeagueInfo = GameModel.instance.actionManager.clanWar.clanWarLeagueInfo();
         _loc2_.onClientExecute(handler_commandGetClanWarLeagueInfo);
      }
      
      public function get leagueInfo() : ClanWarLeagueInfoValueObject
      {
         return _leagueInfo;
      }
      
      public function get tabs() : Vector.<String>
      {
         return _tabs;
      }
      
      public function get clanWarLeagues() : Array
      {
         var _loc1_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = DataStorage.clanWar.getLeaguesList();
         for each(var _loc2_ in DataStorage.clanWar.getLeaguesList())
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function get playerClan() : PlayerClanData
      {
         return player.clan;
      }
      
      public function get playerClanInRating() : Boolean
      {
         if(leagueInfo && (currentWeekFlag && leagueInfo.leagueId > 0 && leagueInfo.position > 0 || !currentWeekFlag && leagueInfo.leagueId && leagueInfo.prevPosition > 0))
         {
            return true;
         }
         return false;
      }
      
      public function get leagueText() : String
      {
         if(!leagueInfo)
         {
            return null;
         }
         if(currentWeekFlag && leagueInfo.leagueId > 0)
         {
            return Translate.translateArgs("UI_DIALOG_CLAN_WAR_LEAGUES_CLAN_PLACE",Translate.translate("LIB_CLANWAR_LEAGUE_NAME_" + leagueInfo.leagueId),leagueInfo.clanPlace);
         }
         if(playerClanInRating && leagueInfo.prevLeague > 0)
         {
            return Translate.translateArgs("UI_DIALOG_CLAN_WAR_LEAGUES_CLAN_PLACE",Translate.translate("LIB_CLANWAR_LEAGUE_NAME_" + leagueInfo.prevLeague),leagueInfo.prevPosition);
         }
         return Translate.translate("UI_DIALOG_CLAN_WAR_LEAGUES_CLAN_NOT_IN_LEAGUE");
      }
      
      public function get leaguePoints() : uint
      {
         if(!leagueInfo)
         {
            return null;
         }
         if(currentWeekFlag)
         {
            return leagueInfo.points;
         }
         return leagueInfo.prevPoints;
      }
      
      public function get playerClanLeagueIndex() : uint
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc1_:Array = clanWarLeagues;
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc3_];
            if(_loc2_ && _loc2_.id == player.clan.clanWarData.leagueId)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return 0;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ClanWarLeaguesPopup(this);
         return _popup;
      }
      
      public function action_getTop(param1:ClanWarLeagueDescription, param2:Boolean) : void
      {
         selecetdLeague = param1;
         currentWeekFlag = param2;
         var _loc3_:CommandClanWarLeagueTop = GameModel.instance.actionManager.clanWar.clanWarLeagueTop(param1.id,param2);
         _loc3_.onClientExecute(handler_commandGetClanWarLeagueTop);
      }
      
      public function action_showRewardsPopup() : void
      {
         var _loc1_:ClanWarLeaguesAndRewardsPopupMediator = new ClanWarLeaguesAndRewardsPopupMediator(GameModel.instance.player);
         _loc1_.open(Stash.click("button_rewards",_popup.stashParams));
      }
      
      private function handler_commandGetClanWarLeagueTop(param1:CommandClanWarLeagueTop) : void
      {
         rating = param1.raiting;
         signal_ratingUpdate.dispatch();
      }
      
      private function handler_commandGetClanWarLeagueInfo(param1:CommandClanWarLeagueInfo) : void
      {
         _leagueInfo = param1.info;
         signal_leagueInfoUpdate.dispatch();
      }
   }
}
