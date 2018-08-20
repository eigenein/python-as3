package game.view.popup.tower
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   
   public class TowerChestPanelCritModClip extends GuiClipNestedContainer
   {
       
      
      public var tf_crit_label:ClipLabel;
      
      public var tf_crit_value:ClipLabel;
      
      public function TowerChestPanelCritModClip()
      {
         tf_crit_label = new ClipLabel();
         tf_crit_value = new ClipLabel();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_crit_label.text = Translate.translate("UI_DIALOG_ALCHEMY_CRIT");
      }
   }
}
