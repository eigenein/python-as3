package game.view.popup.artifacts
{
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.artifacts.PlayerTitanArtifactVO;
   import game.mediator.gui.popup.artifacts.TitanArtifactsPopupMediator;
   import game.model.user.hero.PlayerTitanArtifact;
   import game.model.user.hero.PlayerTitanEntry;
   import game.view.gui.components.controller.TouchClickController;
   import game.view.gui.components.controller.TouchHoverContoller;
   import game.view.gui.components.list.ListItemRenderer;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialButton;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import idv.cjcat.signals.Signal;
   import starling.display.DisplayObject;
   
   public class TitanArtifactListRenderer extends ListItemRenderer implements ITutorialActionProvider, ITutorialButton
   {
      
      public static var mediator:TitanArtifactsPopupMediator;
       
      
      private var clip:TitanArtifactListRendererClip;
      
      private var clickController:TouchClickController;
      
      private var hoverController:TouchHoverContoller;
      
      private var artifactVO:PlayerTitanArtifactVO;
      
      public function TitanArtifactListRenderer()
      {
         super();
         mediator.signal_titanArtifactEvolveStar.add(handler_artifactEvolve);
         mediator.signal_titanArtifactLevelUp.add(handler_artifactLevelUp);
         mediator.signal_inventoryUpdate.add(handler_inventoryUpdate);
         mediator.signal_goldUpdate.add(handler_goldUpdate);
      }
      
      override public function dispose() : void
      {
         data = null;
         clickController.dispose();
         hoverController.dispose();
         mediator.signal_titanArtifactEvolveStar.remove(handler_artifactEvolve);
         mediator.signal_titanArtifactLevelUp.remove(handler_artifactLevelUp);
         mediator.signal_inventoryUpdate.remove(handler_inventoryUpdate);
         mediator.signal_goldUpdate.remove(handler_goldUpdate);
         super.dispose();
      }
      
      public function get graphics() : DisplayObject
      {
         return clip.graphics;
      }
      
      public function get signal_click() : Signal
      {
         return clickController.onClick;
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
      
      private function handler_goldUpdate() : void
      {
         invalidate("data");
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         if(this.artifactVO)
         {
            _loc2_.addButtonWithKey(TutorialNavigator.TITAN_ARTIFACT,this,this.artifactVO.titan.titan);
         }
         return _loc2_;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.artifact_graphics.create(TitanArtifactListRendererClip,"artifact_list_item");
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
