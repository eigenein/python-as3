package game.mechanics.titan_arena.popup.raid
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.MiniHeroTeamRenderer;
   
   public class TitanArenaRaidStartTeamBlockClip extends GuiClipNestedContainer
   {
       
      
      public const team:MiniHeroTeamRenderer = new MiniHeroTeamRenderer();
      
      public const team_layout:ClipLayout = ClipLayout.horizontalMiddleCentered(0,team);
      
      public const icon_lock:ClipSprite = new ClipSprite();
      
      public const button_edit:ClipButtonLabeled = new ClipButtonLabeled();
      
      public function TitanArenaRaidStartTeamBlockClip()
      {
         super();
      }
      
      public function setLocked(param1:Boolean) : void
      {
         icon_lock.graphics.visible = param1;
         button_edit.graphics.visible = !param1;
      }
      
      override public function setNode(param1:Node) : void
      {
         var _loc3_:int = 0;
         super.setNode(param1);
         var _loc2_:int = team.hero.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            team_layout.addChild(team.hero[_loc3_].graphics);
            _loc3_++;
         }
      }
   }
}
