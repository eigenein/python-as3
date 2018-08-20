package game.mechanics.expedition.popup
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class ExpeditionTeamGatherPopupHeroRendererClip extends GuiClipNestedContainer
   {
       
      
      public const icon_power:ClipSprite = new ClipSprite();
      
      public const tf_timer:ClipLabel = new ClipLabel();
      
      public const layout_timer:ClipLayout = ClipLayout.horizontalMiddleCentered(0,tf_timer);
      
      public const tf_power:ClipLabel = new ClipLabel(true);
      
      public const panel_power:GuiClipScale3Image = new GuiClipScale3Image();
      
      public const layout_power:ClipLayout = ClipLayout.horizontalMiddleCentered(2,icon_power,tf_power);
      
      public const panel_timer:ClipSprite = new ClipSprite();
      
      public const highlight:GuiClipScale9Image = new GuiClipScale9Image();
      
      public const layout_back:ClipLayout = ClipLayout.none(highlight);
      
      public function ExpeditionTeamGatherPopupHeroRendererClip()
      {
         super();
      }
   }
}
