package game.mediator.gui.popup.hero
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.view.popup.ClipBasedPopup;
   
   public class HeroTitanGiftLevelDropPopUp extends ClipBasedPopup
   {
       
      
      private var mediator:HeroTitanGiftLevelDropPopUpMediator;
      
      private var clip:HeroTitanGiftLevelDropPopUpClip;
      
      public function HeroTitanGiftLevelDropPopUp(param1:HeroTitanGiftLevelDropPopUpMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_hero_titan_gift_level_drop();
         addChild(clip.graphics);
         clip.price.data = mediator.spentTitanSparks;
         clip.tf_message.text = Translate.translate("UI_DIALOG_HERO_GIFT_LEVEL_DROP_CONFIRM");
         clip.tf_recieve.text = Translate.translate("UI_DIALOG_HERO_GIFT_LEVEL_DROP_RECIEVE");
         clip.btn_continue.label = Translate.translate("UI_DIALOG_HERO_GIFT_LEVEL_DROP_CANCEL");
         clip.btn_drop.label = Translate.translate("UI_DIALOG_ELEMENTS_ACTION_RESET");
         clip.btn_continue.signal_click.add(mediator.action_continue);
         clip.btn_drop.signal_click.add(mediator.action_drop);
      }
   }
}
