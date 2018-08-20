package game.mechanics.dungeon.popup.floor
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   
   public class DungeonScreenColumnsClip extends GuiClipNestedContainer
   {
       
      
      public var column:Vector.<ClipSprite>;
      
      public function DungeonScreenColumnsClip()
      {
         column = new Vector.<ClipSprite>();
         super();
      }
   }
}
