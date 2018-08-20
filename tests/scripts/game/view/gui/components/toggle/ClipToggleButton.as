package game.view.gui.components.toggle
{
   import com.progrestar.framework.ares.core.Node;
   import game.view.gui.components.ClipButton;
   import idv.cjcat.signals.Signal;
   
   public class ClipToggleButton extends ClipButton implements IToggleElement
   {
       
      
      protected var _signal_updateSelectedState:Signal;
      
      protected var _signal_updateToggleState:Signal;
      
      protected var _isSelected:Boolean;
      
      public function ClipToggleButton()
      {
         _signal_updateSelectedState = new Signal(ClipToggleButton);
         _signal_updateToggleState = new Signal(IToggleElement);
         super();
         _signal_updateSelectedState = new Signal(ClipToggleButton);
      }
      
      public function get signal_updateSelectedState() : Signal
      {
         return _signal_updateSelectedState;
      }
      
      public function get signal_updateToggleState() : Signal
      {
         return _signal_updateToggleState;
      }
      
      public function get isSelected() : Boolean
      {
         return _isSelected;
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         if(_isSelected == param1)
         {
            return;
         }
         _isSelected = param1;
         updateViewState();
         _signal_updateSelectedState.dispatch(this);
         _signal_updateToggleState.dispatch(this);
      }
      
      public function setIsSelectedSilently(param1:Boolean) : void
      {
         if(_isSelected == param1)
         {
            return;
         }
         _isSelected = param1;
         updateViewState();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         updateViewState();
      }
      
      override public function click() : void
      {
         isSelected = !_isSelected;
         super.click();
      }
      
      protected function updateViewState() : void
      {
      }
   }
}
