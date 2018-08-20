package game.view.popup.chest
{
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.data.storage.chest.ChestRewardPresentationValueObject;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.hero.UnitDescription;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.hero.MiniHeroStarDisplay;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class ChestDropPresentationRenderer extends GuiClipNestedContainer
   {
       
      
      public var item_icon:InventoryItemRenderer;
      
      public var starDisplay:MiniHeroStarDisplay;
      
      public var clip_animation:GuiAnimation;
      
      public var clip_new:ChestRewardNewPlaque;
      
      public var star_container:ClipLayout;
      
      public function ChestDropPresentationRenderer()
      {
         star_container = ClipLayout.none();
         super();
      }
      
      public function setData(param1:ChestRewardPresentationValueObject) : void
      {
         var _loc2_:* = null;
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
         if(param1.item is UnitDescription)
         {
            var _loc3_:* = param1.is_new;
            clip_animation.graphics.visible = _loc3_;
            clip_new.graphics.visible = _loc3_;
            _loc2_ = param1.item as HeroDescription;
            starDisplay = new MiniHeroStarDisplay();
            starDisplay.touchable = false;
            starDisplay.width = star_container.width;
            star_container.addChild(starDisplay);
            starDisplay.setValue(_loc2_.startingStar.star.id);
            starDisplay.visible = true;
         }
         else
         {
            _loc3_ = false;
            clip_animation.graphics.visible = _loc3_;
            clip_new.graphics.visible = _loc3_;
         }
      }
   }
}
