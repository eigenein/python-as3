package game.mechanics.dungeon.popup.floor
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.view.gui.components.ClipLabel;
   
   public class DungeonFloorClipBase extends GuiClipNestedContainer
   {
       
      
      public var frame:GuiClipNestedContainer;
      
      public var floor_number:ClipLabel;
      
      public var bridge:GuiAnimation;
      
      public function DungeonFloorClipBase()
      {
         frame = new GuiClipNestedContainer();
         floor_number = new ClipLabel();
         super();
      }
      
      public function dispose() : void
      {
         graphics.dispose();
         if(bridge)
         {
            bridge.dispose();
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         frame.graphics.touchable = false;
      }
      
      public function action_playBridgeAnimation(param1:Boolean) : void
      {
         if(!bridge)
         {
            bridge = AssetStorage.rsx.dungeon_floors.create(GuiAnimation,"bridge_clip");
            container.addChild(bridge.graphics);
         }
         if(param1)
         {
            bridge.graphics.x = 1019;
            bridge.graphics.y = 306;
         }
         else
         {
            bridge.graphics.x = -289;
            bridge.graphics.y = 306;
         }
         bridge.gotoAndPlay(0);
         bridge.stopOnFrame(69);
      }
   }
}
