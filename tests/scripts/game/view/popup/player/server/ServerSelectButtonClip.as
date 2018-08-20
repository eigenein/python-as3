package game.view.popup.player.server
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   
   public class ServerSelectButtonClip extends ClipButton
   {
       
      
      public var bg_selected:ClipSprite;
      
      public var bg_hover:GuiClipScale9Image;
      
      public var bg_up:GuiClipScale9Image;
      
      public function ServerSelectButtonClip()
      {
         bg_selected = new ClipSprite();
         bg_hover = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         bg_up = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         super();
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         if(param1 == "hover")
         {
            bg_hover.graphics.visible = true;
            bg_up.graphics.visible = false;
         }
         else
         {
            bg_hover.graphics.visible = false;
            bg_up.graphics.visible = true;
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         bg_hover.graphics.visible = false;
         bg_up.graphics.visible = true;
      }
   }
}
