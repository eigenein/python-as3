package game.view.gui.worldmap
{
   import engine.core.clipgui.ClipSprite;
   import game.assets.storage.rsx.RsxGuiAsset;
   import starling.textures.Texture;
   
   public class WorldMapGUIAsset extends RsxGuiAsset
   {
      
      public static const IDENT:String = "world_map";
       
      
      public function WorldMapGUIAsset(param1:*)
      {
         super(param1);
      }
      
      public function get state_majorClosed() : Texture
      {
         return getTexture("MClosed");
      }
      
      public function get state_majorCompleted() : Texture
      {
         return getTexture("MCompleted");
      }
      
      public function get state_majorOpen() : Texture
      {
         return getTexture("MOpen");
      }
      
      public function get state_majorLava() : Texture
      {
         return getTexture("MLava");
      }
      
      public function get state_minorCompleted() : Texture
      {
         return getTexture("M2Completed");
      }
      
      public function get state_minorOpen() : Texture
      {
         return getTexture("M2Open");
      }
      
      public function get state_minorClosed() : Texture
      {
         return getTexture("M2Closed");
      }
      
      public function create_toggleButton() : WorldMapViewToggleButton
      {
         var _loc1_:WorldMapViewToggleButton = new WorldMapViewToggleButton();
         _factory.create(_loc1_,data.getClipByName("tabToggleButton"));
         return _loc1_;
      }
      
      public function create_tooltip_normal() : WorldMapMissionTooltip
      {
         var _loc1_:WorldMapMissionTooltip = new WorldMapMissionTooltip();
         _factory.create(_loc1_,data.getClipByName("mission_bubble"));
         return _loc1_;
      }
      
      public function create_button_minor() : WorldMapButtonMinor
      {
         var _loc1_:WorldMapButtonMinor = new WorldMapButtonMinor();
         _factory.create(_loc1_,data.getClipByName("mission_minor"));
         return _loc1_;
      }
      
      public function create_button_major() : WorldMapButtonMajor
      {
         var _loc1_:WorldMapButtonMajor = new WorldMapButtonMajor();
         _factory.create(_loc1_,data.getClipByName("mission_major"));
         return _loc1_;
      }
      
      public function create_mission_marker_sprite(param1:String) : ClipSprite
      {
         var _loc2_:ClipSprite = new ClipSprite();
         _factory.create(_loc2_,data.getClipByName(param1));
         return _loc2_;
      }
      
      public function create_map_background() : ClipSprite
      {
         var _loc1_:ClipSprite = new ClipSprite();
         _factory.create(_loc1_,data.getClipByName("MapTotalBG"));
         return _loc1_;
      }
      
      public function create_super_arrow() : WorldMapSelectionEffectAnimation
      {
         var _loc1_:WorldMapSelectionEffectAnimation = new WorldMapSelectionEffectAnimation();
         _factory.create(_loc1_,data.getClipByName("point_animation"));
         return _loc1_;
      }
      
      public function create_super_arrow_big() : WorldMapSelectionEffectAnimation
      {
         var _loc1_:WorldMapSelectionEffectAnimation = new WorldMapSelectionEffectAnimation();
         _factory.create(_loc1_,data.getClipByName("point_animation_big"));
         return _loc1_;
      }
   }
}
