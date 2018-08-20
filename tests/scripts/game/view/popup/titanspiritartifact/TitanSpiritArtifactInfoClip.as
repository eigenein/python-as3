package game.view.popup.titanspiritartifact
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.IGuiClip;
   import flash.geom.Point;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.titanspiritartifact.TitanSpiritArtifactPopupMediator;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   import starling.core.Starling;
   
   public class TitanSpiritArtifactInfoClip extends GuiClipNestedContainer
   {
       
      
      private var starAnimation:GuiAnimation;
      
      public var tf_skill_header:ClipLabel;
      
      public var tf_new_skill:ClipLabel;
      
      public var tf_level:ClipLabel;
      
      public var tf_skill_avaliable:ClipLabel;
      
      public var tf_params:SpecialClipLabel;
      
      public var tf_params_values:SpecialClipLabel;
      
      public var tf_skill_name:ClipLabel;
      
      public var tf_skill_desc:SpecialClipLabel;
      
      public var layout_skill_name_desc:ClipLayout;
      
      public var skill_image_frame:GuiClipImage;
      
      public var skill_image_item:GuiClipImage;
      
      public var star_epic:GuiAnimation;
      
      public var star_1:ClipSprite;
      
      public var star_2:ClipSprite;
      
      public var star_3:ClipSprite;
      
      public var star_4:ClipSprite;
      
      public var star_5:ClipSprite;
      
      public var layout_starCounter:ClipLayout;
      
      private var spiritAnimation:TitanSpiritArtifactAnimation;
      
      private var upgrageAnimation:GuiAnimation;
      
      private var screenFadeAnimaion:GuiAnimation;
      
      private var bg:ClipSprite;
      
      public var spirit_container:ClipLayout;
      
      public var animation_container:ClipLayout;
      
      public var fade_container:ClipLayout;
      
      public var mediator:TitanSpiritArtifactPopupMediator;
      
      public function TitanSpiritArtifactInfoClip()
      {
         tf_skill_header = new ClipLabel();
         tf_new_skill = new ClipLabel();
         tf_level = new ClipLabel();
         tf_skill_avaliable = new ClipLabel();
         tf_params = new SpecialClipLabel();
         tf_params_values = new SpecialClipLabel();
         tf_skill_name = new ClipLabel();
         tf_skill_desc = new SpecialClipLabel();
         layout_skill_name_desc = ClipLayout.verticalMiddleLeft(5,tf_skill_name,tf_skill_desc);
         star_1 = new ClipSprite();
         star_2 = new ClipSprite();
         star_3 = new ClipSprite();
         star_4 = new ClipSprite();
         star_5 = new ClipSprite();
         layout_starCounter = ClipLayout.horizontalMiddleCentered(-4,star_1,star_2,star_3,star_4,star_5);
         spirit_container = ClipLayout.none();
         animation_container = ClipLayout.none();
         fade_container = ClipLayout.none();
         super();
      }
      
      public function updateState(param1:Boolean = false, param2:Boolean = false) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(!bg)
         {
            bg = AssetStorage.rsx.big_pillars.create(ClipSprite,"bg");
            bg.graphics.x = -97;
            bg.graphics.y = -131;
            container.addChildAt(bg.graphics,0);
         }
         if(mediator.selectedArtifact)
         {
            if(!param2)
            {
               updateArtifactLevel();
            }
            else
            {
               Starling.juggler.delayCall(updateArtifactLevel,1.3);
            }
            if(!param1)
            {
               updateSpiritAnimation();
            }
            else
            {
               Starling.juggler.delayCall(updateSpiritAnimation,1.7);
            }
            if(param1 || param2)
            {
               if(upgrageAnimation)
               {
                  upgrageAnimation.dispose();
               }
               _loc3_ = !!param2?mediator.upgradeAnimationName:mediator.levelUpAnimationName;
               upgrageAnimation = AssetStorage.rsx.big_pillars.create(GuiAnimation,_loc3_);
               upgrageAnimation.show(animation_container);
               upgrageAnimation.playOnceAndHide();
               if(param1)
               {
                  _loc4_ = this.container.localToGlobal(new Point(fade_container.x,fade_container.y));
                  fade_container.x = fade_container.x - _loc4_.x;
                  fade_container.y = fade_container.y - _loc4_.y;
                  if(screenFadeAnimaion)
                  {
                     screenFadeAnimaion.dispose();
                  }
                  screenFadeAnimaion = AssetStorage.rsx.artifact_graphics.create(GuiAnimation,"upgrade_fade_animaion");
                  screenFadeAnimaion.playOnceAndHide();
                  screenFadeAnimaion.show(fade_container);
               }
            }
            tf_level.visible = mediator.selectedArtifact.awakened;
            tf_skill_header.text = mediator.getArtifactSkillHeader();
            tf_new_skill.text = Translate.translate("UI_DIALOG_TITAN_SPIRIT_ARTIFACT_NEW_SKILL");
            tf_skill_avaliable.text = mediator.getArtifactSkillAvaliableText();
            tf_skill_name.text = mediator.getArtifactSkillName();
            tf_params.text = mediator.artifactDescText;
            skill_image_item.image.texture = mediator.skillIcon;
            setStarCount(mediator.selectedArtifact.stars,param1);
            updateStats();
         }
      }
      
      public function updateStats(param1:Boolean = false, param2:Boolean = false) : void
      {
         tf_params_values.text = mediator.getStatsText(param1,param2);
         tf_skill_desc.text = mediator.getArtifactSkillDesc(param1,param2);
      }
      
      public function setStarCount(param1:int, param2:Boolean = false) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc9_:* = null;
         var _loc8_:* = null;
         hideStarAnimation();
         var _loc3_:Boolean = star_epic.graphics.visible;
         star_epic.graphics.visible = param1 == 6;
         var _loc7_:IGuiClip = null;
         if(param2 && star_epic.graphics.visible && !_loc3_)
         {
            _loc7_ = star_epic;
         }
         _loc5_ = 1;
         while(_loc5_ <= 6 - 1)
         {
            _loc4_ = this["star_" + _loc5_] as ClipSprite;
            if(_loc4_)
            {
               _loc3_ = _loc4_.graphics.visible;
               _loc4_.graphics.visible = Boolean(_loc5_ <= param1 && param1 < 6);
               if(param2 && _loc4_.graphics.visible && !_loc3_)
               {
                  _loc7_ = _loc4_;
               }
            }
            _loc5_++;
         }
         layout_starCounter.validate();
         if(_loc7_)
         {
            _loc6_ = new Point(_loc7_.graphics.x,_loc7_.graphics.y);
            _loc9_ = new Point();
            _loc7_.graphics.parent.localToGlobal(_loc6_,_loc9_);
            _loc8_ = new Point();
            this.container.globalToLocal(_loc9_,_loc8_);
            if(!starAnimation)
            {
               starAnimation = AssetStorage.rsx.popup_theme.create(GuiAnimation,"starcollect_animation");
            }
            if(_loc7_ == star_epic)
            {
               starAnimation.graphics.x = _loc8_.x + _loc7_.graphics.width / 2 - 48;
               starAnimation.graphics.y = _loc8_.y + _loc7_.graphics.height / 2 - 1;
            }
            else
            {
               starAnimation.graphics.x = _loc8_.x + _loc7_.graphics.width / 2;
               starAnimation.graphics.y = _loc8_.y + _loc7_.graphics.height / 2 - 1;
            }
            this.container.addChild(starAnimation.graphics);
            starAnimation.signal_completed.add(handler_starAnimationComplete);
            starAnimation.playOnce();
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         fade_container.touchable = false;
      }
      
      private function hideStarAnimation() : void
      {
         if(starAnimation)
         {
            starAnimation.hide();
            starAnimation.stop();
         }
      }
      
      private function updateArtifactLevel() : void
      {
         tf_level.text = Translate.translateArgs("UI_COMMON_LEVEL",mediator.selectedArtifact.level);
      }
      
      private function updateSpiritAnimation() : void
      {
         if(spiritAnimation)
         {
            spiritAnimation.dispose();
         }
         spiritAnimation = AssetStorage.rsx.big_pillars.create(TitanSpiritArtifactAnimation,mediator.artifactAnimationName);
         spiritAnimation.hitTest_image.graphics.visible = false;
         spiritAnimation.hover_front.graphics.visible = false;
         spiritAnimation.animation.show(spirit_container);
      }
      
      private function handler_starAnimationComplete() : void
      {
         hideStarAnimation();
      }
   }
}
