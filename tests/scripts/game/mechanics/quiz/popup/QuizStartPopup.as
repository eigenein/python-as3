package game.mechanics.quiz.popup
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.quiz.mediator.QuizStartPopupMediator;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   
   public class QuizStartPopup extends AsyncClipBasedPopupWithPreloader
   {
       
      
      private var mediator:QuizStartPopupMediator;
      
      private var clip:QuizStartPopupClip;
      
      public function QuizStartPopup(param1:QuizStartPopupMediator)
      {
         super(param1,AssetStorage.rsx.getGuiByName("quiz_popup"));
         this.mediator = param1;
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         clip = param1.create(QuizStartPopupClip,"quiz_start_popup");
         addChild(clip.graphics);
         width = clip.bounds_layout_container.graphics.width;
         height = clip.bounds_layout_container.graphics.height;
         clip.tf_label_header.text = Translate.translate("UI_QUIZ_START_POPUP_TF_LABEL_HEADER");
         clip.tf_label_footer.text = Translate.translate("UI_QUIZ_START_POPUP_TF_LABEL_FOOTER");
         clip.tf_label_tickets.text = Translate.translate("UI_QUIZ_START_POPUP_TF_LABEL_TICKETS");
         clip.tf_label_points.text = Translate.translate("UI_QUIZ_START_POPUP_TF_LABEL_POINTS");
         clip.tf_select_quiestion.text = Translate.translate("UI_QUIZ_START_POPUP_TF_SELECT_QUIESTION");
         clip.button_1.label = Translate.translateArgs("UI_QUIZ_START_POPUP_BUTTON_LABEL",1);
         clip.button_10.label = Translate.translateArgs("UI_QUIZ_START_POPUP_BUTTON_LABEL",10);
         clip.blue_labeled_button_134_inst0.label = Translate.translate("UI_QUIZ_START_POPUP_TF_LABEL_REWARD");
         clip.boring_buttonClip_inst0.label = Translate.translate("UI_QUIZ_START_POPUP_TF_LABEL_RATING");
         clip.button_close.signal_click.add(mediator.close);
         clip.boring_buttonClip_inst0.signal_click.add(mediator.navigate_rating);
         clip.blue_labeled_button_134_inst0.signal_click.add(mediator.navigate_event);
         clip.blue_labeled_button_134_inst0.graphics.visible = mediator.hasRatingRewards;
         mediator.item_points.signal_update.add(handler_updatePoints);
         mediator.item_ticket.signal_update.add(handler_updateTickets);
         updatePoints();
         updateTickets();
         clip.button_1.signal_click.add(mediator.action_getQuestion_1);
         clip.button_10.signal_click.add(mediator.action_getQuestion_10);
      }
      
      private function updatePoints() : void
      {
         clip.reward_item_1.data = mediator.item_points;
      }
      
      private function updateTickets() : void
      {
         clip.reward_item_2.data = mediator.item_ticket;
      }
      
      private function handler_updatePoints(param1:InventoryItem) : void
      {
         updatePoints();
      }
      
      private function handler_updateTickets(param1:InventoryItem) : void
      {
         updateTickets();
      }
   }
}
