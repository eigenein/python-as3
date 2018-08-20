package game.view.popup.hero
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.popup.common.CutePanelClipButton;
   
   public class HeroListItemClipBase extends GuiClipNestedContainer
   {
       
      
      public var marker_hero_portrait_inst0:GuiClipContainer;
      
      public var bg_button:CutePanelClipButton;
      
      public function HeroListItemClipBase()
      {
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         marker_hero_portrait_inst0.graphics.touchable = false;
      }
   }
}
