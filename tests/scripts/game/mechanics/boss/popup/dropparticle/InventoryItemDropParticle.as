package game.mechanics.boss.popup.dropparticle
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.IGuiClip;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.AssetStorageUtil;
   import game.data.storage.resource.InventoryItemDescription;
   import game.view.gui.components.InventoryItemIcon;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.textures.Texture;
   
   public class InventoryItemDropParticle implements IDropParticleView
   {
       
      
      public const graphics:Sprite = new Sprite();
      
      public function InventoryItemDropParticle(param1:InventoryItemDescription, param2:Number = 1)
      {
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc4_:* = null;
         var _loc8_:* = null;
         var _loc3_:* = null;
         super();
         graphics.touchable = false;
         var _loc5_:Texture = AssetStorageUtil.getItemGUIIcon(param1);
         if(_loc5_ == AssetStorage.rsx.popup_theme.missing_texture)
         {
            _loc6_ = param1.type.type + param1.id;
            _loc7_ = "icon_" + _loc6_;
            if(AssetStorage.rsx.popup_theme.data.getClipByName(_loc7_) != null)
            {
               _loc4_ = AssetStorage.rsx.popup_theme.create(ClipSprite,_loc7_);
               graphics.addChild(_loc4_.graphics);
            }
            else
            {
               _loc8_ = AssetStorage.rsx.popup_theme.create_inventory_item_icon();
               _loc8_.setItemDescription(param1);
               _loc4_ = _loc8_;
               graphics.addChild(_loc8_.graphics);
            }
            _loc4_.graphics.x = -_loc4_.graphics.width * 0.5 * param2;
            _loc4_.graphics.y = -_loc4_.graphics.height * 0.5 * param2;
            var _loc9_:* = param2;
            _loc4_.graphics.scaleY = _loc9_;
            _loc4_.graphics.scaleX = _loc9_;
         }
         else
         {
            _loc3_ = new Image(_loc5_);
            _loc3_.x = -_loc3_.width * 0.5 * param2;
            _loc3_.y = -_loc3_.height * 0.5 * param2;
            _loc9_ = param2;
            _loc3_.scaleY = _loc9_;
            _loc3_.scaleX = _loc9_;
            graphics.addChild(_loc3_);
         }
      }
      
      public function setParticlePosition(param1:Number, param2:Number) : void
      {
         graphics.x = param1;
         graphics.y = param2;
      }
      
      public function removeParticle() : void
      {
         graphics.removeFromParent(true);
         Starling.juggler.removeTweens(graphics);
      }
   }
}
