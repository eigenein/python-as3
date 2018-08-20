package game.battle.gui
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   
   public class BattleUserPanelBackground extends GuiClipNestedContainer
   {
       
      
      public var bg_clan:ClipSprite;
      
      public var bg_no_clan:ClipSprite;
      
      public function BattleUserPanelBackground()
      {
         bg_clan = new ClipSprite();
         bg_no_clan = new ClipSprite();
         super();
      }
   }
}
