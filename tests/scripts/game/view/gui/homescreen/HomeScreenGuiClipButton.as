package game.view.gui.homescreen
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipLabel;
   import engine.core.clipgui.GuiClipScale3Image;
   import engine.core.clipgui.GuiMarker;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.RedMarkerState;
   import game.view.gui.components.ClipButton;
   import game.view.popup.theme.LabelStyle;
   import starling.display.Image;
   
   public class HomeScreenGuiClipButton extends ClipButton
   {
       
      
      protected var _redMarkerState:RedMarkerState;
      
      protected var _label:String;
      
      public var red_dot:GuiMarker;
      
      public var icon:ClipSprite;
      
      public var guiClipLabel:GuiClipLabel;
      
      public var labelBackground:GuiClipScale3Image;
      
      public function HomeScreenGuiClipButton()
      {
         super();
         createLabel();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         if(red_dot)
         {
            red_dot.container.addChild(new Image(AssetStorage.rsx.popup_theme.getTexture("NewIcon")));
         }
      }
      
      override protected function handler_disposed() : void
      {
         super.handler_disposed();
         if(_redMarkerState != null)
         {
            _redMarkerState.signal_update.remove(handler_markerStateUpdate);
         }
      }
      
      override public function set isEnabled(param1:Boolean) : void
      {
         .super.isEnabled = param1;
         labelBackground.graphics.visible = param1;
         guiClipLabel.graphics.visible = param1;
      }
      
      public function get redMarkerState() : RedMarkerState
      {
         return _redMarkerState;
      }
      
      public function set redMarkerState(param1:RedMarkerState) : void
      {
         _redMarkerState = param1;
         _redMarkerState.signal_update.add(handler_markerStateUpdate);
         handler_markerStateUpdate();
      }
      
      protected function handler_markerStateUpdate() : void
      {
         var _loc1_:int = 1;
         if(red_dot != null)
         {
            red_dot.container.visible = _redMarkerState.value;
         }
      }
      
      public function get label() : String
      {
         return _label;
      }
      
      public function set label(param1:String) : void
      {
         if(_label == param1)
         {
            return;
         }
         _label = param1;
         guiClipLabel.text = param1;
      }
      
      protected function createLabel() : void
      {
         guiClipLabel = new GuiClipLabel(LabelStyle.buttonLabel_size16_white);
      }
   }
}
