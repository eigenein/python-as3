package game.view.gui.components
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import idv.cjcat.signals.Signal;
   
   public class ClipNumericStepper extends GuiClipNestedContainer
   {
       
      
      public var tf_value:ClipLabel;
      
      public var button_minus:ClipButton;
      
      public var button_plus:ClipButton;
      
      private var _signal_change:Signal;
      
      private var _minValue:int;
      
      private var _maxValue:int;
      
      private var _value:int;
      
      private var _step:int;
      
      public function ClipNumericStepper()
      {
         tf_value = new ClipLabel();
         button_minus = new ClipButton();
         button_plus = new ClipButton();
         _signal_change = new Signal();
         super();
      }
      
      public function get signal_change() : Signal
      {
         return _signal_change;
      }
      
      public function get minValue() : int
      {
         return _minValue;
      }
      
      public function set minValue(param1:int) : void
      {
         if(_minValue == param1)
         {
            return;
         }
         _minValue = param1;
         update();
      }
      
      public function get maxValue() : int
      {
         return _maxValue;
      }
      
      public function set maxValue(param1:int) : void
      {
         if(_maxValue == param1)
         {
            return;
         }
         _maxValue = param1;
         if(_value > _maxValue)
         {
            _value = _maxValue;
         }
         update();
      }
      
      public function get value() : int
      {
         return _value;
      }
      
      public function set value(param1:int) : void
      {
         if(_value == param1)
         {
            return;
         }
         _value = param1;
         update();
      }
      
      public function get step() : int
      {
         return _step;
      }
      
      public function set step(param1:int) : void
      {
         if(_step == param1)
         {
            return;
         }
         _step = param1;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         button_minus.signal_click.add(action_minus);
         button_plus.signal_click.add(action_plus);
      }
      
      public function action_minus() : void
      {
         var _loc1_:int = _value;
         if(_value > _minValue)
         {
            _value = _value - _step;
         }
         if(_value < _minValue)
         {
            _value = _minValue;
         }
         if(_value != _loc1_)
         {
            update();
         }
      }
      
      public function action_plus() : void
      {
         var _loc1_:int = _value;
         if(_value < _maxValue)
         {
            _value = _value + _step;
         }
         if(_value > _maxValue)
         {
            _value = _maxValue;
         }
         if(_value != _loc1_)
         {
            update();
         }
      }
      
      private function update() : void
      {
         tf_value.text = _value.toString();
         button_minus.isEnabled = _value > _minValue;
         button_minus.graphics.alpha = !!button_minus.isEnabled?1:0.5;
         button_plus.isEnabled = _value < _maxValue;
         button_plus.graphics.alpha = !!button_plus.isEnabled?1:0.5;
         _signal_change.dispatch();
      }
   }
}
