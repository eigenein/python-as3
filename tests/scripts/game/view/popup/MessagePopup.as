package game.view.popup
{
   import com.progrestar.common.lang.Translate;
   import feathers.core.PopUpManager;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.view.gui.components.LayoutFactory;
   import game.view.popup.message.MessagePopupClip;
   import idv.cjcat.signals.Signal;
   
   public class MessagePopup extends ClipBasedPopup
   {
       
      
      private var _signal_okClose:Signal;
      
      private var messageText:String;
      
      private var titleText:String;
      
      private var block:Boolean;
      
      protected var clip:MessagePopupClip;
      
      public function MessagePopup(param1:String, param2:String, param3:Boolean = false)
      {
         _signal_okClose = new Signal(MessagePopup);
         this.titleText = param2;
         this.messageText = param1;
         this.block = param3;
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
         if(clip.button_ok.graphics.parent)
         {
            clip.button_ok.graphics.parent.addChildAt(LayoutFactory.spacer(NaN,8),clip.button_ok.graphics.parent.getChildIndex(clip.button_ok.graphics));
         }
         clip.button_ok.signal_click.add(handler_close);
         clip.button_ok.label = Translate.translate("UI_COMMON_OK");
         var _loc1_:VerticalLayout = clip.layout_text.layout as VerticalLayout;
         _loc1_.gap = 7;
         if(!titleText)
         {
            _loc1_.paddingTop = 10;
            _loc1_.paddingBottom = 20;
            clip.line.graphics.visible = false;
            clip.tf_header.visible = false;
         }
         else
         {
            _loc1_.paddingTop = 10;
            _loc1_.paddingBottom = 20;
            clip.tf_header.text = titleText;
         }
         clip.tf_message.height = NaN;
         clip.tf_message.maxHeight = 500;
         clip.tf_message.text = messageText;
         clip.tf_message.width = clip.tf_message.textWidthMultiline;
         clip.button_ok.graphics.visible = !block;
         clip.layout_text.height = NaN;
         clip.layout_text.validate();
         clip.bg.graphics.height = clip.layout_text.graphics.height;
         width = clip.bg.graphics.width;
         height = clip.bg.graphics.height;
      }
      
      protected function createClip() : MessagePopupClip
      {
         var _loc1_:MessagePopupClip = AssetStorage.rsx.popup_theme.create(MessagePopupClip,"popup_alert");
         return _loc1_;
      }
      
      override public function dispose() : void
      {
         _signal_okClose.dispatch(this);
         _signal_okClose.clear();
         super.dispose();
      }
      
      override public function close() : void
      {
         if(!block)
         {
            super.close();
         }
      }
      
      public function forceClose() : void
      {
         super.close();
      }
      
      protected function handler_close() : void
      {
         PopUpManager.removePopUp(this);
         dispose();
      }
   }
}
