package game.view.popup.hero.rune
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipContainer;
   import game.mediator.gui.popup.rune.PlayerHeroRuneValueObject;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.gui.components.SpecialClipLabel;
   
   public class HeroRunePopupClip extends PopupClipBase
   {
       
      
      private const runeIconSize:int = 84;
      
      public var bound_layout_container:GuiClipLayoutContainer;
      
      public var animation_enchant:GuiAnimation;
      
      public var block_items:HeroRuneUpgradeBlockClip;
      
      public var block_max_level:HeroRuneMaxLevelBlockClip;
      
      public var hero_position:GuiClipLayoutContainer;
      
      public var rune:Vector.<RuneItemClip>;
      
      public var selector:GuiAnimation;
      
      public var tf_power_label:ClipLabel;
      
      public var tf_power_value:ClipLabel;
      
      public var icon_power:ClipSprite;
      
      public var rune_icon:GuiClipContainer;
      
      public var stat_glow:ClipSprite;
      
      public var stat_glow_line:ClipSprite;
      
      public var tf_stat:SpecialClipLabel;
      
      public var tf_level_label:SpecialClipLabel;
      
      public var tf_locked:ClipLabel;
      
      public var layout_stat:ClipLayout;
      
      public var progress:HeroRuneProgressClip;
      
      public var tf_progress:SpecialClipLabel;
      
      public var minilist_layout_container:ClipLayout;
      
      public var miniList_rightArrow:ClipButton;
      
      public var miniList_leftArrow:ClipButton;
      
      public var layout_tabs:ClipLayout;
      
      public function HeroRunePopupClip()
      {
         animation_enchant = new GuiAnimation();
         selector = new GuiAnimation();
         tf_power_label = new ClipLabel();
         tf_power_value = new ClipLabel();
         stat_glow = new ClipSprite();
         stat_glow_line = new ClipSprite();
         tf_stat = new SpecialClipLabel();
         tf_level_label = new SpecialClipLabel(true);
         tf_locked = new ClipLabel();
         layout_stat = ClipLayout.horizontalDownLeft(0,tf_stat);
         tf_progress = new SpecialClipLabel(true);
         minilist_layout_container = ClipLayout.horizontalCentered(0);
         layout_tabs = ClipLayout.vertical(-16);
         super();
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = rune;
         for each(var _loc1_ in rune)
         {
            _loc1_.dispose();
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         selector.graphics.transformationMatrix = selector.graphics.transformationMatrix;
         rune_icon.graphics.x = rune_icon.graphics.x + 84 * 0.5;
         rune_icon.graphics.y = rune_icon.graphics.y + 84 * 0.5;
      }
      
      public function setRune(param1:PlayerHeroRuneValueObject) : void
      {
         var _loc2_:* = null;
         rune_icon.container.removeChildren(0,-1,true);
         if(param1)
         {
            _loc2_ = param1.createIconSprite();
            rune_icon.container.addChild(_loc2_.graphics);
            _loc2_.graphics.x = -42;
            _loc2_.graphics.y = -42;
         }
         if(param1 && !param1.locked)
         {
            progress.graphics.alpha = 1;
         }
         else
         {
            progress.graphics.alpha = 0.4;
         }
      }
   }
}
