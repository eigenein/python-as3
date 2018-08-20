package game.view.popup.artifactinfo
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.artifactstore.ArtifactFragmentItemRenderer;
   
   public class ArtifactInfoPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var artifact_renderer:ArtifactFragmentItemRenderer;
      
      public var tf_name:ClipLabel;
      
      public var tf_desc:ClipLabel;
      
      public var tf_expedition:ClipLabel;
      
      public var tf_chest:ClipLabel;
      
      public var tf_store:ClipLabel;
      
      public var btn_expedition:ClipButtonLabeled;
      
      public var btn_chest:ClipButtonLabeled;
      
      public var btn_store:ClipButtonLabeled;
      
      public function ArtifactInfoPopupClip()
      {
         button_close = new ClipButton();
         artifact_renderer = new ArtifactFragmentItemRenderer();
         tf_name = new ClipLabel();
         tf_desc = new ClipLabel();
         tf_expedition = new ClipLabel();
         tf_chest = new ClipLabel();
         tf_store = new ClipLabel();
         btn_expedition = new ClipButtonLabeled();
         btn_chest = new ClipButtonLabeled();
         btn_store = new ClipButtonLabeled();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         artifact_renderer.graphics.touchable = false;
      }
   }
}
