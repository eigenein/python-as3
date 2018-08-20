package game.view.popup.artifacts
{
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.artifacts.HeroArtifactsPopupMediator;
   import game.mediator.gui.popup.artifacts.PlayerHeroArtifactVO;
   import game.model.user.hero.PlayerHeroArtifact;
   import game.model.user.hero.PlayerHeroEntry;
   import game.view.gui.components.controller.TouchClickController;
   import game.view.gui.components.controller.TouchHoverContoller;
   import game.view.gui.components.list.ListItemRenderer;
   
   public class HeroArtifactListRenderer extends ListItemRenderer
   {
      
      public static var mediator:HeroArtifactsPopupMediator;
       
      
      private var clip:HeroArtifactListRendererClip;
      
      private var clickController:TouchClickController;
      
      private var hoverController:TouchHoverContoller;
      
      private var artifactVO:PlayerHeroArtifactVO;
      
      public function HeroArtifactListRenderer()
      {
         super();
         mediator.signal_heroArtifactEvolveStar.add(handler_artifactEvolve);
         mediator.signal_heroArtifactLevelUp.add(handler_artifactLevelUp);
         mediator.signal_inventoryUpdate.add(handler_inventoryUpdate);
      }
      
      override public function dispose() : void
      {
         data = null;
         clickController.dispose();
         hoverController.dispose();
         mediator.signal_heroArtifactEvolveStar.remove(handler_artifactEvolve);
         mediator.signal_heroArtifactLevelUp.remove(handler_artifactLevelUp);
         mediator.signal_inventoryUpdate.remove(handler_inventoryUpdate);
         super.dispose();
      }
      
      override public function set data(param1:Object) : void
      {
         if(artifactVO == param1)
         {
            return;
         }
         .super.data = param1;
         artifactVO = param1 as PlayerHeroArtifactVO;
         invalidate("data");
      }
      
      private function handler_artifactLevelUp(param1:PlayerHeroEntry, param2:PlayerHeroArtifact) : void
      {
         invalidate("data");
      }
      
      private function handler_artifactEvolve(param1:PlayerHeroEntry, param2:PlayerHeroArtifact) : void
      {
         invalidate("data");
      }
      
      private function handler_inventoryUpdate() : void
      {
         invalidate("data");
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.artifact_graphics.create(HeroArtifactListRendererClip,"artifact_list_item");
         addChild(clip.graphics);
         clickController = new TouchClickController(this);
         clickController.onClick.add(onClick);
         hoverController = new TouchHoverContoller(this);
         hoverController.signal_hoverChanger.add(onHover);
      }
      
      override protected function draw() : void
      {
         if(isInvalid("selected"))
         {
            clip.bg_selected.graphics.visible = isSelected;
            clip.bg.graphics.touchable = !isSelected;
         }
         if(isInvalid("data"))
         {
            clip.item.setData(artifactVO);
            clip.icon_red_dot.graphics.visible = artifactVO.checkArtifactUpgradeAvaliable();
         }
         super.draw();
      }
      
      private function onClick() : void
      {
         isSelected = true;
      }
      
      private function onHover() : void
      {
         clip.bg_over.graphics.visible = !isSelected && hoverController.hover;
      }
   }
}
