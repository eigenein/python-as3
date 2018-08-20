package game.view.popup.artifacts
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipImage;
   import feathers.layout.AnchorLayoutData;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.AssetStorageUtil;
   import game.mediator.gui.popup.artifacts.PlayerTitanArtifactVO;
   import game.model.user.hero.PlayerTitanArtifact;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipListItem;
   import game.view.popup.hero.MiniHeroStarDisplay;
   import starling.events.Event;
   
   public class PlayerTitanArtifactMiniItemRenderer extends ClipListItem
   {
       
      
      private var artifactVO:PlayerTitanArtifactVO;
      
      private var starDisplay:MiniHeroStarDisplay;
      
      public var level:HeroArtifactLevelClip;
      
      public var item_border_image:GuiClipImage;
      
      public var item_image:GuiClipImage;
      
      public var lock:GuiClipImage;
      
      public var animation_new:GuiAnimation;
      
      public var layout_stars:ClipLayout;
      
      public function PlayerTitanArtifactMiniItemRenderer()
      {
         level = new HeroArtifactLevelClip();
         item_border_image = new GuiClipImage();
         item_image = new GuiClipImage();
         lock = new GuiClipImage();
         animation_new = new GuiAnimation();
         layout_stars = ClipLayout.anchor();
         super();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         setData(null);
         if(!animation_new.graphics.parent)
         {
            animation_new.dispose();
         }
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
         animation_new.stop();
         animation_new.hide();
      }
      
      override public function setData(param1:*) : void
      {
         super.setData(param1);
         if(artifactVO)
         {
            artifactVO.artifact.signal_evolve.remove(handler_evolve);
            artifactVO.artifact.signal_levelUp.remove(handler_levelUp);
            artifactVO.signal_inventoryUpdated.add(handler_inventoryUpdated);
         }
         artifactVO = param1 as PlayerTitanArtifactVO;
         if(artifactVO)
         {
            artifactVO.artifact.signal_evolve.add(handler_evolve);
            artifactVO.artifact.signal_levelUp.add(handler_levelUp);
            artifactVO.signal_inventoryUpdated.add(handler_inventoryUpdated);
         }
         update();
      }
      
      private function updatePlusIcon() : void
      {
         if(artifactVO.artifact.awakened == false && artifactVO.playerCanEvolve)
         {
            animation_new.show(container);
            animation_new.playLoop();
         }
         else
         {
            animation_new.hide();
         }
      }
      
      private function update() : void
      {
         var _loc1_:* = false;
         if(artifactVO && artifactVO.artifact && artifactVO.titan)
         {
            item_border_image.image.texture = AssetStorageUtil.getTitanArtifactSmallFrameTexture(artifactVO.artifact);
            item_image.image.texture = AssetStorage.rsx.titan_artifact_icons.getTexture(artifactVO.artifact.desc.assetTexture);
            level.container.visible = artifactVO.artifact.awakened;
            level.bg.image.texture = AssetStorageUtil.getTitanArtifactLevelTexture(artifactVO.artifact);
            level.tf.text = String(artifactVO.artifact.level);
            starDisplay.setValue(artifactVO.artifact.stars);
            _loc1_ = artifactVO.artifact.desc.artifactTypeData.minHeroLevel > artifactVO.titan.level.level;
            AssetStorage.rsx.popup_theme.setDisabledFilter(item_image.image,_loc1_ || !artifactVO.artifact.awakened);
            lock.graphics.visible = _loc1_;
            updatePlusIcon();
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
      }
      
      private function handler_removedFromStage(param1:Event) : void
      {
      }
      
      private function handler_inventoryUpdated() : void
      {
         updatePlusIcon();
      }
   }
}
