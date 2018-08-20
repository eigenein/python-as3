package game.view.popup.birthday
{
   import com.progrestar.common.lang.Translate;
   import engine.core.assets.AssetProgressProvider;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.util.TimeFormatter;
   import game.view.gui.components.ClipProgressBar;
   import game.view.popup.ClipBasedPopup;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class BirthDayPopUp extends ClipBasedPopup
   {
       
      
      private var mediator:BirthDayPopUpMediator;
      
      private var clip:BirthDayPopUpClip;
      
      private var assetProgress:AssetProgressProvider;
      
      private var progressbar:ClipProgressBar;
      
      public function BirthDayPopUp(param1:BirthDayPopUpMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         if(AssetStorage.rsx.birth_day_graphics.completed)
         {
            handler_assetLoaded(AssetStorage.rsx.birth_day_graphics);
         }
         else
         {
            progressbar = AssetStorage.rsx.popup_theme.create_component_progressbar();
            addChild(progressbar.graphics);
            AssetStorage.instance.globalLoader.requestAssetWithCallback(AssetStorage.rsx.birth_day_graphics,handler_assetLoaded);
            assetProgress = AssetStorage.instance.globalLoader.getAssetProgress(AssetStorage.rsx.birth_day_graphics);
            if(!assetProgress.completed)
            {
               assetProgress.signal_onProgress.add(handler_assetProgress);
               handler_assetProgress(assetProgress);
            }
         }
      }
      
      protected function _initialize() : void
      {
         if(progressbar)
         {
            removeChild(progressbar.graphics);
         }
         width = 650;
         height = 600;
         clip = AssetStorage.rsx.birth_day_graphics.create(BirthDayPopUpClip,"popup_birth_day");
         addChild(clip.graphics);
         clip.action_btn.label = Translate.translate("UI_POPUP_BATTLE_CONTINUE");
         clip.action_btn.signal_click.add(mediator.action_continue);
         clip.tf_header.text = Translate.translate("UI_DIALOG_BIRTH_DAY_TITLE");
         clip.tf_title.text = Translate.translate("UI_DIALOG_BIRTH_DAY_DESC");
         clip.tf_bonus.text = Translate.translate("UI_DIALOG_BIRTH_DAY_BONUS");
         clip.bonus_renderer_1.tf_coin.text = Translate.translate("LIB_COIN_NAME_3");
         clip.bonus_renderer_2.tf_coin.text = Translate.translate("LIB_COIN_NAME_1");
         clip.bonus_renderer_3.tf_coin.text = Translate.translate("LIB_COIN_NAME_4");
         clip.bonus_renderer_4.tf_coin.text = Translate.translate("UI_DIALOG_MERGE_COIN_SKIN");
         clip.bonus_renderer_5.tf_coin.text = Translate.translate("LIB_COIN_NAME_2");
         clip.bonus_renderer_6.tf_coin.text = Translate.translate("LIB_COIN_NAME_6");
         clip.bonus_renderer_1.icon_coin.image.texture = AssetStorage.rsx.popup_theme.getTexture("towerCoinBig");
         clip.bonus_renderer_2.icon_coin.image.texture = AssetStorage.rsx.popup_theme.getTexture("silverCoinBig");
         clip.bonus_renderer_3.icon_coin.image.texture = AssetStorage.rsx.popup_theme.getTexture("cosmoCoinBig");
         clip.bonus_renderer_4.icon_coin.image.texture = AssetStorage.rsx.popup_theme.getTexture("skinsCoinsBig");
         clip.bonus_renderer_5.icon_coin.image.texture = AssetStorage.rsx.popup_theme.getTexture("arenaCoinBig");
         clip.bonus_renderer_6.icon_coin.image.texture = AssetStorage.rsx.popup_theme.getTexture("friendCoinBig");
         clip.bonus_renderer_4.icon_coin.graphics.width = 64;
         clip.bonus_renderer_4.icon_coin.graphics.x = -24;
         clip.tf_cooldown.text = Translate.translateArgs("UI_DIALOG_MERGE_COOLDOWN",ColorUtils.hexToRGBFormat(16645626) + TimeFormatter.toDH(mediator.bonusDuration,"{d} {h} {m}"," ",true));
      }
      
      private function handler_assetProgress(param1:AssetProgressProvider) : void
      {
         if(progressbar)
         {
            progressbar.maxValue = param1.progressTotal;
            progressbar.value = param1.progressCurrent;
         }
      }
      
      protected function handler_assetLoaded(param1:RsxGuiAsset) : void
      {
         _initialize();
      }
   }
}
