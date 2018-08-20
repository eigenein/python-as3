package game.view.gui.components
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.IGuiClip;
   import game.assets.storage.AssetStorage;
   import game.data.storage.DataStorage;
   import game.data.storage.playeravatar.PlayerAvatarDescription;
   import game.view.popup.clan.editicon.RoundImage;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import starling.textures.Texture;
   
   public class AvatarDescRenderer extends Sprite implements IGuiClip
   {
       
      
      private var image_bg:RoundImage;
      
      private var image:RoundImage;
      
      private var _scaleX:Number = 1;
      
      private var _direction:int = 1;
      
      private var _data:PlayerAvatarDescription;
      
      public function AvatarDescRenderer()
      {
         super();
         image_bg = new RoundImage(AssetStorage.rsx.popup_theme.missing_texture);
         addChild(image_bg);
         image = new RoundImage(AssetStorage.rsx.popup_theme.missing_texture);
         addChild(image);
      }
      
      public function get graphics() : DisplayObject
      {
         return this;
      }
      
      public function set direction(param1:int) : void
      {
         _direction = param1;
         updateDirection();
      }
      
      public function get data() : PlayerAvatarDescription
      {
         return _data;
      }
      
      public function set data(param1:PlayerAvatarDescription) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         _data = param1;
         if(!param1)
         {
            image.texture = DataStorage.playerAvatar.getTexture(null);
            direction = 1;
         }
         else
         {
            _loc2_ = DataStorage.playerAvatar.getTextureBackground(param1);
            if(_loc2_)
            {
               image_bg.texture = _loc2_;
            }
            _loc3_ = DataStorage.playerAvatar.getTexture(param1);
            if(_loc3_)
            {
               image.texture = _loc3_;
            }
            updateDirection();
         }
      }
      
      public function set texture(param1:Texture) : void
      {
         image.texture = param1;
      }
      
      public function setNode(param1:Node) : void
      {
         x = param1.state.matrix.tx;
         y = param1.state.matrix.ty;
         scaleX = param1.state.matrix.a;
         scaleY = param1.state.matrix.d;
         var _loc2_:Number = param1.clip.bounds.width;
         var _loc3_:Number = param1.clip.bounds.width;
         var _loc4_:* = _loc2_;
         image_bg.width = _loc4_;
         image.width = _loc4_;
         _loc4_ = _loc3_;
         image_bg.height = _loc4_;
         image.height = _loc4_;
         _scaleX = image.scaleX;
      }
      
      protected function updateDirection() : void
      {
         var _loc1_:int = _direction;
         if(_data)
         {
            if(_data.assetType == "hero" && !DataStorage.hero.isPlayableHeroId(int(_data.assetOwnerId)))
            {
               _loc1_ = -_direction;
            }
            else
            {
               _loc1_ = _direction;
            }
         }
         image_bg.scaleX = _scaleX * _loc1_;
         image_bg.x = (1 - _loc1_) * image_bg.width * 0.5;
         image.scaleX = _scaleX * _loc1_;
         image.x = (1 - _loc1_) * image.width * 0.5;
      }
   }
}
