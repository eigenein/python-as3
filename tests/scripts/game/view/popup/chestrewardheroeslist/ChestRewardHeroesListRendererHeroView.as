package game.view.popup.chestrewardheroeslist
{
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.data.storage.chest.ChestRewardPresentationValueObject;
   import game.data.storage.hero.HeroDescription;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.chest.ChestRewardNewPlaque;
   import game.view.popup.hero.MiniHeroStarDisplay;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class ChestRewardHeroesListRendererHeroView extends GuiClipNestedContainer
   {
       
      
      public var item_icon:InventoryItemRenderer;
      
      public var starDisplay:MiniHeroStarDisplay;
      
      public var clip_animation:GuiAnimation;
      
      public var clip_new:ChestRewardNewPlaque;
      
      public var star_container:ClipLayout;
      
      public function ChestRewardHeroesListRendererHeroView()
      {
         star_container = ClipLayout.none();
         super();
      }
      
      public function setData(param1:ChestRewardPresentationValueObject) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         star_container.removeChildren();
         item_icon.item_counter.graphics.visible = false;
         if(!param1)
         {
            clip_new.graphics.visible = false;
            clip_animation.graphics.visible = false;
            item_icon.item_border_image.image.texture = AssetStorage.rsx.popup_theme.getTexture("border_super_white");
            return;
         }
         item_icon.setData(new InventoryItem(param1.item,1));
         clip_animation.graphics.touchable = false;
         clip_new.graphics.touchable = false;
         if(param1.item is HeroDescription)
         {
            if(param1.is_unique)
            {
               _loc2_ = AssetStorage.rsx.chest_graphics.create(GuiAnimation,"heroitem_hihlite_back");
               var _loc5_:* = 0.75;
               _loc2_.graphics.scaleY = _loc5_;
               _loc2_.graphics.scaleX = _loc5_;
               _loc2_.graphics.x = 20;
               _loc2_.graphics.y = 20;
               container.addChildAt(_loc2_.graphics,0);
               _loc3_ = AssetStorage.rsx.chest_graphics.create(GuiAnimation,"heroitem_hihlite_front");
               _loc5_ = 0.75;
               _loc3_.graphics.scaleY = _loc5_;
               _loc3_.graphics.scaleX = _loc5_;
               _loc3_.graphics.x = 20;
               _loc3_.graphics.y = 20;
               container.addChild(_loc3_.graphics);
               _loc3_.graphics.touchable = false;
            }
            _loc5_ = param1.is_new && !param1.is_unique;
            clip_animation.graphics.visible = _loc5_;
            clip_new.graphics.visible = _loc5_;
            _loc4_ = param1.item as HeroDescription;
            starDisplay = new MiniHeroStarDisplay();
            starDisplay.touchable = false;
            starDisplay.width = star_container.width;
            star_container.addChild(starDisplay);
            starDisplay.setValue(_loc4_.startingStar.star.id);
            starDisplay.visible = true;
         }
         else
         {
            _loc5_ = false;
            clip_animation.graphics.visible = _loc5_;
            clip_new.graphics.visible = _loc5_;
         }
      }
   }
}
