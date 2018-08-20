package game.mechanics.titan_arena.mediator
{
   import game.mechanics.titan_arena.model.command.CommandTitanArenaEndBattle;
   import game.mechanics.titan_arena.popup.TitanArenaRoundEndPopup;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   import org.osflash.signals.Signal;
   
   public class TitanArenaRoundEndPopupMediator extends TitanArenaRoundEndPopupMeditatorBase
   {
       
      
      private var _signal_continue:Signal;
      
      private var _signal_skip:Signal;
      
      public function TitanArenaRoundEndPopupMediator(param1:Player, param2:CommandTitanArenaEndBattle)
      {
         _signal_continue = new Signal(TitanArenaRoundEndPopupMediator);
         _signal_skip = new Signal(TitanArenaRoundEndPopupMediator);
         super(param1,param2);
      }
      
      public function get signal_continue() : Signal
      {
         return _signal_continue;
      }
      
      public function get signal_skip() : Signal
      {
         return _signal_skip;
      }
      
      public function action_continue() : void
      {
         close();
         _signal_continue.dispatch(this);
      }
      
      public function action_skip() : void
      {
         close();
         _signal_skip.dispatch(this);
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TitanArenaRoundEndPopup(this);
         return _popup;
      }
   }
}
