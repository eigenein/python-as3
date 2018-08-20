package game.view.popup.billing.bundle
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLayout;
   
   public class HeroEvolveUpsellBundlePopupStarCounterClip extends GuiClipNestedContainer
   {
       
      
      public var star:Vector.<ClipSprite>;
      
      public var layout_main:ClipLayout;
      
      public function HeroEvolveUpsellBundlePopupStarCounterClip()
      {
         star = new Vector.<ClipSprite>();
         layout_main = ClipLayout.horizontalCentered(0);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         var _loc3_:int = 0;
         super.setNode(param1);
         var _loc2_:int = star.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            layout_main.addChild(star[_loc3_].graphics);
            _loc3_++;
         }
      }
      
      public function setStarCount(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = star.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            star[_loc3_].graphics.visible = _loc3_ + 1 <= param1;
            _loc3_++;
         }
      }
   }
}
