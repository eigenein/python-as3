package game.mediator.gui.popup.ratingquiz
{
   import com.progrestar.common.lang.Translate;
   import game.command.rpc.rating.CommandRatingTopGet;
   import game.command.rpc.rating.CommandRatingTopGetResultEntry;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   import game.view.popup.ratingquiz.RatingQuizPopup;
   import idv.cjcat.signals.Signal;
   
   public class RatingQuizPopupMediator extends PopupMediator
   {
       
      
      private var _signal_dataUpdate:Signal;
      
      private var _dataList:Vector.<CommandRatingTopGetResultEntry>;
      
      private var _playerPlaceEntry:CommandRatingTopGetResultEntry;
      
      private var _playerDelta:int;
      
      public function RatingQuizPopupMediator(param1:Player)
      {
         _signal_dataUpdate = new Signal();
         super(param1);
      }
      
      override protected function dispose() : void
      {
         super.dispose();
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
      
      public function get title() : String
      {
         return Translate.translate("UI_DIALOG_RATING_TITLE");
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new RatingQuizPopup(this);
         return _popup;
      }
      
      public function action_toClans() : void
      {
         Game.instance.navigator.navigateToClan(_popup.stashParams);
      }
      
      public function action_getRating() : void
      {
         var _loc1_:CommandRatingTopGet = GameModel.instance.actionManager.ratingTopGet("quiz");
         _loc1_.onClientExecute(handler_ratingDataGet);
      }
      
      private function handler_ratingDataGet(param1:CommandRatingTopGet) : void
      {
         _dataList = param1.resultValueObject.list.slice();
         _playerPlaceEntry = param1.resultValueObject.playerPlace;
         _playerDelta = param1.resultValueObject.playerPlaceDelta;
         _signal_dataUpdate.dispatch();
      }
   }
}
