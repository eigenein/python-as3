package game.view.popup.artifactinfo
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   
   public class ArtifactRecipeItemInfoPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var item_renderer:ArtifactRecipeItemRenderer;
      
      public var tf_name:ClipLabel;
      
      public var tf_desc:ClipLabel;
      
      public var tf_expedition:ClipLabel;
      
      public var tf_chest:ClipLabel;
      
      public var btn_expedition:ClipButtonLabeled;
      
      public var btn_chest:ClipButtonLabeled;
      
      public function ArtifactRecipeItemInfoPopupClip()
      {
         button_close = new ClipButton();
         item_renderer = new ArtifactRecipeItemRenderer();
         tf_name = new ClipLabel();
         tf_desc = new ClipLabel();
         tf_expedition = new ClipLabel();
         tf_chest = new ClipLabel();
         btn_expedition = new ClipButtonLabeled();
         btn_chest = new ClipButtonLabeled();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         item_renderer.graphics.touchable = false;
      }
   }
}
