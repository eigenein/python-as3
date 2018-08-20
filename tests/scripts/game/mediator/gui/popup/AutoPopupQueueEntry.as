package game.mediator.gui.popup
{
   import idv.cjcat.signals.Signal;
   
   public class AutoPopupQueueEntry
   {
      
      public static const PRIORITY_SOCIAL_QUEST:int = 1;
      
      public static const PRIORITY_BILLING:int = 2;
      
      public static const PRIORITY_SPECIAL_OFFER_LOW:int = 3;
      
      public static const PRIORITY_SPECIAL_OFFER:int = 4;
      
      public static const PRIORITY_SPECIAL_OFFER_HIGH:int = 5;
      
      protected static const PRIORITY_DISPOSED:int = -9999;
       
      
      private var _priority:int;
      
      public const signal_open:Signal = new Signal(PopupStashEventParams);
      
      public const signal_dispose:Signal = new Signal(AutoPopupQueueEntry);
      
      public function AutoPopupQueueEntry(param1:int)
      {
         super();
         this._priority = param1;
      }
      
      public static function sort_byPriority(param1:AutoPopupQueueEntry, param2:AutoPopupQueueEntry) : int
      {
         return param1._priority - param2._priority;
      }
      
      public function dispose() : void
      {
         signal_dispose.dispatch(this);
         signal_dispose.clear();
         _priority = -9999;
      }
      
      public function get disposed() : Boolean
      {
         return _priority == -9999;
      }
      
      public function set priority(param1:int) : void
      {
         _priority = param1;
      }
      
      public function open(param1:PopupStashEventParams) : void
      {
         signal_open.dispatch(param1);
      }
   }
}
