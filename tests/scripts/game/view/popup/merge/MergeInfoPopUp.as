package game.view.popup.merge
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.util.TimeFormatter;
   import game.view.popup.ClipBasedPopup;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class MergeInfoPopUp extends ClipBasedPopup
   {
       
      
      private var mediator:MergeInfoPopUpMediator;
      
      private var clip:MergeInfoPopUpClip;
      
      public function MergeInfoPopUp(param1:MergeInfoPopUpMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(MergeInfoPopUpClip,"popup_server_merge_info");
         addChild(clip.graphics);
         clip.action_btn.label = Translate.translate("UI_POPUP_BATTLE_CONTINUE");
         clip.action_btn.signal_click.add(mediator.action_continue);
         clip.tf_title.text = Translate.translate("UI_DIALOG_MERGE_TITLE");
         clip.tf_desc.text = Translate.translate("UI_DIALOG_MERGE_DESC");
         clip.tf_x2.text = Translate.translate("UI_DIALOG_MERGE_X2");
         clip.tf_cooldown.text = Translate.translateArgs("UI_DIALOG_MERGE_COOLDOWN",ColorUtils.hexToRGBFormat(16645626) + TimeFormatter.toDH(mediator.mergeBonusDuration,"{d} {h} {m}"," ",true));
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
      }
   }
}
