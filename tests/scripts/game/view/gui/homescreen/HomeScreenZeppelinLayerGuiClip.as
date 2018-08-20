package game.view.gui.homescreen
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipLayoutNone;
   import game.view.gui.components.ClipSingleLayoutContainer;
   
   public class HomeScreenZeppelinLayerGuiClip extends GuiClipNestedContainer
   {
       
      
      public var animation:ClipSprite;
      
      public var button_boss:HomeScreenSkyPyramidButton;
      
      public var container_progressbar:ClipSingleLayoutContainer;
      
      public var layout_hidden_moon:ClipLayoutNone;
      
      public var layout_giftdrop:ClipLayoutNone;
      
      public function HomeScreenZeppelinLayerGuiClip()
      {
         container_progressbar = new ClipSingleLayoutContainer(ClipLayout.horizontalMiddleCentered(0));
         layout_hidden_moon = new ClipLayoutNone();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
      }
   }
}
