package game.view.popup.hero.consumable
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.ClipSpriteUntouchable;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipDataProvider;
   import game.view.gui.components.ClipFontColor;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipListWithScroll;
   import game.view.gui.components.ClipVisibilityGroup;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.SpecialClipLabel;
   
   public class HeroUseConsumableWithSelectorPopupClip extends PopupClipBase
   {
       
      
      public const list_hero_signals:HeroUseConsumableHeroSignals = new HeroUseConsumableHeroSignals();
      
      public var tf_max_level:SpecialClipLabel;
      
      public var tf_use_label:SpecialClipLabel;
      
      public var tf_amount_label:ClipLabel;
      
      public var tf_amount:ClipLabel;
      
      public var layout_amount_label:ClipLayout;
      
      public var layout_amount_value:ClipLayout;
      
      public var layout_amount:ClipLayout;
      
      public var items:Vector.<HeroUseConsumableWithSelectorConsumableItemClip>;
      
      public var LinePale_148_148_1_inst0:GuiClipScale3Image;
      
      public var spot_left_top:ClipSprite;
      
      public var spot_left_bottom:ClipSprite;
      
      public var spot_right_top:ClipSprite;
      
      public var spot_right_bottom:ClipSprite;
      
      public var selector_arrow_top:ClipSprite;
      
      public var selector_arrow_bottom:ClipSprite;
      
      public var item_hero:ClipDataProvider;
      
      public var scrollbar:GameScrollBar;
      
      public var list_hero:ClipListWithScroll;
      
      public var gradient_top:ClipSpriteUntouchable;
      
      public var gradient_bottom:ClipSpriteUntouchable;
      
      public var font_color:Vector.<ClipFontColor>;
      
      public var tf_no_potions_title:ClipLabel;
      
      public var tf_no_potions_text:ClipLabel;
      
      public var button_shop:ClipButtonLabeled;
      
      public var button_missions:ClipButtonLabeled;
      
      public var line_no_potions:ClipSpriteUntouchable;
      
      public const block_has_consumable:ClipVisibilityGroup = new ClipVisibilityGroup([tf_max_level,tf_use_label,layout_amount,spot_left_top,spot_left_bottom,spot_right_top,spot_right_bottom,selector_arrow_top,selector_arrow_bottom]);
      
      public const block_no_consumable:ClipVisibilityGroup = new ClipVisibilityGroup([tf_no_potions_title,tf_no_potions_text,button_shop,button_missions,line_no_potions]);
      
      public function HeroUseConsumableWithSelectorPopupClip()
      {
         tf_max_level = new SpecialClipLabel();
         tf_use_label = new SpecialClipLabel(true);
         tf_amount_label = new ClipLabel(true);
         tf_amount = new ClipLabel(true);
         layout_amount_label = ClipLayout.none(tf_amount_label);
         layout_amount_value = ClipLayout.none(tf_amount);
         layout_amount = ClipLayout.horizontalBottomLeft(4,layout_amount_label,layout_amount_value);
         LinePale_148_148_1_inst0 = new GuiClipScale3Image(148,1);
         spot_left_top = new ClipSprite();
         spot_left_bottom = new ClipSprite();
         spot_right_top = new ClipSprite();
         spot_right_bottom = new ClipSprite();
         selector_arrow_top = new ClipSprite();
         selector_arrow_bottom = new ClipSprite();
         item_hero = new ClipDataProvider();
         scrollbar = new GameScrollBar();
         list_hero = new ClipListWithScroll(HeroUseConsumableWithSelectorHeroOneLevelClipListItem,scrollbar,list_hero_signals);
         tf_no_potions_title = new ClipLabel();
         tf_no_potions_text = new ClipLabel();
         button_shop = new ClipButtonLabeled();
         button_missions = new ClipButtonLabeled();
         line_no_potions = new ClipSpriteUntouchable();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         list_hero.itemClipProvider = item_hero;
         list_hero.addGradients(gradient_top.graphics,gradient_bottom.graphics);
         layout_amount_label.width = NaN;
         layout_amount_value.width = NaN;
      }
   }
}
