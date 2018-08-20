package game.mediator.gui.popup.player.server
{
   import com.progrestar.common.lang.Translate;
   import game.command.social.SocialBillingBuyCommand;
   import game.data.storage.DataStorage;
   import game.data.storage.resource.ConsumableDescription;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.billing.BillingConfirmPopupMediator;
   import game.mediator.gui.popup.billing.BillingPopupValueObject;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.billing.PlayerBillingDescription;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.player.server.ServerSelectActionPopup;
   
   public class ServerSelectActionPopupMediator extends PopupMediator
   {
       
      
      private var billing:BillingPopupValueObject;
      
      private var serverId:int;
      
      private var _canTransfer:Boolean;
      
      private var _paidTransfer:Boolean;
      
      private var _transferBilling:PlayerBillingDescription;
      
      private var _serverName:String;
      
      public function ServerSelectActionPopupMediator(param1:Player, param2:int, param3:int)
      {
         var _loc4_:* = null;
         super(param1);
         this.serverId = param2;
         _transferBilling = param1.billingData.getTransferBilling();
         _canTransfer = param3 >= param2;
         var _loc5_:Vector.<ConsumableDescription> = DataStorage.consumable.getItemsByType("transfer");
         if(_loc5_.length > 0)
         {
            _loc4_ = _loc5_[0];
         }
         _paidTransfer = !_loc4_ || param1.inventory.getItemCount(_loc4_) == 0;
         _serverName = Translate.translate("LIB_SERVER_NAME_" + param2);
         billing = new BillingPopupValueObject(_transferBilling,param1);
      }
      
      public function get canTransfer() : Boolean
      {
         return _canTransfer;
      }
      
      public function get paidTransfer() : Boolean
      {
         return _paidTransfer;
      }
      
      public function get transferBilling() : PlayerBillingDescription
      {
         return _transferBilling;
      }
      
      public function get serverName() : String
      {
         return _serverName;
      }
      
      public function get costLabel() : String
      {
         return billing.costString;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ServerSelectActionPopup(this);
         return _popup;
      }
      
      public function action_transfer() : void
      {
         var _loc1_:* = null;
         if(player.clan.clan)
         {
            PopupList.instance.message(Translate.translate("UI_SERVER_TRANSFER_MSG_GUILD"));
            return;
         }
         if(paidTransfer)
         {
            _loc1_ = new BillingConfirmPopupMediator(player,billing);
            _loc1_.open(Stash.click("server_transfer",_popup.stashParams));
            _loc1_.signal_success.add(handler_transferPurchase);
         }
         else
         {
            GameModel.instance.actionManager.playerCommands.serverMigrate(serverId);
         }
      }
      
      public function action_newCharacter() : void
      {
         GameModel.instance.actionManager.playerCommands.serverCreateUser(serverId);
      }
      
      private function handler_transferPurchase(param1:SocialBillingBuyCommand) : void
      {
         GameModel.instance.actionManager.playerCommands.serverMigrate(serverId);
      }
   }
}
