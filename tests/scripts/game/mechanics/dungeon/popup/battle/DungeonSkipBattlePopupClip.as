package game.mechanics.dungeon.popup.battle
{
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.MiniHeroTeamRenderer;
   
   public class DungeonSkipBattlePopupClip extends PopupClipBase
   {
       
      
      public var button_confirm:ClipButtonLabeled;
      
      public var button_decline:ClipButtonLabeled;
      
      public var team:MiniHeroTeamRenderer;
      
      public var tf_header:ClipLabel;
      
      public function DungeonSkipBattlePopupClip()
      {
         button_confirm = new ClipButtonLabeled();
         button_decline = new ClipButtonLabeled();
         team = new MiniHeroTeamRenderer();
         tf_header = new ClipLabel();
         super();
      }
   }
}
