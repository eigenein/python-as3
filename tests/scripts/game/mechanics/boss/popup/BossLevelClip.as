package game.mechanics.boss.popup
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   
   public class BossLevelClip extends GuiClipNestedContainer
   {
       
      
      public var tf:ClipLabel;
      
      public function BossLevelClip()
      {
         tf = new ClipLabel();
         super();
      }
   }
}
