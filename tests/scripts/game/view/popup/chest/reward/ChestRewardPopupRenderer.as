package game.view.popup.chest.reward
{
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.data.storage.hero.HeroDescription;
   import game.model.user.inventory.InventoryFragmentItem;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.hero.MiniHeroStarDisplay;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class ChestRewardPopupRenderer extends GuiClipNestedContainer
   {
       
      
      public var item_icon:InventoryItemRenderer;
      
      public var starDisplay:MiniHeroStarDisplay;
      
      public var clip_animation:GuiAnimation;
      
      public var star_container:ClipLayout;
      
      public function ChestRewardPopupRenderer()
      {
         star_container = ClipLayout.none();
         super();
      }
      
      public function setData(param1:InventoryItem) : void
      {
         var _loc2_:* = null;
         item_icon.setData(param1);
         clip_animation.graphics.touchable = false;
         if(param1.item is HeroDescription && !(param1 is InventoryFragmentItem))
         {
            _loc2_ = param1.item as HeroDescription;
            starDisplay = new MiniHeroStarDisplay();
            starDisplay.touchable = false;
            starDisplay.width = star_container.width;
            star_container.addChild(starDisplay);
            starDisplay.setValue(_loc2_.startingStar.star.id);
            starDisplay.visible = true;
            item_icon.item_counter.graphics.visible = false;
            clip_animation.graphics.visible = true;
         }
         else
         {
            clip_animation.graphics.visible = false;
         }
      }
   }
}
