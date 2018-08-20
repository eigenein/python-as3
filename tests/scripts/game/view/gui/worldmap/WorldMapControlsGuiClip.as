package game.view.gui.worldmap
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipLabel;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.view.gui.components.ClipButton;
   import game.view.popup.theme.LabelStyle;
   
   public class WorldMapControlsGuiClip extends GuiClipNestedContainer
   {
       
      
      public var close:ClipButton;
      
      public var label:ClipSprite;
      
      public var arrow_prev:ClipButton;
      
      public var arrow_next:ClipButton;
      
      public var mapTitle:GuiClipLabel;
      
      public var headerMap_178_178_2_inst0:GuiClipScale3Image;
      
      public function WorldMapControlsGuiClip()
      {
         super();
         mapTitle = new GuiClipLabel(LabelStyle.label_size24_header);
         headerMap_178_178_2_inst0 = new GuiClipScale3Image(178,2);
      }
   }
}
