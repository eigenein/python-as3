package engine.core.clipgui
{
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.Node;
   import com.progrestar.framework.ares.core.State;
   import com.progrestar.framework.ares.starling.StarlingClipNode;
   import flash.geom.Rectangle;
   import starling.display.Sprite;
   
   public class GuiMarker extends GuiClipContainer
   {
       
      
      private var node:Node;
      
      public function GuiMarker()
      {
         super();
      }
      
      public function get name() : String
      {
         return node.clip.className;
      }
      
      public function get bounds() : Rectangle
      {
         return node.clip.bounds;
      }
      
      public function get clip() : Clip
      {
         return node.clip;
      }
      
      public function get state() : State
      {
         return node.state;
      }
      
      override public function setNode(param1:Node) : void
      {
         _container = new Sprite();
         this.node = param1;
         StarlingClipNode.applyState(graphics,param1.state);
      }
   }
}
