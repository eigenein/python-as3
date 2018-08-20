package game.view.popup.friends.referrer
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.friends.FriendDataProvider;
   import game.view.gui.components.CacheImage;
   import game.view.gui.components.CacheImageProxy;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.arena.PlayerPortraitClip;
   
   public class ReferrerPopupListItemRendererClip extends ClipButton
   {
       
      
      public var tf_name:ClipLabel;
      
      public var tf_nickname:ClipLabel;
      
      public var portrait:PlayerPortraitClip;
      
      public var bg:GuiClipScale9Image;
      
      protected var _data:FriendDataProvider;
      
      public function ReferrerPopupListItemRendererClip()
      {
         tf_name = new ClipLabel();
         tf_nickname = new ClipLabel();
         portrait = new PlayerPortraitClip();
         bg = new GuiClipScale9Image();
         super();
      }
      
      public function get data() : FriendDataProvider
      {
         return _data;
      }
      
      public function set data(param1:FriendDataProvider) : void
      {
         this._data = param1;
         graphics.visible = param1;
         if(param1)
         {
            tf_nickname.text = param1.player.nickname;
            tf_name.text = param1.name;
            portrait.setFrameAndLevel(data.userInfo);
            if(data.photo)
            {
               CacheImageProxy.instance.addImage(data.photo,null,handler_avatarComplete,false);
            }
            else
            {
               portrait.portrait.texture = DataStorage.playerAvatar.getTexture(null);
            }
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         portrait.portrait.texture = DataStorage.playerAvatar.getTexture(null);
      }
      
      protected function handler_avatarComplete(param1:CacheImage) : void
      {
         portrait.portrait.texture = param1.image.texture;
      }
   }
}
