package game.view.popup.titanspiritartifact
{
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.artifacts.PlayerTitanArtifactVO;
   import game.mediator.gui.popup.titanspiritartifact.TitanSpiritArtifactPopupMediator;
   import game.model.user.hero.PlayerTitanArtifact;
   import game.model.user.hero.PlayerTitanEntry;
   import game.view.gui.components.controller.TouchClickController;
   import game.view.gui.components.controller.TouchHoverContoller;
   import game.view.gui.components.list.ListItemRenderer;
   
   public class TitanSpiritArtifactListRenderer extends ListItemRenderer
   {
      
      public static var mediator:TitanSpiritArtifactPopupMediator;
       
      
      private var clip:TitanSpiritArtifactListRendererClip;
      
      private var clickController:TouchClickController;
      
      private var hoverController:TouchHoverContoller;
      
      private var artifactVO:PlayerTitanArtifactVO;
      
      public function TitanSpiritArtifactListRenderer()
      {
         super();
         mediator.signal_titanArtifactEvolveStar.add(handler_artifactEvolve);
         mediator.signal_titanArtifactLevelUp.add(handler_artifactLevelUp);
         mediator.signal_inventoryUpdate.add(handler_inventoryUpdate);
      }
      
      override public function dispose() : void
      {
         data = null;
         clickController.dispose();
         hoverController.dispose();
         mediator.signal_titanArtifactEvolveStar.remove(handler_artifactEvolve);
         mediator.signal_titanArtifactLevelUp.remove(handler_artifactLevelUp);
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
         artifactVO = param1 as PlayerTitanArtifactVO;
         invalidate("data");
      }
      
      private function handler_artifactLevelUp(param1:PlayerTitanEntry, param2:PlayerTitanArtifact) : void
      {
         invalidate("data");
      }
      
      private function handler_artifactEvolve(param1:PlayerTitanEntry, param2:PlayerTitanArtifact) : void
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
         clip = AssetStorage.rsx.artifact_graphics.create(TitanSpiritArtifactListRendererClip,"spirit_artifact_list_item");
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
            clip.selected_arrow.graphics.visible = isSelected;
            clip.selected_frame.graphics.visible = isSelected;
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
      }
   }
}
