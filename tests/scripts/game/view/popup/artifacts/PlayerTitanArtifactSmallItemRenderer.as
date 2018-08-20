package game.view.popup.artifacts
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipImage;
   import feathers.layout.AnchorLayoutData;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.AssetStorageUtil;
   import game.mediator.gui.popup.artifacts.PlayerTitanArtifactVO;
   import game.mediator.gui.popup.titan.TitanPopupMediator;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.mediator.gui.tooltip.TooltipLayerMediator;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.model.user.hero.PlayerTitanArtifact;
   import game.view.gui.components.ClipButtonListItem;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.tooltip.TitanArtifactTooltip;
   import game.view.popup.hero.MiniHeroStarDisplay;
   import starling.events.Event;
   import starling.textures.Texture;
   
   public class PlayerTitanArtifactSmallItemRenderer extends ClipButtonListItem implements ITooltipSource
   {
       
      
      protected var artifactVO:PlayerTitanArtifactVO;
      
      private var starDisplay:MiniHeroStarDisplay;
      
      public var level:HeroArtifactLevelClip;
      
      public var item_border_image:GuiClipImage;
      
      public var item_image:GuiClipImage;
      
      public var lock:GuiClipImage;
      
      public var layout_stars:ClipLayout;
      
      private var _tooltipVO:TooltipVO;
      
      public function PlayerTitanArtifactSmallItemRenderer()
      {
         level = new HeroArtifactLevelClip();
         item_border_image = new GuiClipImage();
         item_image = new GuiClipImage();
         lock = new GuiClipImage();
         layout_stars = ClipLayout.anchor();
         _tooltipVO = new TooltipVO(TitanArtifactTooltip,null);
         super(PlayerTitanArtifactVO);
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
      
      protected function get frameTexture() : Texture
      {
         return AssetStorageUtil.getTitanArtifactBigFrameTexture(artifactVO.artifact);
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         starDisplay = new MiniHeroStarDisplay();
         starDisplay.touchable = false;
         layout_stars.addChild(starDisplay);
         starDisplay.width = 80;
         starDisplay.layoutData = new AnchorLayoutData();
         (starDisplay.layoutData as AnchorLayoutData).horizontalCenter = 0;
         (starDisplay.layoutData as AnchorLayoutData).bottom = 0;
         graphics.addEventListener("addedToStage",handler_addedToStage);
         graphics.addEventListener("removedFromStage",handler_removedFromStage);
      }
      
      override protected function getClickData() : *
      {
         return artifactVO;
      }
      
      override public function setData(param1:*) : void
      {
         super.setData(param1);
         if(artifactVO)
         {
            artifactVO.artifact.signal_evolve.remove(handler_evolve);
            artifactVO.artifact.signal_levelUp.remove(handler_levelUp);
         }
         artifactVO = param1 as PlayerTitanArtifactVO;
         if(artifactVO)
         {
            artifactVO.artifact.signal_evolve.add(handler_evolve);
            artifactVO.artifact.signal_levelUp.add(handler_levelUp);
         }
         update();
      }
      
      private function update() : void
      {
         var _loc1_:Boolean = false;
         if(artifactVO && artifactVO.artifact)
         {
            _loc1_ = TitanPopupMediator.artifactsMechanicAvaliable;
            AssetStorage.rsx.popup_theme.setDisabledFilter(item_image.image,!_loc1_ || !artifactVO.artifact.awakened);
            lock.graphics.visible = !_loc1_;
            item_border_image.image.texture = frameTexture;
            item_image.image.texture = AssetStorage.rsx.titan_artifact_icons.getTexture(artifactVO.artifact.desc.assetTexture);
            level.container.visible = artifactVO.artifact.awakened;
            level.bg.image.texture = AssetStorageUtil.getTitanArtifactLevelTexture(artifactVO.artifact);
            level.tf.text = String(artifactVO.artifact.level);
            starDisplay.setValue(artifactVO.artifact.stars);
            _tooltipVO.hintData = artifactVO.artifact;
         }
      }
      
      private function handler_levelUp(param1:PlayerTitanArtifact) : void
      {
         update();
      }
      
      private function handler_evolve(param1:PlayerTitanArtifact) : void
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
