package game.mechanics.quiz.mediator
{
   import game.data.storage.DataStorage;
   import game.data.storage.resource.InventoryItemDescription;
   import game.mechanics.quiz.command.CommandQuizGetNewQuestion;
   import game.mechanics.quiz.popup.QuizStartPopup;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.ratingquiz.RatingQuizPopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.inventory.InventoryItemCountProxy;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   
   public class QuizStartPopupMediator extends PopupMediator
   {
       
      
      private var ticketProxy:InventoryItemCountProxy;
      
      private var _item_ticket:InventoryItem;
      
      private var _item_points:InventoryItem;
      
      public function QuizStartPopupMediator(param1:Player)
      {
         super(param1);
         var _loc2_:InventoryItemDescription = DataStorage.consumable.getById(59) as InventoryItemDescription;
         ticketProxy = param1.inventory.getItemCounterProxy(_loc2_,false);
         ticketProxy.signal_update.add(handler_ticketProxyUpdate);
         _item_ticket = new InventoryItem(_loc2_,ticketProxy.amount);
         _loc2_ = DataStorage.pseudo.QUIZ_POINT;
         _item_points = new InventoryItem(_loc2_,param1.quizData.property_points.value);
         param1.quizData.property_points.signal_update.add(handler_pointsUpdate);
      }
      
      override protected function dispose() : void
      {
         ticketProxy.dispose();
         player.quizData.property_points.signal_update.remove(handler_pointsUpdate);
         super.dispose();
      }
      
      public function get item_ticket() : InventoryItem
      {
         return _item_ticket;
      }
      
      public function get item_points() : InventoryItem
      {
         return _item_points;
      }
      
      public function get hasRatingRewards() : Boolean
      {
         return player.questData.hasEvent(39);
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new QuizStartPopup(this);
         return _popup;
      }
      
      public function action_getQuestion_1() : void
      {
         getQuestion(false);
      }
      
      public function action_getQuestion_10() : void
      {
         getQuestion(true);
      }
      
      public function navigate_rating() : void
      {
         new RatingQuizPopupMediator(GameModel.instance.player).open(Stash.click("rating_quiz",_popup.stashParams));
      }
      
      public function navigate_event() : void
      {
         var _loc1_:Boolean = player.questData.hasEvent(39);
         if(_loc1_)
         {
            Game.instance.navigator.navigateToEvents(Stash.click("rewards",_popup.stashParams),39);
         }
      }
      
      private function getQuestion(param1:Boolean) : CommandQuizGetNewQuestion
      {
         var _loc2_:CommandQuizGetNewQuestion = new CommandQuizGetNewQuestion(param1);
         GameModel.instance.actionManager.executeRPCCommand(_loc2_);
         _loc2_.onClientExecute(handler_newQuestion);
         return _loc2_;
      }
      
      private function handler_ticketProxyUpdate(param1:InventoryItemCountProxy) : void
      {
         _item_ticket.amount = param1.amount;
      }
      
      private function handler_pointsUpdate(param1:int) : void
      {
         _item_points.amount = param1;
      }
      
      private function handler_newQuestion(param1:CommandQuizGetNewQuestion) : void
      {
         var _loc2_:QuizQuestionPopupMediator = new QuizQuestionPopupMediator(player,true);
         _loc2_.open(_popup.stashParams);
         close();
      }
   }
}
