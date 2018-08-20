package game.view.gui.worldmap
{
   import engine.core.clipgui.GuiClipLabel;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   
   public class WorldMapViewToggleButtonStateClip extends GuiClipNestedContainer
   {
       
      
      public var label:GuiClipLabel;
      
      public var backgroundSkin:GuiClipScale3Image;
      
      public function WorldMapViewToggleButtonStateClip(param1:Function)
      {
         super();
         label = new GuiClipLabel(param1);
         backgroundSkin = new GuiClipScale3Image(42,2);
      }
   }
}
