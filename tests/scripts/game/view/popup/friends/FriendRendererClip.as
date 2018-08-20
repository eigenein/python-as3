package game.view.popup.friends
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.friends.FriendDataProvider;
   import game.view.gui.components.CacheImage;
   import game.view.gui.components.CacheImageProxy;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.arena.PlayerPortraitClip;
   
   public class FriendRendererClip extends GuiClipNestedContainer
   {
       
      
      public var portrait:PlayerPortraitClip;
      
      public var tf_name:ClipLabel;
      
      private var _data:FriendDataProvider;
      
      public function FriendRendererClip()
      {
         tf_name = new ClipLabel();
         super();
      }
      
      public function get friendDataProvider() : FriendDataProvider
      {
         return _data;
      }
      
      public function set friendDataProvider(param1:FriendDataProvider) : void
      {
         this._data = param1;
         graphics.visible = param1;
         if(param1)
         {
            portrait.setFrameAndLevel(_data.userInfo);
            tf_name.text = param1.name;
            if(param1.photo)
            {
               CacheImageProxy.instance.addImage(param1.photo,null,handler_avatarComplete,false);
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
      
      private function handler_avatarComplete(param1:CacheImage) : void
      {
         portrait.portrait.texture = param1.image.texture;
      }
   }
}
