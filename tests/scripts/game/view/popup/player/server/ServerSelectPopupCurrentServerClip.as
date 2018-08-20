package game.view.popup.player.server
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   
   public class ServerSelectPopupCurrentServerClip extends GuiClipNestedContainer
   {
       
      
      public var tf_level:ClipLabel;
      
      public var tf_nickname:ClipLabel;
      
      public var tf_server_id:ClipLabel;
      
      public var tf_server_name:ClipLabel;
      
      public function ServerSelectPopupCurrentServerClip()
      {
         tf_level = new ClipLabel();
         tf_nickname = new ClipLabel();
         tf_server_id = new ClipLabel();
         tf_server_name = new ClipLabel();
         super();
      }
   }
}
