package game.view.popup.ny.welcome
{
   import com.progrestar.common.lang.Translate;
   import engine.core.assets.AssetProgressProvider;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.view.gui.components.ClipProgressBar;
   import game.view.popup.AsyncClipBasedPopup;
   import game.view.popup.IEscClosable;
   
   public class NYWelcomePopup extends AsyncClipBasedPopup implements IEscClosable
   {
       
      
      private var mediator:NYWelcomePopupMediator;
      
      private var clip:NYWelcomePopupClip;
      
      private var progressbar:ClipProgressBar;
      
      private var assetProgress:AssetProgressProvider;
      
      public function NYWelcomePopup(param1:NYWelcomePopupMediator)
      {
         super(param1,AssetStorage.rsx.ny_gifts);
         this.mediator = param1;
         this.mediator.signal_timerUpdate.add(handler_timerUpdate);
         this.mediator.signal_giftsToOpenChange.add(handler_giftsToOpenChange);
      }
      
      override public function dispose() : void
      {
         if(mediator)
         {
            mediator.signal_timerUpdate.remove(handler_timerUpdate);
            mediator.signal_giftsToOpenChange.remove(handler_giftsToOpenChange);
         }
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         if(!asset.completed)
         {
            progressbar = AssetStorage.rsx.popup_theme.create_component_progressbar();
            addChild(progressbar.graphics);
            assetProgress = AssetStorage.instance.globalLoader.getAssetProgress(asset);
            if(!assetProgress.completed)
            {
               assetProgress.signal_onProgress.add(handler_assetProgress);
               handler_assetProgress(assetProgress);
            }
         }
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         if(_isDisposed)
         {
            return;
         }
         width = 1000;
         height = 650;
         if(progressbar)
         {
            removeChild(progressbar.graphics);
         }
         var _loc2_:GuiClipNestedContainer = param1.create(GuiClipNestedContainer,"bg_elcom_graphics");
         addChild(_loc2_.graphics);
         clip = param1.create(NYWelcomePopupClip,"ny_welcome_popup_gui");
         addChild(clip.graphics);
         clip.btn_close.signal_click.add(mediator.close);
         clip.tf_title.text = Translate.translate("UI_DIALOG_NY_WELCOME_TITLE");
         clip.tf_desc.text = Translate.translate("UI_DIALOG_NY_WELCOME_DESC");
         clip.tf_timout.text = mediator.timerText;
         clip.tf_welcome_1.text = Translate.translate("UI_DIALOG_NY_WELCOME_TEXT_1");
         clip.tf_welcome_2.text = Translate.translate("UI_DIALOG_NY_WELCOME_TEXT_2");
         clip.tf_welcome_3.text = Translate.translate("UI_DIALOG_NY_WELCOME_TEXT_3");
         clip.tf_welcome_4.text = Translate.translate("UI_DIALOG_NY_WELCOME_TEXT_4");
         clip.btn_1.label = Translate.translate("UI_DIALOG_NY_WELCOME_BTN_1");
         clip.btn_2.label = Translate.translate("UI_DIALOG_NY_WELCOME_BTN_2");
         clip.btn_3.label = Translate.translate("UI_DIALOG_NY_WELCOME_BTN_3");
         clip.btn_4.label = Translate.translate("UI_DIALOG_NY_WELCOME_BTN_4");
         clip.btn_1.signal_click.add(mediator.action_showSpecialQuests);
         clip.btn_2.signal_click.add(mediator.action_showNYTreeUpgrade);
         clip.btn_3.signal_click.add(mediator.action_showNYGifts);
         clip.btn_4.signal_click.add(mediator.action_showRating);
         clip.plate_1.signal_click.add(mediator.action_showSpecialQuests);
         clip.plate_2.signal_click.add(mediator.action_showNYGifts);
         clip.plate_3.signal_click.add(mediator.action_showNYTreeUpgrade);
         clip.not_opened_gifts_marker.graphics.visible = mediator.giftsToOpenAvaliable;
      }
      
      private function handler_giftsToOpenChange() : void
      {
         if(clip)
         {
            clip.not_opened_gifts_marker.graphics.visible = mediator.giftsToOpenAvaliable;
         }
      }
      
      private function handler_timerUpdate(param1:String) : void
      {
         if(clip)
         {
            clip.tf_timout.text = param1;
         }
      }
      
      private function handler_assetProgress(param1:AssetProgressProvider) : void
      {
         if(progressbar)
         {
            progressbar.maxValue = param1.progressTotal;
            progressbar.value = param1.progressCurrent;
         }
      }
   }
}
