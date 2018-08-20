package engine.core.clipgui
{
   import com.progrestar.framework.ares.core.Node;
   import starling.display.DisplayObject;
   
   public interface IGuiClip
   {
       
      
      function get graphics() : DisplayObject;
      
      function setNode(param1:Node) : void;
   }
}
