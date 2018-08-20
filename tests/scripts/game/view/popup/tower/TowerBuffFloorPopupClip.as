package game.view.popup.tower
{
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipLabel;
   
   public class TowerBuffFloorPopupClip extends PopupClipBase
   {
       
      
      public var tf_caption:ClipLabel;
      
      public var buff:Vector.<TowerBuffPanelClip>;
      
      public function TowerBuffFloorPopupClip()
      {
         tf_caption = new ClipLabel();
         buff = new Vector.<TowerBuffPanelClip>();
         super();
      }
   }
}
