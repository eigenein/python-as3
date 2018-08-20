package game.view.gui.worldmap
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipContainer;
   import game.assets.storage.AssetStorage;
   import starling.filters.ColorMatrixFilter;
   
   public class WorldMapButtonMajor extends WorldMapMissionButton
   {
       
      
      public var tooltip:WorldMapMissionTooltip;
      
      private var markerIcon:ClipSprite;
      
      public var base:ClipSprite;
      
      public var gui_marker_container:GuiClipContainer;
      
      public function WorldMapButtonMajor()
      {
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
      }
      
      override protected function createSelectedAnimation() : void
      {
         selection_anim = AssetStorage.rsx.world_map.create_super_arrow_big();
      }
      
      override public function get tutorialButtonOffsetY() : Number
      {
         return -80;
      }
      
      override public function get tutorialButtonRadius() : Number
      {
         return 130;
      }
      
      override protected function updateState() : void
      {
         super.updateState();
         tooltip.setData(_data);
         if(markerIcon)
         {
            gui_marker_container.container.removeChild(markerIcon.graphics);
         }
         markerIcon = AssetStorage.rsx.world_map.create_mission_marker_sprite(_data.marker_name);
         gui_marker_container.container.addChild(markerIcon.graphics);
         if(data.marker_name.toLowerCase().indexOf("boss") != -1)
         {
            tooltip.graphics.y = -gui_marker_container.graphics.height + 60;
         }
         else
         {
            tooltip.graphics.y = -60;
         }
         if(_data.available)
         {
            if(_data.completed)
            {
            }
         }
         if(!isEnabled)
         {
            markerIcon.graphics.filter = filter_grayscale();
         }
         else if(markerIcon.graphics.filter != null)
         {
            markerIcon.graphics.filter.dispose();
            markerIcon.graphics.filter = null;
         }
      }
      
      override protected function updateStarCount() : void
      {
         tooltip.updateStarCount(_data);
      }
      
      private function filter_grayscale() : ColorMatrixFilter
      {
         var _loc1_:ColorMatrixFilter = new ColorMatrixFilter();
         _loc1_.color(3616549,0.8);
         _loc1_.adjustSaturation(-0.2);
         return _loc1_;
      }
   }
}
