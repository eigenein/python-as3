package game.mediator.gui.popup.friends.socialquest
{
   import idv.cjcat.signals.Signal;
   
   public class SocialQuestTaskValueObject
   {
       
      
      var _progress:int;
      
      var _progressMax:int;
      
      var _title:String;
      
      var _desc:String;
      
      var _buttonLabel:String;
      
      var _signal_buttonAction:Signal;
      
      private var _signal_update:Signal;
      
      public function SocialQuestTaskValueObject()
      {
         _signal_buttonAction = new Signal();
         _signal_update = new Signal();
         super();
      }
      
      public function get progress() : int
      {
         return _progress;
      }
      
      public function get progressMax() : int
      {
         return _progressMax;
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function get desc() : String
      {
         return _desc;
      }
      
      public function get buttonLabel() : String
      {
         return _buttonLabel;
      }
      
      public function get complete() : Boolean
      {
         return _progress >= _progressMax;
      }
      
      public function get signal_update() : Signal
      {
         return _signal_update;
      }
      
      public function dispatchAction() : void
      {
         _signal_buttonAction.dispatch();
      }
      
      public function dispatchUpdate() : void
      {
         _signal_update.dispatch();
      }
   }
}
