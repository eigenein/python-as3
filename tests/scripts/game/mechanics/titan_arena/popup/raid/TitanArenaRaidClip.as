package game.mechanics.titan_arena.popup.raid
{
   import engine.core.clipgui.ClipSpriteUntouchable;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   
   public class TitanArenaRaidClip extends PopupClipBase
   {
       
      
      public const tf_header_enemy:ClipLabel = new ClipLabel();
      
      public const tf_header_points:ClipLabel = new ClipLabel();
      
      public const tf_header_reward:ClipLabel = new ClipLabel();
      
      public const tf_invalidBattle:ClipLabel = new ClipLabel();
      
      public const tf_wait:ClipLabel = new ClipLabel();
      
      public const gradient_top:ClipSpriteUntouchable = new ClipSpriteUntouchable();
      
      public const gradient_bottom:ClipSpriteUntouchable = new ClipSpriteUntouchable();
      
      public const scrollbar:GameScrollBar = new GameScrollBar();
      
      public const list_battles:GameScrolledList = new GameScrolledList(scrollbar,gradient_top.graphics,gradient_bottom.graphics);
      
      public const button_finish:ClipButtonLabeled = new ClipButtonLabeled();
      
      public function TitanArenaRaidClip()
      {
         super();
      }
   }
}
