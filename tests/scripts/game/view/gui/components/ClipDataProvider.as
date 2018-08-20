package game.view.gui.components
{
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.Node;
   import com.progrestar.framework.ares.core.State;
   import engine.core.clipgui.GuiClipObject;
   import engine.core.clipgui.IGuiClip;
   import game.assets.storage.AssetStorage;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   
   public class ClipDataProvider extends GuiClipObject
   {
       
      
      private var _node:Node;
      
      public function ClipDataProvider()
      {
         super();
      }
      
      override public function get graphics() : DisplayObject
      {
         return null;
      }
      
      override public function get container() : DisplayObjectContainer
      {
         return null;
      }
      
      public function get clip() : Clip
      {
         return _node.clip;
      }
      
      public function get node() : Node
      {
         return _node;
      }
      
      public function get state() : State
      {
         return _node.state;
      }
      
      override public function setNode(param1:Node) : void
      {
         this._node = param1;
      }
      
      public function create(param1:IGuiClip) : void
      {
         AssetStorage.rsx.popup_theme.factory.create(param1,_node.clip);
      }
   }
}
