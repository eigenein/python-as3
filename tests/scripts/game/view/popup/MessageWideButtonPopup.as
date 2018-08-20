package game.view.popup
{
   import feathers.core.PopUpManager;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.view.popup.message.MessageWideButtonPopupClip;
   import idv.cjcat.signals.Signal;
   
   public class MessageWideButtonPopup extends ClipBasedPopup
   {
       
      
      private var _signal_okClose:Signal;
      
      private var messageText:String;
      
      private var titleText:String;
      
      private var buttonLabel:String;
      
      protected var clip:MessageWideButtonPopupClip;
      
      public function MessageWideButtonPopup(param1:String, param2:String, param3:String)
      {
         _signal_okClose = new Signal();
         this.titleText = param2;
         this.messageText = param1;
         this.buttonLabel = param3;
         super(null);
      }
      
      public function get signal_okClose() : Signal
      {
         return _signal_okClose;
      }
      
      override protected function draw() : void
      {
         super.draw();
         var _loc1_:int = width;
         var _loc2_:int = height;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = createClip();
         addChild(clip.graphics);
         clip.button_ok.signal_click.add(handler_ok);
         clip.button_ok.label = buttonLabel;
         clip.button_close.signal_click.add(handler_close);
         var _loc1_:VerticalLayout = clip.layout_text.layout as VerticalLayout;
         if(!titleText)
         {
            _loc1_.paddingTop = 20;
            _loc1_.paddingBottom = 20;
            clip.line.graphics.visible = false;
            clip.tf_header.visible = false;
         }
         else
         {
            _loc1_.paddingTop = 10;
            _loc1_.paddingBottom = 15;
            clip.tf_header.text = titleText;
         }
         clip.tf_message.height = NaN;
         clip.tf_message.maxHeight = 500;
         clip.tf_message.text = messageText;
         clip.layout_text.height = NaN;
         clip.layout_text.validate();
         clip.bg.graphics.height = clip.layout_text.graphics.height;
         width = clip.bg.graphics.width;
         height = clip.bg.graphics.height;
      }
      
      protected function createClip() : MessageWideButtonPopupClip
      {
         var _loc1_:MessageWideButtonPopupClip = AssetStorage.rsx.popup_theme.create(MessageWideButtonPopupClip,"popup_alert_wide_button");
         return _loc1_;
      }
      
      protected function handler_close() : void
      {
         PopUpManager.removePopUp(this);
         dispose();
      }
      
      private function handler_ok() : void
      {
         handler_close();
         _signal_okClose.dispatch();
         _signal_okClose.clear();
      }
   }
}
