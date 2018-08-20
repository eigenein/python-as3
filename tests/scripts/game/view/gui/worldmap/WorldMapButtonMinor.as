package game.view.gui.worldmap
{
   import engine.core.clipgui.ClipSprite;
   import game.assets.storage.AssetStorage;
   
   public class WorldMapButtonMinor extends WorldMapMissionButton
   {
       
      
      private var bundle_clip:ClipSprite;
      
      public var M2Completed_inst0:ClipSprite;
      
      public var M2Locked_inst0:ClipSprite;
      
      public var M2Open_inst0:ClipSprite;
      
      public var star_1:ClipSprite;
      
      public var star_2:ClipSprite;
      
      public var star_3:ClipSprite;
      
      public var star_empty_1:ClipSprite;
      
      public var star_empty_2:ClipSprite;
      
      public var star_empty_3:ClipSprite;
      
      public function WorldMapButtonMinor()
      {
         M2Completed_inst0 = new ClipSprite();
         M2Locked_inst0 = new ClipSprite();
         M2Open_inst0 = new ClipSprite();
         star_1 = new ClipSprite();
         star_2 = new ClipSprite();
         star_3 = new ClipSprite();
         star_empty_1 = new ClipSprite();
         star_empty_2 = new ClipSprite();
         star_empty_3 = new ClipSprite();
         super();
      }
      
      override protected function updateStarCount() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 3;
         _loc2_ = 1;
         while(_loc2_ <= _loc1_)
         {
            (this["star_empty_" + _loc2_] as ClipSprite).graphics.visible = _data.stars < _loc2_;
            (this["star_" + _loc2_] as ClipSprite).graphics.visible = _data.stars >= _loc2_;
            _loc2_++;
         }
      }
      
      override protected function createSelectedAnimation() : void
      {
         selection_anim = AssetStorage.rsx.world_map.create_super_arrow();
      }
      
      override protected function updateState() : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         if(_data.bundle)
         {
            replaceSelectionAnim(AssetStorage.rsx.world_map.create_super_arrow_big());
            selection_anim = AssetStorage.rsx.world_map.create_super_arrow_big();
            bundle_clip = AssetStorage.rsx.world_map.create(ClipSprite,"special_offer_3_button");
            container.addChild(bundle_clip.graphics);
         }
         else if(bundle_clip)
         {
            replaceSelectionAnim(AssetStorage.rsx.world_map.create_super_arrow());
            container.removeChild(bundle_clip.graphics);
            bundle_clip = null;
         }
         super.updateState();
         if(_data.available)
         {
            _loc2_ = M2Completed_inst0;
         }
         else
         {
            _loc2_ = M2Locked_inst0;
         }
         updateStarCount();
         var _loc4_:Vector.<ClipSprite> = new <ClipSprite>[M2Completed_inst0,M2Locked_inst0,M2Open_inst0];
         var _loc1_:int = _loc4_.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_[_loc3_].graphics.visible = _loc4_[_loc3_] == _loc2_;
            _loc3_++;
         }
      }
      
      private function replaceSelectionAnim(param1:WorldMapSelectionEffectAnimation) : void
      {
         if(selection_anim)
         {
            selection_anim.hide();
            selection_anim = null;
         }
         selection_anim = param1;
      }
   }
}
