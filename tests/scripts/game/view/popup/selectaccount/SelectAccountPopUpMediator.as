package game.view.popup.selectaccount
{
   import game.command.rpc.player.server.ServerListUserValueObject;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.view.popup.PopupBase;
   
   public class SelectAccountPopUpMediator extends PopupMediator
   {
       
      
      private var _accounts:Array;
      
      public function SelectAccountPopUpMediator(param1:Array)
      {
         super(null);
         this.accounts = param1;
      }
      
      public function get accounts() : Array
      {
         return _accounts;
      }
      
      public function set accounts(param1:Array) : void
      {
         _accounts = param1;
         _accounts.sort(sortAccounts);
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new SelectAccountPopUp(this);
         return _popup;
      }
      
      public function selectAccount(param1:ServerListUserValueObject) : void
      {
         PopupList.instance.dialog_confirm_merge_accounts(param1,accounts);
      }
      
      private function sortAccounts(param1:ServerListUserValueObject, param2:ServerListUserValueObject) : int
      {
         if(param1.power > param2.power)
         {
            return -1;
         }
         if(param1.power < param2.power)
         {
            return 1;
         }
         return 0;
      }
   }
}
