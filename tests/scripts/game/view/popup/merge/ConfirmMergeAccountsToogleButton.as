package game.view.popup.merge
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.toggle.ClipToggleButton;
   
   public class ConfirmMergeAccountsToogleButton extends ClipToggleButton
   {
       
      
      public var toggle_on:ClipSprite;
      
      public var toggle_off:ClipSprite;
      
      public var label:ClipLabel;
      
      public function ConfirmMergeAccountsToogleButton()
      {
         label = new ClipLabel(true);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
      }
      
      public function initialize(param1:String, param2:Function, param3:Boolean) : void
      {
         setIsSelectedSilently(param3);
         label.text = param1;
         signal_updateSelectedState.add(param2);
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
