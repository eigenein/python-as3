package game.view.gui.components
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import game.view.gui.components.toggle.ClipToggleButton;
   
   public class CheckBoxLabeledGuiToggleButton extends ClipToggleButton
   {
       
      
      public var toggle_on:ClipSprite;
      
      public var toggle_off:ClipSprite;
      
      public var label:ClipLabel;
      
      public function CheckBoxLabeledGuiToggleButton()
      {
         label = new ClipLabel(true);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
      }
      
      override protected function updateViewState() : void
      {
         super.updateViewState();
         if(toggle_on)
         {
            toggle_on.graphics.visible = _isSelected;
         }
         if(toggle_off)
         {
            toggle_off.graphics.visible = !_isSelected;
         }
      }
   }
}
