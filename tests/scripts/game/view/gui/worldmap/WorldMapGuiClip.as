package game.view.gui.worldmap
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.view.gui.components.ClipLayoutNone;
   
   public class WorldMapGuiClip extends GuiClipNestedContainer
   {
       
      
      public var bitmap:ClipSprite;
      
      public var animation_fx_1:GuiAnimation;
      
      public var animation_fx_2:GuiAnimation;
      
      public var major_button_list:Vector.<WorldMapButtonMajor>;
      
      public var minor_button_list:Vector.<WorldMapButtonMinor>;
      
      public var parallel_button_list:Vector.<WorldMapButtonMinor>;
      
      public var major_marker_list:Vector.<WorldMapRegionButtonMarker>;
      
      public var minor_marker_list:Vector.<WorldMapRegionButtonMarker>;
      
      public var parallel_marker_list:Vector.<WorldMapRegionButtonMarker>;
      
      public var special_marker_list:Vector.<WorldMapRegionButtonMarker>;
      
      public var layout_special_offer:ClipLayoutNone;
      
      public function WorldMapGuiClip()
      {
         parallel_button_list = new Vector.<WorldMapButtonMinor>();
         major_marker_list = new Vector.<WorldMapRegionButtonMarker>();
         minor_marker_list = new Vector.<WorldMapRegionButtonMarker>();
         parallel_marker_list = new Vector.<WorldMapRegionButtonMarker>();
         special_marker_list = new Vector.<WorldMapRegionButtonMarker>();
         layout_special_offer = new ClipLayoutNone();
         super();
      }
      
      public function dispose() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function startAnimation() : void
      {
         if(animation_fx_1)
         {
            animation_fx_1.play();
         }
         if(animation_fx_2)
         {
            animation_fx_2.play();
         }
      }
      
      public function stopAnimation() : void
      {
         if(animation_fx_1)
         {
            animation_fx_1.stop();
         }
         if(animation_fx_2)
         {
            animation_fx_2.stop();
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         _loc4_ = null;
         super.setNode(param1);
         major_button_list = new Vector.<WorldMapButtonMajor>();
         minor_button_list = new Vector.<WorldMapButtonMinor>();
         parallel_button_list = new Vector.<WorldMapButtonMinor>();
         major_marker_list.sort(_sortMarkers);
         minor_marker_list.sort(_sortMarkers);
         minor_marker_list.sort(_sortMarkers);
         var _loc2_:int = major_marker_list.length;
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc5_ = major_marker_list[_loc6_];
            _loc3_ = AssetStorage.rsx.world_map.create_button_major();
            _loc3_.index = _loc5_.index;
            major_button_list.push(_loc3_);
            _loc5_.container.addChild(_loc3_.graphics);
            _loc6_++;
         }
         _loc2_ = minor_marker_list.length;
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc5_ = minor_marker_list[_loc6_];
            _loc4_ = AssetStorage.rsx.world_map.create_button_minor();
            _loc4_.index = _loc5_.index;
            minor_button_list.push(_loc4_);
            _loc5_.container.addChild(_loc4_.graphics);
            _loc6_++;
         }
         _loc2_ = parallel_marker_list.length;
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc5_ = parallel_marker_list[_loc6_];
            _loc4_ = AssetStorage.rsx.world_map.create_button_minor();
            _loc5_.index = _loc6_ + 1;
            _loc4_.index = _loc5_.index;
            parallel_button_list.push(_loc4_);
            _loc5_.container.addChild(_loc4_.graphics);
            _loc6_++;
         }
         if(animation_fx_1)
         {
            animation_fx_1.graphics.touchable = false;
         }
         if(animation_fx_2)
         {
            animation_fx_2.graphics.touchable = false;
         }
      }
      
      private function _sortMarkers(param1:WorldMapRegionButtonMarker, param2:WorldMapRegionButtonMarker) : int
      {
         return param1.index - param2.index;
      }
   }
}
