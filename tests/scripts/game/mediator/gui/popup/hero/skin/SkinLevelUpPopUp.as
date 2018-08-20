package game.mediator.gui.popup.hero.skin
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.view.gui.components.HeroPreview;
   import game.view.popup.ClipBasedPopup;
   
   public class SkinLevelUpPopUp extends ClipBasedPopup
   {
       
      
      private var heroPreview:HeroPreview;
      
      private var mediator:SkinLevelUpPopUpMediator;
      
      public function SkinLevelUpPopUp(param1:SkinLevelUpPopUpMediator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "skin_level_up:" + param1.skinID;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:SkinLevelUpPopUpClip = AssetStorage.rsx.popup_theme.create_dialog_skin_level_up();
         addChild(_loc1_.graphics);
         if(mediator.skinLevel > 1)
         {
            _loc1_.tf_header.text = Translate.translate("UI_DIALOG_SKIN_LEVEL_UP_TITLE");
         }
         else
         {
            _loc1_.tf_header.text = Translate.translate("UI_DIALOG_NEW_SKIN_TITLE");
         }
         if(mediator.userHero)
         {
            _loc1_.recieve_hero_group.visible = false;
            var _loc2_:* = false;
            _loc1_.bottom_bg.graphics.visible = _loc2_;
            _loc2_ = _loc2_;
            _loc1_.line_bottom.graphics.visible = _loc2_;
            _loc1_.line_top.graphics.visible = _loc2_;
         }
         else
         {
            _loc1_.recieve_hero_group.visible = true;
            _loc2_ = true;
            _loc1_.bottom_bg.graphics.visible = _loc2_;
            _loc2_ = _loc2_;
            _loc1_.line_bottom.graphics.visible = _loc2_;
            _loc1_.line_top.graphics.visible = _loc2_;
            _loc1_.tf_recieve_hero.text = Translate.translate("UI_DIALOG_BOSS_NO_HERO");
            _loc1_.recieve_info_btn.label = Translate.translate("UI_DIALOG_HERO_INVENTORY_SLOT_DROPLIST");
            _loc1_.recieve_info_btn.signal_click.add(mediator.showRecieveInfo);
         }
         _loc1_.tf_hero_name.text = mediator.hero.name + " - " + mediator.skinName;
         _loc1_.tf_level.text = Translate.translateArgs("UI_COMMON_LEVEL",mediator.skinLevel);
         _loc1_.tf_desc.text = mediator.getSkinDescription();
         _loc1_.okButton.label = Translate.translate("UI_COMMON_OK");
         _loc1_.okButton.signal_click.add(mediator.close);
         heroPreview = new HeroPreview();
         _loc1_.hero_position.container.addChild(heroPreview.graphics);
         heroPreview.graphics.touchable = false;
         heroPreview.loadHero(mediator.hero,mediator.skinID);
         width = _loc1_.ribbon_154_154_2_inst0.graphics.width;
         if(mediator.userHero)
         {
            height = _loc1_.okButton.graphics.y + _loc1_.okButton.graphics.height;
         }
         else
         {
            height = _loc1_.recieve_hero_group.graphics.y + _loc1_.recieve_hero_group.graphics.height;
         }
      }
   }
}
