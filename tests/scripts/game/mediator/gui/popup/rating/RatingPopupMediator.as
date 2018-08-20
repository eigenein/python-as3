package game.mediator.gui.popup.rating
{
   import com.progrestar.common.lang.Translate;
   import game.command.rpc.rating.CommandRatingTopGet;
   import game.command.rpc.rating.CommandRatingTopGetResultEntry;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   import game.view.popup.rating.RatingPopup;
   import idv.cjcat.signals.Signal;
   
   public class RatingPopupMediator extends PopupMediator
   {
       
      
      private var _signal_dataUpdate:Signal;
      
      private var _dataList:Vector.<CommandRatingTopGetResultEntry>;
      
      private var _playerPlaceEntry:CommandRatingTopGetResultEntry;
      
      private var _playerDelta:int;
      
      private var _tabs:Vector.<String>;
      
      private var _selectedTab:int;
      
      public const signal_tabSet:Signal = new Signal();
      
      public function RatingPopupMediator(param1:Player)
      {
         _signal_dataUpdate = new Signal();
         super(param1);
         _tabs = createTabs();
         getRating();
      }
      
      override protected function dispose() : void
      {
         super.dispose();
         signal_tabSet.clear();
         _signal_dataUpdate.clear();
      }
      
      public function get signal_dataUpdate() : Signal
      {
         return _signal_dataUpdate;
      }
      
      public function get dataList() : Vector.<CommandRatingTopGetResultEntry>
      {
         return _dataList;
      }
      
      public function get playerPlaceEntry() : CommandRatingTopGetResultEntry
      {
         return _playerPlaceEntry;
      }
      
      public function get playerDelta() : int
      {
         return _playerDelta;
      }
      
      public function get tabs() : Vector.<String>
      {
         return _tabs;
      }
      
      public function get selectedTab() : int
      {
         return _selectedTab;
      }
      
      public function get title() : String
      {
         if(_tabs[_selectedTab] == "clan" || _tabs[_selectedTab] == "clanDungeon" || _tabs[_selectedTab] == "nyTree")
         {
            return Translate.translate("UI_DIALOG_RATING_TITLE_CLAN");
         }
         return Translate.translate("UI_DIALOG_RATING_TITLE");
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new RatingPopup(this);
         return _popup;
      }
      
      public function action_toClans() : void
      {
         Game.instance.navigator.navigateToClan(_popup.stashParams);
      }
      
      public function action_tabSelect(param1:int) : void
      {
         _selectedTab = param1;
         getRating();
      }
      
      public function action_toTabGrand() : void
      {
         action_tabSelect(_tabs.indexOf("grand"));
         signal_tabSet.dispatch();
      }
      
      protected function createTabs() : Vector.<String>
      {
         var _loc1_:Vector.<String> = new <String>["power","titanPower","arena","grand","clan","clanDungeon","dungeonFloor"];
         if(player.arena.rankingIsLocked)
         {
            _loc1_.splice(_tabs.indexOf("arena"),1);
         }
         return _loc1_;
      }
      
      protected function getRating() : void
      {
         var _loc1_:CommandRatingTopGet = GameModel.instance.actionManager.ratingTopGet(_tabs[_selectedTab]);
         _loc1_.onClientExecute(handler_ratingDataGet);
      }
      
      private function handler_ratingDataGet(param1:CommandRatingTopGet) : void
      {
         if(param1.ratingType == _tabs[_selectedTab])
         {
            _dataList = param1.resultValueObject.list.slice();
            _playerPlaceEntry = param1.resultValueObject.playerPlace;
            _playerDelta = param1.resultValueObject.playerPlaceDelta;
            _signal_dataUpdate.dispatch();
         }
      }
   }
}
