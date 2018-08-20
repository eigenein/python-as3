package game.mechanics.expedition.popup
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipContainer;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class ExpeditionMapPopupClip extends PopupClipBase
   {
       
      
      public const tf_title:ClipLabel = new ClipLabel();
      
      public const layout_header:ClipLayout = ClipLayout.horizontalMiddleCentered(0,tf_title);
      
      public const item:Vector.<ExpeditionMapPopupPanelClip> = new Vector.<ExpeditionMapPopupPanelClip>();
      
      public const story_position:Vector.<GuiClipContainer> = new Vector.<GuiClipContainer>();
      
      public const tf_status:ClipLabel = new ClipLabel();
      
      public const map_image:ClipSprite = new ClipSprite();
      
      public function ExpeditionMapPopupClip()
      {
         super();
      }
   }
}
