package game.view.popup.settings
{
   import com.progrestar.framework.ares.core.Node;
   import game.battle.gui.BattleGuiToggleButton;
   import game.mediator.gui.popup.settings.SettingToggleButtonMediator;
   import game.view.gui.components.ClipLayout;
   
   public class SettingToggleButton extends BattleGuiToggleButton
   {
       
      
      private var _mediator:SettingToggleButtonMediator;
      
      public var layout_text:ClipLayout;
      
      public function SettingToggleButton()
      {
         layout_text = ClipLayout.verticalMiddleLeft(0);
         super();
      }
      
      public function set mediator(param1:SettingToggleButtonMediator) : void
      {
         if(_mediator)
         {
            _mediator.signal_changed.remove(handler_updated);
         }
         _mediator = param1;
         _isSelected = param1.isEnabled;
         updateViewState();
         _mediator.signal_changed.add(handler_updated);
      }
      
      override public function set isSelected(param1:Boolean) : void
      {
         if(_mediator)
         {
            _mediator.isEnabled = param1;
         }
         else
         {
            .super.isSelected = param1;
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         if(_mediator)
         {
            setIsSelectedSilently(_mediator.isEnabled);
            if(label)
            {
               label.text = _mediator.label;
            }
         }
         if(layout_text && label)
         {
            layout_text.addChild(label);
         }
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
         if(label && _mediator)
         {
            label.text = _mediator.label;
         }
      }
      
      private function handler_updated(param1:Boolean) : void
      {
         .super.isSelected = param1;
      }
   }
}
