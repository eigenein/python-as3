package game.view.popup.tower
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   
   public class TowerTeamGatherPopupHeroRendererDeadLabelClip extends GuiClipNestedContainer
   {
       
      
      public var label:ClipLabel;
      
      public function TowerTeamGatherPopupHeroRendererDeadLabelClip()
      {
         label = new ClipLabel();
         super();
         label.text = Translate.translate("UI_TOWER_DEAD");
      }
      
      public function set visible(param1:Boolean) : void
      {
         graphics.visible = param1;
      }
   }
}
