package game.mechanics.expedition.popup
{
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class ExpeditionListPopupClip extends PopupClipBase
   {
       
      
      public const tf_title:ClipLabel = new ClipLabel();
      
      public const layout_header:ClipLayout = ClipLayout.horizontalMiddleCentered(0,tf_title);
      
      public const item:Vector.<ExpeditionPopupPanelClip> = new Vector.<ExpeditionPopupPanelClip>();
      
      public function ExpeditionListPopupClip()
      {
         super();
      }
   }
}
