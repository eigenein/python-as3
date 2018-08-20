package game.view.popup.friends.referrer
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.friends.FriendDataProvider;
   import game.mediator.gui.popup.friends.ReferrerPopupMediator;
   import game.model.GameModel;
   import game.view.popup.friends.SearchableFriendListPopup;
   
   public class ReferrerPopup extends SearchableFriendListPopup
   {
       
      
      private var _mediator:ReferrerPopupMediator;
      
      public function ReferrerPopup(param1:ReferrerPopupMediator)
      {
         super(param1);
         this._mediator = param1;
      }
      
      private function get _clip() : ReferrerPopupClip
      {
         return clip as ReferrerPopupClip;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         _clip.tf_header.text = Translate.translate("UI_DIALOG_SOCIAL_QUEST_TASK_4");
         _clip.tf_caption.text = Translate.translateArgs("UI_DIALOG_SOCIAL_QUEST_TASK_4_DESC",Translate.genderTriggerString(GameModel.instance.context.platformFacade.user.male));
         _clip.tf_no_one_desc.text = Translate.translate("UI_DIALOG_REFERRER_NO_ONE_DESC");
         _clip.button_no_one.label = Translate.translate("UI_DIALOG_REFERRER_NO_ONE_BTN");
         _clip.button_no_one.signal_click.add(handler_skip);
      }
      
      override protected function createClip() : void
      {
         clip = AssetStorage.rsx.popup_theme.create(ReferrerPopupClip,"dialog_friend_select");
      }
      
      private function handler_skip() : void
      {
         _mediator.action_selectNone();
      }
      
      override protected function handler_select(param1:FriendDataProvider) : void
      {
         _mediator.action_select(param1);
      }
   }
}
