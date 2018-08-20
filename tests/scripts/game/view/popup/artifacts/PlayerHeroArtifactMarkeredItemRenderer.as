package game.view.popup.artifacts
{
   import engine.core.clipgui.GuiClipImage;
   
   public class PlayerHeroArtifactMarkeredItemRenderer extends PlayerHeroArtifactItemRenderer
   {
       
      
      public var icon_red_dot:GuiClipImage;
      
      public function PlayerHeroArtifactMarkeredItemRenderer()
      {
         icon_red_dot = new GuiClipImage();
         super();
      }
      
      override public function setData(param1:*) : void
      {
         super.setData(param1);
         updateRedDotState();
      }
      
      public function updateRedDotState() : void
      {
         icon_red_dot.graphics.visible = artifactVO.checkArtifactUpgradeAvaliable();
      }
   }
}
