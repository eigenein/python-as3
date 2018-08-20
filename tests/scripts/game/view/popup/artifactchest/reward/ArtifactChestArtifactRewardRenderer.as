package game.view.popup.artifactchest.reward
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.INeedNestedParsing;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.AssetStorageUtil;
   import game.data.storage.artifact.ArtifactChestDropItem;
   import game.data.storage.artifact.ArtifactDescription;
   import game.mediator.gui.tooltip.ITooltipSource;
   import game.mediator.gui.tooltip.TooltipLayerMediator;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipListItem;
   import game.view.gui.components.tooltip.ArtifactChestRewardInfoTooltip;
   import game.view.popup.artifactchest.ArtifactChestPopupMediator;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.events.Event;
   
   public class ArtifactChestArtifactRewardRenderer extends ClipListItem implements INeedNestedParsing, ITooltipSource
   {
      
      public static var mediator:ArtifactChestPopupMediator;
       
      
      private var tween:Tween;
      
      private var itemData:ArtifactChestDropItem;
      
      private var _tooltipVO:TooltipVO;
      
      public var item_border_image:GuiClipImage;
      
      public var lock:GuiClipImage;
      
      public var tf_level:ClipLabel;
      
      public var item_image:GuiClipImage;
      
      public var icon_multiplier_container:ClipLayout;
      
      public function ArtifactChestArtifactRewardRenderer()
      {
         item_border_image = new GuiClipImage();
         lock = new GuiClipImage();
         tf_level = new ClipLabel();
         item_image = new GuiClipImage();
         icon_multiplier_container = ClipLayout.horizontalMiddleCentered(0);
         super();
         _tooltipVO = new TooltipVO(ArtifactChestRewardInfoTooltip,null);
      }
      
      public function get tooltipVO() : TooltipVO
      {
         return _tooltipVO;
      }
      
      override public function setData(param1:*) : void
      {
         super.setData(param1);
         itemData = param1 as ArtifactChestDropItem;
         if(itemData)
         {
            updateLockState();
            icon_multiplier_container.removeChildren();
            if(itemData.multiplier > 1)
            {
               icon_multiplier_container.addChild(new Image(AssetStorage.rsx.popup_theme.getTexture("icon_x" + itemData.multiplier)));
            }
            tooltipVO.hintData = itemData;
            updateImage();
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         graphics.addEventListener("addedToStage",handler_addedToStage);
         graphics.addEventListener("removedFromStage",handler_removedFromStage);
      }
      
      public function changeImage(param1:Number) : void
      {
         Starling.juggler.delayCall(handler_changeImage,param1);
      }
      
      public function updateLockState() : void
      {
         var _loc1_:* = false;
         if(itemData)
         {
            _loc1_ = itemData.level <= mediator.artifactChest.level;
            item_image.image.filter = !!_loc1_?null:AssetStorage.rsx.popup_theme.filter_disabled;
            lock.graphics.visible = !_loc1_;
            tf_level.text = itemData.level.toString();
            tf_level.graphics.visible = !_loc1_;
         }
      }
      
      private function updateImage() : void
      {
         var _loc1_:ArtifactDescription = mediator.getRandomArtifactDescription();
         if(_loc1_)
         {
            item_border_image.image.texture = AssetStorageUtil.getArtifactFragmentTexture();
            item_image.image.texture = AssetStorageUtil.getItemDescTexture(_loc1_);
         }
      }
      
      private function handler_addedToStage(param1:Event) : void
      {
         TooltipLayerMediator.instance.addSource(this);
      }
      
      private function handler_removedFromStage(param1:Event) : void
      {
         TooltipLayerMediator.instance.removeSource(this);
      }
      
      private function handler_changeImage() : void
      {
         tween = new Tween(item_image.image,0.1,"linear");
         tween.onComplete = tweenComplete;
         tween.animate("alpha",0.1);
         Starling.juggler.add(tween);
      }
      
      private function tweenComplete() : void
      {
         Starling.juggler.remove(tween);
         updateImage();
         tween = new Tween(item_image.image,0.1,"linear");
         tween.onComplete = clearTween;
         tween.animate("alpha",1);
         Starling.juggler.add(tween);
      }
      
      private function clearTween() : void
      {
         Starling.juggler.remove(tween);
      }
   }
}
