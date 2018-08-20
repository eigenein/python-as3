package game.view.popup.herodescription
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.GuiAnimation;
   import feathers.controls.LayoutGroup;
   import feathers.layout.HorizontalLayout;
   import game.assets.storage.AssetStorage;
   import game.data.storage.skills.SkillDescription;
   import game.view.gui.components.HeroPreview;
   import game.view.popup.ClipBasedPopup;
   
   public class HeroDescriptionPopUp extends ClipBasedPopup
   {
       
      
      private var mediator:HeroDescriptionPopUpMediator;
      
      private var clip:HeroDescriptionPopUpClip;
      
      private var skillsContainer:LayoutGroup;
      
      public function HeroDescriptionPopUp(param1:HeroDescriptionPopUpMediator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "heroDescription";
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_hero_description();
         addChild(clip.graphics);
         clip.button_close.signal_click.add(mediator.close);
         clip.info.title_tf.text = mediator.heroName;
         var _loc4_:GuiAnimation = AssetStorage.rsx.asset_bundle.create(GuiAnimation,"hero_rays_centered");
         var _loc7_:* = 1.3;
         _loc4_.graphics.scaleY = _loc7_;
         _loc4_.graphics.scaleX = _loc7_;
         clip.info.hero_position_rays.container.addChild(_loc4_.graphics);
         var _loc6_:HeroPreview = new HeroPreview();
         clip.info.hero_position_after.container.addChild(_loc6_.graphics);
         _loc6_.graphics.touchable = false;
         _loc6_.loadHero(mediator.hero);
         clip.info.skills_layout.removeChildren();
         clip.info.description_tf.maxHeight = clip.info.description_layout.height;
         clip.info.description_tf.text = mediator.heroDescText;
         clip.info.skills_tf.text = Translate.translate("UI_DIALOG_HERO_TAB_SKILLS") + ":";
         clip.info.skills_layout.addChild(clip.info.skills_tf);
         skillsContainer = new LayoutGroup();
         var _loc3_:HorizontalLayout = new HorizontalLayout();
         _loc3_.gap = 2;
         skillsContainer.layout = _loc3_;
         _loc3_.horizontalAlign = "center";
         _loc3_.verticalAlign = "middle";
         clip.info.skills_layout.addChild(skillsContainer);
         var _loc1_:Vector.<SkillDescription> = mediator.skillList;
         _loc5_ = 0;
         while(_loc5_ < mediator.skillList.length)
         {
            _loc2_ = new HeroDescriptionSkillRenderer();
            _loc2_.data = _loc1_[_loc5_];
            skillsContainer.addChild(_loc2_);
            _loc5_++;
         }
         clip.info.skills_description_tf.text = mediator.skillsDescription;
         clip.info.skills_layout.addChild(clip.info.skills_description_tf);
         if(mediator.recieveInfoMode)
         {
            clip.recieveInfoBtn.graphics.visible = true;
            clip.recieveInfoBtn.label = Translate.translateArgs("UI_DIALOG_HERO_INVENTORY_SLOT_DROPLIST");
            clip.recieveInfoBtn.expandToFitTextWidth();
            clip.recieveInfoBtn.signal_click.add(mediator.showRecieveInfo);
            clip.recieveInfoBtn.graphics.y = clip.info.graphics.y + clip.info.graphics.height + 10;
            clip.PopupBG_12_12_12_12_inst0.graphics.height = clip.recieveInfoBtn.graphics.y + clip.recieveInfoBtn.graphics.height + 5;
         }
         else
         {
            clip.recieveInfoBtn.graphics.visible = false;
            clip.PopupBG_12_12_12_12_inst0.graphics.height = clip.info.graphics.y + clip.info.graphics.height + 15;
         }
      }
   }
}
