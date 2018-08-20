package game.view.popup.mail
{
   import com.progrestar.common.lang.Translate;
   import engine.core.assets.file.ImageFile;
   import feathers.layout.VerticalLayout;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.mail.PlayerMailEntryTranslation;
   import game.mediator.gui.popup.mail.PlayerMailImportantPopupMediator;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrollContainer;
   import game.view.popup.ClipBasedPopup;
   
   public class PlayerMailImportantPopup extends ClipBasedPopup
   {
       
      
      private var mediator:PlayerMailImportantPopupMediator;
      
      private var clip:PlayerMailImportantPopupClip;
      
      private var timer_showCloseButton:Timer;
      
      public function PlayerMailImportantPopup(param1:PlayerMailImportantPopupMediator)
      {
         super(param1);
         stashParams.windowName = "PlayerMailImportantPopup";
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(PlayerMailImportantPopupClip,"important_update_mail_popup");
         addChild(clip.graphics);
         if(mediator.url && mediator.url.indexOf("youtube") != -1)
         {
            clip.title = Translate.translate("LIB_MAIL_TYPE_MASSIMPORTANT_VIDEO_TITLE");
         }
         else
         {
            clip.title = PlayerMailEntryTranslation.translateTitle(mediator.letter);
         }
         var _loc1_:GameScrollBar = new GameScrollBar();
         _loc1_.height = clip.scroll_slider_container.graphics.height;
         clip.scroll_slider_container.container.addChild(_loc1_);
         var _loc3_:Boolean = false;
         clip.gradient_top.graphics.touchable = _loc3_;
         clip.gradient_bottom.graphics.touchable = _loc3_;
         var _loc2_:GameScrollContainer = new GameScrollContainer(_loc1_,clip.gradient_top.graphics,clip.gradient_bottom.graphics);
         (_loc2_.layout as VerticalLayout).horizontalAlign = "center";
         (_loc2_.layout as VerticalLayout).gap = 8;
         _loc2_.width = clip.list_container.graphics.width;
         _loc2_.height = clip.list_container.graphics.height;
         clip.list_container.addChild(_loc2_);
         clip.scroll_content.tf_text.text = mediator.message;
         clip.scroll_content.tf_text.maxHeight = Infinity;
         clip.scroll_content.tf_text.height = NaN;
         clip.scroll_content.layout.height = NaN;
         clip.scroll_content.image.graphics.visible = false;
         if(mediator.imageFile)
         {
            AssetStorage.instance.globalLoader.requestAssetWithCallback(mediator.imageFile,handler_assetLoaded);
         }
         _loc2_.addChild(clip.scroll_content.layout);
         clip.button_close.graphics.visible = false;
         clip.button_close.signal_click.add(mediator.action_ok);
         timer_showCloseButton = new Timer(mediator.timeout_close,1);
         timer_showCloseButton.addEventListener("timerComplete",handler_closeButtonTimerComplete);
         timer_showCloseButton.start();
         if(mediator.url)
         {
            clip.scroll_content.button_go.graphics.visible = false;
         }
         else
         {
            clip.scroll_content.button_go.label = Translate.translate("UI_IMPORTANT_UPDATE_MAIL_CONTENT_BUTTON");
            clip.scroll_content.button_go.signal_click.add(mediator.action_group);
         }
      }
      
      protected function handler_closeButtonTimerComplete(param1:TimerEvent) : void
      {
         if(!mediator)
         {
            return;
         }
         clip.button_close.graphics.visible = true;
      }
      
      protected function handler_assetLoaded(param1:ImageFile) : void
      {
         if(!mediator)
         {
            return;
         }
         clip.scroll_content.image.image.image.width = param1.bitmapData.width;
         clip.scroll_content.image.image.image.height = param1.bitmapData.height;
         clip.scroll_content.image.frame.graphics.width = param1.bitmapData.width + 15;
         clip.scroll_content.image.frame.graphics.height = param1.bitmapData.height + 15;
         clip.scroll_content.image.graphics.visible = true;
         clip.scroll_content.image.image.image.texture = param1.texture;
         if(mediator.url)
         {
            clip.scroll_content.image.signal_click.add(mediator.action_click);
         }
         else
         {
            clip.scroll_content.image.graphics.touchable = false;
         }
      }
   }
}
