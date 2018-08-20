package game.view.popup.player.server
{
   import com.progrestar.common.lang.Translate;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.player.server.ServerSelectActionPopupMediator;
   import game.view.popup.ClipBasedPopup;
   
   public class ServerSelectActionPopup extends ClipBasedPopup
   {
       
      
      private var mediator:ServerSelectActionPopupMediator;
      
      public function ServerSelectActionPopup(param1:ServerSelectActionPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:ServerSelectActionPopupClip = AssetStorage.rsx.popup_theme.create(ServerSelectActionPopupClip,"popup_server_select_choose");
         addChild(_loc1_.graphics);
         _loc1_.button_close.signal_click.add(mediator.close);
         _loc1_.tf_server_name.text = mediator.serverName;
         _loc1_.tf_header.text = Translate.translate("UI_DIALOG_SERVER_SELECT_HEADER");
         _loc1_.tf_new_chr_title.text = Translate.translate("UI_DIALOG_SERVER_NEW_CHAR_TITLE");
         _loc1_.tf_new_chr_desc.text = Translate.translate("UI_DIALOG_SERVER_NEW_CHAR_DESC");
         _loc1_.button_new_chr.label = Translate.translate("UI_DIALOG_SERVER_TRANSFER_BUTTON_NEW");
         _loc1_.tf_transfer_title.text = Translate.translate("UI_DIALOG_SERVER_TRANSFER_TITLE");
         if(mediator.canTransfer)
         {
            if(mediator.paidTransfer)
            {
               _loc1_.tf_transfer_desc.text = Translate.translate("UI_DIALOG_SERVER_TRANSFER_DESC_PAID");
               _loc1_.button_transfer.label = mediator.costLabel;
            }
            else
            {
               _loc1_.tf_transfer_desc.text = Translate.translate("UI_DIALOG_SERVER_TRANSFER_DESC");
               _loc1_.button_transfer.label = Translate.translate("UI_DIALOG_SERVER_TRANSFER_BUTTON_TRANSFER");
            }
         }
         else
         {
            _loc1_.tf_transfer_desc.text = Translate.translate("UI_DIALOG_SERVER_TRANSFER_TITLE_NOT_AV");
            _loc1_.button_transfer.graphics.visible = false;
         }
         (_loc1_.layout_new_character.layout as VerticalLayout).padding = 10;
         (_loc1_.layout_transfer.layout as VerticalLayout).padding = 10;
         _loc1_.layout_new_character.validate();
         _loc1_.layout_transfer.graphics.y = _loc1_.layout_new_character.y + _loc1_.layout_new_character.height + 10;
         _loc1_.layout_transfer.validate();
         _loc1_.bg1.graphics.height = _loc1_.layout_new_character.height;
         _loc1_.layout_transfer.y = _loc1_.layout_new_character.y + _loc1_.layout_new_character.height + 10;
         _loc1_.bg2.graphics.y = _loc1_.layout_transfer.y;
         _loc1_.bg2.graphics.height = _loc1_.layout_transfer.height;
         _loc1_.bg.graphics.height = _loc1_.layout_transfer.y + _loc1_.layout_transfer.height + 20;
         _loc1_.button_new_chr.signal_click.add(mediator.action_newCharacter);
         _loc1_.button_transfer.signal_click.add(mediator.action_transfer);
      }
   }
}
