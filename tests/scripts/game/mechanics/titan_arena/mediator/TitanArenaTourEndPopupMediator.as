package game.mechanics.titan_arena.mediator
{
   import com.progrestar.common.lang.Translate;
   import engine.context.platform.PlatformFacade;
   import game.data.reward.RewardData;
   import game.mechanics.titan_arena.model.command.CommandTitanArenaCompleteTier;
   import game.mechanics.titan_arena.popup.TitanArenaTourEndPopup;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   import org.osflash.signals.Signal;
   
   public class TitanArenaTourEndPopupMediator extends PopupMediator
   {
       
      
      private var _reward:RewardData;
      
      private var _header:String;
      
      private var _message:String;
      
      private var _button:String;
      
      private var _signal_ok:Signal;
      
      private var cmd:CommandTitanArenaCompleteTier;
      
      public function TitanArenaTourEndPopupMediator(param1:Player, param2:CommandTitanArenaCompleteTier)
      {
         _signal_ok = new Signal();
         super(param1);
         this.cmd = param2;
         _header = Translate.translate("UI_TITAN_ARENA_NEXT_ROUND_HEADER");
         var _loc3_:PlatformFacade = GameModel.instance.context.platformFacade;
         _message = Translate.translateArgs("UI_TITAN_ARENA_NEXT_ROUND_MESSAGE",Translate.genderTriggerString(_loc3_.user.male));
         _button = Translate.translate("UI_TITAN_ARENA_NEXT_ROUND_BUTTON");
         _reward = param2.reward;
      }
      
      public function get reward() : RewardData
      {
         return _reward;
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
         _popup = new TitanArenaTourEndPopup(this);
         return _popup;
      }
      
      public function action_ok() : void
      {
         close();
         _signal_ok.dispatch();
      }
   }
}
