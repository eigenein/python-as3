package game.view.popup.merge
{
   import game.command.timer.GameTimer;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   
   public class MergeInfoPopUpMediator extends PopupMediator
   {
       
      
      private var _accounts:Array;
      
      public function MergeInfoPopUpMediator(param1:Player, param2:Array)
      {
         super(param1);
         this.accounts = param2;
      }
      
      public function get accounts() : Array
      {
         return _accounts;
      }
      
      public function set accounts(param1:Array) : void
      {
         _accounts = param1;
      }
      
      public function get mergeBonusDuration() : Number
      {
         return player.specialOffer.mergebonusEndTime - GameTimer.instance.currentServerTime;
      }
      
      public function action_continue() : void
      {
         if(accounts)
         {
            PopupList.instance.dialog_select_account(accounts);
         }
         close();
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new MergeInfoPopUp(this);
         return _popup;
      }
      
      override public function open(param1:PopupStashEventParams = null) : void
      {
         super.open(param1);
         player.sharedObjectStorage.writeTimeout("game.view.popup.merge.MergeInfoPopUpMediator.mergeBonus");
      }
      
      override public function openDelayed(param1:PopupStashEventParams = null, param2:int = 1000) : void
      {
         super.openDelayed(param1);
         player.sharedObjectStorage.writeTimeout("game.view.popup.merge.MergeInfoPopUpMediator.mergeBonus");
      }
   }
}
