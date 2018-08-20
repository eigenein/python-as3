package game.view.popup.player.server
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   
   public class ServerSelectPopupItemRendererClip extends GuiClipNestedContainer
   {
       
      
      public var tf_level:ClipLabel;
      
      public var tf_nickname:ClipLabel;
      
      public var tf_server_id:ClipLabel;
      
      public var tf_server_name:ClipLabel;
      
      public var tf_friend_count:ClipLabel;
      
      public var friend_list:ClipButton;
      
      public var bg:ServerSelectButtonClip;
      
      public function ServerSelectPopupItemRendererClip()
      {
         tf_level = new ClipLabel();
         tf_nickname = new ClipLabel();
         tf_server_id = new ClipLabel();
         tf_server_name = new ClipLabel();
         tf_friend_count = new ClipLabel();
         friend_list = new ClipButton();
         bg = new ServerSelectButtonClip();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         var _loc2_:* = false;
         tf_friend_count.touchable = _loc2_;
         _loc2_ = _loc2_;
         tf_level.touchable = _loc2_;
         _loc2_ = _loc2_;
         tf_nickname.touchable = _loc2_;
         _loc2_ = _loc2_;
         tf_server_id.touchable = _loc2_;
         tf_server_name.touchable = _loc2_;
      }
   }
}
