package game.view.popup.reward.multi
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import game.command.rpc.mail.MailRewardValueObject;
   import game.mediator.gui.component.RewardValueObject;
   import game.mediator.gui.popup.mail.PlayerMailEntryTranslation;
   
   public class MailRewardRenderer extends MultiRewardRenderer
   {
       
      
      public function MailRewardRenderer()
      {
         super();
      }
      
      override protected function setCaption(param1:RewardValueObject) : void
      {
         var _loc2_:MailRewardValueObject = param1 as MailRewardValueObject;
         clip.tf_caption.text = PlayerMailEntryTranslation.translateTitle(_loc2_.letter);
         clip.layout_item_list.list.dataProvider = new ListCollection(_loc2_.reward.outputDisplay);
         if(_loc2_.deleted)
         {
            clip.tf_empty.visible = true;
            clip.tf_empty.text = Translate.translate("UI_POPUP_MAIL_REWARD_DELETED");
         }
         else if(_loc2_.reward.isEmpty)
         {
            clip.tf_empty.visible = true;
            clip.tf_empty.text = Translate.translate("UI_POPUP_MAIL_REWARD_EMPTY");
         }
         else
         {
            clip.tf_empty.visible = false;
         }
      }
   }
}
