package game.view.popup.artifacts
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipImage;
   import feathers.layout.AnchorLayoutData;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.AssetStorageUtil;
   import game.mediator.gui.popup.artifacts.PlayerHeroArtifactVO;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.mediator.gui.tooltip.TooltipLayerMediator;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.ClipButtonListItem;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.tooltip.HeroArtifactTooltip;
   import game.view.popup.hero.HeroStarDisplay;
   import starling.events.Event;
   
   public class PlayerHeroArtifactItemRenderer extends ClipButtonListItem implements ITooltipSource
   {
       
      
      protected var artifactVO:PlayerHeroArtifactVO;
      
      private var starDisplay:HeroStarDisplay;
      
      public var level:HeroArtifactLevelClip;
      
      public var item_border_image:GuiClipImage;
      
      public var item_image:GuiClipImage;
      
      public var lock:GuiClipImage;
      
      public var stars_container:ClipLayout;
      
      private var _tooltipVO:TooltipVO;
      
      public function PlayerHeroArtifactItemRenderer()
      {
         level = new HeroArtifactLevelClip();
         item_border_image = new GuiClipImage();
         item_image = new GuiClipImage();
         lock = new GuiClipImage();
         stars_container = ClipLayout.anchor();
         _tooltipVO = new TooltipVO(HeroArtifactTooltip,null);
         super(PlayerHeroArtifactVO);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         setData(null);
      }
      
      public function get tooltipVO() : TooltipVO
      {
         return _tooltipVO;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         starDisplay = new HeroStarDisplay();
         starDisplay.touchable = false;
         stars_container.addChild(starDisplay);
         starDisplay.width = 80;
         starDisplay.layoutData = new AnchorLayoutData();
         (starDisplay.layoutData as AnchorLayoutData).horizontalCenter = 0;
         (starDisplay.layoutData as AnchorLayoutData).bottom = 0;
         graphics.addEventListener("addedToStage",handler_addedToStage);
         graphics.addEventListener("removedFromStage",handler_removedFromStage);
      }
      
      override public function setData(param1:*) : void
      {
         super.setData(param1);
         if(artifactVO)
         {
            artifactVO.artifact.signal_evolve.remove(handler_evolve);
            artifactVO.artifact.signal_levelUp.remove(handler_levelUp);
         }
         artifactVO = param1 as PlayerHeroArtifactVO;
         if(artifactVO)
         {
            artifactVO.artifact.signal_evolve.add(handler_evolve);
            artifactVO.artifact.signal_levelUp.add(handler_levelUp);
         }
         update();
      }
      
      override protected function getClickData() : *
      {
         return artifactVO;
      }
      
      private function update() : void
      {
         var _loc1_:* = false;
         if(artifactVO && artifactVO.artifact && artifactVO.hero)
         {
            item_border_image.image.texture = AssetStorageUtil.getArtifactBigFrameTexture(artifactVO.artifact);
            item_image.image.texture = AssetStorage.rsx.artifact_icons.getTexture(artifactVO.artifact.desc.assetTexture);
            level.container.visible = artifactVO.artifact.awakened;
            level.bg.image.texture = AssetStorageUtil.getArtifactLevelTexture(artifactVO.artifact);
            level.tf.text = String(artifactVO.artifact.level);
            starDisplay.setValue(artifactVO.artifact.stars);
            _loc1_ = artifactVO.artifact.desc.artifactTypeData.minHeroLevel > artifactVO.hero.level.level;
            AssetStorage.rsx.popup_theme.setDisabledFilter(item_image.image,_loc1_ || !artifactVO.artifact.awakened);
            lock.graphics.visible = _loc1_;
            _tooltipVO.hintData = artifactVO.artifact;
         }
      }
      
      private function handler_levelUp() : void
      {
         update();
      }
      
      private function handler_evolve() : void
      {
         update();
      }
      
      private function handler_addedToStage(param1:Event) : void
      {
         TooltipLayerMediator.instance.addSource(this);
      }
      
      private function handler_removedFromStage(param1:Event) : void
      {
         TooltipLayerMediator.instance.removeSource(this);
      }
   }
}
