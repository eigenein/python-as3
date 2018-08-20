package game.view.gui.overlay
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipImage;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.RedMarkerState;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLayout;
   
   public class RedDotLabeledClipButton extends ClipButtonLabeled
   {
       
      
      public var red_dot:GuiClipImage;
      
      public var layout_label:ClipLayout;
      
      protected var _redMarkerState:RedMarkerState;
      
      public function RedDotLabeledClipButton()
      {
         layout_label = ClipLayout.horizontalMiddleCentered(4);
         super();
      }
      
      override public function set label(param1:String) : void
      {
         guiClipLabel.text = param1;
         guiClipLabel.validate();
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
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         red_dot.image.texture = AssetStorage.rsx.popup_theme.getTexture("NewIcon");
         guiClipLabel.maxHeight = Infinity;
         layout_label.addChild(guiClipLabel);
      }
      
      protected function handler_markerStateUpdate() : void
      {
         var _loc1_:int = 1;
         if(red_dot && red_dot.graphics)
         {
            red_dot.graphics.visible = _redMarkerState.value;
         }
      }
   }
}
