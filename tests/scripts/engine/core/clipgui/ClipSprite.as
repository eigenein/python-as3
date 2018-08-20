package engine.core.clipgui
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.animation.Animation;
   import engine.core.utils.AbstractMethodError;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   
   public class ClipSprite implements IGuiClip
   {
       
      
      protected const animation:Animation = new Animation(null);
      
      public function ClipSprite()
      {
         super();
      }
      
      public function get graphics() : DisplayObject
      {
         return animation.graphics;
      }
      
      public function get container() : DisplayObjectContainer
      {
         new AbstractMethodError();
         return animation.graphics;
      }
      
      public function setNode(param1:Node) : void
      {
         animation.setClip(param1.clip,param1.state.matrix);
         animation.state.copyFrom(param1.state);
         animation.advanceTime(0);
         animation.graphics.transformationMatrix = param1.state.matrix;
      }
      
      public function setFrame(param1:int) : void
      {
         animation.setFrame(param1);
      }
   }
}
