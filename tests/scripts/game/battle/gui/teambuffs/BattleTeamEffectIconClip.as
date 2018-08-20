package game.battle.gui.teambuffs
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   
   public class BattleTeamEffectIconClip extends GuiClipNestedContainer
   {
       
      
      public var image:GuiClipImage;
      
      public var frame:ClipSprite;
      
      public var label:ClipLabel;
      
      public var bg:ClipSprite;
      
      public function BattleTeamEffectIconClip()
      {
         image = new GuiClipImage();
         frame = new ClipSprite();
         label = new ClipLabel();
         bg = new ClipSprite();
         super();
      }
   }
}
