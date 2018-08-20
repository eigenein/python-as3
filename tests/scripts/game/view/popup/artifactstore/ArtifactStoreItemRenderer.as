package game.view.popup.artifactstore
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.data.storage.artifact.ArtifactDescription;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.popup.refillable.CostButton;
   
   public class ArtifactStoreItemRenderer extends GuiClipNestedContainer
   {
       
      
      private var artifact:ArtifactDescription;
      
      public var mediator:ArtifactStorePopupMediator;
      
      public var artifact_renderer:ArtifactFragmentItemRenderer;
      
      public var tf_amount:SpecialClipLabel;
      
      public var tf_title:ClipLabel;
      
      public var tf_type:ClipLabel;
      
      public var layout_container:ClipLayout;
      
      public var btn_buy:CostButton;
      
      public function ArtifactStoreItemRenderer()
      {
         artifact_renderer = new ArtifactFragmentItemRenderer();
         tf_amount = new SpecialClipLabel();
         tf_title = new ClipLabel();
         tf_type = new ClipLabel();
         layout_container = ClipLayout.verticalMiddleCenter(5,tf_title,tf_type);
         btn_buy = new CostButton();
         super();
      }
      
      public function dispose() : void
      {
         btn_buy.signal_click.remove(handler_buyButtonClick);
         artifact_renderer.signal_click.remove(handler_artifactClick);
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         btn_buy.signal_click.add(handler_buyButtonClick);
         artifact_renderer.signal_click.add(handler_artifactClick);
      }
      
      public function setData(param1:ArtifactDescription) : void
      {
         artifact = param1;
         update();
      }
      
      private function update() : void
      {
         if(artifact)
         {
            artifact_renderer.setData(artifact);
            tf_amount.text = mediator.getAmountText(artifact);
            tf_title.text = artifact.name + " " + Translate.translate("LIB_INVENTORYITEM_TYPE_FRAGMENT");
            tf_type.text = "(" + Translate.translate("LIB_ARTIFACT_TYPE_" + artifact.artifactType.toUpperCase()).toLowerCase() + ")";
            btn_buy.cost = artifact.fragmentBuyCost.outputDisplayFirst;
         }
      }
      
      private function handler_buyButtonClick() : void
      {
         if(artifact)
         {
            mediator.action_buy(artifact);
         }
      }
      
      private function handler_artifactClick() : void
      {
         if(artifact)
         {
            mediator.action_navigate_artifacts(artifact);
         }
      }
   }
}
