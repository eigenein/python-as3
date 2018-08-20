package game.view.popup.tower.screen
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   
   public class TowerScreenProceedButton extends ClipButton
   {
       
      
      public var guiClipLabel:ClipLabel;
      
      public function TowerScreenProceedButton()
      {
         guiClipLabel = new ClipLabel();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         guiClipLabel.text = Translate.translate("UI_TOWER_PROCEED");
      }
   }
}
