package game.mechanics.titan_arena.mediator.halloffame
{
   import com.progrestar.common.lang.Translate;
   import flash.utils.Dictionary;
   import game.mechanics.titan_arena.mediator.trophies.TitanArenaTrophiesPopupMediator;
   import game.mechanics.titan_arena.model.TitanArenaHallOfFameUserInfo;
   import game.mechanics.titan_arena.model.TitanArenaHallOfFameVO;
   import game.mechanics.titan_arena.model.command.CommandTitanArenaHallOfFameGet;
   import game.mechanics.titan_arena.popup.halloffame.TitanArenaHallOfFamePopup;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.titanarena.TitanArenaRulesPopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.stat.Stash;
   import game.view.popup.MessagePopup;
   import game.view.popup.PopupBase;
   import idv.cjcat.signals.Signal;
   
   public class TitanArenaHallOfFamePopupMediator extends PopupMediator
   {
       
      
      private var _currentInfo:TitanArenaHallOfFameVO;
      
      private var cashedInfo:Dictionary;
      
      private var openStashParams:PopupStashEventParams;
      
      public var signal_infoUpdate:Signal;
      
      public function TitanArenaHallOfFamePopupMediator(param1:Player)
      {
         cashedInfo = new Dictionary();
         signal_infoUpdate = new Signal(TitanArenaHallOfFameVO);
         super(param1);
      }
      
      public function get currentInfo() : TitanArenaHallOfFameVO
      {
         return _currentInfo;
      }
      
      public function get serverName() : String
      {
         return player.serverId + " " + Translate.translate("LIB_SERVER_NAME_" + player.serverId);
      }
      
      public function get maxDisplayedRenderers() : uint
      {
         return 6;
      }
      
      override public function createPopup() : PopupBase
      {
         if(_currentInfo)
         {
            _popup = new TitanArenaHallOfFamePopup(this);
         }
         else
         {
            _popup = new MessagePopup(Translate.translate("UI_TITAN_ARENA_NEGATIVE_TEXT_HALL_OF_FAME"),"");
         }
         return _popup;
      }
      
      public function action_getHallOfFame() : void
      {
         var _loc1_:CommandTitanArenaHallOfFameGet = GameModel.instance.actionManager.titanArena.titanArenaHallOfFameGet();
         _loc1_.signal_complete.add(handler_hallOfFameGet);
      }
      
      override public function open(param1:PopupStashEventParams = null) : void
      {
         this.openStashParams = param1;
         action_getHallOfFame();
      }
      
      public function action_getPrevHallOfFameGet() : void
      {
         var _loc1_:* = null;
         if(currentInfo)
         {
            if(!cashedInfo[currentInfo.prev])
            {
               _loc1_ = GameModel.instance.actionManager.titanArena.titanArenaHallOfFameGet(currentInfo.prev);
               _loc1_.signal_complete.add(handler_hallOfFameGet);
            }
            else
            {
               _currentInfo = cashedInfo[currentInfo.prev];
               signal_infoUpdate.dispatch(currentInfo);
            }
         }
      }
      
      public function action_getNextHallOfFameGet() : void
      {
         var _loc1_:* = null;
         if(currentInfo)
         {
            if(!cashedInfo[currentInfo.next])
            {
               _loc1_ = GameModel.instance.actionManager.titanArena.titanArenaHallOfFameGet(currentInfo.next);
               _loc1_.signal_complete.add(handler_hallOfFameGet);
            }
            else
            {
               _currentInfo = cashedInfo[currentInfo.next];
               signal_infoUpdate.dispatch(currentInfo);
            }
         }
      }
      
      public function action_showMyTrophies() : void
      {
         new TitanArenaTrophiesPopupMediator(player).open(Stash.click("trophies",_popup.stashParams));
      }
      
      public function action_showTitanArenaRules() : void
      {
         new TitanArenaRulesPopupMediator(player,"TAB_CUPS").open(Stash.click("rules",_popup.stashParams));
      }
      
      public function action_showGoldCupHolderPlayers() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Vector.<TitanArenaHallOfFameUserInfo> = new Vector.<TitanArenaHallOfFameUserInfo>();
         _loc2_ = 1;
         while(_loc2_ < currentInfo.champions.length)
         {
            _loc1_.push(currentInfo.champions[_loc2_]);
            _loc2_++;
         }
         new TitanArenaBestPlayersPopupMediator(player,Translate.translate("UI_DIALOG_TITAN_ARENA_HALL_OF_FAME_GOLD_CUPS_HOLDERS"),_loc1_).open(Stash.click("best_players",_popup.stashParams));
      }
      
      public function action_showBestGuildMembers() : void
      {
         new TitanArenaBestPlayersPopupMediator(player,Translate.translate("UI_DIALOG_TITAN_ARENA_HALL_OF_FAME_BEST_GUILD_PLAYERS"),currentInfo.bestGuildMembers).open(Stash.click("best_players",_popup.stashParams));
      }
      
      private function sortChampions(param1:TitanArenaHallOfFameUserInfo, param2:TitanArenaHallOfFameUserInfo) : int
      {
         return param1.place - param2.place;
      }
      
      private function handler_hallOfFameGet(param1:CommandTitanArenaHallOfFameGet) : void
      {
         var _loc2_:* = param1.result.body == null;
         if(!_loc2_)
         {
            _currentInfo = new TitanArenaHallOfFameVO(param1.result.body);
            currentInfo.champions.sort(sortChampions);
            cashedInfo[currentInfo.key] = currentInfo;
            signal_infoUpdate.dispatch(currentInfo);
         }
         else
         {
            _currentInfo = null;
         }
         if(openStashParams)
         {
            super.open(openStashParams);
            openStashParams = null;
         }
      }
   }
}
