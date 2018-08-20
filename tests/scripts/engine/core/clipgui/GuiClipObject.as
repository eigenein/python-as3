package engine.core.clipgui
{
   import com.progrestar.framework.ares.core.Node;
   import com.progrestar.framework.ares.core.State;
   import com.progrestar.framework.ares.starling.StarlingClipNode;
   import engine.core.utils.AbstractMethodError;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   
   public class GuiClipObject implements IGuiClip
   {
       
      
      public function GuiClipObject()
      {
         super();
      }
      
      public function get graphics() : DisplayObject
      {
         new AbstractMethodError();
         return null;
      }
      
      public function get container() : DisplayObjectContainer
      {
         new AbstractMethodError();
         return null;
      }
      
      public function setNode(param1:Node) : void
      {
         StarlingClipNode.applyState(graphics,param1.state);
      }
      
      protected function applyState(param1:DisplayObject, param2:State) : void
      {
      }
   }
}
