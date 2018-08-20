package game.view.popup.hero.consumable
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.hero.HeroUseXPConsumableNotEnoughPopupMediator;
   import game.view.popup.ClipBasedPopup;
   
   public class HeroUseXPConsumableNotEnoughPopup extends ClipBasedPopup
   {
       
      
      private var mediator:HeroUseXPConsumableNotEnoughPopupMediator;
      
      private var clip:HeroUseXPConsumableNotEnoughPopupClip;
      
      public function HeroUseXPConsumableNotEnoughPopup(param1:HeroUseXPConsumableNotEnoughPopupMediator)
      {
         clip = AssetStorage.rsx.popup_theme.create(HeroUseXPConsumableNotEnoughPopupClip,"popup_hero_use_xp_consumable_not_enough");
         super(param1);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         addChild(clip.graphics);
         clip.button_close.signal_click.add(mediator.close);
         clip.button_shop.initialize(Translate.translate("UI_DIALOG_QUEST_INFO"),mediator.action_toShop);
         clip.button_missions.initialize(Translate.translate("UI_DIALOG_QUEST_INFO"),mediator.action_toMissions);
         clip.tf_header.text = Translate.translate("UI_HERO_DIALOG_NO_XP_CONSUMABLES");
         clip.tf_message.text = Translate.translate("UI_HERO_DIALOG_NO_XP_CONSUMABLES_GET_MORE");
         clip.tf_shop.text = Translate.translate("LIB_SHOP_NAME_1");
         clip.tf_missions.text = Translate.translate("UI_HERO_DIALOG_NO_XP_CONSUMABLES_MISSIONS");
      }
   }
}
