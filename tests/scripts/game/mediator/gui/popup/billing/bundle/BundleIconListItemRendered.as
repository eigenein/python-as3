package game.mediator.gui.popup.billing.bundle
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.utils.VectorUtil;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.AssetStorageUtil;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.resource.InventoryItemDescription;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.specialoffer.InventoryItemSortOrder;
   import game.view.gui.components.list.ListItemRenderer;
   import starling.display.DisplayObjectContainer;
   import starling.display.Image;
   import starling.textures.Texture;
   
   public class BundleIconListItemRendered extends ListItemRenderer
   {
      
      private static const SORTER:InventoryItemSortOrder = new InventoryItemSortOrder(["lootBox","stamina","artifactExperience33","artifactExperience32","artifactExperience31","artifactExperience30","artifactExperience29","artifactExperience38","artifactExperience37","artifactExperience36","artifactExperience35","artifactExperience34","artifactExperience43","artifactExperience42","artifactExperience41","artifactExperience40","artifactExperience39","titanExperience","enchantValue","heroExperience","starmoney","coin","gold"]);
       
      
      private var clip:BundleIconListItemClip;
      
      public function BundleIconListItemRendered()
      {
         super();
      }
      
      override public function set isSelected(param1:Boolean) : void
      {
         .super.isSelected = param1;
         setSelected();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(BundleIconListItemClip,"bundle_list_icon");
         clip.signal_click.add(handler_click);
         addChild(clip.graphics);
         width = clip.image_frame.graphics.width;
         height = clip.image_frame.graphics.height;
         setSelected();
      }
      
      override protected function commitData() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function setItems(param1:Vector.<InventoryItem>) : void
      {
         var _loc7_:int = 0;
         var _loc10_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc8_:* = null;
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc9_:int = Math.min(param1.length,clip.items.item.length);
         _loc7_ = 0;
         while(_loc7_ < _loc9_)
         {
            _loc10_ = param1[_loc7_].item;
            _loc3_ = clip.items.item[_loc7_].layout.container;
            _loc4_ = AssetStorageUtil.getItemGUIIcon(_loc10_);
            if(_loc4_ == AssetStorage.rsx.popup_theme.missing_texture)
            {
               _loc6_ = _loc10_.type.type + _loc10_.id;
               _loc8_ = "icon_" + _loc6_;
               if(AssetStorage.rsx.popup_theme.data.getClipByName(_loc8_) != null)
               {
                  _loc5_ = AssetStorage.rsx.popup_theme.create(ClipSprite,_loc8_);
                  _loc3_.addChild(_loc5_.graphics);
               }
            }
            else
            {
               _loc2_ = new Image(_loc4_);
               _loc3_.addChild(_loc2_);
            }
            _loc7_++;
         }
      }
      
      protected function setSelected() : void
      {
         if(!clip)
         {
            return;
         }
         clip.selection.graphics.visible = _isSelected;
         clip.graphics.touchable = !_isSelected;
      }
      
      private function handler_click() : void
      {
         .super.isSelected = true;
      }
   }
}
