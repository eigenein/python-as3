package game.view.gui.worldmap
{
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipFactory;
   import engine.core.clipgui.INeedNestedParsing;
   import starling.display.DisplayObjectContainer;
   
   public class WorldMapRegionGuiClipFactory extends GuiClipFactory
   {
       
      
      private const NAMETEMPLATE_BUTTON_MAJOR:String = "major";
      
      private const NAMETEMPLATE_BUTTON_MINOR:String = "minor";
      
      private var _asset:WorldMapGuiClip;
      
      public function WorldMapRegionGuiClipFactory()
      {
         super();
         _createUnimplementedChildren = false;
      }
      
      override protected function childNotImplemented(param1:INeedNestedParsing, param2:Node) : void
      {
         var _loc5_:* = null;
         _loc5_ = null;
         var _loc3_:DisplayObjectContainer = param1.container;
         var _loc4_:Array = param2.state.name.split("_");
         if(_loc4_[0] == "major")
         {
            _loc5_ = new WorldMapRegionButtonMarker();
            _loc5_.index = _loc4_[1];
            applyChildNode(_loc3_,_loc5_,param2,WorldMapRegionButtonMarker);
            _asset.major_marker_list.push(_loc5_);
         }
         else if(_loc4_[0] == "minor")
         {
            _loc5_ = new WorldMapRegionButtonMarker();
            _loc5_.index = _loc4_[1];
            applyChildNode(_loc3_,_loc5_,param2,WorldMapRegionButtonMarker);
            _asset.minor_marker_list.push(_loc5_);
         }
         else
         {
            super.childNotImplemented(param1,param2);
         }
      }
      
      public function createWorldMap(param1:WorldMapGuiClip, param2:Clip) : void
      {
         _asset = param1;
         create(param1,param2);
         _asset = null;
      }
   }
}
