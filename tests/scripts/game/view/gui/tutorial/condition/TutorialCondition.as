package game.view.gui.tutorial.condition
{
   import game.view.gui.tutorial.ITutorialConditionListener;
   import game.view.gui.tutorial.TutorialTask;
   
   public class TutorialCondition
   {
       
      
      protected var _listener:ITutorialConditionListener;
      
      protected var _ident:String;
      
      public var data;
      
      public function TutorialCondition(param1:String, param2:* = null)
      {
         super();
         this._ident = param1;
         this.data = param2;
      }
      
      public function get ident() : String
      {
         return _ident;
      }
      
      public function set listener(param1:ITutorialConditionListener) : void
      {
         _listener = param1;
      }
      
      public function get listener() : ITutorialConditionListener
      {
         return _listener;
      }
      
      public function triggerIfEqual(param1:*) : void
      {
         if(this.data == param1 && _listener)
         {
            _listener.triggerCondition(this);
         }
      }
      
      public function trigger() : void
      {
         if(_listener)
         {
            _listener.triggerCondition(this);
         }
      }
      
      public function check(param1:TutorialTask) : Boolean
      {
         return false;
      }
   }
}
