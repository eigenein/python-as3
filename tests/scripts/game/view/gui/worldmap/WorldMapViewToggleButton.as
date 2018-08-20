package game.view.gui.worldmap
{
   import game.view.gui.components.GameLabel;
   import game.view.gui.components.toggle.ClipToggleButton;
   import game.view.popup.theme.LabelStyle;
   
   public class WorldMapViewToggleButton extends ClipToggleButton
   {
       
      
      private var labels:Vector.<GameLabel>;
      
      public var defaultSkin:WorldMapViewToggleButtonStateClip;
      
      public var selectedSkin:WorldMapViewToggleButtonStateClip;
      
      public function WorldMapViewToggleButton()
      {
         labels = new Vector.<GameLabel>();
         super();
         defaultSkin = new WorldMapViewToggleButtonStateClip(LabelStyle.label_size18_center);
         selectedSkin = new WorldMapViewToggleButtonStateClip(LabelStyle.buttonLabel_size18);
         updateViewState();
      }
      
      public function set label(param1:String) : void
      {
         defaultSkin.label.text = param1;
         selectedSkin.label.text = param1;
      }
      
      override protected function updateViewState() : void
      {
         super.updateViewState();
         defaultSkin.graphics.visible = !_isSelected;
         selectedSkin.graphics.visible = _isSelected;
      }
   }
}
