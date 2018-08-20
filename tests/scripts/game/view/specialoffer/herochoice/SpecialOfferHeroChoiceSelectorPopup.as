package game.view.specialoffer.herochoice
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.GuiAnimation;
   import feathers.controls.LayoutGroup;
   import feathers.layout.HorizontalLayout;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.skills.SkillDescription;
   import game.model.user.hero.HeroUtils;
   import game.view.gui.components.HeroPreview;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.herodescription.HeroDescriptionSkillRenderer;
   import starling.events.Event;
   
   public class SpecialOfferHeroChoiceSelectorPopup extends ClipBasedPopup
   {
       
      
      private var mediator:SpecialOfferHeroChoiceSelectorPopupMediator;
      
      private var clip:SpecialOfferHeroChoiceSelectorPopupClip;
      
      private var heroPreview:HeroPreview;
      
      private var skillsContainer:LayoutGroup;
      
      public function SpecialOfferHeroChoiceSelectorPopup(param1:SpecialOfferHeroChoiceSelectorPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         heroPreview.dispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(SpecialOfferHeroChoiceSelectorPopupClip,"dialog_specialOffer_heroChoice_selector");
         addChild(clip.graphics);
         heroPreview = new HeroPreview();
         heroPreview.graphics.touchable = false;
         clip.layout_hero.container.addChild(heroPreview.graphics);
         clip.tf_header.text = Translate.translate("UI_SPECIALOFFER_HEROCHOICE_SELECT_HEADER");
         clip.tf_list_title.text = Translate.translate("UI_SPECIALOFFER_HEROCHOICE_AVAILABLE_HEROES");
         clip.button_select.initialize(Translate.translate("UI_SPECIALOFFER_HEROCHOICE_SELECT"),mediator.action_complete);
         clip.button_close.signal_click.add(mediator.close);
         var _loc2_:GuiAnimation = AssetStorage.rsx.asset_bundle.create(GuiAnimation,"hero_rays_centered");
         var _loc4_:* = 1.3;
         _loc2_.graphics.scaleY = _loc4_;
         _loc2_.graphics.scaleX = _loc4_;
         clip.hero_position_rays.container.addChild(_loc2_.graphics);
         clip.list_heroes.isSelectable = true;
         clip.list_heroes.itemRendererType = SpecialOfferHeroChoiceSelectorItemRenderer;
         clip.list_heroes.addEventListener("change",handler_listHeroChange);
         var _loc3_:VerticalLayout = new VerticalLayout();
         _loc3_.paddingTop = 0;
         _loc3_.paddingBottom = 12;
         _loc3_.paddingLeft = 10;
         _loc3_.gap = 3;
         clip.list_heroes.layout = _loc3_;
         skillsContainer = new LayoutGroup();
         var _loc1_:HorizontalLayout = new HorizontalLayout();
         _loc1_.gap = 2;
         skillsContainer.layout = _loc1_;
         _loc1_.horizontalAlign = "center";
         _loc1_.verticalAlign = "middle";
         clip.skills_layout.addChild(clip.skills_tf);
         clip.skills_layout.addChild(skillsContainer);
         clip.skills_layout.addChild(clip.skills_description_tf);
         clip.list_heroes.dataProvider = mediator.dataProvider;
         mediator.selectedHero.onValue(handler_selectedHero);
      }
      
      private function handler_listHeroChange(param1:Event) : void
      {
         if(clip.list_heroes.selectedItem)
         {
            mediator.action_selectHero(clip.list_heroes.selectedItem as SpecialOfferHeroChoiceHeroValueObject);
         }
      }
      
      private function handler_selectedHero(param1:SpecialOfferHeroChoiceHeroValueObject) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         if(!param1)
         {
            return;
         }
         clip.list_heroes.selectedItem = param1;
         var _loc5_:HeroDescription = param1.unit as HeroDescription;
         if(!_loc5_)
         {
            return;
         }
         heroPreview.loadHero(_loc5_);
         clip.title_tf.text = _loc5_.name;
         clip.description_tf.maxHeight = clip.description_layout.height;
         clip.description_tf.text = _loc5_.descText;
         clip.skills_tf.text = Translate.translate("UI_DIALOG_HERO_TAB_SKILLS") + ":";
         skillsContainer.removeChildren(0,-1,true);
         var _loc2_:Vector.<SkillDescription> = mediator.selectedHeroSkills;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = new HeroDescriptionSkillRenderer();
            _loc3_.data = _loc2_[_loc4_];
            skillsContainer.addChild(_loc3_);
            _loc4_++;
         }
         clip.skills_description_tf.text = HeroUtils.getFullRolesDescription(_loc5_);
      }
   }
}
