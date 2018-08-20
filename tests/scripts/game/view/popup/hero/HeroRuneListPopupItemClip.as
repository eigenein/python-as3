package game.view.popup.hero
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.hero.rune.RuneItemSmallClip;
   
   public class HeroRuneListPopupItemClip extends HeroListItemClipBase
   {
       
      
      public var rune:Vector.<RuneItemSmallClip>;
      
      public var NewIcon_inst0:ClipSprite;
      
      public var GreenPlusIcon_inst0:ClipSprite;
      
      public var tf_hero_name:ClipLabel;
      
      public var layout_name:ClipLayout;
      
      public function HeroRuneListPopupItemClip()
      {
         rune = new Vector.<RuneItemSmallClip>();
         tf_hero_name = new ClipLabel(true);
         layout_name = ClipLayout.horizontalCentered(2,tf_hero_name);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         marker_hero_portrait_inst0.graphics.touchable = false;
         layout_name.graphics.touchable = false;
         var _loc4_:int = 0;
         var _loc3_:* = rune;
         for each(var _loc2_ in rune)
         {
            container.addChild(_loc2_.image_container);
            _loc2_.image_container.x = _loc2_.image_container.x + _loc2_.graphics.x;
            _loc2_.image_container.y = _loc2_.image_container.y + _loc2_.graphics.y;
            _loc2_.image_container.touchable = false;
         }
         var _loc6_:int = 0;
         var _loc5_:* = rune;
         for each(_loc2_ in rune)
         {
            container.addChild(_loc2_.lock_icon.graphics);
            _loc2_.lock_icon.graphics.x = _loc2_.lock_icon.graphics.x + _loc2_.graphics.x;
            _loc2_.lock_icon.graphics.y = _loc2_.lock_icon.graphics.y + _loc2_.graphics.y;
            _loc2_.lock_icon.graphics.touchable = false;
         }
         var _loc8_:int = 0;
         var _loc7_:* = rune;
         for each(_loc2_ in rune)
         {
            container.addChild(_loc2_.tf_level);
            _loc2_.tf_level.x = _loc2_.tf_level.x + _loc2_.graphics.x;
            _loc2_.tf_level.y = _loc2_.tf_level.y + _loc2_.graphics.y;
            _loc2_.tf_level.touchable = false;
         }
      }
   }
}
