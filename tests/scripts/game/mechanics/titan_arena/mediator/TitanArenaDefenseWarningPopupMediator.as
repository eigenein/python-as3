package game.mechanics.titan_arena.mediator
{
   import game.mechanics.titan_arena.popup.TitanArenaDefenseWarningPopup;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   import org.osflash.signals.Signal;
   
   public class TitanArenaDefenseWarningPopupMediator extends PopupMediator
   {
       
      
      private var _header:String;
      
      private var _message:String;
      
      private var _button:String;
      
      private var _signal_ok:Signal;
      
      public function TitanArenaDefenseWarningPopupMediator(param1:Player, param2:String, param3:String, param4:String)
      {
         _signal_ok = new Signal();
         super(param1);
         this._button = param4;
         this._message = param3;
         this._header = param2;
      }
      
      public function get header() : String
      {
         return _header;
      }
      
      public function get message() : String
      {
         return _message;
      }
      
      public function get button() : String
      {
         return _button;
      }
      
      public function get signal_ok() : Signal
      {
         return _signal_ok;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TitanArenaDefenseWarningPopup(this);
         return _popup;
      }
      
      public function action_ok() : void
      {
         close();
         _signal_ok.dispatch();
      }
   }
}
