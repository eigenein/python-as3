package game.view.popup.artifactchest.leveluprewardpopup
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class ArtifactChestLevelUpRewardKeyContentCip extends GuiClipNestedContainer
   {
       
      
      public var tf_key:ClipLabel;
      
      public var tf_key_desc:ClipLabel;
      
      public var key_layout_group:ClipLayout;
      
      public function ArtifactChestLevelUpRewardKeyContentCip()
      {
         tf_key = new ClipLabel();
         tf_key_desc = new ClipLabel();
         key_layout_group = ClipLayout.verticalMiddleCenter(5,tf_key,tf_key_desc);
         super();
      }
   }
}
