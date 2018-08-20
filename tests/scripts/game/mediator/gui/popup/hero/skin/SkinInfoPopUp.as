package game.mediator.gui.popup.hero.skin
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.HeroPreview;
   import game.view.gui.components.LayoutFactory;
   import game.view.gui.components.tooltip.TooltipTextView;
   import game.view.popup.ClipBasedPopup;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   import starling.display.Image;
   
   public class SkinInfoPopUp extends ClipBasedPopup
   {
       
      
      private var heroPreview:HeroPreview;
      
      private var mediator:SkinInfoPopUpMediator;
      
      private var clip:SkinInfoPopUpClip;
      
      private var tooltipVO:TooltipVO;
      
      public function SkinInfoPopUp(param1:SkinInfoPopUpMediator)
      {
         tooltipVO = new TooltipVO(TooltipTextView,"");
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "skin_info:" + param1.skinID;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(clip)
         {
            TooltipHelper.removeTooltip(clip.icon_upgrade_cost.image);
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_skin_info();
         addChild(clip.graphics);
         var _loc1_:ClipSprite = AssetStorage.rsx.asset_bundle.create(ClipSprite,"skin_background");
         clip.skin_bg.container.addChild(_loc1_.container);
         clip.title_tf.text = mediator.hero.name + " - " + mediator.skinName;
         clip.button_close.signal_click.add(mediator.close);
         var _loc2_:GuiAnimation = AssetStorage.rsx.asset_bundle.create(GuiAnimation,"hero_rays_centered");
         var _loc4_:* = 1.3;
         _loc2_.graphics.scaleY = _loc4_;
         _loc2_.graphics.scaleX = _loc4_;
         clip.hero_position_rays.container.addChild(_loc2_.graphics);
         heroPreview = new HeroPreview();
         _loc4_ = 1.35;
         heroPreview.graphics.scaleY = _loc4_;
         heroPreview.graphics.scaleX = _loc4_;
         clip.hero_position_after.container.addChild(heroPreview.graphics);
         heroPreview.graphics.touchable = false;
         heroPreview.loadHero(mediator.hero,mediator.skinID);
         var _loc3_:Image = new Image(mediator.skinIcon);
         _loc3_.width = 72;
         _loc3_.height = 72;
         clip.image_item.container.removeChildren(0,-1,true);
         clip.image_item.container.addChild(_loc3_);
         clip.tf_level.text = ColorUtils.hexToRGBFormat(16573879) + Translate.translate("UI_DIALOG_HERO_STAT_LEVEL") + ColorUtils.hexToRGBFormat(15919178) + " " + Translate.translateArgs("UI_DIALOG_SKIN_INFO_LEVEL_FROM",mediator.skinLevel,mediator.skinMaxLevel);
         clip.tf_skill.text = ColorUtils.hexToRGBFormat(16573879) + mediator.getStatBonusByLevel(mediator.skinLevel).name + " " + ColorUtils.hexToRGBFormat(15919178) + "+" + mediator.getStatBonusByLevel(mediator.skinLevel).value;
         clip.tf_skill_to.text = ColorUtils.hexToRGBFormat(16573879) + Translate.translateArgs("UI_POPUP_BUNDLE_SKIN_STAT_BONUS",ColorUtils.hexToRGBFormat(15919178) + "+" + mediator.getStatBonusByLevel(mediator.skinMaxLevel).value);
         clip.tf_desc.visible = mediator.specialOfferExplicit;
         if(mediator.specialOfferExplicit)
         {
            clip.tf_desc.text = Translate.translate("UI_DIALOG_SKIN_INFO_NY_EVENT");
         }
         if(!mediator.specialOfferExplicit && mediator.canBeUpgraded && Translate.has("UI_DIALOG_SKIN_INFO_UGPRADE_COST"))
         {
            clip.tf_upgrade_cost_label.text = Translate.translate("UI_DIALOG_SKIN_INFO_UGPRADE_COST");
            LayoutFactory.wrapInPaddingsLayout(clip.icon_upgrade_cost.image,0,0,-10);
            clip.icon_upgrade_cost.image.texture = mediator.upgradeCostItemIcon;
            TooltipHelper.addTooltip(clip.icon_upgrade_cost.image,tooltipVO);
            tooltipVO.hintData = mediator.upgradeCostItemName;
            clip.layout_upgrade_cost.visible = true;
         }
         else
         {
            TooltipHelper.removeTooltip(clip.icon_upgrade_cost.image);
            clip.layout_upgrade_cost.visible = false;
         }
         if(mediator.userHero)
         {
            clip.recieve_hero_group.visible = false;
            clip.okButton.graphics.visible = true;
            clip.okButton.label = Translate.translate("OK");
            clip.okButton.signal_click.add(mediator.close);
         }
         else
         {
            clip.recieve_hero_group.visible = true;
            clip.okButton.graphics.visible = false;
            clip.tf_recieve_hero.text = Translate.translate("UI_DIALOG_BOSS_NO_HERO");
            clip.recieve_info_btn.label = Translate.translate("UI_DIALOG_HERO_INVENTORY_SLOT_DROPLIST");
            clip.recieve_info_btn.signal_click.add(mediator.showRecieveInfo);
         }
      }
   }
}
