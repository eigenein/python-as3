package game.mediator.gui.popup.titan
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.GuiAnimation;
   import game.assets.storage.AssetStorage;
   import game.view.gui.components.HeroPreview;
   import game.view.popup.ClipBasedPopup;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class TitanDescriptionPopup extends ClipBasedPopup
   {
       
      
      private var mediator:TitanDescriptionPopupMediator;
      
      private var clip:TitanDescriptionPopupClip;
      
      public function TitanDescriptionPopup(param1:TitanDescriptionPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_titan_description();
         addChild(clip.graphics);
         clip.button_close.signal_click.add(mediator.close);
         clip.title_tf.text = mediator.titanName;
         clip.titul_tf.text = mediator.titanDesc.descText;
         clip.element_icon.image.texture = AssetStorage.rsx.popup_theme.getTexture("icon_element_" + mediator.titanElement);
         var _loc1_:GuiAnimation = AssetStorage.rsx.asset_bundle.create(GuiAnimation,"hero_rays_centered");
         var _loc3_:* = 1.3;
         _loc1_.graphics.scaleY = _loc3_;
         _loc1_.graphics.scaleX = _loc3_;
         clip.hero_position_rays.container.addChild(_loc1_.graphics);
         var _loc2_:HeroPreview = new HeroPreview();
         clip.hero_position_after.container.addChild(_loc2_.graphics);
         _loc2_.graphics.touchable = false;
         _loc2_.loadTitan(mediator.titanDesc);
         clip.progressbar_fragments.value = mediator.fragmentsAmount;
         clip.progressbar_fragments.maxValue = mediator.fragmentsAmountMax;
         clip.tf_label_fragments.text = Translate.translate("UI_DIALOG_HERO_FRAGMENTS") + " " + ColorUtils.hexToRGBFormat(16645626) + clip.progressbar_fragments.value + "/" + clip.progressbar_fragments.maxValue;
         clip.tf_label_fragments_desc.text = Translate.translate("UI_DIALOG_TITAN_FRAGMENTS_DESC");
         clip.find_group_1.tf_label_fragments_find_1.text = Translate.translate("UI_POPUP_TITAN_GUILD_DUNGEON");
         clip.find_group_2.tf_label_fragments_find_2.text = Translate.translate("UI_DIALOG_TITAN_SUMMON_CIRCLE");
         clip.find_group_1.button_fragment_find_1.label = Translate.translate("UI_DIALOG_TITAN_FIND");
         clip.find_group_2.button_fragment_find_2.label = Translate.translate("UI_DIALOG_TITAN_FIND");
         clip.find_group_1.button_fragment_find_1.signal_click.add(mediator.action_navigateToDungeon);
         clip.find_group_2.button_fragment_find_2.signal_click.add(mediator.action_navigateToSummoningCircle);
         clip.find_group_1.container.visible = !mediator.isUltra;
      }
   }
}
