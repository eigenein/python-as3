package game.view.popup.artifacts
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import engine.core.clipgui.IGuiClip;
   import flash.geom.Point;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.AssetStorageUtil;
   import game.mediator.gui.popup.artifacts.HeroArtifactsPopupMediator;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.popup.chest.SoundGuiAnimation;
   import starling.core.Starling;
   import starling.display.Sprite;
   import starling.textures.Texture;
   
   public class HeroArtifactsInfoClip extends GuiClipNestedContainer
   {
       
      
      private var starAnimation:GuiAnimation;
      
      private var animationsContainer:Sprite;
      
      private var idleAnimation:GuiAnimation;
      
      public var tf_name:ClipLabel;
      
      public var tf_level:ClipLabel;
      
      public var tf_evolution:ClipLabel;
      
      public var tf_desc:SpecialClipLabel;
      
      public var stats:HeroArtifactStatsClip;
      
      public var item_border_image:GuiClipImage;
      
      public var item_image:GuiClipImage;
      
      public var idle_animation_container:GuiClipContainer;
      
      public var unlock_animation:SoundGuiAnimation;
      
      public var evolution_animation:SoundGuiAnimation;
      
      public var rank_animation:SoundGuiAnimation;
      
      public var lvlup_animation:SoundGuiAnimation;
      
      public var ribbon_image:GuiClipScale3Image;
      
      public var star_epic:GuiAnimation;
      
      public var star_1:ClipSprite;
      
      public var star_2:ClipSprite;
      
      public var star_3:ClipSprite;
      
      public var star_4:ClipSprite;
      
      public var star_5:ClipSprite;
      
      public var layout_starCounter:ClipLayout;
      
      public var mediator:HeroArtifactsPopupMediator;
      
      public function HeroArtifactsInfoClip()
      {
         tf_name = new ClipLabel();
         tf_level = new ClipLabel();
         tf_evolution = new ClipLabel();
         tf_desc = new SpecialClipLabel();
         stats = new HeroArtifactStatsClip();
         item_border_image = new GuiClipImage();
         item_image = new GuiClipImage();
         idle_animation_container = new GuiClipContainer();
         unlock_animation = new SoundGuiAnimation();
         evolution_animation = new SoundGuiAnimation();
         rank_animation = new SoundGuiAnimation();
         lvlup_animation = new SoundGuiAnimation();
         star_1 = new ClipSprite();
         star_2 = new ClipSprite();
         star_3 = new ClipSprite();
         star_4 = new ClipSprite();
         star_5 = new ClipSprite();
         layout_starCounter = ClipLayout.horizontalMiddleCentered(-4,star_1,star_2,star_3,star_4,star_5);
         super();
      }
      
      public function updateState(param1:Boolean = false, param2:Boolean = false) : void
      {
         var _loc7_:* = null;
         var _loc3_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc4_:int = 0;
         var _loc6_:* = null;
         if(mediator.artifact)
         {
            if(!param1 && !param2)
            {
               var _loc8_:* = mediator.artifact.desc.backgroundColorIdent;
               if("blue" !== _loc8_)
               {
                  if("gold" !== _loc8_)
                  {
                     if("yellow" !== _loc8_)
                     {
                        if("green" !== _loc8_)
                        {
                           if("purple" !== _loc8_)
                           {
                              if("red" !== _loc8_)
                              {
                                 if("cyan" !== _loc8_)
                                 {
                                    _loc7_ = "artefact_backglow_blue";
                                 }
                                 else
                                 {
                                    _loc7_ = "artefact_backglow_blue";
                                 }
                              }
                              else
                              {
                                 _loc7_ = "artefact_backglow_red";
                              }
                           }
                           else
                           {
                              _loc7_ = "artefact_backglow_purple";
                           }
                        }
                        else
                        {
                           _loc7_ = "artefact_backglow_green";
                        }
                     }
                  }
                  _loc7_ = "artefact_backglow_yellow";
               }
               else
               {
                  _loc7_ = "artefact_backglow_deepblue";
               }
               if(!idleAnimation)
               {
                  idleAnimation = AssetStorage.rsx.artifact_graphics.create(GuiAnimation,_loc7_);
               }
               else
               {
                  idleAnimation.setClip(AssetStorage.rsx.artifact_graphics.data.getClipByName(_loc7_));
               }
               idleAnimation.show(idle_animation_container.container);
               idleAnimation.play();
            }
            _loc3_ = true;
            _loc5_ = true;
            if(param1)
            {
               if(mediator.artifact.stars == 1)
               {
                  unlock_animation.show(animationsContainer);
                  unlock_animation.playOnceAndHide();
               }
               else
               {
                  evolution_animation.show(animationsContainer);
                  evolution_animation.playOnceAndHide();
               }
            }
            if(param2)
            {
               if(mediator.artifact.prevLevelData == null || mediator.artifact.prevLevelData.color != mediator.artifact.color)
               {
                  _loc3_ = false;
                  rank_animation.show(animationsContainer);
                  rank_animation.playOnceAndHide();
               }
               else
               {
                  _loc5_ = false;
                  lvlup_animation.show(animationsContainer);
                  lvlup_animation.playOnceAndHide();
               }
            }
            ribbon_image.image.textures = mediator.ribbonTexture;
            tf_name.text = mediator.artifact.desc.name;
            tf_desc.text = mediator.artifactDescText;
            tf_level.visible = mediator.artifact.awakened;
            _loc4_ = mediator.artifact.level;
            if(_loc5_)
            {
               updateArtifactLevel(_loc4_);
            }
            else
            {
               Starling.juggler.delayCall(updateArtifactLevel,1,_loc4_);
            }
            setStarCount(mediator.artifact.stars,param1);
            updateStats();
            _loc6_ = AssetStorageUtil.getArtifactBigFrameTexture(mediator.artifact);
            if(_loc3_)
            {
               updateArtifactFrame(_loc6_);
            }
            else
            {
               Starling.juggler.delayCall(updateArtifactFrame,1,_loc6_);
            }
            item_image.image.texture = AssetStorage.rsx.artifact_icons_large.getTexture(mediator.artifact.desc.assetTexture);
         }
      }
      
      public function updateStats(param1:Boolean = false, param2:Boolean = false) : void
      {
         stats.tf_title.text = mediator.getStatsTitle(param1,param2);
         stats.tf_stats.text = mediator.getStatsText(param1,param2);
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
         animationsContainer = new Sprite();
         container.addChild(animationsContainer);
         animationsContainer.blendMode = "add";
         unlock_animation.hide();
         unlock_animation.stop();
         evolution_animation.hide();
         evolution_animation.stop();
         rank_animation.hide();
         rank_animation.stop();
         lvlup_animation.hide();
         lvlup_animation.stop();
      }
      
      private function updateArtifactFrame(param1:Texture) : void
      {
         item_border_image.image.texture = param1;
      }
      
      private function updateArtifactLevel(param1:int) : void
      {
         tf_level.text = Translate.translateArgs("UI_COMMON_LEVEL",param1);
      }
      
      private function hideStarAnimation() : void
      {
         if(starAnimation)
         {
            starAnimation.hide();
            starAnimation.stop();
         }
      }
      
      private function handler_starAnimationComplete() : void
      {
         hideStarAnimation();
      }
   }
}
