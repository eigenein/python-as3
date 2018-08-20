package game.view.popup.chestrewardheroeslist
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.GuiAnimation;
   import feathers.controls.LayoutGroup;
   import feathers.data.ListCollection;
   import feathers.layout.HorizontalLayout;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.data.storage.DataStorage;
   import game.data.storage.chest.ChestRewardPresentationValueObject;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.skills.SkillDescription;
   import game.model.user.hero.HeroUtils;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import game.view.gui.components.HeroPreview;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.herodescription.HeroDescriptionSkillRenderer;
   import starling.events.Event;
   
   public class ChestRewardHeroesListPopUp extends ClipBasedPopup
   {
       
      
      private var mediator:ChestRewardHeroesListPopUpMediator;
      
      private var clip:ChestRewardHeroesListPopUpClip;
      
      private var skillsContainer:LayoutGroup;
      
      private var heroesList:GameScrolledList;
      
      private var heroPreview:HeroPreview;
      
      private var heroPreviewAnimation:GuiAnimation;
      
      public function ChestRewardHeroesListPopUp(param1:ChestRewardHeroesListPopUpMediator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "heroDescriptionList";
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_chest_reward_hero_list();
         addChild(clip.graphics);
         clip.button_close.signal_click.add(mediator.close);
         clip.list_title_tf.text = Translate.translate("UI_DIALOG_HERO_DESCRIPTION_LIST_TITLE");
         var _loc1_:GameScrollBar = new GameScrollBar();
         _loc1_.height = clip.scroll_slider_container.graphics.height;
         clip.scroll_slider_container.container.addChild(_loc1_);
         heroesList = new GameScrolledList(_loc1_,clip.gradient_top.graphics,clip.gradient_bottom.graphics);
         heroesList.isSelectable = true;
         heroesList.width = clip.skin_list_container.graphics.width;
         heroesList.height = clip.skin_list_container.graphics.height;
         heroesList.addEventListener("change",onListChange);
         heroesList.itemRendererType = ChestRewardHeroesListRenderer;
         heroesList.dataProvider = new ListCollection(mediator.rewardHeros);
         heroesList.selectedIndex = 0;
         var _loc2_:VerticalLayout = new VerticalLayout();
         _loc2_.paddingTop = 0;
         _loc2_.paddingBottom = 0;
         _loc2_.paddingLeft = 10;
         _loc2_.gap = 3;
         heroesList.layout = _loc2_;
         clip.skin_list_container.container.addChild(heroesList);
      }
      
      private function onListChange(param1:Event) : void
      {
         if(heroesList.selectedItem)
         {
            updateCurrentHeroInfo((heroesList.selectedItem as ChestRewardPresentationValueObject).item as HeroDescription);
         }
      }
      
      private function updateCurrentHeroInfo(param1:HeroDescription) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         clip.info.title_tf.text = param1.name;
         if(!heroPreviewAnimation)
         {
            heroPreviewAnimation = AssetStorage.rsx.asset_bundle.create(GuiAnimation,"hero_rays_centered");
            var _loc6_:* = 1.3;
            heroPreviewAnimation.graphics.scaleY = _loc6_;
            heroPreviewAnimation.graphics.scaleX = _loc6_;
            clip.info.hero_position_rays.container.addChild(heroPreviewAnimation.graphics);
         }
         if(!heroPreview)
         {
            heroPreview = new HeroPreview();
            clip.info.hero_position_after.container.addChild(heroPreview.graphics);
            heroPreview.graphics.touchable = false;
         }
         heroPreview.loadHero(param1);
         clip.info.skills_layout.removeChildren();
         clip.info.description_tf.maxHeight = clip.info.description_layout.height;
         clip.info.description_tf.text = param1.descText;
         clip.info.skills_tf.text = Translate.translate("UI_DIALOG_HERO_TAB_SKILLS") + ":";
         clip.info.skills_layout.addChild(clip.info.skills_tf);
         skillsContainer = new LayoutGroup();
         var _loc4_:HorizontalLayout = new HorizontalLayout();
         _loc4_.gap = 2;
         skillsContainer.layout = _loc4_;
         _loc4_.horizontalAlign = "center";
         _loc4_.verticalAlign = "middle";
         clip.info.skills_layout.addChild(skillsContainer);
         var _loc2_:Vector.<SkillDescription> = DataStorage.skill.getUpgradableSkillsByHero(param1.id);
         _loc2_.sort(mediator.sortSkills);
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc3_ = new HeroDescriptionSkillRenderer();
            _loc3_.data = _loc2_[_loc5_];
            skillsContainer.addChild(_loc3_);
            _loc5_++;
         }
         clip.info.skills_description_tf.text = HeroUtils.getFullRolesDescription(param1);
         clip.info.skills_layout.addChild(clip.info.skills_description_tf);
      }
   }
}
