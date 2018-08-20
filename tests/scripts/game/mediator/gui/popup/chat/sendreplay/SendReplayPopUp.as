package game.mediator.gui.popup.chat.sendreplay
{
   import com.progrestar.common.lang.Translate;
   import flash.desktop.Clipboard;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import game.assets.storage.AssetStorage;
   import game.view.popup.ClipBasedPopup;
   import starling.core.Starling;
   import starling.events.Event;
   
   public class SendReplayPopUp extends ClipBasedPopup
   {
       
      
      private var clip:SendReplayPopUpClipShort;
      
      private var mediator:SendReplayPopUpMediator;
      
      public function SendReplayPopUp(param1:SendReplayPopUpMediator)
      {
         super(param1);
         this.mediator = param1;
         addEventListener("addedToStage",onAddedToStage);
      }
      
      override protected function initialize() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         super.initialize();
         if(mediator.canShareChat)
         {
            _loc1_ = new SendReplayPopUpClip();
            AssetStorage.rsx.popup_theme.factory.create(_loc1_,AssetStorage.rsx.popup_theme.data.getClipByName("send_replay_popup"));
            addChild(_loc1_.graphics);
            _loc1_.tf_title.text = Translate.translate("UI_DIALOG_CHAT_SEND_REPLAY_TEXT");
            _loc1_.replay_info.tf_label.text = Translate.translate("UI_DIALOG_CHAT_REPLAY_TEXT");
            _loc1_.action_btn.label = Translate.translate("UI_POPUP_CHAT_SEND");
            _loc1_.tf_message_input.prompt = Translate.translate("UI_DIALOG_CHAT_INPUT_MESSAGE_PROMPT");
            _loc1_.tf_message_input.text = mediator.defauiltText;
            _loc1_.action_btn.signal_click.add(handler_sendClick);
            _loc1_.replay_info.btn_option.signal_click.add(handler_replayClick);
            clip = _loc1_;
         }
         else
         {
            _loc2_ = new SendReplayPopUpClipShort();
            AssetStorage.rsx.popup_theme.factory.create(_loc2_,AssetStorage.rsx.popup_theme.data.getClipByName("send_replay_popup_short"));
            addChild(_loc2_.graphics);
            clip = _loc2_;
         }
         clip.button_close.signal_click.add(mediator.close);
         clip.tf_replay.text = Translate.translate("UI_DIALOG_ARENA_REPLAY_URL");
         clip.replay_url_input.text = mediator.replayURL;
         clip.replay_url_input.addEventListener("change",handler_replayUrlInputChange);
         clip.copy_btn.label = Translate.translate("UI_DIALOG_BUTTON_COPY");
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         Starling.current.nativeStage.addEventListener("mouseUp",handler_mouseUp);
         addEventListener("removedFromStage",onRemovedFromStage);
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         Starling.current.nativeStage.removeEventListener("mouseUp",handler_mouseUp);
         removeEventListener("removedFromStage",onRemovedFromStage);
      }
      
      private function handler_replayUrlInputChange(param1:Event) : void
      {
         clip.replay_url_input.text = mediator.replayURL;
      }
      
      private function handler_replayClick() : void
      {
         mediator.replay();
      }
      
      private function handler_sendClick() : void
      {
         mediator.sendReplay((clip as SendReplayPopUpClip).tf_message_input.text);
      }
      
      private function handler_mouseUp(param1:MouseEvent) : void
      {
         var _loc3_:Point = new Point(Starling.current.nativeStage.mouseX,Starling.current.nativeStage.mouseY);
         var _loc2_:Point = clip.copy_btn.container.globalToLocal(_loc3_);
         if(clip.copy_btn.container.hitTest(_loc2_))
         {
            Clipboard.generalClipboard.clear();
            Clipboard.generalClipboard.setData("air:text",clip.replay_url_input.text);
         }
      }
   }
}
