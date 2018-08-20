package game.mechanics.titan_arena.popup
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipLayoutNone;
   import game.view.gui.components.MiniHeroTeamRenderer;
   
   public class TooltipTitanArenaEnemyViewTeamClip extends GuiClipNestedContainer
   {
       
      
      public var powerIconSmall_inst0:ClipSprite;
      
      public var team:MiniHeroTeamRenderer;
      
      public var tf_power:ClipLabel;
      
      public var tf_label_power:ClipLabel;
      
      public var tf_nickname:ClipLabel;
      
      public var layout_tooltip:ClipLayoutNone;
      
      public var layout_power:ClipLayout;
      
      public function TooltipTitanArenaEnemyViewTeamClip()
      {
         powerIconSmall_inst0 = new ClipSprite();
         team = new MiniHeroTeamRenderer();
         tf_power = new ClipLabel(true);
         tf_label_power = new ClipLabel(true);
         tf_nickname = new ClipLabel();
         layout_tooltip = new ClipLayoutNone();
         layout_power = ClipLayout.horizontalMiddleCentered(0,tf_label_power,powerIconSmall_inst0,tf_power);
         super();
      }
   }
}
