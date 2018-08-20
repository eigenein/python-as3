package game.view.popup.hero.slot
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import feathers.layout.HorizontalLayout;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeledGlow;
   import game.view.gui.components.ClipDataProvider;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class HeroSlotPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_wear:ClipButtonLabeledGlow;
      
      public var button_craft:ClipButtonLabeledGlow;
      
      public var button_close:ClipButton;
      
      public var item_description:ClipHeroSlotItemDescription;
      
      public var layout_craft_order:GuiClipLayoutContainer;
      
      public var craft_order_item_icon:ClipDataProvider;
      
      public var arrow_right:ClipDataProvider;
      
      public var current_craft:ClipCraftBlock;
      
      public var current_drop_sources:ClipDropSourcesBlock;
      
      public var tf_current_item_name:ClipLabel;
      
      public var layout_buttons_left:ClipLayout;
      
      public function HeroSlotPopupClip()
      {
         button_wear = new ClipButtonLabeledGlow();
         button_craft = new ClipButtonLabeledGlow();
         button_close = new ClipButton();
         layout_buttons_left = ClipLayout.horizontalCentered(4,button_wear,button_craft);
         super();
         layout_craft_order = new GuiClipLayoutContainer();
         var _loc1_:HorizontalLayout = new HorizontalLayout();
         _loc1_.verticalAlign = "middle";
         _loc1_.horizontalAlign = "center";
         _loc1_.gap = -3;
         layout_craft_order.layoutGroup.layout = _loc1_;
      }
   }
}
