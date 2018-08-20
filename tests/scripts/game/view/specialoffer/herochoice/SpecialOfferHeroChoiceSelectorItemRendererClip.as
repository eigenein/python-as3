package game.view.specialoffer.herochoice
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.assets.storage.AssetStorage;
   import game.data.storage.hero.UnitDescription;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.hero.MiniHeroStarDisplay;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class SpecialOfferHeroChoiceSelectorItemRendererClip extends GuiClipNestedContainer
   {
       
      
      private var starDisplay:MiniHeroStarDisplay;
      
      public var tf_name:ClipLabel;
      
      public var tf_you_have:ClipLabel;
      
      public var layout_name:ClipLayout;
      
      public var icon_item:InventoryItemRenderer;
      
      public var animation_glow:GuiAnimation;
      
      public var bg:ClipButton;
      
      public var bg_selected:GuiClipScale9Image;
      
      public var star_container:ClipLayout;
      
      public function SpecialOfferHeroChoiceSelectorItemRendererClip()
      {
         tf_name = new ClipLabel();
         tf_you_have = new ClipLabel();
         layout_name = ClipLayout.verticalMiddleCenter(4,tf_name,tf_you_have);
         animation_glow = new GuiAnimation();
         bg = new ClipButton();
         bg_selected = new GuiClipScale9Image();
         star_container = ClipLayout.none();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_you_have.alpha = 0.4;
         tf_you_have.text = Translate.translate("UI_DIALOG_REWARD_HERO_HDR_FRAGMENTS");
         icon_item.item_counter.graphics.visible = false;
         animation_glow.graphics.visible = false;
         var _loc2_:Boolean = false;
         animation_glow.graphics.touchable = _loc2_;
         layout_name.touchable = _loc2_;
         starDisplay = new MiniHeroStarDisplay();
         starDisplay.touchable = false;
         starDisplay.width = star_container.width;
         star_container.addChild(starDisplay);
      }
      
      public function setUnit(param1:UnitDescription) : void
      {
         tf_name.text = param1.name;
         icon_item.setData(new InventoryItem(param1,1));
         if(!param1)
         {
            starDisplay.visible = false;
            icon_item.item_border_image.image.texture = AssetStorage.rsx.popup_theme.getTexture("border_super_white");
            return;
         }
         starDisplay.visible = true;
         starDisplay.setValue(param1.startingStarNum);
      }
      
      public function setPlayerHas(param1:Boolean) : void
      {
         tf_you_have.visible = param1;
      }
   }
}
