package game.view.popup.fightresult
{
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   
   public class RewardDialogRibbonHeader extends GuiClipNestedContainer
   {
       
      
      public var tf_header:ClipLabel;
      
      public var animation_EpicRays_inst0:GuiAnimation;
      
      public var rays_inst0:GuiAnimation;
      
      public function RewardDialogRibbonHeader()
      {
         tf_header = new ClipLabel();
         animation_EpicRays_inst0 = new GuiAnimation();
         rays_inst0 = new GuiAnimation();
         super();
      }
   }
}
