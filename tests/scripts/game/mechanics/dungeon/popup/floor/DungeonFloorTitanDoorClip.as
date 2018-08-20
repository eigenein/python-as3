package game.mechanics.dungeon.popup.floor
{
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipNestedContainer;
   
   public class DungeonFloorTitanDoorClip extends GuiClipNestedContainer
   {
       
      
      public var door_1:GuiAnimation;
      
      public var door_2:GuiAnimation;
      
      public var element_1:GuiClipContainer;
      
      public var element_2:GuiClipContainer;
      
      public var element_1_up:GuiClipContainer;
      
      public var element_2_up:GuiClipContainer;
      
      public var element_1_over:GuiClipContainer;
      
      public var element_2_over:GuiClipContainer;
      
      public var runes_1:GuiAnimation;
      
      public function DungeonFloorTitanDoorClip()
      {
         door_1 = new GuiAnimation();
         door_2 = new GuiAnimation();
         element_1 = new GuiClipContainer();
         element_2 = new GuiClipContainer();
         element_1_up = new GuiClipContainer();
         element_2_up = new GuiClipContainer();
         element_1_over = new GuiClipContainer();
         element_2_over = new GuiClipContainer();
         runes_1 = new GuiAnimation();
         super();
      }
   }
}
