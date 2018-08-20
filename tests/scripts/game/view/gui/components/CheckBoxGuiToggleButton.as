package game.view.gui.components
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import game.view.gui.components.toggle.ClipToggleButton;
   
   public class CheckBoxGuiToggleButton extends ClipToggleButton
   {
       
      
      public var toggle_on:ClipSprite;
      
      public var toggle_off:ClipSprite;
      
      public function CheckBoxGuiToggleButton()
      {
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
