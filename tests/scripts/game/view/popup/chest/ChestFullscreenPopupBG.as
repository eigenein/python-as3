package game.view.popup.chest
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class ChestFullscreenPopupBG extends GuiClipNestedContainer
   {
       
      
      public var light_gold:ClipSprite;
      
      public var bottom_gold:GuiAnimation;
      
      public var idle_gold:ChestIdleButton;
      
      public var blindSideLeft:ClipSprite;
      
      public var blindSideRight:ClipSprite;
      
      public var blindSideTop:ClipSprite;
      
      public var header_layout_container:GuiClipLayoutContainer;
      
      public var drapingLeft:GuiAnimation;
      
      public var drapingRight:GuiAnimation;
      
      public function ChestFullscreenPopupBG()
      {
         light_gold = new ClipSprite();
         bottom_gold = new GuiAnimation();
         idle_gold = new ChestIdleButton();
         blindSideLeft = new ClipSprite();
         blindSideRight = new ClipSprite();
         blindSideTop = new ClipSprite();
         header_layout_container = new GuiClipLayoutContainer();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         if(drapingLeft)
         {
            drapingLeft.playOnce();
         }
         if(drapingRight)
         {
            drapingRight.playOnce();
         }
         blindSideLeft.graphics.touchable = false;
         blindSideRight.graphics.touchable = false;
         blindSideTop.graphics.touchable = false;
      }
   }
}
