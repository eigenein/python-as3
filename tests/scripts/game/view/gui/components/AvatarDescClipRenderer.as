package game.view.gui.components
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.assets.file.AssetFile;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipRoundImage;
   import game.data.storage.DataStorage;
   import game.data.storage.playeravatar.PlayerAvatarDescription;
   import game.model.GameModel;
   import game.model.user.friends.PlayerFriendEntry;
   import starling.textures.Texture;
   
   public class AvatarDescClipRenderer extends GuiClipNestedContainer
   {
       
      
      private var _socialImagePath:String;
      
      public var portrait:GuiClipRoundImage;
      
      public var image_bg:GuiClipRoundImage;
      
      public var frame:GuiClipImage;
      
      private var _data:PlayerAvatarDescription;
      
      public function AvatarDescClipRenderer()
      {
         portrait = new GuiClipRoundImage();
         image_bg = new GuiClipRoundImage();
         frame = new GuiClipImage();
         super();
      }
      
      public function get data() : PlayerAvatarDescription
      {
         return _data;
      }
      
      public function set data(param1:PlayerAvatarDescription) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(_data == param1)
         {
            return;
         }
         _data = param1;
         _socialImagePath = null;
         if(!param1)
         {
            portrait.image.texture = DataStorage.playerAvatar.getTexture(null);
         }
         else if(param1.assetType == "external_file")
         {
            _loc2_ = GameModel.instance.context.assetIndex.getAssetFile(param1.assetOwnerId);
            if(_loc2_)
            {
               fileAvatarData = _loc2_.url;
            }
            else
            {
               portrait.image.texture = DataStorage.playerAvatar.getTexture(null);
            }
         }
         else
         {
            _loc3_ = DataStorage.playerAvatar.getTextureBackground(param1);
            if(_loc3_)
            {
               image_bg.image.texture = _loc3_;
            }
            _loc4_ = DataStorage.playerAvatar.getTexture(param1);
            portrait.image.texture = _loc4_;
         }
      }
      
      public function set socialAvatarData(param1:PlayerFriendEntry) : void
      {
         _data = null;
         _socialImagePath = param1.photoURL;
         portrait.image.texture = DataStorage.playerAvatar.getTexture(null);
         CacheImageProxy.instance.addImage(_socialImagePath,null,handler_avatarComplete,false);
      }
      
      public function set fileAvatarData(param1:String) : void
      {
         _data = null;
         _socialImagePath = param1;
         portrait.image.texture = DataStorage.playerAvatar.getTexture(null);
         CacheImageProxy.instance.addImage(_socialImagePath,null,handler_avatarComplete,false);
      }
      
      override public function setNode(param1:Node) : void
      {
         portrait.image.texture = DataStorage.playerAvatar.getTexture(null);
         super.setNode(param1);
      }
      
      private function handler_avatarComplete(param1:CacheImage) : void
      {
         if(_socialImagePath == param1.path)
         {
            portrait.image.texture = param1.image.texture;
         }
      }
   }
}
