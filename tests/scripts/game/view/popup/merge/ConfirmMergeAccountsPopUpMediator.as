package game.view.popup.merge
{
   import com.progrestar.common.lang.Translate;
   import game.command.rpc.merge.CommandUserMergeSelectUser;
   import game.command.rpc.player.server.ServerListUserValueObject;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.GameModel;
   import game.view.popup.PopupBase;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class ConfirmMergeAccountsPopUpMediator extends PopupMediator
   {
       
      
      public var selectedAccount:ServerListUserValueObject;
      
      private var _accounts:Array;
      
      public function ConfirmMergeAccountsPopUpMediator(param1:ServerListUserValueObject, param2:Array)
      {
         super(null);
         this.selectedAccount = param1;
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
      
      override public function createPopup() : PopupBase
      {
         _popup = new ConfirmMergeAccountsPopUp(this);
         return _popup;
      }
      
      public function get resultsText() : String
      {
         var _loc1_:int = 0;
         var _loc2_:String = "billing_vip_green_bullet";
         var _loc3_:String = "";
         _loc1_ = 0;
         while(_loc1_ < accounts.length)
         {
            if(accounts[_loc1_] != selectedAccount)
            {
               _loc3_ = _loc3_ + ("^{sprite:" + _loc2_ + "}^ ");
               _loc3_ = _loc3_ + (Translate.translateArgs("UI_DIALOG_MERGE_TEXT1",ColorUtils.hexToRGBFormat(16645626) + getAccountName(accounts[_loc1_]) + ColorUtils.hexToRGBFormat(16573879),ColorUtils.hexToRGBFormat(11220276),ColorUtils.hexToRGBFormat(16573879)) + "\n");
            }
            _loc1_++;
         }
         _loc3_ = _loc3_ + "\n";
         _loc3_ = _loc3_ + ("^{sprite:" + _loc2_ + "}^ ");
         _loc3_ = _loc3_ + (Translate.translateArgs("UI_DIALOG_MERGE_TEXT2",ColorUtils.hexToRGBFormat(16645626) + getAccountName(selectedAccount) + ColorUtils.hexToRGBFormat(16573879),getServerNameByAccount(selectedAccount)) + "\n");
         if(selectedAccount.getStarMoneyFromOthers > 0)
         {
            _loc3_ = _loc3_ + ("^{sprite:" + _loc2_ + "}^ ");
            _loc3_ = _loc3_ + (Translate.translateArgs("UI_DIALOG_MERGE_TEXT3",ColorUtils.hexToRGBFormat(16645626) + "^{sprite:" + "icon_green_gem_small" + "}^" + selectedAccount.getStarMoneyFromOthers + ColorUtils.hexToRGBFormat(16573879)) + "\n");
         }
         _loc3_ = _loc3_ + ("^{sprite:" + _loc2_ + "}^ ");
         _loc3_ = _loc3_ + (Translate.translate("UI_DIALOG_MERGE_TEXT4") + "\n");
         if(selectedAccount.clanInfo)
         {
            _loc3_ = _loc3_ + ("^{sprite:" + _loc2_ + "}^ ");
            _loc3_ = _loc3_ + Translate.translate("UI_DIALOG_MERGE_TEXT5");
         }
         return _loc3_;
      }
      
      public function action_select() : void
      {
         var _loc1_:* = null;
         if(selectedAccount)
         {
            _loc1_ = new CommandUserMergeSelectUser(int(selectedAccount.id));
            _loc1_.signal_complete.add(selectAccountComplete);
            _loc1_.signal_error.add(selectAccountError);
            GameModel.instance.actionManager.executeRPCCommand(_loc1_);
         }
      }
      
      private function getAccountName(param1:ServerListUserValueObject) : String
      {
         if(param1)
         {
            return "ID:" + param1.id + " " + param1.nickname;
         }
         return null;
      }
      
      private function getServerNameByAccount(param1:ServerListUserValueObject) : String
      {
         if(param1)
         {
            return Translate.translateArgs("UI_DIALOG_MERGE_SERVER",param1.currentServerId) + ": " + Translate.translate("LIB_SERVER_NAME_" + param1.currentServerId);
         }
         return null;
      }
      
      private function selectAccountComplete(param1:CommandUserMergeSelectUser) : void
      {
         PopupList.instance.message(Translate.translate("UI_DIALOG_MERGE_PROCESSING"),"",true);
      }
      
      private function selectAccountError(param1:CommandUserMergeSelectUser) : void
      {
         PopupList.instance.message(Translate.translate("UI_POPUP_ERROR_HEADER"),"",true);
      }
   }
}
