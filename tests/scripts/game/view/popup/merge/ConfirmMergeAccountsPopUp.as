package game.view.popup.merge
{
   import com.progrestar.common.lang.Translate;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrollContainer;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.selectaccount.SelectAccountItemRenderer;
   
   public class ConfirmMergeAccountsPopUp extends ClipBasedPopup
   {
       
      
      private var mediator:ConfirmMergeAccountsPopUpMediator;
      
      private var clip:ConfirmMergeAccountsPopUpClip;
      
      public function ConfirmMergeAccountsPopUp(param1:ConfirmMergeAccountsPopUpMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(ConfirmMergeAccountsPopUpClip,"popup_confirm_merge_accounts");
         addChild(clip.graphics);
         clip.tf_title_1.text = Translate.translate("UI_DIALOG_MERGE_SELECTED_PROFILE");
         clip.tf_title_2.text = Translate.translate("UI_DIALOG_MERGE_RESULTS");
         clip.back_btn.label = Translate.translate("UI_DIALOG_MERGE_BACK");
         clip.continue_btn.label = Translate.translate("UI_DIALOG_MERGE_CONTINUE");
         clip.text_tf.text = mediator.resultsText;
         clip.text_tf.textRendererProperties.lineHeight = 19;
         clip.text_tf.x = 0;
         clip.text_tf.y = 0;
         var _loc1_:GameScrollBar = new GameScrollBar();
         _loc1_.height = clip.scroll_slider_container.graphics.height;
         clip.scroll_slider_container.container.addChild(_loc1_);
         var _loc2_:GameScrollContainer = new GameScrollContainer(_loc1_,null,null);
         (_loc2_.layout as VerticalLayout).paddingTop = 0;
         (_loc2_.layout as VerticalLayout).paddingBottom = 0;
         _loc2_.width = clip.text_container.graphics.width;
         _loc2_.height = clip.text_container.graphics.height;
         _loc2_.addChild(clip.text_tf);
         clip.text_container.container.addChild(_loc2_);
         var _loc3_:SelectAccountItemRenderer = new SelectAccountItemRenderer();
         _loc3_.data = mediator.selectedAccount;
         clip.account_renderer_container.container.addChild(_loc3_);
         clip.toggle.label.text = Translate.translate("UI_DIALOG_MERGE_CONFIRM_TEXT");
         clip.toggle.label.validate();
         clip.toggle.signal_click.add(handler_toggleClick);
         clip.back_btn.signal_click.add(mediator.close);
         clip.continue_btn.signal_click.add(mediator.action_select);
         clip.continue_btn.isEnabled = clip.toggle.isSelected;
         updateContinueButtonState();
      }
      
      private function updateContinueButtonState() : void
      {
         clip.continue_btn.isEnabled = clip.toggle.isSelected;
         clip.continue_btn.graphics.alpha = !!clip.toggle.isSelected?1:0.5;
      }
      
      private function handler_toggleClick() : void
      {
         updateContinueButtonState();
      }
   }
}
