package game.view.popup
{
   import game.assets.storage.AssetStorage;
   import game.view.popup.message.MessagePopupClip;
   import idv.cjcat.signals.Signal;
   
   public class PromptPopup extends MessagePopup
   {
       
      
      private var noText:String;
      
      private var yesText:String;
      
      public var data:Object;
      
      private var _signal_confirm:Signal;
      
      private var _signal_cancel:Signal;
      
      public function PromptPopup(param1:String, param2:String, param3:String, param4:String)
      {
         _signal_confirm = new Signal(PromptPopup);
         _signal_cancel = new Signal(PromptPopup);
         super(param1,param2);
         this.yesText = param3;
         this.noText = param4;
      }
      
      public function get signal_confirm() : Signal
      {
         return _signal_confirm;
      }
      
      public function get signal_cancel() : Signal
      {
         return _signal_cancel;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:PromptPopupClip = clip as PromptPopupClip;
         _loc1_.button_cancel.label = noText;
         clip.button_ok.label = yesText;
         _loc1_.button_cancel.expandToFitTextWidth();
         _loc1_.button_cancel.signal_click.add(handler_cancel);
         _loc1_.button_ok.signal_click.add(handler_confirm);
      }
      
      override protected function createClip() : MessagePopupClip
      {
         var _loc1_:PromptPopupClip = AssetStorage.rsx.popup_theme.create(PromptPopupClip,"popup_prompt");
         return _loc1_;
      }
      
      private function handler_cancel() : void
      {
         _signal_cancel.dispatch(this);
         close();
      }
      
      private function handler_confirm() : void
      {
         _signal_confirm.dispatch(this);
         close();
      }
   }
}
